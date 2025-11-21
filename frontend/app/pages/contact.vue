<template>
    <NuxtLayout>
        <section class="contact">
            <div class="contact__container">
                <div class="contact__content">
                    <FormPrimary
                        theme="light"
                        :image="page?.form_image_url ?? ''"
                        :title="page?.title ?? ''"
                        :description="page?.form_title ?? ''"
                        class="fade-scale"
                    />
                    <div class="contact__list fade-right" style="animation-delay: 0.3s">
                        <div class="contact__item" v-if="contact?.phone">
                            <p class="contact__item-title">Можно позвонить</p>
                            <a
                                class="contact__item-link"
                                :href="`tel:${contact?.phone.trim().replace(/\s+/g, '')}`"
                            >
                                {{ contact?.phone }}
                            </a>
                        </div>
                        <div class="contact__item">
                            <p class="contact__item-title">А можно написать</p>
                            <a
                                v-if="contact?.vk"
                                class="contact__item-link"
                                :href="contact?.vk?.trim().replace(/\s+/g, '')"
                            >
                                {{ contact?.vk.replace('https://', '') }}
                            </a>
                            <a
                                v-if="contact?.tg"
                                class="contact__item-link"
                                :href="contact?.tg?.trim().replace(/\s+/g, '')"
                            >
                                {{ contact?.tg.replace('https://', '') }}
                            </a>
                            <a
                                v-if="contact?.ok"
                                class="contact__item-link"
                                :href="contact?.ok?.trim().replace(/\s+/g, '')"
                            >
                                {{ contact?.ok.replace('https://', '') }}
                            </a>
                            <a
                                v-if="contact?.instagram"
                                class="contact__item-link"
                                :href="contact?.instagram?.trim().replace(/\s+/g, '')"
                            >
                                {{ contact?.instagram.replace('https://', '') }}
                            </a>
                            <a
                                v-if="contact?.whatsapp"
                                class="contact__item-link"
                                :href="contact?.whatsapp?.trim().replace(/\s+/g, '')"
                            >
                                {{ contact?.whatsapp.replace('https://', '') }}
                            </a>
                            <a
                                v-if="contact?.email"
                                class="contact__item-link"
                                :href="contact?.email?.trim().replace(/\s+/g, '')"
                            >
                                {{ contact?.email.replace('https://', '') }}
                            </a>
                        </div>
                        <div class="contact__item" v-if="contact?.address">
                            <p class="contact__item-title">Или даже придти в гости!</p>
                            <p class="contact__item-link contact__item-link--caption">
                                {{ contact?.address }}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IContact } from '~~/interfaces/contact';

    interface IContactPage {
        id: string | number;
        date_upadted: string | null;
        title: string;
        form_title: string;
        form_image: string;
        form_image_url?: string;
    }

    const { content: page } = useCms<IContactPage>('contact_page');
    const { content: contact } = useCms<IContact>('contact');
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .contact {
        $p: &;

        &__container {
            position: relative;
            @include horizontal-layout;
        }
        &__content {
            display: flex;
            align-items: center;
            gap: rem(128);
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(40);
        }
        &__item {
            display: flex;
            flex-direction: column;
            gap: rem(8);
            &-title {
                text-transform: uppercase;
                font-size: lineScale(32, 24, 480, 1440);
                line-height: 1.2;
                font-weight: $fw-bold;
                margin-bottom: rem(8);
            }
            &-link {
                font-size: lineScale(22, 18, 480, 1440);
                width: fit-content;
                &:not(#{$p}__item-link--caption) {
                    @include gradient-text-hover;
                }
            }
        }
    }

    @media (max-width: 768px) {
        .contact {
            &__sticker {
                display: none;
            }
            &__content {
                display: flex;
                flex-direction: column;
            }
            &__list {
                align-self: flex-start;
            }
        }
    }
</style>
