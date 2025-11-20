<template>
    <section class="about-brand">
        <div class="about-brand__container">
            <div class="about-brand__body">
                <AboutBrandStickers />
                <picture class="about-brand__image-container">
                    <img class="about-brand__image" :src="props.letters.B" alt="#" />
                </picture>
                <picture class="about-brand__image-container">
                    <img class="about-brand__image" :src="props.letters.R" alt="#" />
                </picture>
                <picture class="about-brand__image-container">
                    <img class="about-brand__image" :src="props.letters.A" alt="#" />
                </picture>
                <picture class="about-brand__image-container">
                    <img class="about-brand__image" :src="props.letters.N" alt="#" />
                </picture>
                <picture class="about-brand__image-container">
                    <img class="about-brand__image" :src="props.letters.D" alt="#" />
                </picture>
            </div>
            <div class="about-brand__hint">
                <TheSectionHint class="home-hero__hint" :hint="props.hint" />
            </div>
            <div class="about-brand__services">
                <CircleButton
                    style="position: absolute; left: 55%; bottom: 0; rotate: -6deg"
                    type="NuxtLink"
                    to="services"
                    variant="red"
                >
                    <span>Услуги</span>
                </CircleButton>
                <h2 class="about-brand__services-title">{{ props.title }}</h2>
                <p class="about-brand__services-subtitle" v-if="props.subtitle">
                    {{ props.subtitle }}
                </p>

                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_1" alt="#" />
                </picture>
                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_2" alt="#" />
                </picture>
                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_3" alt="#" />
                </picture>
                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_4" alt="#" />
                </picture>
                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_5" alt="#" />
                </picture>
                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_6" alt="#" />
                </picture>
                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_7" alt="#" />
                </picture>
                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_8" alt="#" />
                </picture>
                <picture class="about-brand__services-image-container">
                    <img class="about-brand__services-image" :src="props.gallery.image_9" alt="#" />
                </picture>
            </div>

            <FormPrimary
                :image="props.form_image ?? ''"
                :title="props.form_title ?? ''"
                :description="props.form_subtitle ?? ''"
            />
            <div class="about-brand__footer">
                <CircleButton
                    style="position: absolute; left: 0%; bottom: -5%"
                    type="NuxtLink"
                    to="contact"
                    variant="grey"
                >
                    <span>Контакты</span>
                </CircleButton>
                <picture class="about-brand__footer-image-container">
                    <img
                        class="about-brand__footer-image"
                        :src="props.footer_image"
                        alt="Игорь Кулагин"
                    />
                </picture>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { IVideoHint } from '~~/interfaces/chunks/hint';

    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string | null;

            form_title: string;
            form_subtitle: string;
            form_image: string;

            hint: IVideoHint | null;

            footer_image: string;

            letters: {
                B: string;
                R: string;
                A: string;
                N: string;
                D: string;
            };
            gallery: {
                image_1: string;
                image_2: string;
                image_3: string;
                image_4: string;
                image_5: string;
                image_6: string;
                image_7: string;
                image_8: string;
                image_9: string;
            };
        }>(),
        {}
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .about-brand {
        color: $c-F3F2EE;
        background-color: $c-111111;
        &__container {
            @include horizontal-layout;
        }
        &__body {
            position: relative;
            display: flex;
            align-items: center;
            gap: lineScale(32, 16, 480, 1440);
        }
        &__sticker-container {
            max-width: rem(180);
            aspect-ratio: 1;
            z-index: 2;
            rotate: -10deg;
            user-select: none;
        }
        &__sticker {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__image-container {
            position: relative;
            z-index: 1;
            height: 100%;
            width: rem(560);
            mask-repeat: no-repeat;
            mask-size: 100% 100%;
            @include horizontal-max-height;
            &:nth-of-type(5n + 1) {
                mask-image: url(/img/masks/letters/b.svg);
                @media (max-width: 768px) {
                    mask-image: url(/img/masks/letters/b-rotate.svg);
                }
            }
            &:nth-of-type(5n + 2) {
                mask-image: url(/img/masks/letters/r.svg);
                @media (max-width: 768px) {
                    mask-image: url(/img/masks/letters/r-rotate.svg);
                }
            }
            &:nth-of-type(5n + 3) {
                mask-image: url(/img/masks/letters/a.svg);
                @media (max-width: 768px) {
                    mask-image: url(/img/masks/letters/a-rotate.svg);
                }
            }
            &:nth-of-type(5n + 4) {
                mask-image: url(/img/masks/letters/n.svg);
                @media (max-width: 768px) {
                    mask-image: url(/img/masks/letters/n-rotate.svg);
                }
            }
            &:nth-of-type(5n + 5) {
                mask-image: url(/img/masks/letters/d.svg);
                @media (max-width: 768px) {
                    mask-image: url(/img/masks/letters/d-rotate.svg);
                }
            }
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__hint {
            display: flex;
            align-items: flex-end;
        }
        &__services {
            position: relative;
            height: 100%;
            display: grid;
            grid-template-columns: repeat(6, auto);
            grid-template-rows: repeat(5, 1fr);
            grid-template-areas:
                '. . image-3 image-3 . .'
                '. image-2 image-3 image-3 image-4 image-5'
                'image-1 image-2 image-3 image-3 image-4 image-5'
                'image-1 image-6 image-6 image-7 image-8 image-9'
                '. image-6 image-6 . image-8 .';
            padding: 0 $px;
            @include horizontal-max-height;
            &-title,
            &-subtitle {
                text-shadow: 1px 1px 5px $c-111111;
                // mix-blend-mode: exclusion;
            }
            &-title {
                position: absolute;
                z-index: 1;
                top: 50%;
                left: 50%;
                translate: -50% -50%;
                white-space: nowrap;
                text-transform: uppercase;
                font-family: 'Fira-Extra', sans-serif;
                font-size: lineScale(120, 48, 480, 1440);
                font-weight: $fw-bold;
            }
            &-subtitle {
                position: absolute;
                z-index: 1;
                top: 60%;
                left: 25%;
                max-width: 15ch;
                text-transform: uppercase;
                font-size: lineScale(32, 24, 480, 1440);
                font-weight: $fw-bold;
            }
            &-image-container {
                &:nth-of-type(1) {
                    grid-area: image-1;
                    max-width: rem(326);
                    max-height: rem(326);
                    rotate: 9deg;
                    translate: 20% 0;
                }
                &:nth-of-type(2) {
                    grid-area: image-2;
                    max-width: rem(230);
                    max-height: rem(319);
                    rotate: -3deg;
                }
                &:nth-of-type(3) {
                    grid-area: image-3;
                    max-width: rem(464);
                    max-height: rem(464);
                    rotate: 2.55deg;
                }
                &:nth-of-type(4) {
                    grid-area: image-4;
                    max-width: rem(416);
                    max-height: rem(350);
                    rotate: -8deg;
                    translate: -10% 0;
                }
                &:nth-of-type(5) {
                    grid-area: image-5;
                    max-width: rem(400);
                    max-height: rem(350);
                    rotate: 7deg;
                    translate: -20% 0;
                }
                &:nth-of-type(6) {
                    grid-area: image-6;
                    max-width: rem(326);
                    max-height: rem(326);
                    rotate: 13deg;
                    translate: 10% -10%;
                }
                &:nth-of-type(7) {
                    grid-area: image-7;
                    max-width: rem(326);
                    max-height: rem(326);
                    rotate: 17deg;
                }
                &:nth-of-type(8) {
                    grid-area: image-8;
                    max-width: rem(326);
                    max-height: rem(326);
                    rotate: -6deg;
                    translate: -40% 0;
                }
                &:nth-of-type(9) {
                    grid-area: image-9;
                    max-width: rem(180);
                    max-height: rem(326);
                    rotate: 12deg;
                    translate: -80% 0;
                }
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__footer {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0 rem(64);
            &-image-container {
                max-width: rem(380);
                max-height: rem(524);
                rotate: 5deg;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
    }

    @media (max-width: 768px) {
        .about-brand {
            &__body {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }
            &__image-container {
                aspect-ratio: 2/1.5;
                width: 100%;
            }
            &__services {
                &-title {
                    width: 15ch;
                    text-align: center;
                    white-space: initial;
                }
                &-subtitle {
                    display: none;
                }
            }
        }
    }
</style>
