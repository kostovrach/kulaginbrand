<template>
    <TheHeader />
    <main ref="containerRef" class="content content--horizontal">
        <TheProgressbar :progress="scrollProgress" :show-when-scrolling="isScrolling" />
        <slot></slot>
    </main>
    <TheFooter />
</template>

<script setup lang="ts">
    const { containerRef, scrollProgress, isScrolling } = useHorizontalScroll();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .content {
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
        .content--horizontal:not(.content--horizontal-forced) {
            height: initial;

            display: flex;
            flex-direction: column;

            overflow-x: clip;
        }
    }
</style>
