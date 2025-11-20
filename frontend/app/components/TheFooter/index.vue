<template>
    <footer class="footer">
        <div class="footer__container"></div>
    </footer>
</template>

<script setup lang="ts">
    import { ModalsDocs } from '#components';
    import { useModal } from 'vue-final-modal';

    // const { content: policies, status: policiesStatus } = useCms<IPolicy[]>('policies');

    // function openDocsModal(title: string, dateUpdated: string, content: string) {
    //     const { open: openModal, close: closeModal } = useModal({
    //         component: ModalsDocs,
    //         attrs: {
    //             title: title,
    //             dateUpdated: dateUpdated,
    //             content: content,
    //             status: policiesStatus.value,
    //             onClose() {
    //                 closeModal();
    //             },
    //         },
    //     });
    //     openModal();
    // }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .footer {
        $p: &;

        &__container {
        }
    }
</style>
