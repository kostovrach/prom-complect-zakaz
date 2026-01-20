<template>
    <section class="home-hero">
        <div class="home-hero__container">
            <div class="home-hero__nav">
                <LinkPrimary
                    v-for="service in services.slice(0, 5)"
                    :key="service.id"
                    class="home-hero__nav-item"
                    :icon-size="16"
                    type="NuxtLink"
                    :to="{
                        name: 'services-service',
                        params: { service: slugify(service.hero_title) },
                        query: { id: service.id },
                    }"
                >
                    {{ service.hero_title }}
                </LinkPrimary>
            </div>
            <EmblaContainer ref="sliderRef" class="home-hero__slider" fade>
                <EmblaSlide
                    v-for="(slide, idx) in props.slides"
                    :key="idx"
                    class="home-hero__slide"
                    width="100%"
                >
                    <template v-if="slide.file.type.startsWith('video/')">
                        <video class="home-hero__slide-bg" loop muted autoplay playsinline>
                            <source
                                :src="`/api/cms/assets/${slide.file.id}`"
                                :type="slide.file.type"
                            />
                        </video>
                    </template>
                    <template v-else>
                        <picture class="home-hero__slide-bg">
                            <img
                                class="home-hero__slide-bg-image"
                                :src="`/api/cms/assets/${slide.file.id}`"
                                :alt="slide.title ?? '#'"
                            />
                        </picture>
                    </template>
                    <div class="home-hero__slide-content">
                        <div class="home-hero__slide-overlay">
                            <SvgSprite v-for="n in 3" :key="n" type="plus" :size="32" />
                        </div>
                        <h2 class="home-hero__slide-title">{{ slide.title }}</h2>
                        <div class="home-hero__slide-controls">
                            <p v-if="slide.subtitle" class="home-hero__slide-subtitle">
                                {{ slide.subtitle }}
                            </p>
                            <ButtonPrimary
                                class="home-hero__slide-button"
                                theme="yellow"
                                type="button"
                                button-type="button"
                                @click="openModalRequest"
                            >
                                Обсудить проект
                            </ButtonPrimary>
                            <LinkPrimary
                                class="home-hero__slide-link"
                                type="NuxtLink"
                                :to="{ name: 'quiz' }"
                            >
                                Подобрать оборудование
                            </LinkPrimary>
                        </div>
                    </div>
                </EmblaSlide>
            </EmblaContainer>
            <div class="home-hero__footer">
                <EmblaNavigation
                    class="home-hero__controls"
                    :slider-ref="computed(() => sliderRef)"
                ></EmblaNavigation>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { IDirectusFile } from '~~/interfaces/directus-file';
    import type { EmblaCarouselType, EmblaEventType } from 'embla-carousel';
    import { useModal } from 'vue-final-modal';
    import { ModalsFormRequest } from '#components';

    const props = withDefaults(
        defineProps<{
            slides: {
                title: string;
                subtitle: string;
                file: IDirectusFile;
            }[];
        }>(),
        {
            slides: () => [],
        }
    );

    const servicesStore = useServicesStore();

    // Slider ===================================================
    const TWEEN_FACTOR_BASE = 0.2;

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
    const sliderApi = computed(() => sliderRef.value?.emblaApi);

    const tweenFactor = ref(0);
    const tweenNodes = ref<HTMLElement[]>([]);
    const tweenNodesReverse = ref<HTMLElement[]>([]);

    function setTweenFactor() {
        if (!sliderApi.value) return;

        tweenFactor.value = TWEEN_FACTOR_BASE * sliderApi.value.scrollSnapList().length;
    }

    function setTweenNodes() {
        if (!sliderApi.value) return;

        const nodes = sliderApi.value.slideNodes().map((slideNode) => {
            return slideNode.querySelector('.home-hero__slide-title');
        });

        const nodesReverse = sliderApi.value.slideNodes().map((slideNode) => {
            return slideNode.querySelector('.home-hero__slide-subtitle');
        });

        tweenNodes.value = nodes.filter((node) => node instanceof HTMLElement);
        tweenNodesReverse.value = nodesReverse.filter((node) => node instanceof HTMLElement);
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
                const tweenNodeReverse = tweenNodesReverse.value[slideIdx];

                if (!tweenNode || !tweenNodeReverse) return;

                tweenNode.style.transform = `translateX(${translate}rem)`;
                tweenNodeReverse.style.transform = `translateX(${translate * -1}rem)`;
            });
        });
    }
    // ==========================================================

    const services = computed(() => servicesStore.services);

    const { open: openModalRequest, close: _closeModalRequest } = useModal({
        component: ModalsFormRequest,
        attrs: {
            onClose() {
                _closeModalRequest();
            },
        },
    });

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

    .home-hero {
        position: relative;
        @include content-block($margin: rem(64));
        &__container {
            @include content-container;
            @media (max-width: 768px) {
                padding: 0;
            }
        }
        &__nav {
            position: absolute;
            z-index: 3;
            right: calc(rem(24) + lineScale(32, 16, 480, 1920));
            top: rem(32);
            display: flex;
            flex-direction: column;
            color: $c-FFFFFF;
            @media (max-width: 768px) {
                display: none;
            }
            &-item {
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: lineScale(128, 64, 480, 1920);
                text-align: right;
                text-transform: uppercase;
                padding: rem(12) 0;
                border-bottom: rem(1) solid rgba($c-FFF3B0, 0.5);
            }
        }
        &__slide {
            position: relative;
            width: 100%;
            min-height: 75vh;
            height: fit-content;
            display: flex;
            align-items: flex-end;
            justify-content: flex-start;
            color: $c-FFFFFF;
            overflow: hidden;
            &-bg {
                position: absolute;
                z-index: -1;
                inset: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                filter: brightness(50%);
                @include fullscreen-double-corner;
                &-image {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            &-content {
                position: relative;
                width: fit-content;
                max-width: 125ch;
                height: fit-content;
                display: flex;
                flex-direction: column;
                gap: rem(64);
                padding: rem(96) rem(32);
                margin-top: rem(220);
            }
            &-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                pointer-events: none;
            }
            &-title {
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(64, 32, 480, 1920);
                font-weight: $fw-bold;
                text-wrap: balance;
            }
            &-controls {
                width: fit-content;
                display: grid;
                grid-template-areas:
                    'subtitle subtitle'
                    'button link';
                gap: rem(32) rem(64);
                @media (max-width: 768px) {
                    grid-template-columns: 100%;
                    grid-template-areas:
                        'subtitle'
                        'link'
                        'button';
                }
            }
            &-subtitle {
                grid-area: subtitle;
                max-width: 55ch;
                line-height: 1.4;
                text-wrap: balance;
            }
            &-button {
                grid-area: button;
            }
            &-link {
                grid-area: link;
                max-width: 15ch;
                display: flex;
                align-items: center;
                gap: rem(16);
                font-size: lineScale(18, 16, 480, 1920);
                line-height: 1.4;
            }
        }
        &__footer {
            display: flex;
            align-items: flex-end;
            justify-content: flex-end;
            margin-top: rem(32);
            @media (max-width: 768px) {
                align-items: center;
                justify-content: center;
            }
        }
    }
</style>
