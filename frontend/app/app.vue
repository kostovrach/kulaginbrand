<template>
    <NuxtPage />
    <TheCookieToast />
    <ModalsContainer />
</template>

<script setup lang="ts">
    import type { ISeo } from '~~/interfaces/seo';
    import { ModalsContainer } from 'vue-final-modal';

    const { content: seo } = useCms<ISeo>('seo');

    // SEO & Meta ==========================================================
    useHead({
        title: `${seo.value?.meta_title ?? ''}`,
        meta: [
            { name: 'description', content: `${seo.value?.meta_description ?? ''}` },
            // ----Open Graph----
            { property: 'og:title', content: `${seo.value?.meta_title ?? ''}` },
            { property: 'og:description', content: `${seo.value?.meta_description ?? ''}` },
            { property: 'og:image', content: `${seo.value?.og_image_url ?? ''}` },
        ],
    });
    // =====================================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    html,
    body {
        font-family: 'Fira', sans-serif;
        color: $c-text;
        background-color: $c-main;
    }

    .fade-bottom {
        opacity: 0;
        translate: 0 rem(64);
        animation: fade-bottom $td $tf forwards;
        @keyframes fade-bottom {
            from {
                opacity: 0;
                translate: 0 rem(64);
            }
            to {
                opacity: 1;
                translate: 0 0;
            }
        }
    }
    .fade-right {
        opacity: 0;
        translate: rem(64) 0;
        animation: fade-right $td $tf forwards;
        @keyframes fade-right {
            from {
                opacity: 0;
                translate: rem(64) 0;
            }
            to {
                opacity: 1;
                translate: 0 0;
            }
        }
    }
    .fade-bottom-rotate {
        opacity: 0;
        translate: 0 rem(64);
        transform-origin: top left;
        animation: fade-bottom-rotate $td $tf-spring forwards;
        @keyframes fade-bottom-rotate {
            from {
                opacity: 0;
                translate: 0 rem(64);
                rotate: 45deg;
            }
            to {
                opacity: 1;
                translate: 0 0;
                rotate: 0;
            }
        }
    }
    .fade-scale {
        opacity: 0;
        animation: fade-scale $td $tf-spring forwards;
        @keyframes fade-scale {
            from {
                opacity: 0;
                scale: 1.5;
            }
            to {
                opacity: 1;
                scale: 1;
            }
        }
    }
</style>
