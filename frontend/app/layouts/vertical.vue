<template>
    <main class="page-vertical">
        <TheHeader />
        <slot></slot>
        <TheFooter />
    </main>
</template>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .page-vertical {
        max-width: 100vw;
        padding-top: $py;
        overflow-x: clip;
    }
</style>
