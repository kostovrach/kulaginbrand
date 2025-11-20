<template>
    <div class="agency" ref="container">
        <CircleButton
            class="agency__follower"
            type="a"
            :href="props.link.trim().replace(/\s+/g, '') ?? '#'"
            target="_blank"
            variant="grey"
            logic="noanim"
            :style="{
                translate: `${mouseX}px ${mouseY}px`,
                fontSize: '20px',
                cursor: 'none',
            }"
        >
            <span>Заказать&nbsp;проект</span>
        </CircleButton>
        <div class="agency__wrapper">
            <div class="agency__titlebox">
                <h2 class="agency__title">{{ props.title }}</h2>
                <p class="agency__subtitle">{{ props.subtitle }}</p>
                <p class="agency__link" v-if="props.description.length">{{ props.description }}</p>
            </div>
            <CircleButton
                class="agency__button"
                type="a"
                :href="props.link.trim().replace(/\s+/g, '') ?? '#'"
                target="_blank"
                variant="grey"
                style="font-size: 20px"
            >
                Заказать&nbsp;проект
            </CircleButton>
            <HomeAutoAccordion :interval="5000" :items="props.slides"></HomeAutoAccordion>
        </div>
    </div>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string;
            description?: string;
            link: string;
            slides: {
                title: string;
                image: string;
            }[];
        }>(),
        {
            title: '',
            subtitle: '',
            description: '',
            slides: () => [],
        }
    );

    const container = ref<HTMLElement | null>(null);
    const { elementX: mouseX, elementY: mouseY } = useMouseInElement(container, {
        handleOutside: false,
    });
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .agency {
        $p: &;

        position: relative;
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
            transition:
                opacity $td $tf,
                translate 0.03s linear;
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
    }
</style>
