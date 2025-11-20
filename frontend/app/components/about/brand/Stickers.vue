<template>
    <CircleButton
        style="position: absolute; left: 12%; bottom: -2%"
        type="NuxtLink"
        to="blog"
        variant="grey"
        logic="double-line"
    >
        <span>личный блог</span>
    </CircleButton>

    <Draggble :top="-5" :left="35">
        <img
            class="about-brand__sticker--hide"
            src="/img/stickers/smile.png"
            alt="#"
            style="pointer-events: auto; width: 288px; rotate: 15deg"
        />
    </Draggble>

    <Draggble :top="70" :left="55">
        <img
            src="/img/stickers/thunder.png"
            alt="#"
            style="pointer-events: auto; width: 180px; rotate: 7deg"
        />
    </Draggble>

    <CircleButton
        style="position: absolute; right: 0; top: -10%; rotate: -5deg"
        type="NuxtLink"
        to="marketers"
        variant="grey"
    >
        <span>Маркетологам</span>
    </CircleButton>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    @media (max-width: 768px) {
        .about-brand {
            &__sticker--hide {
                display: none;
            }
        }
    }
</style>
