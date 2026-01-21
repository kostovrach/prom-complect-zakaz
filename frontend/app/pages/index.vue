<template>
    <NuxtLayout>
        <PHomeHero
            :slides="
                content?.hero.map((el) => ({
                    title: el.home_hero_id.title,
                    subtitle: el.home_hero_id.subtitle,
                    file: el.home_hero_id.file,
                })) ?? []
            "
        />
        <PHomeAdvant
            :title="content?.advant_title ?? ''"
            :subtitle="content?.advant_subtitle ?? null"
            :cards="content?.advant_cards ?? []"
        />
        <PHomeServices
            :title="content?.services_title ?? ''"
            :subtitle="content?.services_subtitle ?? null"
        />
        <CPartners />
        <CCo />
        <CNews />
        <CFaq />
        <CPoints />
        <CConnection />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IDirectusFile } from '~~/interfaces/directus-file';
    import type { ISeoSettings } from '~~/interfaces/seo-settings';

    interface IPage extends ISeoSettings {
        id: string | number;
        date_created: string;
        date_updated: string | null;

        hero: {
            id: string | number;
            home_page_id: any;
            home_hero_id: {
                id: string | number;
                title: string;
                subtitle: string;
                file: IDirectusFile;
            };
        }[];

        advant_title: string;
        advant_subtitle: string | null;
        advant_cards: {
            title: string;
            content: string;
        }[];

        services_title: string;
        services_subtitle: string | null;
    }

    const { content } = await useCms<IPage>('home_page', [
        'hero.*',
        'hero.home_hero_id.*',
        'hero.home_hero_id.file.*',
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
