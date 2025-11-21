<template>
    <section class="services-list">
        <div class="services-list__container">
            <div class="services-list__titlebox">
                <h1 class="services-list__title fade-bottom-rotate">{{ props.title }}</h1>
                <p
                    v-if="props.subtitle && props.subtitle.length"
                    class="services-list__subtitle fade-bottom-rotate"
                    style="animation-delay: 0.2s"
                >
                    {{ props.subtitle }}
                </p>
            </div>
            <ul class="services-list__list fade-right" style="animation-delay: 0.5s">
                <li class="services-list__item" v-for="(item, idx) in props.items" :key="idx">
                    <div class="services-list__item-wrapper">
                        <picture class="services-list__item-image-container">
                            <img
                                class="services-list__item-image"
                                :src="item.image"
                                :alt="item.title ?? '#'"
                            />
                        </picture>
                        <div class="services-list__item-content">
                            <div class="services-list__item-titlebox">
                                <p class="services-list__item-desc" v-if="item.tag?.length">
                                    {{ item.tag }}
                                </p>
                                <h2 class="services-list__item-title">{{ item.title }}</h2>
                            </div>
                            <ul class="services-list__item-values">
                                <li
                                    class="services-list__item-values-discount"
                                    v-if="item.discount"
                                >
                                    <span class="ruble">{{ item.price.toLocaleString() }}</span>
                                </li>
                                <li class="services-list__item-values-price">
                                    <span class="ruble">
                                        {{
                                            item.discount
                                                ? item.discount.toLocaleString()
                                                : item.price.toLocaleString()
                                        }}
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string | null;
            items: {
                image: string;
                tag: string | null;
                title: string;
                price: number;
                discount: number | null;
            }[];
        }>(),
        {}
    );
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .services-list {
        $p: &;

        @include horizontal-layout;
        &__container {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(40);
        }
        &__titlebox {
            display: flex;
            gap: rem(64);
        }
        &__title {
            @include block-title;
        }
        &__subtitle {
            max-width: 40ch;
            text-transform: uppercase;
            font-size: lineScale(22, 18, 480, 1440);
            font-weight: $fw-semi;
            line-height: 1.4;
        }
        &__list {
            height: fit-content;
            display: flex;
            gap: rem(64);
        }
        &__item {
            width: rem(640);
            height: fit-content;
            &-wrapper {
                width: 100%;
                height: 100%;
            }
            &-image-container {
                width: 100%;
                height: lineScale-y(380, 240, 480, 1440);
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            &-content {
                display: flex;
                justify-content: space-between;
                gap: rem(96);
                margin-top: rem(16);
            }
            &-desc {
                font-family: 'Inter', sans-serif;
                color: $c-accent;
                font-size: lineScale(18, 16, 480, 1440);
                font-weight: $fw-bold;
            }
            &-title {
                text-transform: uppercase;
                font-family: 'Fira-Extra', sans-serif;
                font-size: lineScale(40, 24, 480, 1440);
                font-weight: $fw-med;
            }
            &-values {
                display: flex;
                flex-direction: column;
                gap: rem(8);
                font-family: 'Fira-Extra', sans-serif;
                white-space: nowrap;
                &-discount {
                    font-size: lineScale(22, 18, 480, 1440);
                    text-decoration: line-through;
                    opacity: 0.8;
                }
                &-price {
                    font-size: lineScale(48, 24, 480, 1440);
                    font-weight: $fw-med;
                }
            }
        }
    }

    @media (max-width: 768px) {
        .services-list {
            &__titlebox {
                display: flex;
                flex-direction: column;
                gap: rem(32);
            }
            &__list {
                width: 100%;
                display: flex;
                flex-direction: column;
                gap: rem(64);
            }
            &__item {
                width: 100%;
            }
        }
    }
</style>
