<template>
    <BlockLiquidTitle
        v-if="props.title && props.slides.length"
        :title="props.title"
        :subtitle="props.subtitle"
        class="about-gallery"
    >
        <div class="about-gallery__body">
            <EmblaContainer ref="sliderRef" class="about-gallery__slider" fade>
                <EmblaSlide
                    v-for="(slide, idx) in props.slides"
                    :key="idx"
                    class="about-gallery__slide"
                    width="100%"
                >
                    <div class="about-gallery__slide">
                        <div class="about-gallery__slide-wrapper">
                            <picture class="about-gallery__slide-image-container">
                                <img
                                    class="about-gallery__slide-image"
                                    :src="slide.image_url ?? ''"
                                    :alt="slide.description ?? '#'"
                                />
                            </picture>
                            <p v-if="slide.description" class="about-gallery__slide-desc">
                                {{ slide.description }}
                            </p>
                        </div>
                    </div>
                </EmblaSlide>
            </EmblaContainer>
            <EmblaNavigation
                :slider-ref="computed(() => sliderRef)"
                class="about-gallery__controls"
            ></EmblaNavigation>
        </div>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType, EmblaEventType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            title: string | null;
            subtitle: string | null;
            slides: {
                image_url?: string;
                description: string | null;
            }[];
        }>(),
        {
            title: null,
            subtitle: null,
            slides: () => [],
        }
    );

    // Slider ===================================================
    const TWEEN_FACTOR_BASE = 0.2;

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
    const sliderApi = computed(() => sliderRef.value?.emblaApi);

    const tweenFactor = ref(0);
    const tweenNodes = ref<HTMLElement[]>([]);

    function setTweenFactor() {
        if (!sliderApi.value) return;

        tweenFactor.value = TWEEN_FACTOR_BASE * sliderApi.value.scrollSnapList().length;
    }

    function setTweenNodes() {
        if (!sliderApi.value) return;

        const nodes = sliderApi.value.slideNodes().map((slideNode) => {
            return slideNode.querySelector('.about-gallery__slide-desc');
        });

        tweenNodes.value = nodes.filter((node) => node instanceof HTMLElement);
    }

    function tweenParallax(eventName?: EmblaEventType) {
        if (!sliderApi.value) return;

        const engine = sliderApi.value.internalEngine();
        const scrollProgress = sliderApi.value.scrollProgress();
        const slidesInView = sliderApi.value.slidesInView();
        const isScrollEvent = eventName === 'scroll';

        sliderApi.value.scrollSnapList().forEach((scrollSnap, snapIdx) => {
            let diffToTarget = scrollSnap - scrollProgress;
            const slidesInSnap = engine.slideRegistry[snapIdx] ?? [];

            slidesInSnap.forEach((slideIdx) => {
                if (isScrollEvent && !slidesInView.includes(slideIdx)) return;

                if (engine.options.loop) {
                    engine.slideLooper.loopPoints.forEach((loopItem) => {
                        const target = loopItem.target();

                        if (slideIdx === loopItem.index && target !== 0) {
                            const sign = Math.sign(target);

                            if (sign === -1) {
                                diffToTarget = scrollSnap - (1 + scrollProgress);
                            }
                            if (sign === 1) {
                                diffToTarget = scrollSnap + (1 - scrollProgress);
                            }
                        }
                    });
                }

                const translate = diffToTarget * (-1 * tweenFactor.value) * 100;
                const tweenNode = tweenNodes.value[slideIdx];

                if (!tweenNode) return;

                tweenNode.style.transform = `translateX(${translate}rem)`;
            });
        });
    }
    // ==========================================================

    // Lifecycle ================================================
    onMounted(() => {
        if (!sliderApi.value) return;

        setTweenNodes();
        setTweenFactor();
        tweenParallax();

        sliderApi.value
            .on('reInit', setTweenNodes)
            .on('reInit', setTweenFactor)
            .on('reInit', (_, event) => tweenParallax(event))
            .on('scroll', (_, event) => tweenParallax(event))
            .on('slideFocus', (_, event) => tweenParallax(event));
    });
    // ==========================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .about-gallery {
        &__body {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: rem(64);
            margin-top: rem(64);
            @media (max-width: 768px) {
                align-items: center;
            }
        }
        &__slider {
            width: 100%;
        }
        &__slide {
            &-wrapper {
                display: flex;
                flex-direction: column;
                gap: rem(32);
            }
            &-image-container {
                width: 100%;
                height: lineScale(640, 480, 480, 1920);
                @include fullscreen-double-corner;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-desc {
                max-width: 80ch;
                font-size: lineScale(18, 16, 480, 1920);
                text-wrap: balance;
            }
        }
    }
</style>
