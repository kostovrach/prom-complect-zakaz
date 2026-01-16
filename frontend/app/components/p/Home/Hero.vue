<template>
    <section class="home-hero">
        <div class="home-hero__container">
            <EmblaContainer ref="sliderRef" class="home-hero__slider">
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
                            >
                                Обсудить проект
                            </ButtonPrimary>
                            <LinkPrimary
                                class="home-hero__slide-link"
                                type="NuxtLink"
                                :to="{ name: 'index' }"
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
    import type { EmblaCarouselType } from 'embla-carousel';

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

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-hero {
        position: relative;
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
                padding: rem(12) 0;
                border-bottom: rem(1) solid rgba($c-FFF3B0, 0.5);
                // @include arrow-link($overlay-size: rem(18));
            }
        }
        &__button {
            cursor: pointer;
            position: relative;
            transition: scale $td $tf;
            &::before {
                content: '';
                position: absolute;
                z-index: -1;
                top: 50%;
                left: 50%;
                translate: -50% -50%;
                background-color: $c-main;
                width: rem(64);
                aspect-ratio: 1;
                border-radius: 50%;
                opacity: 0;
                transition: opacity $td $tf;
            }
            @media (pointer: fine) {
                &:hover {
                    scale: 1.05;
                    color: $c-FFFFFF;
                    &::before {
                        opacity: 1;
                    }
                }
            }
            &:active {
                scale: 0.99;
            }
            &--prev {
                transform: scaleX(-1);
            }
        }
        &__pagination {
            width: fit-content;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(8);
            font-weight: $fw-bold;
            &-separator {
                display: block;
                width: rem(18);
                height: rem(2);
                background-color: currentColor;
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
            pointer-events: all !important;
            // &:not(.current) {
            // 	opacity: 0;
            // }
            &-bg {
                position: absolute;
                z-index: -1;
                inset: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                filter: brightness(50%);
                @include fullscreen-double-corner;
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
