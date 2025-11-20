<template>
    <div
        v-if="showProgress"
        :class="[
            'progress-bar',
            `progress-bar--${props.position}`,
            { 'progress-bar--visible': props.progress > 0 && props.progress < 100 },
        ]"
        :style="{ '--progress': `${props.progress}%` }"
        role="progressbar"
        :aria-valuenow="Math.round(props.progress)"
        aria-valuemin="0"
        aria-valuemax="100"
        aria-label="Scroll progress"
    >
        <div class="progress-bar__fill"></div>
    </div>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            progress?: number;
            position?: 'top' | 'bottom';
            showWhenScrolling?: boolean;
            alwaysShow?: boolean;
        }>(),
        {
            progress: 0,
            position: 'top',
            showWhenScrolling: false,
            alwaysShow: true,
        }
    );

    const showProgress = computed(() => {
        if (props.alwaysShow) return true;
        return props.showWhenScrolling && props.progress > 0 && props.progress < 100;
    });
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .progress-bar {
        $p: &;

        position: fixed;
        left: 0;
        right: 0;
        z-index: 10;
        height: rem(4);
        background-color: transparent;
        transition: opacity $td $tf;
        &--top {
            top: 0;
        }
        &--bottom {
            bottom: 0;
        }
        &__fill {
            height: 100%;
            background-color: $c-accent;
            width: var(--progress);
            transition: width 0.1s ease-out;
            transform-origin: left center;
        }
        &:not(#{$p}--visible) {
            opacity: 0.3;
        }
    }

    @media (prefers-reduced-motion: reduce) {
        .progress-bar,
        .progress-bar__fill {
            transition: none;
        }
    }
</style>
