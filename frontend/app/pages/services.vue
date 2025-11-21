<template>
    <NuxtLayout>
        <ServicesList
            :title="page?.title ?? ''"
            :subtitle="page?.subtitle ?? null"
            :items="
                page?.services.map((el) => ({
                    tag: el.services_id.tag,
                    title: el.services_id.title,
                    image: el.services_id.image_url ?? '',
                    price: el.services_id.price,
                    discount: el.services_id.discount,
                })) ?? []
            "
        />
        <ServicesFeedback v-if="page?.feedback_enable" :title="page?.feedback_title ?? ''" />
        <section class="hint">
            <div class="hint__container">
                <TheSectionHint class="hero__hint" :hint="page?.hint ?? null" />
                <CircleButton
                    class="hint__button"
                    type="a"
                    :href="contact?.studio_link.trim().replace(/\s+/g, '')"
                    target="_blank"
                >
                    <span>Сайт студии</span>
                </CircleButton>
            </div>
        </section>
        <section class="contact">
            <div class="contact__container">
                <ContactPrimary />
            </div>
        </section>
        <PageNavigator
            :to="{ name: 'projects' }"
            :image="page?.navigator_image_url ?? ''"
            tag="Далее"
            title="Проекты"
        />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IVideoHint } from '~~/interfaces/chunks/hint';
    import type { IService } from '~~/interfaces/service';
    import type { IFeedback } from '~~/interfaces/feedback';
    import type { IContact } from '~~/interfaces/contact';

    interface IServicesPage {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        subtitle: string | null;
        services: {
            id: string | number;
            services_page_id: any;
            services_id: IService;
        }[];
        feedback_title: string | null;
        feedback_enable: boolean;
        hint: IVideoHint;
        navigator_image: string;
        navigator_image_url?: string;
    }

    const { content: page } = useCms<IServicesPage>('services_page', [
        'services.*',
        'services.services_id.*',
        'hint.*',
    ]);

    const { content: feedback } = useCms<IFeedback[]>('feedback');

    const { content: contact } = useCms<IContact>('contact');
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .hint {
        @include horizontal-layout;
        @media (max-width: 512px) {
            display: flex;
            flex-direction: column;
        }
        &__container {
            position: relative;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(32);
        }
        &__button {
            position: absolute;
            top: 35%;
            left: 85%;
            @media (max-width: 512px) {
                position: relative;
                top: auto;
                left: auto;
                align-self: flex-end;
                // bottom: -50%;
                // right: 0;
            }
        }
    }
    .contact {
        @include horizontal-layout;
    }
</style>
