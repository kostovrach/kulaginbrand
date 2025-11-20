<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-menu">
            <div class="modal-menu__container">
                <button
                    class="modal-menu__button"
                    type="button"
                    aria-label="Закрыть"
                    @click="emit('close')"
                >
                    <SvgSprite type="cross" :size="32" />
                </button>
                <nav class="modal-menu__nav">
                    <NuxtLink
                        v-for="(link, idx) in navLinks"
                        :key="idx"
                        :class="['modal-menu__link', { current: route.name == link.path.name }]"
                        :to="link.path"
                    >
                        {{ link.label }}
                    </NuxtLink>
                </nav>
                <div class="modal-menu__footer">
                    <div class="modal-menu__socials">
                        <a
                            v-if="contact?.vk"
                            class="modal-menu__socials-item"
                            style="--mask: url(/img/masks/vk.svg)"
                            :href="contact?.vk.trim().replace(/\s+/g, '')"
                            target="_blank"
                            rel="noopener noreferrer"
                        ></a>
                        <a
                            v-if="contact?.tg"
                            class="modal-menu__socials-item"
                            style="--mask: url(/img/masks/telegram.svg)"
                            :href="contact.tg.trim().replace(/\s+/g, '')"
                            target="_blank"
                            rel="noopener noreferrer"
                        ></a>
                        <a
                            v-if="contact?.ok"
                            class="modal-menu__socials-item"
                            style="--mask: url(/img/masks/ok.svg)"
                            :href="contact?.ok.trim().replace(/\s+/g, '')"
                            target="_blank"
                            rel="noopener noreferrer"
                        ></a>
                        <a
                            v-if="contact?.instagram"
                            class="modal-menu__socials-item"
                            style="--mask: url(/img/masks/instagram.svg)"
                            :href="contact?.instagram.trim().replace(/\s+/g, '')"
                            target="_blank"
                            rel="noopener noreferrer"
                        ></a>
                    </div>
                </div>
                <div class="modal-menu__links">
                    <button
                        class="modal-menu__links-item"
                        type="button"
                        v-for="policy in policies"
                        :key="policy.id"
                        @click="
                            openDocsModal(
                                policy.date_updated ?? policy.date_created,
                                policy.title,
                                policy.content
                            )
                        "
                    >
                        {{ policy.title }}
                    </button>
                </div>
                <div class="modal-menu__label">
                    <p class="modal-menu__label-text">Сайт разработали:</p>
                    <a
                        class="modal-menu__label-link"
                        :href="contact?.studio_link.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        kulaginbrand.ru
                    </a>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import type { RouteLocationAsRelativeGeneric } from 'vue-router';
    import type { IContact } from '~~/interfaces/contact';
    import type { IPolicy } from '~~/interfaces/policy';
    import { useModal, VueFinalModal } from 'vue-final-modal';
    import { ModalsDocs } from '#components';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const route = useRoute();

    const { content: contact } = useCms<IContact>('contact');
    const { content: policies, status: policiesStatus } = useCms<IPolicy[]>('policies');

    function openDocsModal(date: string, title: string, content: string) {
        const { open: openPolicy, close: closePolicy } = useModal({
            component: ModalsDocs,
            attrs: {
                dateUpdated: date,
                title,
                content,
                status: policiesStatus.value,
                onClose() {
                    closePolicy();
                },
            },
        });
        openPolicy();
    }

    const navLinks: {
        label: string;
        path: RouteLocationAsRelativeGeneric;
    }[] = [
        {
            label: 'Kulagin brand',
            path: { name: 'index' },
        },
        {
            label: 'Обо мне',
            path: { name: 'about' },
        },
        {
            label: 'Услуги',
            path: { name: 'services' },
        },
        {
            label: 'Все проекты',
            path: { name: 'projects' },
        },
        {
            label: 'Хобби',
            path: { name: 'hobby' },
        },
        {
            label: 'Маркетологам',
            path: { name: 'marketers' },
        },
        {
            label: 'Блог',
            path: { name: 'blog' },
        },
        {
            label: 'Контакты',
            path: { name: 'contact' },
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-menu {
        position: fixed;
        z-index: 10;
        top: 0;
        right: 0;
        width: 100%;
        max-width: rem(360);
        height: 100vh;
        color: $c-main;
        background-color: $c-111111;
        padding: rem(16) rem(16) rem(64);
        &__container {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(16);
        }
        &__button {
            align-self: flex-end;
            cursor: pointer;
            width: fit-content;
            > svg {
                will-change: rotate;
                transition: rotate $td $tf-spring;
            }
            @media (pointer: fine) {
                &:hover svg {
                    rotate: 90deg;
                }
            }
        }
        &__nav {
            flex: 1 1 100%;
            display: flex;
            flex-direction: column;
            gap: rem(16);
            overflow-y: auto;
            overflow-x: hidden;
            padding: rem(32) 0;
            mask-image: linear-gradient(to bottom, $c-111111 70%, transparent 100%);
        }
        &__link {
            text-transform: uppercase;
            font-family: 'Fira-Extra', sans-serif;
            font-size: rem(48);
            font-weight: $fw-med;
            &.current {
                pointer-events: none;
                opacity: 0.5;
            }
        }
        &__footer {
            display: flex;
            flex-direction: column;
            gap: rem(24);
        }
        &__socials {
            display: flex;
            align-items: center;
            gap: rem(4);
            &-item {
                width: rem(28);
                aspect-ratio: 1;
                background-color: $c-9E9595;
                mask-image: var(--mask);
                mask-size: cover;
                mask-repeat: no-repeat;
                pointer-events: auto;
                will-change: rotate;
                @media (pointer: fine) {
                    &:hover {
                        background-color: $c-main;
                        translate: 0 -5%;
                        &:nth-of-type(4n + 1) {
                            rotate: -6deg;
                        }
                        &:nth-of-type(4n + 2) {
                            rotate: -9deg;
                        }
                        &:nth-of-type(4n + 3) {
                            rotate: -5deg;
                        }
                        &:nth-of-type(4n + 4) {
                            rotate: -13deg;
                        }
                    }
                }
            }
        }
        &__links {
            display: flex;
            flex-wrap: wrap;
            gap: rem(8);
            &-item {
                cursor: pointer;
                text-transform: uppercase;
                font-family: 'Inter', sans-serif;
                font-size: rem(12);
                @include gradient-text-hover($main-color: $c-main);
            }
        }
        &__label {
            display: flex;
            align-items: center;
            gap: rem(8);
            text-transform: uppercase;
            &-text {
                color: $c-main;
                font-family: 'Inter', sans-serif;
                font-weight: $fw-med;
                font-size: rem(12);
                opacity: 0.5;
            }
            &-link {
                pointer-events: auto;
                font-size: rem(14);
                font-weight: $fw-semi;
                @include gradient-text-hover($main-color: $c-FFFFFF, $accent-color: $c-0FD2D3);
            }
        }
    }
</style>
