<template>
    <main class="page page--vertical">
        <TheHeader />
        <slot></slot>
        <TheFooter />
    </main>
</template>

<script setup></script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .page--vertical {
        max-width: 100vw;
        min-height: 100%;
        padding-top: $py;
        overflow-x: clip;
    }
</style>
