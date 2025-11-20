<template>
    <footer class="footer">
        <div class="footer__container">
            <div class="footer__controls">
                <div class="footer__socials">
                    <a
                        v-if="contact?.vk"
                        class="footer__socials-icon"
                        style="--mask: url(/img/masks/vk.svg); --color: #016fcc"
                        :href="contact?.vk.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    ></a>
                    <a
                        v-if="contact?.tg"
                        class="footer__socials-icon"
                        style="--mask: url(/img/masks/telegram.svg); --color: #03a4df"
                        :href="contact?.tg.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    ></a>
                    <a
                        v-if="contact?.ok"
                        class="footer__socials-icon"
                        style="--mask: url(/img/masks/ok.svg); --color: #ff7700"
                        :href="contact?.ok.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    ></a>
                    <a
                        v-if="contact?.instagram"
                        class="footer__socials-icon"
                        style="
                            --mask: url(/img/masks/instagram.svg);
                            --color: linear-gradient(
                                45deg,
                                #feda75 0%,
                                #fa7e1e 25%,
                                #d62976 50%,
                                #962fbf 75%,
                                #4f5bd5 100%
                            );
                        "
                        :href="contact?.instagram.trim().replace(/\s+/g, '')"
                        target="_blank"
                        rel="noopener noreferrer"
                    ></a>
                </div>
                <div class="footer__links">
                    <button
                        class="footer__link"
                        type="button"
                        v-for="(policy, idx) in policies"
                        :key="policy.id"
                        @click="
                            openDocsModal(
                                policy.title,
                                policy.date_updated ?? policy.date_created,
                                policy.content
                            )
                        "
                    >
                        {{ policy.title }}
                    </button>
                </div>
            </div>
            <div class="footer__label">
                <p class="footer__label-text">Сайт разработали:</p>
                <a
                    class="footer__label-link"
                    :href="contact?.studio_link.trim().replace(/\s+/g, '')"
                    target="_blank"
                    rel="noopener noreferrer"
                >
                    kulaginbrand.ru
                </a>
            </div>
        </div>
    </footer>
</template>

<script setup lang="ts">
    import { ModalsDocs } from '#components';
    import { useModal } from 'vue-final-modal';
    import type { IContact } from '~~/interfaces/contact';
    import type { IPolicy } from '~~/interfaces/policy';

    const { content: contact } = useCms<IContact>('contact');
    const { content: policies, status: policiesStatus } = useCms<IPolicy[]>('policies');

    function openDocsModal(title: string, date: string, content: string) {
        const { open: openModal, close: closeModal } = useModal({
            component: ModalsDocs,
            attrs: {
                dateUpdated: date,
                title,
                content,
                status: policiesStatus.value,
                onClose() {
                    closeModal();
                },
            },
        });
        openModal();
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;
    .footer {
        position: fixed;
        z-index: 10;
        bottom: 0;
        left: 0;
        width: 100vw;
        mix-blend-mode: difference;
        padding: rem(16) $px;
        pointer-events: none;
        &__container {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        &__controls {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(32);
        }
        &__socials {
            display: flex;
            align-items: center;
            gap: rem(0);
            &-icon {
                width: rem(40);
                aspect-ratio: 1;
                background: $c-FFFFFF;
                mask-image: var(--mask);
                mask-size: cover;
                mask-repeat: no-repeat;
                pointer-events: auto;
                will-change: rotate;
                @media (pointer: fine) {
                    &:hover {
                        // background: var(--color);
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
            align-items: center;
            flex-wrap: wrap;
            gap: rem(32);
        }
        &__link {
            cursor: pointer;
            text-transform: uppercase;
            font-family: 'Inter', sans-serif;
            font-size: rem(14);
            font-weight: $fw-semi;
            pointer-events: auto;
            @include gradient-text-hover($main-color: $c-FFFFFF, $accent-color: $c-0FD2D3);
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

    @media (max-width: 1260px) {
        .footer {
            display: none;
        }
    }
</style>
