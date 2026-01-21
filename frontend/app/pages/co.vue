<template>
    <NuxtLayout>
        <PCoHero
            :title="content?.hero_title ?? ''"
            :subtitle="content?.hero_subtitle ?? ''"
            :image_url="content?.hero_image_url ?? ''"
        />
        <PCoAbout
            :title="content?.about_title ?? ''"
            :subtitle="content?.advant_subtitle ?? null"
            :cards="content?.about_cards ?? []"
            :image_url="content?.about_image_url ?? null"
            :next-block="content?.advant_title ?? null"
        />
        <PCoAdvant
            :title="content?.advant_title ?? null"
            :subtitle="content?.advant_subtitle ?? null"
            :cards="content?.advant_cards ?? []"
        />
        <CPoints />
        <CCo />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { ISeoSettings } from '~~/interfaces/seo-settings';

    interface IContent extends ISeoSettings {
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

    // SEO & Meta ==================================================
    useHead({
        title: content.value?.meta_title ?? '',
        meta: [
            { name: 'description', content: content.value?.meta_description ?? '' },
            { name: 'robots', content: content.value?.meta_robots ?? 'index, follow' },
            { name: 'keywords', content: content.value?.meta_keywords ?? [] },

            { property: 'og:title', content: content.value?.meta_title ?? '' },
            { property: 'og:description', content: content.value?.meta_description ?? '' },
            { property: 'og:type', content: content.value?.og_type ?? 'website' },
            { property: 'og:image', content: content.value?.og_image_url ?? '' },
            { property: 'og:url', content: useRequestURL().href },

            { name: 'twitter:card', content: 'summary_large_image' },
            { name: 'twitter:title', content: content.value?.meta_title ?? '' },
        ],
    });

    if (content.value?.shema_markup) {
        useHead({
            script: [
                {
                    type: 'application/ld+json',
                    innerHTML: content.value.shema_markup || {},
                },
            ],
        });
    }
    // =============================================================
</script>
