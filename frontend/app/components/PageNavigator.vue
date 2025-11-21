<template>
    <NuxtLink
        :to="props.to"
        :class="['navigator', `navigator--${props.orientation}`, 'fade-right']"
    >
        <div class="navigator__container">
            <div class="navigator__body">
                <div class="navigator__titlebox">
                    <div class="navigator__tag">{{ props.tag }}</div>
                    <h2 class="navigator__title">{{ props.title }}</h2>
                </div>
                <picture v-if="props.image.length" class="navigator__image-container">
                    <img class="navigator__image" :src="props.image" alt="#" />
                </picture>
                <div class="navigator__icon">
                    <SvgSprite type="arrow" :size="96" />
                </div>
            </div>
        </div>
    </NuxtLink>
</template>

<script setup lang="ts">
    import type { RouteLocationAsRelativeGeneric } from 'vue-router';

    const props = withDefaults(
        defineProps<{
            image: string;
            orientation?: 'vertical' | 'horizontal';
            to: RouteLocationAsRelativeGeneric;
            tag: string;
            title: string;
        }>(),
        {
            orientation: 'vertical',
        }
    );
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .navigator {
        $p: &;

        position: relative;
        display: block;
        color: $c-main;
        background-color: $c-111111;
        &--vertical {
            min-width: fit-content;
            #{$p}__body {
                height: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: space-between;
                gap: rem(32);
            }
        }
        &--horizontal {
            width: 100%;
            #{$p}__body {
                display: flex;
                flex-direction: row;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: rem(32);
                @media (max-width: 768px) {
                    justify-content: center;
                }
            }
            #{$p}__image-container {
                max-width: rem(600);
            }
        }
        @media (pointer: fine) {
            &:hover {
                #{$p}__icon svg {
                    animation: arrow-translate calc($td * 1.2) $tf;
                }
            }
        }
        &__container {
            height: 100%;
            @include horizontal-layout;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            text-transform: uppercase;
        }
        &__tag {
            color: $c-9E9595;
            font-size: lineScale(32, 24, 480, 1440);
            line-height: 1;
            font-weight: $fw-bold;
        }
        &__title {
            @include block-title;
        }
        &__image-container {
            max-width: rem(200);
            height: rem(300);
            @media (max-width: 768px) {
                max-width: rem(600);
            }
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__icon {
            height: fit-content;
            rotate: 45deg;
            overflow: hidden;
        }
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
</style>
