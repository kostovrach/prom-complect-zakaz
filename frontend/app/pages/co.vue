<template>
    <NuxtLayout>
        <PCoHero
            :title="content?.hero_title ?? ''"
            :subtitle="content?.hero_subtitle ?? ''"
            :image_url="content?.hero_image_url ?? ''"
        />
        <CPoints />
        <CConnection />
    </NuxtLayout>
</template>

<script setup lang="ts">
    interface IContent {
        id: string | number;
        date_created: string;
        date_updated: string | null;

        hero_image: string;
        hero_image_url?: string;
        hero_title: string;
        hero_subtitle: string;

        about_title: string;
        about_subtitle: string | null;
        about_image: string | null;
        about_image_url?: string;
        about_cards: {
            title: string;
            content: string;
        }[];

        advant_title: string | null;
        advant_subtitle: string | null;
        advant_cards: {
            title: string;
            content: string;
        }[];
    }

    const { content } = await useCms<IContent>('co_page');
</script>
