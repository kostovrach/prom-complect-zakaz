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
    }

    const { content } = await useCms<IPage>('home_page', [
        'hero.*',
        'hero.home_hero_id.*',
        'hero.home_hero_id.file.*',
    ]);

    const { content: test } = await useCms<IPage>('services', []);
    console.log(test.value);
</script>
