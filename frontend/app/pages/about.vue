<template>
    <NuxtLayout>
        <PAboutHero
            :title="content?.hero_title ?? ''"
            :subtitle="content?.hero_subtitle ?? null"
            :image_url="content?.hero_image_url ?? ''"
        />
        <PAboutAdvant
            :title="content?.advant_title ?? ''"
            :subtitle="content?.advant_subtitle ?? null"
            :cards="content?.advant_cards ?? []"
        />
        <PAboutGallery
            :title="content?.gallery_title ?? null"
            :subtitle="content?.gallery_subtitle ?? null"
            :slides="content?.gallery_slides.map((el) => el.about_page_gallery_id) ?? []"
        />
        <CPartners />
        <PAbout
            :title="content?.about_title ?? null"
            :content="content?.about_content ?? null"
            :image-url="content?.about_image_url ?? null"
        />
        <CConnection />
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
        hero_subtitle: string | null;

        advant_title: string;
        advant_subtitle: string | null;
        advant_cards: {
            title: string;
            content: string;
        }[];

        gallery_title: string | null;
        gallery_subtitle: string | null;
        gallery_slides: {
            id: string | number;
            about_page_id: any;
            about_page_gallery_id: {
                image: string;
                image_url?: string;
                description: string | null;
            };
        }[];

        about_image: string | null;
        about_image_url?: string;
        about_title: string | null;
        about_content: string | null;
    }

    const { content } = await useCms<IContent>('about_page', [
        'gallery_slides.*',
        'gallery_slides.about_page_gallery_id.*',
    ]);

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
