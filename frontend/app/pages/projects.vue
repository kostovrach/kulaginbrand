<template>
    <NuxtLayout>
        <ProjectsMain :title="page?.title ?? ''" />
        <PageNavigator
            :to="{ name: 'hobby' }"
            tag="Далее"
            title="Хобби"
            :image="page?.navigator_image_url ?? ''"
        />
    </NuxtLayout>
</template>

<script setup lang="ts">
    interface IProjectsPage {
        id: string | number;
        date_updated: string | null;
        title: string;
        navigator_image: string;
        navigator_image_url?: string;
    }

    const { content: page } = useCms<IProjectsPage>('projects_page');
</script>
