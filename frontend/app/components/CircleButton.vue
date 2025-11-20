<template>
    <component
        :is="componentTag"
        v-bind="{ ...attrs, ...$attrs }"
        :id="id || undefined"
        :class="[
            'circle-button',
            `circle-button--${props.logic}`,
            `circle-button--${props.variant}`,
        ]"
    >
        <div class="circle-button__body">
            <span v-if="firstPart">{{ firstPart }}</span>
            <span v-if="secondPart">
                {{ secondPart }}<SvgSprite type="arrow" :size="14" style="rotate: -45deg;" />
            </span>
            <div class="circle-button__icon">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </component>
</template>

<script setup lang="ts">
    import { NuxtLink } from '#components';

    interface IProps {
        type?: 'button' | 'a' | 'NuxtLink';
        logic?: 'double-line' | 'noanim' | 'basic';
        variant?: 'red' | 'grey' | 'black';
        to?: string;
        href?: string;
        buttonType?: string;
        target?: '' | '_blank' | '_self' | '_parent' | '_top';
        id?: string;
    }

    const props = withDefaults(defineProps<IProps>(), {
        type: 'a',
        logic: 'basic',
        variant: 'red',
        to: '/',
        href: '/',
        buttonType: 'button',
        target: '',
        id: '',
    });

    const slots = useSlots();

    const componentTag = computed(() => {
        switch (props.type) {
            case 'NuxtLink':
                return NuxtLink;
            case 'button':
                return 'button';
            default:
                return 'a';
        }
    });

    const attrs = computed(() => {
        switch (props.type) {
            case 'NuxtLink':
                return props.to ? { to: { name: props.to } } : {};
            case 'button':
                return { type: props.buttonType };
            case 'a':
                return {
                    href: props.href,
                    target: props.target || undefined,
                    rel: props.target === '_blank' ? 'noopener noreferrer' : undefined,
                };
            default:
                return {};
        }
    });

    const slotText = computed(() => {
        const raw = slots.default?.()[0]?.children || '';
        return typeof raw === 'string' ? raw : '';
    });

    const firstPart = computed(() => {
        const text = slotText.value;
        if (props.logic === 'double-line') return text.split(' ')[0] || '';
        return text.slice(0, Math.ceil(text.length / 2));
    });

    const secondPart = computed(() => {
        const text = slotText.value;
        if (props.logic === 'double-line') return text.split(' ').splice(1).join(' ') || '';
        return text.slice(Math.ceil(text.length / 2));
    });
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .circle-button {
        $p: &;

        cursor: pointer;
        position: relative;
        z-index: 2;
        width: fit-content;
        aspect-ratio: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        text-transform: uppercase;
        white-space: nowrap;
        font-size: lineScale(32, 24, 480, 1440); // <-----
        font-weight: $fw-bold; // <-----
        border-radius: 50%;
        padding: lineScale(32, 24, 480, 1440); // <-----
        box-shadow: rem(1) rem(1) rem(1) $c-111111;
        overflow: hidden;
        transition:
            background-color $td $tf,
            outline-color $td $tf;
        &::before {
            content: '';
            position: absolute;
            z-index: 1;
            inset: 0;
            background-image: url('/img/patterns/variant2.png');
            opacity: 0.4;
            pointer-events: none;
            transition: opacity $td $tf;
        }

        @media (pointer: fine) {
            // &:hover {
            //     &::before {
            //         background-color: $c-accent;
            //         border-color: transparent;
            //     }
            // }
            &:not(#{$p}--double-line, #{$p}--noanim):hover {
                #{$p}__body > span {
                    &:first-of-type {
                        translate: rem(-64) 0;
                        opacity: 0;
                    }
                    &:last-of-type {
                        translate: rem(64) 0;
                        opacity: 0;
                    }
                }
            }
            &:not(#{$p}--noanim):hover {
                background-color: $c-111111;
                outline-color: $c-111111;
                &::before {
                    opacity: 0;
                }
                #{$p}__icon {
                    > * {
                        background-position: 100% 100%;
                    }
                }
            }
        }
        &__body {
            display: flex;
            align-items: center;
            justify-content: center;
            > span {
                position: relative;
                z-index: 2;
                display: block;
                transition: all $td $tf;
            }
        }
        &__icon {
            position: absolute;
            z-index: 2;
            top: 50%;
            left: 50%;
            translate: -50% -50%;
            width: rem(96);
            aspect-ratio: 1;
            pointer-events: none;
            > * {
                display: block;
                position: absolute;
                width: rem(4);
                background-image: linear-gradient(to top, $c-FFFFFF 49%, transparent 50%);
                background-size: 200% 200%;
                transition: background-position $td $tf;
            }
            :nth-child(1) {
                top: 50%;
                left: 50%;
                translate: -50% -50%;
                height: rem(96);
                rotate: 45deg;
            }
            :nth-child(2) {
                height: rem(48);
                top: rem(14);
                right: rem(12);
            }
            :nth-child(3) {
                height: rem(48);
                top: rem(-9);
                right: rem(35);
                rotate: 90deg;
            }
        }
        &--double-line {
            #{$p}__body {
                overflow: hidden;
                flex-direction: column;
                gap: rem(4);
            }
            @media (pointer: fine) {
                &:hover {
                    #{$p}__body > span {
                        &:first-of-type {
                            translate: 0 rem(-32);
                            opacity: 0;
                        }
                        &:last-of-type {
                            translate: 0 rem(32);
                            opacity: 0;
                        }
                    }
                }
            }
        }
        &--red {
            background-color: $c-accent;
            color: $c-FFFFFF;
            outline-color: $c-accent;
        }
        &--grey {
            background-color: $c-FFFFFF;
            color: $c-111111;
            outline-color: $c-FFFFFF;
        }
        &--black {
            background-color: $c-111111;
            color: $c-FFFFFF;
            outline-color: $c-111111;
        }
    }
</style>
