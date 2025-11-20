<template>
    <VueFinalModal overlay-transition="vfm-fade" content-transition="vfm-slide-top">
        <div class="modal-interviews">
            <div class="interviews-modal__container">
                <div class="interviews-modal__header">
                    <h2 class="interviews-modal__title">Интервью</h2>
                    <button
                        class="interviews-modal__button"
                        aria-label="Закрыть"
                        @click="emit('close')"
                    >
                        <SvgSprite type="cross" :size="32" />
                    </button>
                </div>
                <div class="interviews-modal__body">
                    <ul class="interviews-modal__list">
                        <!-- <li
                            v-for="item in page?.interviews_item"
                            :key="item.id"
                            class="interviews-modal__item"
                        >
                            <picture class="interviews-modal__item-image-container">
                                <img
                                    class="interviews-modal__item-image"
                                    :src="item.interviews_item_id?.logo_url"
                                    :alt="item.interviews_item_id?.title"
                                />
                            </picture>
                            <div class="interviews-modal__item-content">
                                <h3 class="interviews-modal__item-title">
                                    {{ item.interviews_item_id?.title }}
                                </h3>
                                <a
                                    v-if="item.interviews_item_id?.link"
                                    class="interviews-modal__item-button"
                                    :href="item.interviews_item_id?.link"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    <span class="interviews-modal__item-button-text">Смотреть</span>
                                    <span class="interviews-modal__item-button-icon">
                                        <TheSvgSprite type="arrow" :size="12" />
                                    </span>
                                </a>
                            </div>
                        </li> -->
                    </ul>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .interviews-modal {
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
        .interviews-modal {
            &__list {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
