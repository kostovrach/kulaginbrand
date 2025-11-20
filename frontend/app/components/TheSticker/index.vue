<template>
    <div
        :class="[
            'sticker',
            `sticker--${variant}`,
            { 'sticker--nowrap': !props.textAccent && !props.textAccent.length },
        ]"
    >
        <span
            v-if="props.textAccent && props.textAccent.length"
            class="sticker__text sticker__text--accent"
        >
            {{ props.textAccent }}
        </span>
        <span
            v-if="props.textMain && props.textMain.length"
            class="sticker__text sticker__text--main"
        >
            {{ props.textMain }}
        </span>
    </div>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            textAccent?: string;
            textMain?: string;
            variant: 'default' | 'red' | 'black' | 'black-2' | 'grey';
        }>(),
        {
            textAccent: '',
            textMain: '',
            variant: 'default',
        }
    );
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .sticker {
        $p: &;

        position: relative;
        width: fit-content;
        max-width: rem(380);
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: rem(8);
        font-family: 'Fira-Extra', sans-serif;
        padding: rem(12);
        overflow: hidden;
        border-radius: rem(16);
        user-select: none;
        &::before {
            content: '';
            position: absolute;
            z-index: 2;
            inset: 0;
            opacity: 0.6;
            background-image: url('/img/patterns/variant1.png');
            background-size: 150% 150%;
            pointer-events: none;
        }
        &__text {
            width: fit-content;
            text-transform: uppercase;
            font-weight: $fw-semi;
            &--accent {
                max-width: fit-content;
                font-size: lineScale(60, 40, 480, 1440);
                line-height: 1;
                white-space: nowrap;
            }
            &--main {
                max-width: 15ch;
                font-size: lineScale(22, 18, 480, 1440);
            }
        }
        &--nowrap {
            white-space: nowrap;
            #{$p}__text--main {
                max-width: initial;
            }
        }
        &--default {
            color: $c-111111;
            background-color: $c-accent;
            &::before {
                background-position: 5% 10%;
            }
        }
        &--red {
            color: $c-111111;
            background-color: $c-accent;
            &::before {
                background-position: 200% 30%;
            }
        }
        &--black {
            color: $c-accent;
            background-color: $c-111111;
            &::before {
                background-position: 120% 100%;
            }
        }
        &--black-2 {
            color: $c-main;
            background-color: $c-111111;
            &::before {
                background-position: 120% 100%;
            }
        }
        &--grey {
            color: $c-111111;
            background-color: $c-9E9595;
            &::before {
                background-position: 81% -10%;
            }
        }
        > * {
            flex: 1 1 50%;
        }
    }
</style>
