<template>
    <BlockLiquidTitle
        v-if="props.title && props.slides.length"
        :title="props.title"
        class="service-cases"
    >
        <div class="service-cases__body">
            <EmblaContainer ref="sliderRef" class="service-cases__slider">
                <EmblaSlide
                    v-for="(article, idx) in props.slides"
                    :key="article.id"
                    class="service-cases__slide"
                    width="100%"
                >
                    <div class="service-cases__slide-wrapper">
                        <picture class="service-cases__slide-image-container">
                            <img
                                class="service-cases__slide-image"
                                :src="article.cover_url ?? ''"
                                :alt="article.title ?? '#'"
                            />
                        </picture>
                        <div class="service-cases__slide-body">
                            <span class="service-cases__slide-count">{{ `0${idx + 1}` }}</span>

                            <h3 class="service-cases__slide-title">{{ article.title }}</h3>
                            <div
                                class="service-cases__slide-content"
                                v-html="article.content"
                            ></div>
                            <LinkPrimary
                                class="service-cases__slide-button"
                                type="NuxtLink"
                                :to="{
                                    name: 'blog-article',
                                    params: { article: slugify(article.title) },
                                    query: { id: article.id },
                                }"
                            >
                                Подробнее
                            </LinkPrimary>
                        </div>
                    </div>
                </EmblaSlide>
            </EmblaContainer>
            <EmblaNavigation
                :slider-ref="computed(() => sliderRef)"
                class="service-cases__contols"
            />
        </div>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';
    import type { IArticle } from '~~/interfaces/article';

    const props = withDefaults(
        defineProps<{
            title: string | null;
            slides: IArticle[];
        }>(),
        {
            title: null,
            slides: () => [],
        }
    );

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .service-cases {
        &__body {
            display: flex;
            flex-direction: column;
            gap: rem(64);
            margin-top: rem(64);
            @media (max-width: 768px) {
                align-items: center;
                justify-content: center;
            }
        }
        &__slide {
            background-color: $c-FFFFFF;
            @include double-corner;
            @media (max-width: 768px) {
                clip-path: none;
            }
            &-wrapper {
                width: 100%;
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                @media (max-width: 1024px) {
                    display: flex;
                    flex-direction: column;
                }
            }
            &-image-container {
                position: relative;
                width: 100%;
                height: 100%;
                @media (max-width: 1024px) {
                    height: rem(320);
                }
            }
            &-image {
                position: absolute;
                inset: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-body {
                max-width: 75%;
                padding: rem(64) lineScale(64, 32, 480, 1920);
            }
            &-count {
                font-size: lineScale(16, 14, 480, 1920);
                opacity: 0.25;
            }
            &-title {
                color: $c-082605;
                font-size: lineScale(24, 20, 480, 1920);
                font-weight: $fw-bold;
                line-height: 1.2;
                margin-top: rem(16);
            }
            &-content {
                margin-top: rem(32);
                @include text-content(
                    $font-size: lineScale(18, 16, 480, 1920),
                    $h2-size: lineScale(24, 20, 480, 1920),
                    $h-size: lineScale(20, 18, 480, 1920)
                );
                @include lineClamp(10);
                > p {
                    margin: rem(16) 0;
                }
            }
            &-button {
                display: flex;
                align-items: center;
                gap: rem(8);
                text-transform: uppercase;
                font-size: lineScale(18, 16, 480, 1920);
                line-height: 1.2;
                font-weight: $fw-semi;
                margin-top: rem(32);
            }
        }
    }
</style>
