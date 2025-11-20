<template>
    <main id="page" class="home">
        <section class="home__container">
            <HomeAgency />
        </section>
    </main>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home {
        $p: &;

        height: 100%;
        width: 100vw;
        padding: rem(32) lineScale(32, 0, 480, 1440);
        background-color: #dfdddd;
        &__container {
            min-height: calc(100lvh - rem(64));
            height: 100%;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(16);
        }
    }

    @media (max-width: 1024px) {
        .home {
            &__container {
                display: flex;
                flex-direction: column-reverse;
            }
        }
    }
</style>
