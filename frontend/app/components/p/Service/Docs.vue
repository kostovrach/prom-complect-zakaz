<template>
    <BlockLiquidTitle
        v-if="props.title && props.docs.length"
        :title="props.title"
        alignment="left"
        class="service-docs"
    >
        <div class="service-docs__body">
            <EmblaContainer ref="sliderRef" class="service-docs__slider" padding="16px 0">
                <EmblaSlide
                    v-for="(slide, idx) in props.docs"
                    :key="idx"
                    class="service-docs__slide"
                    width="100%"
                >
                    <Lightbox>
                        <a
                            class="service-docs__slide-wrapper"
                            :href="slide.file_url"
                            data-fancybox="docs"
                        >
                            <h3 class="service-docs__slide-title">{{ slide.title }}</h3>
                            <div class="service-docs__slide-icon">
                                <SvgSprite type="file" :size="48" />
                            </div>
                            <div class="service-docs__slide-button">
                                <div class="service-docs__slide-button-wrapper">
                                    <SvgSprite type="eye" :size="18" />
                                    <span>Посмотреть</span>
                                </div>
                            </div>
                        </a>
                    </Lightbox>
                </EmblaSlide>
            </EmblaContainer>
            <EmblaNavigation
                :slider-ref="computed(() => sliderRef)"
                class="service-docs__controls"
            ></EmblaNavigation>
        </div>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            title: string | null;
            docs: {
                id: string | number;
                date_created: string;
                date_updated: string | null;
                title: string;
                file: string;
                file_url?: string;
            }[];
        }>(),
        {
            title: null,
            docs: () => [],
        }
    );

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .service-docs {
        $p: &;

        &__body {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: rem(64);
            margin-top: rem(64);
        }
        &__slide {
            max-width: rem(268);
            min-width: rem(268);
            aspect-ratio: 1;
            box-sizing: border-box;
            margin-right: rem(16);
            &-wrapper {
                width: 100%;
                height: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: space-between;
                gap: rem(32);
                background-color: $c-FFFFFF;
                padding: lineScale(32, 16, 480, 1920);
                transition: translate $td $tf;
                @media (pointer: fine) {
                    @at-root #{$p}__slide:hover & {
                        translate: 0 rem(-16);
                    }
                }
            }
            &-title {
                font-weight: $fw-semi;
                color: $c-082605;
                text-align: center;
            }
            &-button {
                height: 1.2em;
                font-size: lineScale(16, 14, 480, 1920);
                font-weight: $fw-bold;
                color: $c-082605;
                &-wrapper {
                    min-height: 0;
                    display: flex;
                    align-items: center;
                    gap: rem(4);
                    overflow: hidden;
                    transition: height $td $tf;
                    @media (pointer: fine) {
                        height: 0;
                        @at-root #{$p}__slide:hover & {
                            height: 1.2em;
                        }
                    }
                }
            }
        }
    }
</style>
