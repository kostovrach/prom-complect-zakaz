<template>
    <section v-if="content && content.slides.length >= 7" class="c-partners">
        <div class="c-partners__container">
            <div class="c-partners__titlebox">
                <h3 class="c-partners__title">{{ content?.title }}</h3>
            </div>
            <EmblaContainer
                class="c-partners__body"
                :options="{ loop: true, dragFree: true }"
                auto-scroll
                :auto-scroll-options="{ speed: 0.5 }"
                stop-scroll-on-hover
            >
                <EmblaSlide
                    v-for="(item, idx) in content?.slides"
                    :key="idx"
                    width="100%"
                    class="c-partners__slide"
                >
                    <picture class="c-partners__image-container">
                        <img
                            class="c-partners__image"
                            :src="`/api/cms/assets/${item.directus_files_id.id}`"
                            alt="#"
                        />
                    </picture>
                </EmblaSlide>
            </EmblaContainer>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { IDirectusFile } from '~~/interfaces/directus-file';

    interface IContent {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        slides: {
            id: string | number;
            partners_id: any;
            directus_files_id: IDirectusFile;
        }[];
    }

    const { content } = await useCms<IContent>('partners', [
        'slides.*',
        'slides.directus_files_id.*',
    ]);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .c-partners {
        @include content-block;
        &__titlebox {
            width: 100%;
            display: flex;
            justify-content: flex-end;
            @include content-container;
        }
        &__title {
            @include block-tag;
        }
        &__body {
            margin-top: rem(32);
        }
        &__slide {
            max-width: rem(180);
            aspect-ratio: 1;
            filter: grayscale(1);
            opacity: 0.25;
            margin-right: lineScale(96, 64, 480, 1920);
        }
        &__image-container {
            width: 100%;
            height: 100%;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
    }
</style>
