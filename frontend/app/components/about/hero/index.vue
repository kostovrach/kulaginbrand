<template>
    <section class="about-hero">
        <div class="about-hero__container">
            <div class="about-hero__head">
                <div class="about-hero__titlebox">
                    <h1 class="about-hero__title fade-bottom-rotate">{{ props.title }}</h1>
                    <p
                        class="about-hero__subtitle fade-bottom-rotate"
                        style="animation-delay: 0.2s"
                    >
                        {{ props.subtitle }}
                    </p>
                </div>
                <picture
                    class="about-hero__image-container fade-scale"
                    style="animation-delay: 0.3s"
                >
                    <img class="about-hero__image" :src="props.imageUrl" alt="Игорь Кулагин" />
                </picture>
            </div>
            <div class="about-hero__body fade-right">
                <AboutHeroStickers />
                <picture class="about-hero__text-image-container">
                    <source media="(max-width: 768px)" srcset="/img/kulagin-y.svg" />
                    <img class="about-hero__text-image" src="/img/kulagin-x.svg" alt="КУЛАГИН" />
                </picture>
            </div>
            <div class="about-hero__footer">
                <Draggble :top="15" :left="0">
                    <TheSticker
                        class="about-hero__sticker--hide"
                        style="rotate: -5deg"
                        variant="black"
                        textAccent="от 120%"
                        textMain="средний рост конверсии"
                    />
                </Draggble>

                <TheSectionHint
                    class="about-hero__hint"
                    :modal-video="props?.hint?.video ?? ''"
                    :modal-title="props?.hint?.title ?? ''"
                >
                    <template #title>{{ props?.hint?.title }}</template>
                    <template #text>{{ props?.hint?.description }}</template>
                    <template #media-description>{{ props?.hint?.button_text }}</template>
                </TheSectionHint>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string;
            imageUrl: string;
            hint: {
                video: string;
                title: string;
                description: string | null;
                button_text: string;
            } | null;
        }>(),
        {
            title: '',
            subtitle: '',
            imageUrl: '',
            hint: null,
        }
    );
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .about-hero {
        position: relative;
        &__container {
            @include horizontal-layout;
        }
        &__head {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            @include horizontal-max-height;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__title {
            @include block-title;
        }
        &__subtitle {
            font-size: lineScale(22, 18, 480, 1440);
            font-weight: $fw-semi;
            line-height: 1.2;
            text-transform: uppercase;
            max-width: 40ch;
            margin-top: rem(32);
        }
        // Временное изображение
        //
        &__image-container {
            position: relative;
            bottom: calc($py * -1);
            max-width: rem(640);
            min-height: rem(340);
            max-height: 100%;
            overflow: hidden;
            margin-top: rem(32);
            &::before {
                content: '';
                position: absolute;
                top: 25%;
                left: 50%;
                translate: -50% 0;
                width: 100%;
                aspect-ratio: 1;
                border-radius: 50%;
                background-color: $c-accent;
                pointer-events: none;
            }
        }
        &__image {
            position: relative;
            z-index: 1;
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        //
        /////
        &__body {
            position: relative;
        }
        &__text-image-container {
            width: 100%;
            height: 100%;
            user-select: none;
        }
        &__text-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        &__interactive {
            &--face {
                position: absolute;
                top: rem(-330);
                right: rem(480);
                width: rem(415);
                height: rem(800);
                pointer-events: none;
                &-container {
                    width: rem(415);
                    height: rem(485);
                    pointer-events: auto;
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: contain;
                        rotate: 5deg;
                        transform: scaleY(-1);
                    }
                }
            }
        }
        &__footer {
            position: relative;
            display: flex;
        }
        &__hint {
            grid-row: 2;
            align-self: flex-end;
        }
    }

    @media (max-width: 768px) {
        .hero {
            &__image-container {
                position: initial;
            }
            img.hero__sticker {
                display: none;
            }
            &__sticker--hide {
                display: none;
            }
        }
    }
</style>
