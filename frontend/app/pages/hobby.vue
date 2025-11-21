<template>
    <NuxtLayout>
        <section class="hobby">
            <div class="hobby__container">
                <div class="hobby__titlebox">
                    <h1 class="hobby__title fade-bottom-rotate">{{ page?.title }}</h1>
                </div>
                <EmblaContainer
                    ref="sliderRef"
                    class="hobby__slider"
                    :options="sliderOptions"
                    overflow="visible"
                >
                    <EmblaSlide
                        v-for="(slide, idx) in hobby"
                        :key="slide.id"
                        :class="['hobby__slide', { active: selectedSnap === idx }]"
                        :space-between="96"
                        width="100%"
                    >
                        <div class="hobby__slide-wrapper">
                            <h2 class="hobby__slide-title">{{ slide.title }}</h2>
                            <template v-if="slide.file.type.startsWith('video/')">
                                <div
                                    class="hobby__slide-video-container"
                                    :style="{ '--mask': `url('${masks[idx % masks.length]}')` }"
                                >
                                    <video
                                        class="hobby__slide-video"
                                        muted
                                        autoplay
                                        loop
                                        playsinline
                                    >
                                        <source
                                            :src="`/api/cms/assets/${slide.file.id}`"
                                            :type="slide.file.type"
                                        />
                                    </video>
                                </div>
                            </template>
                            <template v-else>
                                <picture
                                    class="hobby__slide-image-container"
                                    :style="{ '--mask': `url('${masks[idx % masks.length]}')` }"
                                >
                                    <img
                                        class="hobby__slide-image"
                                        :src="`/api/cms/assets/${slide.file.id}`"
                                        :alt="slide.title ?? '#'"
                                    />
                                </picture>
                            </template>
                            <p class="hobby__slide-desc" v-if="slide.subtitle">
                                {{ slide.subtitle }}
                            </p>
                        </div>
                    </EmblaSlide>
                </EmblaContainer>
                <div class="hobby__controls">
                    <button
                        class="hobby__button hobby__button--prev"
                        type="button"
                        @click="scrollPrev"
                    >
                        <SvgSprite type="arrow" :size="32" />
                    </button>
                    <button
                        class="hobby__button hobby__button--next"
                        type="button"
                        @click="scrollNext"
                    >
                        <SvgSprite type="arrow" :size="32" />
                    </button>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import { EmblaContainer, EmblaSlide } from '#components';
    import type { EmblaCarouselType } from 'embla-carousel';
    import type { EmblaOptionsType } from 'embla-carousel';
    import type { IDirectusFile } from '~~/interfaces/direcctus-file';

    interface IHobby {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        subtitle: string | null;
        file: IDirectusFile;
    }

    // data =================================================================
    const { content: hobby } = useCms<IHobby[]>('hobby', ['file.*']);
    const { content: page } = useCms<{ title: string }>('hobby_page');

    const masks = ['/img/masks/guitar.svg', '/img/masks/helmet.svg'];
    // ======================================================================

    // slider ================================================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const sliderOptions: EmblaOptionsType = {
        align: 'center',
        loop: true,
    };

    const selectedSnap = ref<number>(0);

    const updateSnapDisplay = () => {
        selectedSnap.value = sliderRef.value?.emblaApi?.selectedScrollSnap() ?? 0;
    };

    const scrollPrev = useDebounceFn(() => sliderRef?.value?.emblaApi?.scrollPrev(), 100);
    const scrollNext = useDebounceFn(() => sliderRef?.value?.emblaApi?.scrollNext(), 100);

    let wheelHandler: (event: WheelEvent) => void;
    // =======================================================================

    onMounted(() => {
        sliderRef.value?.emblaApi?.on('select', updateSnapDisplay).on('reInit', updateSnapDisplay);
        updateSnapDisplay();

        wheelHandler = (event: WheelEvent) => {
            event.preventDefault();
            if (event.deltaY > 0) scrollNext();
            if (event.deltaY < 0) scrollPrev();
        };

        window.addEventListener('wheel', wheelHandler, { passive: false });
    });
    onBeforeMount(() => {
        if (wheelHandler) {
            window.removeEventListener('wheel', wheelHandler);
        }
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .hobby {
        $p: &;

        width: 100vw;
        overflow: hidden;
        @include horizontal-layout;
        &__container {
            position: relative;
        }
        &__titlebox {
            position: absolute;
            top: 0;
            left: 0;
        }
        &__title {
            @include block-title;
        }
        &__slider {
            height: 100%;
            max-width: calc(100vw - ($px * 2));
        }
        &__slide {
            position: relative;
            height: 75lvh;
            max-width: rem(560);
            will-change: scale;
            transition: scale $td $tf;
            user-select: none;
            @include horizontal-max-height;
            &:not(.active) {
                scale: 0.5;
                #{$p}__slide-title,
                #{$p}__slide-desc {
                    opacity: 0;
                    translate: -50% 0;
                }
            }
            &-wrapper {
                width: 100%;
                height: 100%;
            }
            &-image-container,
            &-video-container {
                width: 100%;
                height: 100%;
                mask-image: var(--mask);
                mask-size: 100% 100%;
                mask-repeat: no-repeat;
                user-select: none;
            }
            &-image,
            &-video {
                width: 100%;
                height: 100%;
                min-height: rem(480);
                aspect-ratio: 2/1; // <-----
                object-fit: cover;
            }
            &-title {
                min-width: 25ch;
                position: absolute;
                top: 20%;
                left: 90%;
                text-transform: uppercase;
                font-size: lineScale(22, 18, 480, 1440);
                line-height: 1.2;
                font-weight: $fw-med;
                will-change: opacity;
                transition:
                    opacity $td $tf,
                    translate $td $tf;
            }
            &-desc {
                min-width: 45ch;
                position: absolute;
                bottom: 10%;
                left: 100%;
                text-transform: uppercase;
                font-size: rem(16);
                line-height: 1.4;
                font-weight: $fw-med;
                will-change: opacity;
                transition:
                    opacity $td $tf,
                    translate $td $tf;
            }
        }
        &__controls {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(32);
        }
        &__button {
            cursor: pointer;
            &--prev {
                transform: scaleX(-1);
            }
        }
    }

    @media (max-width: 1100px) {
        .hobby {
            &__container {
                display: flex;
                flex-direction: column;
                gap: rem(64);
            }
            &__titlebox {
                position: initial;
            }
            &__slider {
                height: fit-content;
                &-wrapper {
                    height: fit-content;
                }
            }
            &__slide {
                max-width: initial;
                height: initial;
                &-wrapper {
                    display: grid;
                    grid-template-areas:
                        'image title'
                        'image . '
                        'image desc';
                }
                &-image-container {
                    grid-area: image;
                    width: rem(320);
                    height: rem(480);
                }
                &-title,
                &-desc {
                    position: static;
                    min-width: initial;
                }
                &-title {
                    grid-area: title;
                }
                &-desc {
                    grid-area: desc;
                }
            }
        }
    }

    @media (max-width: 560px) {
        .hobby {
            &__slide {
                &-wrapper {
                    display: flex;
                    flex-direction: column;
                    gap: rem(24);
                }
                &-image-container {
                    align-self: center;
                }
            }
        }
    }
</style>
