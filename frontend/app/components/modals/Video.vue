<template>
    <VueFinalModal overlay-transition="vfm-fade" content-transition="vfm-fade">
        <div class="modal-video">
            <div class="modal-video__header">
                <h2 class="modal-video__title">{{ props.title }}</h2>
                <button
                    class="modal-video__button"
                    type="button"
                    aria-label="Закрыть"
                    @click="emit('close')"
                >
                    <SvgSprite type="cross" :size="32" />
                </button>
            </div>
            <div class="modal-video__body">
                <video
                    class="modal-video__video"
                    controls
                    playsinline
                    v-if="props.videoUrl && props.videoUrl.length"
                >
                    <source :src="props.videoUrl" type="video/mp4" />
                </video>
                <p class="modal-video__error" v-else>Кажется видео потерялось 🔍</p>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    const props = withDefaults(
        defineProps<{
            title: string;
            videoUrl: string;
        }>(),
        {
            title: 'Про уникальный опыт',
            videoUrl: '',
        }
    );

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-video {
        position: fixed;
        top: 50%;
        left: 50%;
        translate: -50% -50%;
        width: 100%;
        max-width: rem(512);
        max-height: 85lvh;
        background-color: $c-main;
        &__header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: rem(1) solid $c-111111;
        }
        &__title {
            text-transform: uppercase;
            font-family: 'Fira-Extra', sans-serif;
            font-size: rem(18);
            font-weight: $fw-med;
            line-height: 1;
            padding: rem(12) rem(24);
        }
        &__button {
            cursor: pointer;
            width: fit-content;
            border-left: rem(1) solid $c-111111;
            padding: rem(8);
            > svg {
                will-change: rotate;
                transition: rotate $td $tf-spring;
            }
            @media (pointer: fine) {
                &:hover svg {
                    rotate: 90deg;
                }
            }
        }
        &__body {
            padding: rem(24);
        }
        &__video {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__error {
            font-size: lineScale(24, 18, 480, 1440);
            line-height: 1.5;
            text-align: center;
            padding: rem(64) rem(32);
        }
    }
</style>
