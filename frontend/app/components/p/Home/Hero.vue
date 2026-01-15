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
                            <ButtonPrimary class="home-hero__slide-button" theme="yellow">
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
        &__container {
            @include content-container;
        }
    }
</style>
