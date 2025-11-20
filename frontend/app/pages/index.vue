<template>
    <main id="page" class="home">
        <section class="home__container">
            <HomeAgency
                :title="page?.agency_title ?? ''"
                :subtitle="page?.agency_subtitle ?? ''"
                :description="page?.agency_description ?? ''"
                :link="contact?.studio_link ?? '#'"
                :slides="
                    page?.agency_slides.map((el) => ({
                        title: el.home_agency_slide_id.title,
                        image: el.home_agency_slide_id.image_url ?? '',
                    })) ?? []
                "
            />
            <HomeNavigator
                :title="page?.personal_title ?? ''"
                :subtitle="page?.personal_subtitle ?? ''"
                :image="page?.personal_image_url ?? ''"
                :contact="contact"
            />
        </section>
    </main>
</template>

<script setup lang="ts">
    import type { IContact } from '~~/interfaces/contact';

    interface IHomePage {
        id: string | number;
        date_upadted: string | null;

        agency_title: string;
        agency_subtitle: string;
        agency_description: string | null;
        agency_slides: {
            id: string | number;
            home_page_id: any;
            home_agency_slide_id: {
                id: string | number;
                title: string;
                image: string;
                image_url?: string;
            };
        }[];

        personal_title: string;
        personal_subtitle: string;
        personal_image: string;
        personal_image_url?: string;
    }
    const { content: page } = useCms<IHomePage>('home_page', [
        'agency_slides.*',
        'agency_slides.home_agency_slide_id.*',
    ]);

    const { content: contact } = useCms<IContact>('contact');
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home {
        $p: &;

        height: 100%;
        max-width: 100vw;
        padding: rem(32) lineScale(32, 0, 480, 1440);
        background-color: #dfdddd;
        overflow-x: hidden;
        &__container {
            min-height: calc(100lvh - rem(64));
            height: 100%;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(16);
        }
    }

    @media (max-width: 1024px) {
        .home {
            &__container {
                display: flex;
                flex-direction: column-reverse;
            }
        }
    }
</style>
