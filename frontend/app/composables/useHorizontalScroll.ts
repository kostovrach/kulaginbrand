interface UseHorizontalScrollOptions {
    easing?: number;
    inertiaDecay?: number;
    minInertiaVelocity?: number;
    keyboardStepRatio?: number;
    wheelSensitivity?: number;
    touchSensitivity?: number;
    breakpoint?: number;
}
export function useHorizontalScroll(options: UseHorizontalScrollOptions = {}): {
    containerRef: Ref<HTMLElement | null>;
    scrollProgress: Ref<number>;
    isScrolling: Ref<boolean>;
    isDesktop: Ref<boolean>;
    isEnabled: Ref<boolean>;
    forceMode: Ref<boolean>;
    isActive: ComputedRef<boolean>;
    setForceMode: (state: boolean) => void;
    scrollTo: (position: number, smooth?: boolean) => void;
    scrollBy: (delta: number, smooth?: boolean) => void;
    enable: () => void;
    disable: () => void;
    toggle: () => void;
    setupListeners: () => void;
    removeListeners: () => void;
} {
    const {
        easing = 0.08,
        inertiaDecay = 0.95,
        minInertiaVelocity = 0.1,
        keyboardStepRatio = 0.8,
        wheelSensitivity = 1,
        touchSensitivity = 1,
        breakpoint = 768,
    } = options;

    const isClient = import.meta.client;

    const containerRef: Ref<HTMLElement | null> = ref(null);
    const scrollProgress: Ref<number> = ref(0);
    const isScrolling: Ref<boolean> = ref(false);
    const isDesktop: Ref<boolean> = ref(true);
    const isEnabled: Ref<boolean> = ref(true);
    const forceMode: Ref<boolean> = ref(false);
    const isActive: ComputedRef<boolean> = computed(
        () => (forceMode.value || isDesktop.value) && isEnabled.value
    );

    let current: number = 0;
    let target: number = 0;
    let isAnimating: boolean = false;
    let inertiaVelocity: number = 0;
    let lastTouchX: number = 0;
    let lastTouchTime: number = 0;
    let touchVelocities: { velocity: number; time: number }[] = [];
    let rafId: number | null = null;
    let lastWheelTime: number = 0;
    let mediaQuery: MediaQueryList | null = null;

    const wheelDebounceTime = 16;
    function animate() {
        if (!containerRef.value || !isActive.value) return;
        if (Math.abs(target - current) < 0.5 && Math.abs(inertiaVelocity) > minInertiaVelocity) {
            target += inertiaVelocity;
            inertiaVelocity *= inertiaDecay;
        }
        current += (target - current) * easing;
        const maxScroll = containerRef.value.scrollWidth - containerRef.value.clientWidth;
        if (current < 0) {
            current = 0;
            inertiaVelocity = 0;
        }
        if (current > maxScroll) {
            current = maxScroll;
            inertiaVelocity = 0;
        }

        containerRef.value.scrollLeft = current;

        updateScrollProgress();

        const needsContinue =
            Math.abs(target - current) > 0.5 || Math.abs(inertiaVelocity) > minInertiaVelocity;
        if (needsContinue && isActive.value) {
            rafId = requestAnimationFrame(animate);
            isScrolling.value = true;
        } else {
            isAnimating = false;
            isScrolling.value = false;
            inertiaVelocity = 0;
        }
    }
    function startAnimation() {
        if (!isAnimating && containerRef.value && isActive.value) {
            isAnimating = true;
            rafId = requestAnimationFrame(animate);
        }
    }
    function updateScrollProgress() {
        if (!containerRef.value) return;
        const maxScroll = containerRef.value.scrollWidth - containerRef.value.clientWidth;
        scrollProgress.value = maxScroll > 0 ? (current / maxScroll) * 100 : 0;
    }
    function handleWheel(e: WheelEvent) {
        if (!isActive.value) return;

        e.preventDefault();

        const now = performance.now();

        if (now - lastWheelTime < wheelDebounceTime) return;
        lastWheelTime = now;

        if (!containerRef.value) return;

        const maxScroll = containerRef.value.scrollWidth - containerRef.value.clientWidth;
        const delta = (e.deltaY + e.deltaX) * wheelSensitivity;

        target += delta;
        target = Math.max(0, Math.min(target, maxScroll));
        inertiaVelocity = 0;

        startAnimation();
    }
    function handleTouchStart(e: TouchEvent) {
        if (!isActive.value) return;

        const touch = e.touches[0];

        lastTouchX = touch?.clientX ?? 0;
        lastTouchTime = performance.now();
        touchVelocities = [];
        inertiaVelocity = 0;
    }
    function handleTouchMove(e: TouchEvent) {
        if (!isActive.value) return;

        e.preventDefault();

        if (!containerRef.value) return;

        const touch = e.touches[0];
        const now = performance.now();
        const deltaX = (lastTouchX - (touch?.clientX ?? 0)) * touchSensitivity;
        const deltaTime = now - lastTouchTime;

        if (deltaTime > 0) {
            const velocity = deltaX / deltaTime;
            touchVelocities.push({ velocity, time: now });
            touchVelocities = touchVelocities.filter((v) => now - v.time < 100);
        }

        const maxScroll = containerRef.value.scrollWidth - containerRef.value.clientWidth;

        target += deltaX;
        target = Math.max(0, Math.min(target, maxScroll));
        lastTouchX = touch?.clientX ?? 0;
        lastTouchTime = now;

        startAnimation();
    }
    function handleTouchEnd() {
        if (!isActive.value) return;

        if (touchVelocities.length > 0) {
            const avgVelocity =
                touchVelocities.reduce((sum, v) => sum + v.velocity, 0) / touchVelocities.length;
            inertiaVelocity = avgVelocity * 10;
        }
        touchVelocities = [];

        startAnimation();
    }
    function handleKeydown(e: KeyboardEvent) {
        if (!isActive.value || !containerRef.value) return;

        const step = window.innerWidth * keyboardStepRatio;
        let shouldHandle = false;

        switch (e.key) {
            case 'ArrowRight':
                target += step;
                shouldHandle = true;
                break;
            case 'ArrowLeft':
                target -= step;
                shouldHandle = true;
                break;
            case 'Home':
                target = 0;
                shouldHandle = true;
                break;
            case 'End':
                target = containerRef.value.scrollWidth - containerRef.value.clientWidth;
                shouldHandle = true;
                break;
        }

        if (shouldHandle) {
            e.preventDefault();

            const maxScroll = containerRef.value.scrollWidth - containerRef.value.clientWidth;
            target = Math.max(0, Math.min(target, maxScroll));
            inertiaVelocity = 0;

            startAnimation();
        }
    }
    function handleMediaQueryChange(e: MediaQueryListEvent) {
        if (forceMode.value) return;

        isDesktop.value = e.matches;

        if (!isDesktop.value) {
            stopAnimation();
            resetScrollState();
        } else {
            syncWithNativeScroll();
        }
    }
    function stopAnimation() {
        if (rafId) {
            cancelAnimationFrame(rafId);
            rafId = null;
        }
        isAnimating = false;
        isScrolling.value = false;
        inertiaVelocity = 0;
    }
    function resetScrollState() {
        scrollProgress.value = 0;
    }
    function syncWithNativeScroll() {
        if (!containerRef.value) return;
        current = containerRef.value.scrollLeft;
        target = current;
        updateScrollProgress();
    }
    function scrollTo(position: number, smooth: boolean = true) {
        if (!containerRef.value || !isActive.value) return;

        const maxScroll = containerRef.value.scrollWidth - containerRef.value.clientWidth;
        target = Math.max(0, Math.min(position, maxScroll));

        if (smooth) {
            inertiaVelocity = 0;
            startAnimation();
        } else {
            current = target;
            containerRef.value.scrollLeft = current;
            updateScrollProgress();
        }
    }
    function scrollBy(delta: number, smooth: boolean = true) {
        scrollTo(target + delta, smooth);
    }
    function setupListeners() {
        if (!containerRef.value) return;

        syncWithNativeScroll();

        containerRef.value.addEventListener('wheel', handleWheel, { passive: false });
        containerRef.value.addEventListener('touchstart', handleTouchStart, { passive: false });
        containerRef.value.addEventListener('touchmove', handleTouchMove, { passive: false });
        containerRef.value.addEventListener('touchend', handleTouchEnd);

        window.addEventListener('keydown', handleKeydown);

        containerRef.value.setAttribute('aria-label', 'Horizontally scrollable content');
        containerRef.value.setAttribute('tabindex', '0');
    }
    function removeListeners() {
        if (!containerRef.value) return;

        containerRef.value.removeEventListener('wheel', handleWheel);
        containerRef.value.removeEventListener('touchstart', handleTouchStart);
        containerRef.value.removeEventListener('touchmove', handleTouchMove);
        containerRef.value.removeEventListener('touchend', handleTouchEnd);

        window.removeEventListener('keydown', handleKeydown);

        containerRef.value.removeAttribute('aria-label');
        containerRef.value.removeAttribute('tabindex');
    }
    function setupMediaQuery() {
        mediaQuery = window.matchMedia(`min-width: ${breakpoint + 1}px`);
        isDesktop.value = mediaQuery.matches;

        if (mediaQuery.addEventListener) {
            mediaQuery.addEventListener('change', handleMediaQueryChange);
        } else {
            mediaQuery.addListener(handleMediaQueryChange);
        }
    }
    function cleanupMediaQuery() {
        if (!mediaQuery) return;
        if (mediaQuery.removeEventListener) {
            mediaQuery.removeEventListener('change', handleMediaQueryChange);
        } else {
            mediaQuery.removeListener(handleMediaQueryChange);
        }
        mediaQuery = null;
    }
    function enable() {
        isEnabled.value = true;
        if (isDesktop.value && containerRef.value) {
            syncWithNativeScroll();
        }
    }
    function disable() {
        isEnabled.value = false;
        stopAnimation();
        resetScrollState();
    }
    function toggle() {
        if (isEnabled.value) {
            disable();
        } else {
            enable();
        }
    }
    function setForceMode(state: boolean) {
        forceMode.value = state;
        if (state) {
            isDesktop.value = true;
            syncWithNativeScroll();
            if (containerRef.value) {
                setupListeners();
            }
        } else {
            if (mediaQuery) {
                isDesktop.value = mediaQuery.matches;
                handleMediaQueryChange({ matches: mediaQuery.matches } as MediaQueryListEvent);
            }
        }
    }
    onMounted(() => {
        if (!isClient) return;
        setupMediaQuery();
        nextTick(() => {
            if (containerRef.value) {
                setupListeners();
            }
        });
    });
    onUnmounted(() => {
        removeListeners();
        cleanupMediaQuery();
        stopAnimation();
    });
    return {
        containerRef,
        scrollProgress,
        isScrolling,
        isDesktop,
        isEnabled,
        forceMode,
        isActive,
        setForceMode,
        scrollTo,
        scrollBy,
        enable,
        disable,
        toggle,
        setupListeners,
        removeListeners,
    };
}
