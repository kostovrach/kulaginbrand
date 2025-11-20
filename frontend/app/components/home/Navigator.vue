<template>
    <li class="navigator">
        <CircleButton
            class="navigator__follower"
            v-follow-cursor="{ bound: true }"
            type="router-link"
            to="/about"
            variant="red"
            logic="noanim"
            style="font-size: 20px; cursor: none"
            >Познакомиться</CircleButton
        >
        <div class="navigator__wrapper">
            <div class="navigator__titlebox">
                <h1 class="navigator__title">{{ content?.title }}</h1>
                <p class="navigator__subtitle">{{ content?.description }}</p>
            </div>
            <picture class="navigator__image-container">
                <img class="navigator__image" :src="content?.image_url" alt="Игорь Кулагин" />
            </picture>
            <ButtonPrimary
                class="navigator__button"
                type="router-link"
                to="/about"
                variant="red"
                style="font-size: 20px"
                >Познакомиться</ButtonPrimary
            >
            <div class="navigator__socials">
                <h3 class="navigator__socials-title">Публикую творчество в соцсетях</h3>
                <div class="navigator__socials-list">
                    <a class="navigator__socials-item" :href="page?.vk?.link" target="_blank" rel="noopener noreferrer">
                        <img src="/img/stickers/vk.png" alt="vk" />
                    </a>
                    <a
                        class="navigator__socials-item"
                        :href="page?.telegram?.link"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <img src="/img/stickers/tg.png" alt="tg" />
                    </a>
                    <a
                        class="navigator__socials-item"
                        :href="page?.whatsapp?.link"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <img src="/img/stickers/whatsapp.png" alt="whatsapp" />
                    </a>
                    <a class="navigator__socials-item" :href="page?.ok?.link" target="_blank" rel="noopener noreferrer">
                        <img src="/img/stickers/ok.png" alt="ok" />
                    </a>
                    <a
                        class="navigator__socials-item"
                        :href="page?.tiktok?.link"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <img src="/img/stickers/tiktok.png" alt="tiktok" />
                    </a>
                </div>
            </div>
        </div>
    </li>
</template>

<script setup>
import ButtonPrimary from '@/components/ButtonPrimary/ButtonPrimary.vue';

// content management
import { usePage } from '@/composables/usePage';

const { page } = usePage('socials', ['vk.*', 'whatsapp.*', 'tiktok.*', 'telegram.*', 'ok.*'], {
    resolveFiles: true,
});
//

defineProps({
    content: { type: Object, default: () => ({}) },
});
</script>

<style lang="scss" scoped>
@use '@/assets/abstracts' as *;

.navigator {
    position: relative;
    background-color: $c-main;
    border-radius: rem(24);
    overflow: hidden;
    &__follower {
        @media (pointer: coarse) {
            display: none;
        }
    }
    &__wrapper {
        height: 100%;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-template-rows: repeat(3, auto);
        grid-template-areas:
            'titlebox titlebox socials'
            'image image socials'
            'image image socials';
    }
    &__titlebox {
        grid-area: titlebox;
        display: flex;
        flex-direction: column;
        gap: rem(16);
        padding: rem(16);
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
    &__button {
        position: absolute;
        right: 30%;
        bottom: -2.5%;
        rotate: 7deg;
        display: none;
        scale: 0.8;
        @media (pointer: coarse) {
            display: flex;
        }
    }
    &__image-container {
        grid-area: image;
        img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    }
    &__socials {
        grid-area: socials;
        justify-self: flex-end;
        position: relative;
        &-title {
            position: absolute;
            top: 50%;
            right: lineScale(48, 0, 480, 1440);
            text-transform: uppercase;
            font-family: 'Fira-Extra', sans-serif;
            font-size: lineScale(22, 18, 480, 1440);
            font-weight: $fw-med;
            white-space: nowrap;
            rotate: -90deg;
        }
        &-list {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            :nth-child(3n + 1) {
                rotate: -7deg;
            }
            :nth-child(3n + 2) {
                rotate: 5deg;
            }
            :nth-child(3n + 3) {
                rotate: -2deg;
            }
        }
        &-item {
            position: relative;
            z-index: 7;
            width: lineScale(150, 96, 480, 1440);
            aspect-ratio: 1;
            scale: 1.2;
            transition: translate $td $tf-spring;
            @media (pointer: fine) {
                &:hover {
                    translate: -15% 0;
                }
            }
            img {
                width: 100%;
                height: 100%;
                object-fit: contain;
                user-select: none;
            }
        }
    }
}
</style>
