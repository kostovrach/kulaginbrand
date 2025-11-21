<template>
    <NuxtLayout name="vertical">
        <section class="not-found">
            <div class="not-found__container">
                <h1 class="not-found__title">ошибка 404</h1>
                <p class="not-found__subtitle">Что-то произошло, но пока не понятно, что именно</p>
                <video class="not-found__media" controls autoplay muted loop playsinline>
                    <source src="/404.mp4" type="video/mp4" />
                </video>
                <NuxtLink class="not-found__button" :to="{ name: 'index' }">
                    <span class="not-found__button-text">На главную</span>
                    <span class="not-found__button-icon">
                        <SvgSprite type="arrow" :size="24" />
                    </span>
                </NuxtLink>
            </div>
        </section>
    </NuxtLayout>
</template>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .not-found {
        @include vertical-layout;
        &__container {
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        &__title {
            @include block-title($font-size: lineScale(96, 32, 480, 1440));
        }
        &__subtitle {
            max-width: 35ch;
            text-transform: uppercase;
            font-size: lineScale(32, 18, 480, 1440);
            font-weight: $fw-bold;
            margin-top: rem(32);
        }
        &__media {
            width: 100%;
            max-width: rem(630);
            aspect-ratio: 16/9;
            object-fit: cover;
            margin-top: rem(64);
        }
        &__button {
            margin-top: rem(32);
            @include button-secondary($width: fit-content);
        }
    }
</style>
