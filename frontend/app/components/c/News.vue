<template>
    <section class="c-news">
        <div class="c-news__container">
            <EmblaContainer ref="sliderRef" class="c-news__slider" :options="{ loop: true }">
                <EmblaSlide
                    v-for="item in articles"
                    :key="item.id"
                    class="c-news__slide"
                    width="100%"
                >
                    <div class="c-news__slide-wrapper">
                        <div class="c-news__slide-titlebox">
                            <h3 class="c-news__slide-title">{{ item.title }}</h3>
                            <div class="c-news__slide-subtitle" v-html="item.content"></div>
                        </div>
                        <LinkPrimary
                            class="c-news__slide-link"
                            type="NuxtLink"
                            :to="{
                                name: 'blog-article',
                                params: { article: slugify(item.title) },
                                query: { id: item.id },
                            }"
                            :icon-size="20"
                        >
                            Читать
                        </LinkPrimary>
                    </div>
                </EmblaSlide>
            </EmblaContainer>
            <div class="c-news__body">
                <div class="c-news__titlebox">
                    <h4 class="c-news__title">Новости и Проекты</h4>
                    <NuxtLink class="c-news__link" :to="{ name: 'blog' }">
                        <span>Все публикации</span>
                        <span>
                            <SvgSprite type="arrow" :size="12" />
                        </span>
                    </NuxtLink>
                </div>
                <EmblaNavigation
                    class="c-news__controls"
                    :slider-ref="computed(() => sliderRef)"
                ></EmblaNavigation>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';

    const blogStore = useBlogStore();
    const articles = computed(() => blogStore.articles);

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .c-news {
        @include content-block;
        &__container {
            display: grid;
            grid-template-columns: 70% auto;
            gap: rem(32);
            @include content-container;
            @media (max-width: 1024px) {
                display: flex;
                flex-direction: column-reverse;
            }
        }
        &__slider {
            width: 100%;
        }
        &__slide {
            max-width: rem(320);
            width: 100%;
            aspect-ratio: 1;
            color: $c-FFFFFF;
            background-color: $c-1C3A19;
            clip-path: polygon(20% 0, 100% 0, 100% 80%, 80% 100%, 0 100%, 0 20%);
            margin-right: rem(16);
            &-wrapper {
                box-sizing: border-box;
                width: 100%;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                gap: rem(32);
                padding: rem(64) rem(48);
            }
            &-title {
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(24, 18, 480, 1920);
                line-height: 1.2;
                font-weight: $fw-bold;
                @include lineClamp(2);
            }
            &-subtitle {
                font-size: lineScale(18, 14, 480, 1920);
                color: $c-EBEBEB;
                line-height: 1.4;
                opacity: 0.5;
                margin-top: rem(24);
                @include lineClamp(4);
            }
            &-link {
                display: flex;
                align-items: center;
                gap: rem(8);
                text-transform: uppercase;
            }
        }
        &__body {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(64);
        }
        &__title {
            text-transform: uppercase;
            font-family: 'Nuniti', sans-serif;
            font-size: lineScale(40, 32, 480, 1920);
            font-weight: $fw-bold;
        }
        &__link {
            display: flex;
            align-items: center;
            gap: rem(6);
            font-size: lineScale(18, 16, 480, 1920);
            margin-top: rem(32);
            span:has(svg) {
                transition: translate $td $tf;
                will-change: translate;
            }
            @media (pointer: fine) {
                &:hover {
                    span:has(svg) {
                        translate: rem(8) 0;
                    }
                }
            }
        }
    }
</style>
