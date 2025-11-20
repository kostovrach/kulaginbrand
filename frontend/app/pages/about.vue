<template>
    <NuxtLayout>
        <AboutHero
            :title="page?.hero_title ?? ''"
            :subtitle="page?.hero_subtitle ?? ''"
            :image-url="page?.hero_image_url ?? '#'"
            :hint="page?.hero_hint ?? null"
        />
        <AboutBrand
            :title="page?.brand_title ?? ''"
            :subtitle="page?.brand_description ?? ''"
            :hint="page?.brand_hint ?? null"
            :footer_image="page?.brand_image_url ?? ''"
            :form_title="page?.brand_form_title ?? ''"
            :form_subtitle="page?.brand_form_subtitle ?? ''"
            :form_image="page?.brand_form_image_url ?? ''"
            :letters="{
                B: page?.brand_letter_b_url ?? '',
                R: page?.brand_letter_r_url ?? '',
                A: page?.brand_letter_a_url ?? '',
                N: page?.brand_letter_n_url ?? '',
                D: page?.brand_letter_d_url ?? '',
            }"
            :gallery="{
                image_1: page?.brand_gallery_1_url ?? '',
                image_2: page?.brand_gallery_2_url ?? '',
                image_3: page?.brand_gallery_3_url ?? '',
                image_4: page?.brand_gallery_4_url ?? '',
                image_5: page?.brand_gallery_5_url ?? '',
                image_6: page?.brand_gallery_6_url ?? '',
                image_7: page?.brand_gallery_7_url ?? '',
                image_8: page?.brand_gallery_8_url ?? '',
                image_9: page?.brand_gallery_9_url ?? '',
            }"
        />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IVideoHint } from '~~/interfaces/chunks/hint';

    interface IAboutPage {
        id: string | number;
        date_updated: string | null;

        hero_title: string;
        hero_subtitle: string;
        hero_image: string;
        hero_image_url?: string;
        hero_hint: IVideoHint;

        brand_letter_b: string;
        brand_letter_b_url?: string;
        brand_letter_r: string;
        brand_letter_r_url?: string;
        brand_letter_a: string;
        brand_letter_a_url?: string;
        brand_letter_n: string;
        brand_letter_n_url?: string;
        brand_letter_d: string;
        brand_letter_d_url?: string;

        brand_hint: IVideoHint;
        brand_title: string;
        brand_description: string | null;

        brand_gallery_1: string;
        brand_gallery_1_url?: string;
        brand_gallery_2: string;
        brand_gallery_2_url?: string;
        brand_gallery_3: string;
        brand_gallery_3_url?: string;
        brand_gallery_4: string;
        brand_gallery_4_url?: string;
        brand_gallery_5: string;
        brand_gallery_5_url?: string;
        brand_gallery_6: string;
        brand_gallery_6_url?: string;
        brand_gallery_7: string;
        brand_gallery_7_url?: string;
        brand_gallery_8: string;
        brand_gallery_8_url?: string;
        brand_gallery_9: string;
        brand_gallery_9_url?: string;

        brand_form_title: string;
        brand_form_subtitle: string;
        brand_form_image: string | null;
        brand_form_image_url?: string;

        brand_image: string;
        brand_image_url?: string;
    }

    const { content: page } = useCms<IAboutPage>('about_page', ['hero_hint.*', 'brand_hint.*']);
</script>

<style scoped></style>
