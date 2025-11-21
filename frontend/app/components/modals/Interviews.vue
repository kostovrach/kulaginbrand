<template>
    <VueFinalModal overlay-transition="vfm-fade" content-transition="vfm-fade">
        <div class="modal-interviews">
            <div class="modal-interviews__container">
                <div class="modal-interviews__header">
                    <h2 class="modal-interviews__title">Интервью</h2>
                    <button
                        class="modal-interviews__button"
                        aria-label="Закрыть"
                        @click="emit('close')"
                    >
                        <SvgSprite type="cross" :size="32" />
                    </button>
                </div>
                <div class="modal-interviews__body">
                    <ul class="modal-interviews__list">
                        <li
                            v-for="item in interviews"
                            :key="item.id"
                            class="modal-interviews__item"
                        >
                            <picture class="modal-interviews__item-image-container">
                                <img
                                    class="modal-interviews__item-image"
                                    :src="item.image_url ?? '/img/human-placeholder.png'"
                                    :alt="item.title ?? '#'"
                                />
                            </picture>
                            <div class="modal-interviews__item-content">
                                <h3 class="modal-interviews__item-title">
                                    {{ item.title }}
                                </h3>
                                <a
                                    v-if="item.link"
                                    class="modal-interviews__item-button"
                                    :href="item.link.trim().replace(/\s+/g, '')"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    <span class="modal-interviews__item-button-text">Смотреть</span>
                                    <span class="modal-interviews__item-button-icon">
                                        <SvgSprite type="arrow" :size="12" />
                                    </span>
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    interface IInterview {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        link: string;
        image: string | null;
        image_url?: string;
    }

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const { content: interviews } = useCms<IInterview[]>('interviews');
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-interviews {
        position: fixed;
        top: 50%;
        left: 50%;
        translate: -50% -50%;
        width: 100%;
        height: 100%;
        max-width: rem(768);
        max-height: 90lvh;
        background-color: $c-main;
        &__container {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
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
            flex: 0 1 100%;
            overflow-y: auto;
            overflow-x: hidden;
            padding: 0 lineScale(24, 16, 480, 1440);
            mask-image: linear-gradient(to bottom, $c-main 90%, transparent 100%);
            @include hide-scrollbar;
        }
        &__list {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(32) rem(64);
            padding: rem(64) 0;
        }
        &__item {
            display: flex;
            align-items: center;
            gap: rem(16);
            &-image-container {
                width: rem(80);
                aspect-ratio: 1;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: contain;
                }
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(8);
            }
            &-title {
                text-transform: uppercase;
                font-family: 'Fira-Extra', sans-serif;
                font-size: lineScale(22, 18, 480, 1440);
                font-weight: $fw-bold;
            }
            &-button {
                display: flex;
                align-items: center;
                gap: rem(8);
                text-transform: uppercase;
                font-family: 'Fira-Extra', sans-serif;
                font-size: rem(14);
                font-weight: $fw-semi;
                color: $c-9E9595;
                @include hover-underline;
            }
        }
    }

    @media (max-width: 512px) {
        .modal-interviews {
            &__list {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
