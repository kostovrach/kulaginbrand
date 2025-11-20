<template>
    <main
        ref="containerRef"
        class="page page--horizontal"
        :class="{ 'page--horizontal-forced': props.forceMode }"
    >
        <slot></slot>
    </main>
</template>

<script setup lang="ts">
    interface Props {
        easing?: number;
        inertiaDecay?: number;
        minInertiaVelocity?: number;
        keyboardStepRatio?: number;
        wheelSensitivity?: number;
        touchSensitivity?: number;
        breakpoint?: number;
        forceMode?: boolean;
    }

    const props = withDefaults(defineProps<Props>(), {
        easing: 0.08,
        inertiaDecay: 0.95,
        minInertiaVelocity: 0.1,
        keyboardStepRatio: 0.8,
        wheelSensitivity: 1,
        touchSensitivity: 1,
        breakpoint: 768,
        forceMode: false,
    });

    const emit = defineEmits<{
        'update:scrollProgress': [progress: number];
        'update:isScrolling': [isScrolling: boolean];
    }>();

    const containerRef = ref<HTMLElement | null>(null);
    const scrollProgress = ref(0);
    const isScrolling = ref(false);
    const isDesktop = ref(true);
    const isEnabled = ref(true);

    const isActive = computed(() => (props.forceMode || isDesktop.value) && isEnabled.value);

    let current = 0;
    let target = 0;
    let isAnimating = false;
    let inertiaVelocity = 0;
    let lastTouchX = 0;
    let lastTouchTime = 0;
    let touchVelocities: { velocity: number; time: number }[] = [];
    let rafId: number | null = null;
    let lastWheelTime = 0;
    let mediaQuery: MediaQueryList | null = null;

    const wheelDebounceTime = 16;

    function animate() {
        if (!containerRef.value || !isActive.value) return;

        if (
            Math.abs(target - current) < 0.5 &&
            Math.abs(inertiaVelocity) > props.minInertiaVelocity
        ) {
            target += inertiaVelocity;
            inertiaVelocity *= props.inertiaDecay;
        }

        current += (target - current) * props.easing;

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
            Math.abs(target - current) > 0.5 ||
            Math.abs(inertiaVelocity) > props.minInertiaVelocity;

        if (needsContinue && isActive.value) {
            rafId = requestAnimationFrame(animate);
            isScrolling.value = true;
            emit('update:isScrolling', true);
        } else {
            isAnimating = false;
            isScrolling.value = false;
            emit('update:isScrolling', false);
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
        emit('update:scrollProgress', scrollProgress.value);
    }

    function handleWheel(e: WheelEvent) {
        if (!isActive.value) return;

        e.preventDefault();

        const now = performance.now();
        if (now - lastWheelTime < wheelDebounceTime) return;
        lastWheelTime = now;

        if (!containerRef.value) return;

        const maxScroll = containerRef.value.scrollWidth - containerRef.value.clientWidth;
        const delta = (e.deltaY + e.deltaX) * props.wheelSensitivity;

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
        const deltaX = (lastTouchX - (touch?.clientX ?? 0)) * props.touchSensitivity;
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

        const step = window.innerWidth * props.keyboardStepRatio;
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
        if (props.forceMode) return;

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
        emit('update:isScrolling', false);
        inertiaVelocity = 0;
    }

    function resetScrollState() {
        scrollProgress.value = 0;
        emit('update:scrollProgress', 0);
    }

    function syncWithNativeScroll() {
        if (!containerRef.value) return;

        current = containerRef.value.scrollLeft;
        target = current;
        updateScrollProgress();
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
        mediaQuery = window.matchMedia(`(min-width: ${props.breakpoint + 1}px)`);
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

    onMounted(() => {
        if (process.server) return;

        setupMediaQuery();

        nextTick(() => {
            if (containerRef.value) {
                setupListeners();
            }
            if (props.forceMode) {
                isDesktop.value = true;
                syncWithNativeScroll();
            }
        });
    });

    onUnmounted(() => {
        removeListeners();
        cleanupMediaQuery();
        stopAnimation();
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .page {
        &--horizontal {
            width: 100vw;
            height: 100lvh;

            display: grid;
            grid-auto-flow: column;

            overflow-x: auto;
            overflow-y: hidden;

            @include hide-scrollbar;
        }
    }

    @media (max-width: 768px) {
        .page--horizontal:not(.page--horizontal-forced) {
            height: initial;

            display: flex;
            flex-direction: column;

            overflow-x: clip;
        }
    }
</style>
