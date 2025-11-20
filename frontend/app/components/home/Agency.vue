<template>
    <div class="agency" ref="container">
        <CircleButton
            class="agency__follower"
            type="a"
            href="https://kulaginbrand.ru"
            target="_blank"
            variant="grey"
            logic="noanim"
            :style="{
                translate: `${mouseX}px ${mouseY}px`,
                fontSize: '20px',
                cursor: 'none',
            }"
        >
            Заказать&nbsp;проект
        </CircleButton>
        <div class="agency__wrapper">
            <div class="agency__titlebox">
                <h2 class="agency__title">Дизайн студия</h2>
                <p class="agency__subtitle">
                    Симбиоз талантливых и неординарных личностей, создающих нечто более, чни просто
                    продукт
                </p>
                <a class="agency__link" :href="`tel:`">+7 (927) 714-33-39</a>
            </div>
            <CircleButton
                class="agency__button"
                type="a"
                href="https://kulaginbrand.ru"
                target="_blank"
                variant="grey"
                style="font-size: 20px"
            >
                Заказать&nbsp;проект
            </CircleButton>
            <AutoAccordion class="agency__list" :interval="5000">
                <li class="agency__item">
                    <h3 class="agency__item-title">Брендинг</h3>
                    <picture class="agency__item-image-container">
                        <img class="agency__item-image" src="/img/content/snapshot.gif" alt="#" />
                    </picture>
                </li>
                <li class="agency__item">
                    <h3 class="agency__item-title">Создание сайтов</h3>
                    <picture class="agency__item-image-container">
                        <img class="agency__item-image" src="/img/content/snapshot.gif" alt="#" />
                    </picture>
                </li>
                <li class="agency__item">
                    <h3 class="agency__item-title">Продвижение</h3>
                    <picture class="agency__item-image-container">
                        <img class="agency__item-image" src="/img/content/snapshot.gif" alt="#" />
                    </picture>
                </li>
            </AutoAccordion>
        </div>
    </div>
</template>

<script setup lang="ts">
    const container = ref<HTMLElement | null>(null);
    const { x: mouseX, y: mouseY } = useMouse({ target: container, touch: false });
    // defineProps({
    //     content: { type: Object, default: () => ({}) },
    // });
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .agency {
        $p: &;

        background-color: $c-main;
        border-radius: rem(24);
        padding: rem(16);
        overflow: hidden;
        &:not(:hover) {
            #{$p}__follower {
                opacity: 0;
            }
        }
        &__follower {
            position: absolute;
            top: 0;
            left: 0;
            transform: translate(-50%, -50%);
            transition: opacity $td $tf, translate 0.03s linear;
            @media (pointer: coarse) {
                display: none;
            }
        }
        &__wrapper {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(64);
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__title {
            text-transform: uppercase;
            font-family: 'Fira-Extra', sans-serif;
            font-size: lineScale(64, 32, 480, 1440);
            font-weight: $fw-bold;
        }
        &__subtitle {
            max-width: 45ch;
            font-family: 'Inter', sans-serif;
            font-size: rem(16);
            line-height: 1.4;
            margin-top: rem(16);
        }
        &__link {
            width: fit-content;
            font-family: 'Inter', sans-serif;
            @include gradient-text-hover;
        }
        &__button {
            position: absolute;
            top: 25%;
            right: 0;
            rotate: -7deg;
            display: none;
            scale: 0.8;
            @media (pointer: coarse) {
                display: flex;
            }
        }
        &__list {
            display: flex;
            gap: rem(8);
        }
        &__item {
            flex: 1 1 10%;
            position: relative;
            height: 100%;
            height: rem(430);
            overflow: hidden;
            transition: flex 1.2s $tf;
            &.active {
                flex: 1 1 65%;
                #{$p}__item-title {
                    transform: scaleX(1);
                    opacity: 1;
                }
            }
            &-title {
                position: absolute;
                z-index: 1;
                top: 50%;
                left: 50%;
                translate: -50% -50%;
                text-transform: uppercase;
                color: $c-main;
                font-family: 'Fira-Extra', sans-serif;
                font-size: lineScale(48, 18, 480, 1440);
                font-weight: $fw-med;
                white-space: nowrap;

                transform: scaleX(0.5);
                opacity: 0;
                transition: all 1.5s $tf-spring;
            }
            &-image-container {
                width: 100%;
                height: 100%;
                border-radius: rem(16);
                overflow: hidden;
                filter: brightness(60%);
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
        }
    }
</style>
