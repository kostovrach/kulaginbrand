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
                B: page?.brand_letter_b ?? null,
                R: page?.brand_letter_r ?? null,
                A: page?.brand_letter_a ?? null,
                N: page?.brand_letter_n ?? null,
                D: page?.brand_letter_d ?? null,
            }"
            :gallery="{
                image_1: page?.brand_gallery_1 ?? null,
                image_2: page?.brand_gallery_2 ?? null,
                image_3: page?.brand_gallery_3 ?? null,
                image_4: page?.brand_gallery_4 ?? null,
                image_5: page?.brand_gallery_5 ?? null,
                image_6: page?.brand_gallery_6 ?? null,
                image_7: page?.brand_gallery_7 ?? null,
                image_8: page?.brand_gallery_8 ?? null,
                image_9: page?.brand_gallery_9 ?? null,
            }"
        />
        <AboutProjects
            :title="page?.projects_title ?? ''"
            :project_1="{
                title: page?.projects_project_1_title ?? '',
                subtitle: page?.projects_project_1_subtitle ?? '',
                link: page?.projects_project_1_link ?? '',
                logo: page?.projects_project_1_logo_url ?? '',
                image_1: page?.projects_project_1_image_1_url ?? '',
                image_2: page?.projects_project_1_image_2_url ?? '',
            }"
            :divider="{ image: page?.projects_divider_image_url ?? '' }"
            :project_2="{
                title: page?.projects_project_2_title ?? '',
                link: page?.projects_project_2_link ?? '',
                logo: page?.projects_project_2_logo_url ?? '',
                image_1: page?.projects_project_2_image_1_url ?? '',
                image_2: page?.projects_project_2_image_2_url ?? '',
                image_3: page?.projects_project_2_image_3_url ?? '',
                image_4: page?.projects_project_2_image_4_url ?? '',
            }"
        />
        <PageNavigator
            tag="Далее"
            title="Услуги"
            :to="{ name: 'services' }"
            :image="page?.navigator_image_url ?? ''"
        />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IVideoHint } from '~~/interfaces/chunks/hint';
    import type { IDirectusFile } from '~~/interfaces/direcctus-file';

    interface IAboutPage {
        id: string | number;
        date_updated: string | null;

        hero_title: string;
        hero_subtitle: string;
        hero_image: string;
        hero_image_url?: string;
        hero_hint: IVideoHint;

        brand_letter_b: IDirectusFile;
        brand_letter_r: IDirectusFile;
        brand_letter_a: IDirectusFile;
        brand_letter_n: IDirectusFile;
        brand_letter_d: IDirectusFile;

        brand_hint: IVideoHint;
        brand_title: string;
        brand_description: string | null;

        brand_gallery_1: IDirectusFile | null;
        brand_gallery_2: IDirectusFile | null;
        brand_gallery_3: IDirectusFile | null;
        brand_gallery_4: IDirectusFile | null;
        brand_gallery_5: IDirectusFile | null;
        brand_gallery_6: IDirectusFile | null;
        brand_gallery_7: IDirectusFile | null;
        brand_gallery_8: IDirectusFile | null;
        brand_gallery_9: IDirectusFile | null;

        brand_form_title: string;
        brand_form_subtitle: string;
        brand_form_image: string | null;
        brand_form_image_url?: string;

        brand_image: string;
        brand_image_url?: string;

        projects_title: string;
        projects_project_1_title: string;
        projects_project_1_subtitle: string;
        projects_project_1_link: string;

        projects_project_1_logo: string;
        projects_project_1_logo_url?: string;
        projects_project_1_image_1: string;
        projects_project_1_image_1_url?: string;
        projects_project_1_image_2: string;
        projects_project_1_image_2_url?: string;

        projects_divider_image: string;
        projects_divider_image_url?: string;

        projects_project_2_title: string;
        projects_project_2_link: string;

        projects_project_2_logo: string;
        projects_project_2_logo_url?: string;
        projects_project_2_image_1: string;
        projects_project_2_image_1_url?: string;
        projects_project_2_image_2: string;
        projects_project_2_image_2_url?: string;
        projects_project_2_image_3: string;
        projects_project_2_image_3_url?: string;
        projects_project_2_image_4: string;
        projects_project_2_image_4_url?: string;

        navigator_image: string;
        navigator_image_url?: string;
    }

    const { content: page } = useCms<IAboutPage>('about_page', [
        'hero_hint.*',
        'brand_hint.*',
        'brand_letter_b.*',
        'brand_letter_r.*',
        'brand_letter_a.*',
        'brand_letter_n.*',
        'brand_letter_d.*',
        'brand_gallery_1.*',
        'brand_gallery_2.*',
        'brand_gallery_3.*',
        'brand_gallery_4.*',
        'brand_gallery_5.*',
        'brand_gallery_6.*',
        'brand_gallery_7.*',
        'brand_gallery_8.*',
        'brand_gallery_9.*',
    ]);
</script>

<style scoped></style>
