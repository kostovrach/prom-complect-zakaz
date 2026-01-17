<template>
    <div class="slider-navigation">
        <button
            class="slider-navigation__button slider-navigation__button--prev"
            type="button"
            @click="scrollPrev"
            :disabled="!canScrollPrev"
        >
            <SvgSprite type="arrow" :size="20" />
        </button>
        <div class="slider-navigation__pagination">
            <span class="slider-navigation__pagination-current">{{ selectedSnap }}</span>
            <span class="slider-navigation__pagination-separator"></span>
            <span class="slider-navigation__pagination-total">{{ snapCount }}</span>
        </div>

        <button
            class="slider-navigation__button slider-navigation__button--next"
            type="button"
            @click="scrollNext"
            :disabled="!canScrollNext"
        >
            <SvgSprite type="arrow" :size="20" />
        </button>
    </div>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            sliderRef: ComputedRef<{ emblaApi: EmblaCarouselType | null } | null> | null;
        }>(),
        {
            sliderRef: null,
        }
    );

    const emblaApi = computed(() => props.sliderRef?.value?.emblaApi);

    // controls =======================================================
    const scrollPrev = () => {
        if (!emblaApi.value || !canScrollPrev.value) return;
        emblaApi.value.scrollPrev();
    };
    const scrollNext = () => {
        if (!emblaApi.value || !canScrollNext.value) return;
        emblaApi.value.scrollNext();
    };
    // ================================================================

    // pagination =====================================================
    const selectedSnap = ref<number>(0);
    const snapCount = ref<number>(0);

    const canScrollPrev = ref(false);
    const canScrollNext = ref(false);

    const updateSnapDisplay = () => {
        selectedSnap.value = (emblaApi.value?.selectedScrollSnap() ?? 0) + 1;
        snapCount.value = emblaApi.value?.scrollSnapList().length ?? 0;

        canScrollPrev.value = emblaApi.value?.canScrollPrev() || false;
        canScrollNext.value = emblaApi.value?.canScrollNext() || false;
    };

    onMounted(() => {
        emblaApi.value?.on('select', updateSnapDisplay).on('reInit', updateSnapDisplay);

        updateSnapDisplay();
    });
    // ================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .slider-navigation {
        display: flex;
        align-items: center;
        gap: rem(32);
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
                background-color: $c-accent;
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
            &:disabled {
                opacity: 0.5;
                pointer-events: none;
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
    }
</style>
