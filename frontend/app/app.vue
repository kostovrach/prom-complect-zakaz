<template>
    <NuxtPage />
    <ModalsContainer />
    <ModalsCookie />
</template>

<script setup lang="ts">
    import { ModalsContainer } from 'vue-final-modal';
    import type { IArticle } from '~~/interfaces/article';
    import type { IService } from '~~/interfaces/service';

    const { setArticles } = useBlogStore();
    const { setServices } = useServicesStore();

    // Data =================================================
    const { content: articles } = await useCms<IArticle[]>('articles');
    const { content: services } = await useCms<IService[]>('services');
    // ======================================================

    // Setters ==============================================
    setArticles(articles.value ?? []);
    setServices(services.value ?? []);
    // ======================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    html,
    body {
        background-color: $c-main;
        color: $c-secondary;
    }
</style>
