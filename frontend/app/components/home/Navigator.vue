<template>
    <div class="navigator">
        <CircleButton
            class="navigator__follower"
            type="NuxtLink"
            to="about"
            variant="red"
            logic="noanim"
            :style="{
                translate: `${mouseX}px ${mouseY}px`,
                fontSize: '20px',
                cursor: 'none',
            }"
        >
            <span>Познакомиться</span>
        </CircleButton>
        <div ref="container" class="navigator__wrapper">
            <div class="navigator__titlebox">
                <h1 class="navigator__title">{{ props.title }}</h1>
                <p class="navigator__subtitle">{{ props.subtitle }}</p>
            </div>
            <picture class="navigator__image-container">
                <img class="navigator__image" :src="props.image" alt="Игорь Кулагин" />
            </picture>
            <CircleButton
                class="navigator__button"
                type="NuxtLink"
                to="about"
                variant="red"
                style="font-size: 20px"
            >
                <span>Познакомиться</span>
            </CircleButton>
            <div class="navigator__socials" v-if="props.contact">
                <h3 class="navigator__socials-title">Публикую творчество в соцсетях</h3>
                <div class="navigator__socials-list">
                    <a
                        v-if="props.contact.vk"
                        class="navigator__socials-item"
                        :href="props.contact.vk.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <img src="/img/stickers/vk.png" alt="vk" />
                    </a>
                    <a
                        v-if="props.contact.tg"
                        class="navigator__socials-item"
                        :href="props.contact.tg.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <img src="/img/stickers/tg.png" alt="tg" />
                    </a>
                    <a
                        v-if="props.contact.whatsapp"
                        class="navigator__socials-item"
                        :href="props.contact.whatsapp.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <img src="/img/stickers/whatsapp.png" alt="whatsapp" />
                    </a>
                    <a
                        v-if="props.contact.ok"
                        class="navigator__socials-item"
                        :href="props.contact.ok.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <img src="/img/stickers/ok.png" alt="ok" />
                    </a>
                    <a
                        v-if="props.contact.tiktok"
                        class="navigator__socials-item"
                        :href="props.contact.tiktok.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <img src="/img/stickers/tiktok.png" alt="tiktok" />
                    </a>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import type { IContact } from '~~/interfaces/contact';

    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string;
            image: string;
            contact: IContact | null;
        }>(),
        {
            title: '',
            subtitle: '',
            image: '',
            contact: null,
        }
    );

    const container = ref<HTMLElement | null>(null);
    const { elementX: mouseX, elementY: mouseY } = useMouseInElement(container, {
        handleOutside: false,
    });
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .navigator {
        $p: &;

        position: relative;
        background-color: $c-main;
        border-radius: rem(24);
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
            transition: opacity $td $tf;
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
