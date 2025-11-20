<template>
    <ul class="agency__list">
        <li
            v-for="(item, idx) in props.items"
            :key="idx"
            :class="['agency__list-item', { active: idx === activeIndex }]"
        >
            <h3 class="agency__list-item-title">{{ item.title }}</h3>
            <picture class="agency__list-item-image-container">
                <img class="agency__list-item-image" :src="item.image" :alt="item.title ?? '#'" />
            </picture>
        </li>
    </ul>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            interval?: number;
            items: {
                title: string;
                image: string;
            }[];
        }>(),
        {
            interval: 2000,
        }
    );

    const activeIndex = ref(0);
    let timer: NodeJS.Timeout | null = null;

    const next = () => {
        activeIndex.value = (activeIndex.value + 1) % props.items.length;
    };

    const start = () => {
        stop();
        if (props.items.length > 0) {
            timer = setInterval(next, props.interval);
        }
    };

    const stop = () => {
        if (timer) {
            clearInterval(timer);
            timer = null;
        }
    };

    onMounted(async () => {
        await nextTick();
        start();
    });
    onBeforeUnmount(stop);

    watch(() => props.interval, start);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .agency__list {
        $p: &;

        height: rem(430);
        display: flex;
        gap: rem(8);
        &-item {
            flex: 1 1 10%;
            position: relative;
            height: 100%;
            overflow: hidden;
            transition: flex 1.2s $tf;
            &.active {
                flex: 1 1 65%;
                #{$p}-item-title {
                    transform: scaleX(1);
                    opacity: 1;
                }
            }
            &-title {
                position: absolute;
                z-index: 1;
                top: 50%;
                left: 50%;
                translate: -50% -50%;
                text-transform: uppercase;
                color: $c-main;
                font-family: 'Fira-Extra', sans-serif;
                font-size: lineScale(48, 18, 480, 1440);
                font-weight: $fw-med;
                white-space: nowrap;

                transform: scaleX(0.5);
                opacity: 0;
                transition: all 1.5s $tf-spring;
            }
            &-image-container {
                width: 100%;
                height: 100%;
                border-radius: rem(16);
                overflow: hidden;
                filter: brightness(60%);
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
        }
    }
</style>
