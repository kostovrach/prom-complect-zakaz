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

    interface IPage {
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
</script>
