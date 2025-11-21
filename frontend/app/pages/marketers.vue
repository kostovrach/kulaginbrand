<template>
    <NuxtLayout name="vertical">
        <section ref="container" class="marketers">
            <CircleButton
                v-if="page?.link"
                class="marketers__button"
                type="a"
                :href="page?.link?.trim().replace(/\s+/g, '')"
                target="_blank"
                variant="red"
                logic="noanim"
                :style="{
                    translate: `${mouseX}px ${mouseY}px`,
                    fontSize: '1.5rem',
                    cursor: 'none',
                }"
            >
                <span>Присоединиться</span>
            </CircleButton>
            <div class="marketers__container">
                <div class="marketers__section" v-for="section in page?.blocks" :key="section.id">
                    <div class="marketers__section-title-container">
                        <div class="marketers__section-titlebox">
                            <h1 class="marketers__section-title">
                                {{ section.marketers_blocks_id?.title }}
                            </h1>
                            <p
                                class="marketers__section-desc"
                                v-if="section.marketers_blocks_id?.subtitle"
                            >
                                {{ section.marketers_blocks_id?.subtitle }}
                            </p>
                            <CircleButton
                                v-if="page?.link"
                                class="marketers__button--touch"
                                type="a"
                                :href="page?.link?.trim().replace(/\s+/g, '')"
                                target="_blank"
                                variant="red"
                                style="font-size: 1rem"
                            >
                                <span>Присоединиться</span>
                            </CircleButton>
                        </div>
                    </div>

                    <div class="marketers__section-gallery">
                        <picture
                            v-for="image in section.marketers_blocks_id?.gallery"
                            :key="image.directus_files_id.id"
                            class="marketers__section-image-container"
                        >
                            <img
                                class="marketers__section-image"
                                :src="`/api/cms/assets/${image.directus_files_id.id}`"
                                alt="#"
                            />
                        </picture>
                    </div>
                </div>
            </div>
        </section>
        <section class="contact">
            <div class="contact__container">
                <ContactPrimary orientation="vertical" />
            </div>
        </section>
        <PageNavigator
            :to="{ name: 'blog' }"
            :image="page?.navigator_image_url ?? ''"
            tag="Далее"
            title="Блог"
            orientation="horizontal"
        />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IDirectusFile } from '~~/interfaces/direcctus-file';

    interface IMarketersPage {
        id: string | number;
        link: string | null;
        blocks: {
            id: string | number;
            marketers_page_id: any;
            marketers_blocks_id: {
                id: string | number;
                date_created: string;
                date_updated: string | null;
                title: string;
                subtitle: string | null;
                gallery: {
                    id: string | number;
                    marketers_blocks_id: any;
                    directus_files_id: IDirectusFile;
                }[];
            };
        }[];
        navigator_image: string;
        navigator_image_url?: string;
    }

    const { content: page } = useCms<IMarketersPage>('marketers_page', [
        'blocks.*',
        'blocks.marketers_blocks_id.*',
        'blocks.marketers_blocks_id.gallery.*',
        'blocks.marketers_blocks_id.gallery.directus_files_id.*',
    ]);

    const container = ref<HTMLElement | null>(null);
    const { elementX: mouseX, elementY: mouseY } = useMouseInElement(container, {
        handleOutside: false,
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .marketers {
        $p: &;

        position: relative;
        overflow: clip;
        @include vertical-layout;
        &:not(:hover) {
            #{$p}__button {
                opacity: 0;
            }
        }
        &__button {
            position: absolute;
            top: 0;
            left: 0;
            transform: translate(-50%, -50%);
            transition: opacity $td $tf;
            @media (pointer: coarse) {
                display: none;
            }
        }
        &__container {
            display: flex;
            flex-direction: column;
            gap: rem(128);
        }
        &__section {
            position: relative;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(96);
            &:nth-child(odd) {
                grid-template-areas:
                    'titlebox gallery'
                    'titlebox gallery';
                #{$p}__section-gallery {
                    align-self: flex-end;
                }
            }
            &:nth-child(even) {
                grid-template-areas:
                    'gallery titlebox'
                    'gallery titlebox';
                #{$p}__section-titlebox {
                    align-items: flex-end;
                    text-align: right;
                }
            }
            &-title-container {
                grid-area: titlebox;
                position: relative;
                z-index: 1;
                height: 100%;
            }
            &-titlebox {
                position: sticky;
                top: $py;
                height: fit-content;
                display: flex;
                flex-direction: column;
                gap: rem(32);
            }
            &-title {
                @include block-title($font-size: lineScale(96, 24, 480, 1440));
            }
            &-desc {
                max-width: 60ch;
                font-family: 'Inter', sans-serif;
                font-size: lineScale(22, 18, 480, 1440);
            }
            &-gallery {
                grid-area: gallery;
                // max-width: 60%;
                display: flex;
                flex-direction: column;
                gap: rem(34);
            }
            &-image-container {
                max-width: 100%;
                height: rem(635);
                &:nth-child(odd) {
                    rotate: -2deg;
                }
                &:nth-child(even) {
                    rotate: 3deg;
                }
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__button--touch {
            position: absolute;
            top: 100%;
            right: 0;
            @media (pointer: fine) {
                display: none;
            }
        }
    }

    .contact {
        @include vertical-layout;
        &__container {
            padding: $py 0;
        }
    }

    @media (max-width: 768px) {
        .marketers {
            $p: &;

            &__section {
                display: flex;
                flex-direction: column;
                &:nth-child(even) {
                    #{$p}__section-titlebox {
                        align-items: initial;
                        text-align: initial;
                    }
                }
                &-gallery {
                    max-width: initial;
                }
            }
            &__button {
                display: none;
            }
        }
    }
</style>
