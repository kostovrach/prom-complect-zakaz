<template>
    <section :class="['block-layout', `block-layout--${props.layout}`, props.class]">
        <div :class="['block-layout__container', props.containerClass]">
            <div ref="container" class="block-layout__titlebox">
                <div
                    class="block-layout__titlebox-wrapper"
                    :style="{
                        textAlign: props.alignment,
                        alignItems: props.alignment === 'center' ? props.alignment : 'flex-start',
                    }"
                >
                    <h2 class="block-layout__title">
                        <span
                            v-for="(word, idx) in splitTitle"
                            :key="idx"
                            :style="`--fill: ${wordProgressArray[idx] ? wordProgressArray[idx] : 0}%`"
                        >
                            {{ `${word}${' '}` }}
                        </span>
                    </h2>
                    <p class="block-layout__subtitle" v-if="props.subtitle?.length">
                        {{ props.subtitle }}
                    </p>
                    <slot name="button"></slot>
                </div>
            </div>
            <div class="block-layout__content">
                <slot></slot>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle?: string | null;
            layout?: 'vertical' | 'horizontal';
            class?: string | Record<string, any>;
            containerClass?: string | Record<string, any>;
            alignment?: 'center' | 'left';
        }>(),
        {
            title: '',
            subtitle: null,
            layout: 'vertical',
            class: '',
            containerClass: '',
            alignment: 'center',
        }
    );

    const container = shallowRef<HTMLElement | null>(null);
    const { top, bottom, height: elHeight } = useElementBounding(container);
    const { height: windowHeight } = useWindowSize();

    const splitTitle = computed(() => props.title.trim().split(' '));

    const visible = computed(
        () => Math.min(bottom.value, windowHeight.value / 1.3) - Math.max(top.value, 0)
    );

    const progressRaw = computed(() => Math.max(0, visible.value / elHeight.value));

    const wordProgressArray = computed(() => {
        const length = splitTitle.value.length;
        const segment = 1 / length;
        return splitTitle.value.map((_, index) => {
            const start = index * segment;
            const end = (index + 1) * segment;
            let localProgress;

            if (progressRaw.value <= start) localProgress = 0;
            else if (progressRaw.value >= end) localProgress = 1;
            else localProgress = (progressRaw.value - start) / segment;

            return Math.round(localProgress * 100);
        });
    });
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .block-layout {
        $p: &;

        @include content-block;
        &__container {
            position: relative;
            @include content-container;
            @at-root #{$p}--horizontal & {
                display: grid;
                grid-template-columns: 40% auto;
                gap: rem(48);
                @media (max-width: 1024px) {
                    grid-template-columns: 100%;
                }
            }
        }

        &__titlebox {
            @at-root #{$p}--horizontal & {
                position: relative;
                height: 100%;
            }
            &-wrapper {
                display: flex;
                flex-direction: column;
                gap: rem(24);
                @at-root #{$p}--horizontal & {
                    position: sticky;
                    top: rem(96);
                }
            }
        }
        &__title {
            > span {
                color: transparent;
                background-image: linear-gradient(90deg, $c-1C3A19 50%, $c-secondary 50%);
                background-size: 200% 100%;
                background-position-x: calc(100% - var(--fill));
                background-clip: text;
                -webkit-background-clip: text;
                transition: background-position calc($td / 2) $tf;
            }
        }
        &__subtitle {
        }
    }
</style>
