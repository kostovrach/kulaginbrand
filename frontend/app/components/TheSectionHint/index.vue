<template>
    <div class="section-hint">
        <h3 class="section-hint__title">{{ props.hint?.title }}</h3>
        <p class="section-hint__text">{{ props.hint?.description }}</p>
        <button class="section-hint__media" @click="openVideo">
            <span class="section-hint__media-icon"><SvgSprite type="arrow" :size="30" /></span>

            <div
                v-if="props.hint?.video_url && props.hint?.video_url.length"
                class="section-hint__media-video-container"
            >
                <video class="section-hint__media-video" autoplay muted loop playsinline>
                    <source :src="props.hint?.video_url" type="video/mp4" />
                </video>
            </div>

            <div class="section-hint__media-button">
                <span><SvgSprite type="play" :size="11" /></span>
                <p>{{ props.hint?.button_text }}</p>
            </div>
        </button>
    </div>
</template>

<script setup lang="ts">
    import type { IVideoHint } from '~~/interfaces/chunks/hint';
    import { ModalsVideo } from '#components';
    import { useModal } from 'vue-final-modal';

    const props = withDefaults(defineProps<{ hint: IVideoHint | null }>(), { hint: null });

    const { open: openVideo, close: closeVideo } = useModal({
        component: ModalsVideo,
        attrs: {
            title: props.hint?.title ?? '',
            videoUrl: props.hint?.video_url ?? '',
            onClose() {
                closeVideo();
            },
        },
    });
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .section-hint {
        $p: &;

        width: fit-content;
        height: fit-content;
        display: flex;
        flex-direction: column;
        &__title {
            max-width: 23ch;
            text-transform: uppercase;
            font-size: lineScale(32, 24, 480, 1440);
            font-weight: $fw-bold;
        }
        &__text {
            max-width: 30ch;
            font-family: 'Inter', sans-serif;
            font-size: rem(14);
            font-weight: $fw-med;
            margin-top: rem(18);
        }
        &__media {
            cursor: pointer;
            width: fit-content;
            display: grid;
            grid-template-areas:
                'icon .'
                'media button';
            gap: rem(16);
            margin-top: rem(32);

            @media (pointer: fine) {
                &:hover {
                    #{$p}__media {
                        &-icon svg {
                            animation: arrow-translate calc($td * 1.2) $tf;
                        }
                    }
                    > svg {
                        animation: arrow-translate calc($td * 1.2) $tf;
                    }
                    #{$p}__media-image-container,
                    #{$p}__media-video-container {
                        &::before {
                            opacity: 0;
                        }
                    }
                }
            }
            &-icon {
                grid-area: icon;
                width: fit-content;
                rotate: 45deg;
                overflow: hidden;
                @keyframes arrow-translate {
                    0% {
                        translate: 0 0;
                        opacity: 1;
                    }
                    45% {
                        translate: 100% 0;
                        opacity: 0;
                    }
                    55% {
                        translate: -100% 0;
                        opacity: 0;
                    }
                    100% {
                        translate: 0 0;
                        opacity: 1;
                    }
                }
            }
            &-image-container,
            &-video-container {
                grid-area: media;
                position: relative;
                z-index: 0;
                width: rem(160);
                aspect-ratio: 1;
                height: 100%;
                object-fit: cover;
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 2;
                    inset: 0;
                    backdrop-filter: blur(5px) saturate(0);
                    background-image: url('/img/patterns/noise.png');
                    pointer-events: none;
                    transition: opacity $td $tf;
                }
            }
            &-image,
            &-video {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-button {
                grid-area: button;
                align-self: flex-end;
                display: flex;
                flex-direction: column;
                gap: rem(8);
                > span {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    width: rem(48);
                    aspect-ratio: 1;
                    border: rem(2) solid currentColor;
                    border-radius: 50%;
                }
                > p {
                    max-width: 15ch;
                    text-transform: uppercase;
                    font-family: 'Fira-Extra', sans-serif;
                    font-size: lineScale(18, 16, 480, 1440);
                    font-weight: $fw-med;
                }
            }
        }
    }

    @media (max-width: 768px) {
        .section-hint {
            width: 100%;
            &__title {
                max-width: initial;
            }
        }
    }
</style>
