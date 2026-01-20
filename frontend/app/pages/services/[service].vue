<template>
    <NuxtLayout>
        <PServiceHero
            :title="service?.hero_title ?? ''"
            :subtitle="service?.hero_subtitle ?? null"
            :background_url="service?.hero_image_url ?? ''"
            :advant="service?.hero_advant.flatMap((el) => el.content) ?? []"
        />
        <PServiceAbout
            :title="service?.about_title ?? ''"
            :content="service?.about_content ?? ''"
        />
        <PServiceBanner
            :value="service?.banner_value ?? null"
            :unit="service?.banner_unit ?? null"
            :description="service?.banner_description ?? null"
            :content="service?.banner_content ?? null"
            :article="service?.banner_article?.articles_id ?? null"
        />
        <PServiceGallery
            :title="service?.gallery_title ?? null"
            :slides="service?.gallery_slides.map((el) => el.services_gallery_id) ?? []"
        />
        <PServiceFaq
            :tag="service?.faq_tag ?? null"
            :title="service?.faq_title ?? null"
            :items="service?.faq_items ?? []"
        />
        <PServiceCases
            :title="service?.articles_title ?? null"
            :slides="service?.articles_items.map((el) => el.articles_id) ?? []"
        />
        <CPartners />
        <PServiceDocs
            :title="service?.docs_title ?? null"
            :docs="service?.docs_items.map((el) => el.services_docs_id) ?? []"
        />
        <CConnection />
        <BlockLiquidTitle v-if="suggest.length" title="Смежные категории" class="service-suggest">
            <div class="service-suggest__body">
                <NuxtLink
                    v-for="item in suggest.slice(0, 2)"
                    :key="item.id"
                    class="service-suggest__item"
                    :to="{
                        name: 'services-service',
                        params: { service: slugify(item.hero_title) },
                        query: { id: item.id },
                    }"
                >
                    <picture class="service-suggest__item-image-container">
                        <img
                            class="service-suggest__item-image"
                            :src="item.hero_image_url ?? ''"
                            :alt="item.hero_title ?? '#'"
                        />
                    </picture>
                    <div class="service-suggest__item-wrapper">
                        <span class="service-suggest__item-icon">
                            <SvgSprite type="arrow" :size="20" />
                        </span>
                        <h3 class="service-suggest__item-title">{{ item.hero_title }}</h3>
                    </div>
                </NuxtLink>
            </div>
        </BlockLiquidTitle>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IService } from '~~/interfaces/service';

    const route = useRoute();
    const queryServiceId = route.query.id;

    if (!queryServiceId || typeof queryServiceId !== 'string') {
        throw createError({
            status: 404,
            message: 'Page not found',
            fatal: true,
            data: { additionalInfo: 'Service ID is missing' },
        });
    }

    const serviceId = queryServiceId;
    const { item: service } = await useCmsItem<IService>('services', serviceId, [
        'banner_article.*',
        'banner_article.articles_id.*',
        'gallery_slides.*',
        'gallery_slides.services_gallery_id.*',
        'articles_items.*',
        'articles_items.articles_id.*',
        'docs_items.*',
        'docs_items.services_docs_id.*',
    ]);
    const { content: servicesList } = await useCms<IService[]>('services');
    const suggest = computed(() => servicesList.value?.filter((el) => el.id !== serviceId) ?? []);

    if (!service || !service.value) {
        throw createError({
            status: 404,
            message: 'Page not found',
            fatal: true,
        });
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .service-suggest {
        $p: &;

        &__body {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(32);
            margin-top: rem(64);
            @media (max-width: 768px) {
                display: flex;
                flex-direction: column;
            }
        }
        &__item {
            position: relative;
            display: block;
            width: 100%;
            aspect-ratio: 1.75/1;
            @include right-corner;
            @media (pointer: fine) {
                &:hover {
                    #{$p}__item-image-container {
                        scale: 1.05;
                    }
                }
            }
            &-image-container {
                position: absolute;
                z-index: 0;
                inset: 0;
                transition: scale $td $tf;
                will-change: scale;
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 1;
                    inset: 0;
                    background: linear-gradient(to top, rgba($c-1C3A19, 0.75) 0%, transparent 100%);
                }
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                filter: grayscale(80%);
            }
            &-wrapper {
                width: 100%;
                max-width: 90%;
                height: 100%;
                position: relative;
                z-index: 1;
                display: flex;
                flex-direction: column;
                justify-content: flex-end;
                gap: rem(8);
                color: $c-FFFFFF;
                padding: lineScale(32, 16, 480, 1920);
            }
            &-icon {
                display: flex;
                align-items: center;
                gap: rem(4);
                font-size: rem(24);
                color: $c-FFF3B0;
                &::before {
                    content: '(';
                }
                &::after {
                    content: ')';
                }
            }
            &-title {
                font-family: 'Nuniti', sans-serif;
                text-transform: uppercase;
                font-size: lineScale(44, 20, 480, 1920);
                font-weight: $fw-bold;
                line-height: 1.2;
            }
        }
    }
</style>
