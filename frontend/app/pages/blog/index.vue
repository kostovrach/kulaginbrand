<template>
    <NuxtLayout>
        <section class="blog">
            <div class="blog__container">
                <div class="blog__titlebox">
                    <h1 class="blog__title fade-bottom">{{ page?.title ?? 'Личный блог' }}</h1>
                    <ul class="blog__tags" v-if="page?.tags?.length">
                        <li v-for="(tag, idx) in page.tags" :key="idx">{{ tag }}</li>
                    </ul>
                </div>
                <div class="blog__list">
                    <div class="blog__item" v-for="(article, index) in articles" :key="article.id">
                        <NuxtLink
                            class="blog__item-wrapper fade-bottom"
                            :style="`animation-delay: ${0.1 * (index + 1)}s`"
                            :to="{
                                name: 'blog-slug',
                                params: { slug: slugify(article.title) },
                                query: { id: article.id },
                            }"
                        >
                            <picture class="blog__item-image-container">
                                <img
                                    class="blog__item-image"
                                    :src="article.cover_url"
                                    :alt="article.title"
                                />
                            </picture>
                            <h2 class="blog__item-title">{{ article.title }}</h2>
                        </NuxtLink>
                    </div>
                </div>
            </div>
        </section>
        <PageNavigator
            :to="{ name: 'contact' }"
            tag="Далее"
            title="Контакты"
            :image="page?.navigator_image_url ?? ''"
        />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IArticle } from '~~/interfaces/article';

    interface IBlogPage {
        id: string | number;
        title: string;
        tags: string[] | null;
        navigator_image: string;
        navigator_image_url?: string;
    }

    const { content: page } = useCms<IBlogPage>('blog_page');
    const { content: articles } = useCms<IArticle[]>('articles');
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .blog {
        $p: &;

        position: relative;
        &__container {
            min-width: max-content;
            height: 100%;
            min-height: fit-content;
            display: grid;
            grid-auto-flow: column;
            gap: rem(64);
            padding: $py $px;
        }
        &__titlebox {
            position: fixed;
            z-index: 0;
            top: 50%;
            left: 50%;
            translate: -50% -50%;
            display: flex;
            flex-direction: column;
            @media (max-width: 768px) {
                opacity: 0.6;
            }
        }
        &__title {
            text-transform: uppercase;
            font-family: 'Fira-Extra', sans-serif;
            color: $c-accent;
            font-size: lineScale(256, 72, 480, 1440);
            font-weight: $fw-semi;
            white-space: nowrap;
            max-height: 1.35ch;
            overflow: hidden;
        }
        &__tags {
            width: 100%;
            display: flex;
            justify-content: space-between;
            > li {
                text-transform: uppercase;
                font-size: rem(14);
                color: $c-accent;
                font-weight: $fw-bold;
                margin-top: rem(6);
                @media (max-width: 768px) {
                    scale: 0.6;
                }
            }
        }
        &__list {
            display: grid;
            grid-template-rows: repeat(2, 1fr);
            grid-auto-flow: column dense;
            gap: 0 rem(128);
        }
        &__item {
            grid-row: span 2;
            width: fit-content;
            height: fit-content;
            transition: opacity $td $tf;
            opacity: 0.95;
            @media (pointer: fine) {
                &:hover {
                    opacity: 1;
                    #{$p}__item-image-container::before {
                        opacity: 0;
                    }
                }
            }
            &-wrapper {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-image-container {
                width: 100%;
                height: 100%;
                @media (pointer: fine) {
                    position: relative;
                    &::before {
                        content: '';
                        position: absolute;
                        z-index: 2;
                        inset: 0;
                        backdrop-filter: blur(5px) saturate(0);
                        background-image: url('/img/patterns/noise.png');
                        pointer-events: none;
                        transition: opacity $td $tf;
                    }
                }
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-title {
                text-transform: uppercase;
                font-family: 'Fira-Extra', sans-serif;
                font-size: lineScale(20, 18, 480, 1440);
                font-weight: $fw-bold;
                text-shadow: 1px 1px 5px $c-main;
            }
            &:nth-child(6n + 1) {
                width: rem(230);
                #{$p}__item-image-container {
                    height: rem(232);
                }
            }
            &:nth-child(6n + 2) {
                width: rem(230);
                #{$p}__item-image-container {
                    height: rem(307);
                }
            }
            &:nth-child(6n + 3) {
                width: rem(420);
                translate: 0 calc($py * -1);
                #{$p}__item-image-container {
                    height: rem(360);
                }
            }
            &:nth-child(6n + 4) {
                width: rem(230);
                translate: 0 calc($py * -1);
                #{$p}__item-image-container {
                    height: rem(232);
                }
            }
            &:nth-child(6n + 5) {
                width: rem(375);
                translate: 0 $py;
                #{$p}__item-image-container {
                    height: rem(226);
                }
            }
            &:nth-child(6n + 6) {
                width: rem(420);
                translate: 0 calc($py * -1.5);
                #{$p}__item-image-container {
                    height: rem(460);
                }
            }
            &:nth-child(even) {
                align-self: end;
            }
        }
    }

    @media (max-width: 768px) {
        .blog {
            &__container {
                min-width: initial;
                display: flex;
                flex-direction: column;
            }
            &__list {
                display: flex;
                flex-direction: column;
                gap: rem(64);
            }
            &__item {
                &:nth-child(6n + 3) {
                    translate: initial;
                }
                &:nth-child(6n + 4) {
                    translate: initial;
                }
                &:nth-child(6n + 5) {
                    translate: initial;
                }
                &:nth-child(6n + 6) {
                    translate: initial;
                }
            }
        }
    }
</style>
