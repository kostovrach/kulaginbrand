<template>
    <CircleButton
        class="sticker"
        style="position: absolute; left: 12%; top: 15%"
        type="NuxtLink"
        to="services"
        variant="red"
    >
        <span>Услуги</span>
    </CircleButton>

    <CircleButton
        class="sticker"
        style="position: absolute; left: 20%; top: 45%"
        type="button"
        variant="grey"
        logic="double-line"
        @click="openInterviews"
    >
        <span>Упоминания в&nbsp;СМИ</span>
    </CircleButton>

    <CircleButton
        v-if="contact?.studio_link"
        class="sticker"
        style="position: absolute; left: 45%; top: 5%"
        type="a"
        :href="contact.studio_link.trim().replace(/\s+/g, '')"
        target="_blank"
        variant="grey"
    >
        <span>Студия</span>
    </CircleButton>

    <CircleButton
        class="sticker"
        style="position: absolute; right: 10%; top: 55%"
        type="NuxtLink"
        to="hobby"
        variant="red"
    >
        <span>Мои хобби</span>
    </CircleButton>

    <Draggble :top="-5" :left="75">
        <img
            class="sticker"
            src="/img/stickers/igor.png"
            style="pointer-events: auto; width: 220px; rotate: 9deg"
            alt="#"
        />
    </Draggble>

    <Draggble :top="30" :left="55">
        <img
            class="sticker"
            src="/img/stickers/theplace-white.png"
            style="pointer-events: auto; width: 220px; rotate: 5deg"
            alt="#"
        />
    </Draggble>

    <Draggble :top="65" :left="-3">
        <TheSticker
            class="sticker"
            style="rotate: -10deg"
            variant="default"
            textAccent="от 120%"
            textMain="средний рост конверсии"
        />
    </Draggble>

    <Draggble :top="35" :left="25">
        <TheSticker
            class="sticker"
            style="rotate: 5deg"
            variant="black"
            textAccent="от 120%"
            textMain="средний рост конверсии"
        />
    </Draggble>

    <Draggble :top="80" :left="35">
        <TheSticker
            class="sticker"
            style="rotate: -15deg"
            variant="red"
            textAccent="от 120%"
            textMain="средний рост конверсии"
        />
    </Draggble>
</template>

<script setup lang="ts">
    import type { IContact } from '~~/interfaces/contact';

    import { ModalsInterviews } from '#components';
    import { useModal } from 'vue-final-modal';

    const { open: openInterviews, close: closeInterviews } = useModal({
        component: ModalsInterviews,
        attrs: {
            onClose() {
                closeInterviews();
            },
        },
    });

    const { content: contact } = useCms<IContact>('contact');
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;
</style>
