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
    interface IContent {
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
</script>
