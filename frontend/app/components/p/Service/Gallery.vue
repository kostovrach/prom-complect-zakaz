<template>
    <BlockLiquidTitle
        v-if="props.title && props.slides.length"
        class="service-gallery"
        :title="props.title"
        alignment="left"
    >
        <template #default>
            <EmblaContainer
                ref="sliderRef"
                class="service-gallery__slider"
                :options="{ loop: true, align: 'start' }"
            >
                <EmblaSlide
                    v-for="(slide, idx) in props.slides"
                    :key="idx"
                    class="service-gallery__slide"
                    width="100%"
                >
                    <picture class="service-gallery__slide-image-container">
                        <img
                            class="service-gallery__slide-image"
                            :src="slide.image_url ?? ''"
                            :alt="slide.title ?? '#'"
                        />
                    </picture>
                    <div class="service-gallery__slide-wrapper">
                        <div class="service-gallery__slide-head">
                            <div class="service-gallery__slide-icon">
                                <SvgSprite type="plus" :size="48" />
                            </div>
                        </div>
                        <div class="service-gallery__slide-content">
                            <h3 class="service-gallery__slide-title">{{ slide.title }}</h3>
                            <p class="service-gallery__slide-desc">{{ slide.description }}</p>
                        </div>
                    </div>
                </EmblaSlide>
            </EmblaContainer>
            <EmblaNavigation
                class="service-gallery__controls"
                :slider-ref="computed(() => sliderRef)"
            />
        </template>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    import { EmblaNavigation } from '#components';
    import type { EmblaCarouselType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            title: string | null;
            slides: {
                id: string | number;
                date_created: string;
                date_updated: string | null;
                title: string;
                description: string;
                image: string;
                image_url?: string;
            }[];
        }>(),
        {
            title: null,
            slides: () => [],
        }
    );

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null; $el: HTMLElement | null } | null>(
        null
    );

    onMounted(async () => {
        await nextTick();

        const elements = sliderRef.value?.$el?.querySelectorAll(
            '.service-gallery__slide-desc'
        ) as NodeListOf<HTMLParagraphElement>;
        if (!elements || !elements.length) return;

        elements.forEach((el) => {
            const height = el.clientHeight;
            el.style.setProperty('--height', `${height}px`);
        });
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .service-gallery {
        $p: &;

        &__controls {
            margin-top: rem(64);
        }
        &__slider {
            margin-top: rem(64);
        }
        &__slide {
            position: relative;
            box-sizing: border-box;
            color: $c-FFFFFF;
            max-width: rem(480);
            aspect-ratio: 1;
            margin-right: rem(16);
            overflow: hidden;
            @media (max-width: 1024px) {
                max-width: rem(420);
            }
            &-image-container {
                position: absolute;
                z-index: 0;
                inset: 0;
                clip-path: polygon(100% 0, 100% 80%, 80% 100%, 0 100%, 0 0);
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 1;
                    inset: 0;
                    pointer-events: none;
                    background-color: rgba($c-4E6A4C, 0.5);
                    backdrop-filter: blur(5px);
                    transition: opacity $td $tf;
                    @media (pointer: fine) {
                        opacity: 0;
                        @at-root #{$p}__slide:hover & {
                            opacity: 1;
                        }
                    }
                }
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-wrapper {
                width: 100%;
                height: 100%;
                position: relative;
                z-index: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                padding: lineScale(24, 16, 480, 1920);
            }
            &-icon {
                width: fit-content;
                opacity: 0.5;
                transition: rotate $td $tf;
                @media (pointer: fine) {
                    @at-root #{$p}__slide:hover & {
                        rotate: 135deg;
                    }
                }
            }
            &-content {
                max-width: 85%;
                display: flex;
                flex-direction: column;
            }
            &-title {
                text-transform: uppercase;
                font-size: lineScale(32, 24, 480, 1920);
                font-weight: $fw-bold;
            }
            &-desc {
                font-size: lineScale(18, 16, 480, 1920);
                line-height: 1.3;
                transition:
                    flex $td $tf,
                    margin-top $td $tf;
                @media (pointer: coarse) {
                    margin-top: rem(16);
                }
                @media (pointer: fine) {
                    min-height: 0;
                    flex: 0 1 calc(var(--height) - var(--height));
                    overflow: hidden;
                    @at-root #{$p}__slide:hover & {
                        flex: 1 1 var(--height);
                        margin-top: rem(16);
                    }
                }
            }
        }
    }
</style>
