<template>
    <NuxtLayout name="vertical">
        <section class="article">
            <div class="article__container">
                <article class="article__body">
                    <header class="article__header">
                        <div class="article__titlebox">
                            <time
                                class="article__date"
                                :datetime="article?.date_updated ?? article?.date_created ?? ''"
                            >
                                {{
                                    normalizeDate(
                                        article?.date_updated ?? article?.date_created ?? ''
                                    )
                                }}
                            </time>
                            <h1 class="article__title">{{ article?.title }}</h1>
                            <button class="article__back-link" type="button" @click="goBack">
                                <span class="article__back-link-icon">
                                    <SvgSprite type="arrow" :size="14" />
                                </span>
                                <span class="article__back-link-text">Назад</span>
                            </button>
                        </div>

                        <picture class="article__cover">
                            <img :src="article?.cover_url" :alt="article?.title ?? '#'" />
                        </picture>
                    </header>
                    <div class="article__main">
                        <aside class="article__sider">
                            <nav class="article__nav" aria-label="Оглавление">
                                <p class="article__nav-title">Содержание</p>
                                <a
                                    v-for="(link, idx) in headers"
                                    :key="idx"
                                    :href="`#target-${idx}`"
                                    class="article__nav-link"
                                >
                                    {{ link }}
                                </a>
                            </nav>
                        </aside>
                        <div class="article__wrapper">
                            <p class="article__summary" v-if="article?.summary">
                                {{ article?.summary }}
                            </p>
                            <div
                                ref="articleRef"
                                class="article__content"
                                v-html="article?.content"
                            ></div>
                        </div>
                    </div>
                </article>

                <div class="article__suggest">
                    <div class="article__suggest-container">
                        <div class="article__suggest-title">Читать далее</div>
                        <div class="article__suggest-list">
                            <NuxtLink
                                v-for="suggest in blog
                                    ?.filter((el) => el.id !== route.query.id)
                                    .slice(0, 4)"
                                :key="suggest.id"
                                :to="{
                                    name: 'blog-slug',
                                    params: { slug: slugify(suggest.title) },
                                    query: { id: suggest.id },
                                }"
                                class="article__suggest-item"
                            >
                                <picture class="article__suggest-item-image-container">
                                    <img
                                        class="article__suggest-item-image"
                                        :src="suggest.cover_url"
                                        :alt="suggest.title ?? '#'"
                                    />
                                </picture>
                                <p class="article__suggest-item-title">{{ suggest.title }}</p>
                            </NuxtLink>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IArticle } from '~~/interfaces/article';

    const route = useRoute();
    const router = useRouter();
    const articleRef = ref<HTMLElement | null>(null);
    const headers = ref<string[]>([]);

    if (!route.query.id) {
        router.push('/err');
    }

    const goBack = () => {
        if (window.history.length > 1) {
            router.back();
        } else {
            router.push('blog');
        }
    };

    const { item: article } = useCmsItem<IArticle>('articles', route.query.id as string);
    const { content: blog } = useCms<IArticle[]>('articles');

    onMounted(async () => {
        await nextTick();

        setTimeout(() => {
            if (!articleRef) return;
            const h2 = articleRef.value?.querySelectorAll('h2');

            h2?.forEach((el, idx) => el.setAttribute('id', `target-${idx}`));
            headers.value = Array.from(h2 ?? []).flatMap((el) => el.textContent);
        }, 300);
    });
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .article {
        $p: &;

        &__header {
            display: flex;
            flex-direction: column;
            gap: rem(64);
        }
        &__titlebox {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: rem(24);
            @include vertical-layout;
        }
        &__date {
            align-self: flex-end;
            font-family: 'Inter', sans-serif;
            text-transform: uppercase;
            font-size: rem(14);
            font-weight: $fw-med;
            color: $c-323232;
        }
        &__title {
            font-family: 'Fira-Extra', sans-serif;
            text-transform: uppercase;
            font-weight: $fw-bold;
            font-size: lineScale(96, 32, 480, 1440);
            text-wrap: balance;
        }
        &__back-link {
            cursor: pointer;
            width: fit-content;
            display: flex;
            align-items: center;
            gap: rem(8);
            font-family: 'Inter', sans-serif;
            color: $c-accent;
            font-size: rem(14);
            font-weight: $fw-med;
            &-icon {
                rotate: 180deg;
                overflow: hidden;
            }
            @media (pointer: fine) {
                &:hover {
                    > span svg {
                        animation: arrow-translate calc($td * 1.2) $tf;
                    }
                }
            }
            @keyframes arrow-translate {
                0% {
                    translate: 0 0;
                    opacity: 1;
                }
                45% {
                    translate: 100% 0;
                    opacity: 0;
                }
                55% {
                    translate: -100% 0;
                    opacity: 0;
                }
                100% {
                    translate: 0 0;
                    opacity: 1;
                }
            }
        }
        &__cover {
            width: 100%;
            height: rem(480);
            margin: 0 auto;
            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__main {
            width: 100%;
            max-width: rem(1920);
            display: grid;
            grid-template-columns: 30% auto;
            gap: rem(64);
            padding: 0 $px;
            margin: rem(96) auto;
            @media (max-width: 768px) {
                display: flex;
                flex-direction: column;
            }
        }
        &__sider {
            height: 100%;
            position: relative;
        }
        &__nav {
            position: sticky;
            top: $py;
            display: flex;
            flex-direction: column;
            gap: rem(16);
            border: rem(1) solid $c-111111;
            padding: rem(32);
            &-title {
                text-transform: uppercase;
                font-size: lineScale(24, 20, 480, 1440);
                font-weight: $fw-bold;
                margin-bottom: rem(16);
            }
            &-link {
                width: fit-content;
                font-family: 'Inter', sans-serif;
                font-size: lineScale(18, 16, 480, 1440);
                @include gradient-text-hover;
                &.active {
                    background-position: -160% -200%;
                }
            }
        }
        &__summary {
            font-family: 'Inter', sans-serif;
            font-size: lineScale(20, 18, 480, 1440);
            line-height: 1.4;
            opacity: 0.5;
        }
        &__content {
            width: 100%;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(16, 14, 480, 1440);
            line-height: 1.6;
            padding: lineScale(64, 40, 480, 1440) 0;
            h2 {
                font-family: 'Fira', sans-serif;
                scroll-margin: $py;
                text-transform: uppercase;
                font-size: lineScale(32, 24, 480, 1440);
                font-weight: $fw-bold;
                line-height: 1;
                margin: rem(24) 0;
                &:not(:first-of-type) {
                    margin-top: rem(64);
                }
            }
            p {
                img,
                video {
                    width: 100%;
                    height: 100%;
                    max-height: rem(480);
                    object-fit: cover;
                    margin: rem(32) 0;
                }
            }
            ul,
            ol {
                margin: rem(16) 0;
                li {
                    margin-left: rem(24);
                }
            }
            ul > li {
                list-style: disc outside;
            }
            ol > li {
                list-style: decimal outside;
            }
        }
        &__suggest {
            color: $c-main;
            background-color: $c-111111;
            padding: rem(64) 0 $py 0;
            &-container {
                display: flex;
                flex-direction: column;
                gap: rem(32);
                @include vertical-layout;
            }
            &-title {
                text-transform: uppercase;
                color: $c-9E9595;
                font-size: lineScale(32, 24, 480, 1440);
                font-weight: $fw-bold;
            }
            &-list {
                display: flex;
                flex-wrap: wrap;
                gap: rem(32);
            }
            &-item {
                flex: 1 0 22%;
                min-width: rem(180);
                display: flex;
                flex-direction: column;
                gap: rem(16);
                @media (pointer: fine) {
                    &:hover {
                        #{$p}__suggest-item-image-container::before {
                            opacity: 0;
                        }
                    }
                }
                &-image-container {
                    position: relative;
                    width: 100%;
                    height: rem(278);
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
                &-image {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
                &-title {
                    text-transform: uppercase;
                    font-family: 'Fira-Extra', sans-serif;
                    font-size: rem(20);
                    font-weight: $fw-bold;
                    @include lineClamp(2);
                }
            }
        }
    }
</style>
