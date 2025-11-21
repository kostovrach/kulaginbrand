<template>
    <header class="header">
        <div class="header__container">
            <div class="header__logo-container">
                <NuxtLink class="header__logo" :to="{ name: 'about' }">игорь кулагин</NuxtLink>
                <NuxtLink class="header__sublogo" :to="{ name: 'index' }">KULAGIN GROUP</NuxtLink>
            </div>
            <div class="header__controls">
                <nav class="header__nav">
                    <NuxtLink
                        :class="['header__nav-link', { current: route.name == 'about' }]"
                        :to="{ name: 'about' }"
                    >
                        Обо мне
                    </NuxtLink>
                    <NuxtLink
                        :class="['header__nav-link', { current: route.name == 'services' }]"
                        :to="{ name: 'services' }"
                    >
                        Услуги
                    </NuxtLink>
                    <NuxtLink
                        :class="['header__nav-link', { current: route.name == 'projects' }]"
                        :to="{ name: 'projects' }"
                    >
                        Все Проекты
                    </NuxtLink>
                    <NuxtLink
                        :class="['header__nav-link', { current: route.name == 'hobby' }]"
                        :to="{ name: 'hobby' }"
                    >
                        Хобби
                    </NuxtLink>
                    <NuxtLink
                        :class="['header__nav-link', { current: route.name == 'marketers' }]"
                        :to="{ name: 'marketers' }"
                    >
                        Маркетологам
                    </NuxtLink>
                    <NuxtLink
                        :class="['header__nav-link', { current: route.name == 'blog' }]"
                        :to="{ name: 'blog' }"
                    >
                        Блог
                    </NuxtLink>
                    <NuxtLink
                        :class="['header__nav-link', { current: route.name == 'contact' }]"
                        :to="{ name: 'contact' }"
                    >
                        Контакты
                    </NuxtLink>
                </nav>
                <NuxtLink class="header__button" :to="{ name: 'contact' }">
                    Связаться со мной
                </NuxtLink>
                <div class="header__menu">
                    <TheHeaderBurger @click="openMenu" />
                </div>
            </div>
        </div>
    </header>
</template>

<script setup lang="ts">
    import { ModalsSideMenu } from '#components';
    import { useModal } from 'vue-final-modal';

    const route = useRoute();

    // modals ==============================================================================
    const { open: openMenu, close: closeMenu } = useModal({
        component: ModalsSideMenu,
        attrs: {
            onClose() {
                closeMenu();
            },
        },
    });
    // =====================================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .header {
        $p: &;

        position: fixed;
        z-index: 10;
        top: 0;
        left: 0;
        width: 100%;
        padding: rem(16) $px;
        pointer-events: none;
        mix-blend-mode: difference;
        &__container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: rem(32);
            white-space: nowrap;
        }
        &__logo-container {
            display: flex;
            align-items: center;
            gap: rem(32);
            color: $c-F3F2EE;
        }
        &__logo {
            text-transform: uppercase;
            font-size: lineScale(32, 24, 480, 1440);
            line-height: 1;
            font-weight: $fw-bold;
            pointer-events: auto;
            @media (pointer: fine) {
                &:hover {
                    rotate: -1.5deg;
                }
            }
        }
        &__sublogo {
            cursor: pointer;
            text-transform: uppercase;
            font-size: rem(14);
            font-weight: $fw-semi;
            pointer-events: auto;
            @include gradient-text-hover($main-color: $c-FFFFFF, $accent-color: $c-0FD2D3);
            &.current {
                background-position: -160% -200%;
                pointer-events: none;
            }
        }
        &__controls {
            display: flex;
            align-items: center;
            gap: rem(32);
        }
        &__nav {
            display: flex;
            align-items: center;
            gap: rem(32);
            &-link {
                cursor: pointer;
                text-transform: uppercase;
                font-size: rem(14);
                font-weight: $fw-semi;
                pointer-events: auto;
                @include gradient-text-hover($main-color: $c-FFFFFF, $accent-color: $c-0FD2D3);
                &.current {
                    background-position: -160% -200%;
                    pointer-events: none;
                }
            }
        }
        &__button {
            cursor: pointer;
            position: relative;
            text-transform: uppercase;
            color: $c-FFFFFF;
            font-size: rem(14);
            font-weight: $fw-med;
            padding: rem(14) rem(32);
            border-radius: rem(32);
            box-shadow:
                0 0 15px rgba($c-FFFFFF, 0.1),
                inset 0 0 15px rgba($c-FFFFFF, 0.1);
            border: rem(1) solid $c-000000;
            overflow: hidden;
            transition: color $td $tf;
            pointer-events: auto;
            &::before {
                content: '';
                position: absolute;
                z-index: -1;
                inset: 0;
                pointer-events: none;
                border-radius: inherit;
                background-image: linear-gradient(90deg, $c-0FD2D3 40%, $c-000000 50%);
                background-size: 250% 200%;
                background-position: -80% -100%;
                transition: background-position $td $tf;
            }
            @media (pointer: fine) {
                &:hover {
                    color: $c-111111;
                    &::before {
                        background-position: -165% -200%;
                    }
                }
            }
            &:active {
                color: $c-000000;
                background-color: $c-FFFFFF;
                scale: 0.95;
                &::before {
                    display: none;
                }
            }
        }
        &__menu {
            pointer-events: auto;
            display: none;
        }
    }

    @media (max-width: 1260px) {
        .header {
            &__sublogo {
                display: none;
            }
            &__nav {
                &-link {
                    display: none;
                }
            }
            &__button {
                display: none;
            }
            &__menu {
                display: initial;
            }
        }
    }
</style>
