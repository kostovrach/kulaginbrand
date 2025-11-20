<template>
    <TheHeader />
    <HorizontalScroll
        v-model:scroll-progress="scrollProgress"
        v-model:is-scrolling="isScrolling"
        :breakpoint="768"
    >
        <TheProgressbar :progress="scrollProgress" :show-when-scrolling="isScrolling" />
        <slot></slot>
    </HorizontalScroll>
    <TheFooter />
</template>

<script setup lang="ts">
    const scrollProgress = ref(0);
    const isScrolling = ref(false);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;
</style>
