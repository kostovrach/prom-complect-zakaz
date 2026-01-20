<template>
    <BlockLiquidTitle
        v-if="props.title && props.items.length"
        :title="props.title"
        :tag="props.tag"
        alignment="left"
        layout="horizontal"
        class="service-faq"
    >
        <Accordion
            class="service-faq__body"
            unstyled
            @tab-close="activeIdx = undefined"
            @tab-open="(e) => (activeIdx = e.index)"
        >
            <AccordionPanel
                v-for="(item, idx) in props.items"
                :key="idx"
                :value="idx"
                :class="['service-faq__item', { 'service-faq__item--active': activeIdx === idx }]"
            >
                <div class="service-faq__item-wrapper">
                    <AccordionHeader class="service-faq__item-head">
                        <h3 class="service-faq__item-title">{{ item.title }}</h3>
                        <template #toggleicon>
                            <div class="service-faq__item-icon">
                                <SvgSprite type="triangle" :size="16" />
                            </div>
                        </template>
                    </AccordionHeader>
                    <AccordionContent class="service-faq__item-body">
                        <div class="service-faq__item-content" v-html="item.content"></div>
                    </AccordionContent>
                </div>
                <div class="service-faq__item-sider">
                    <span class="service-faq__item-count">{{ idx + 1 }}</span>
                </div>
            </AccordionPanel>
        </Accordion>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string | null;
            tag: string | null;
            items: {
                title: string;
                content: string;
            }[];
        }>(),
        {
            title: null,
            tag: null,
            items: () => [],
        }
    );

    const activeIdx = ref<number | undefined>(undefined);
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .service-faq {
        $p: &;

        &__body {
            display: flex;
            flex-direction: column;
            gap: lineScale(32, 16, 480, 1920);
            overflow: visible;
        }
        &__item {
            position: relative;
            background-color: $c-FFFFFF;
            border-left: rem(2) solid $c-082605;
            @media (pointer: fine) {
                display: grid;
                grid-template-columns: 80% auto;
                grid-template-areas: 'content sider';
                gap: rem(16);
            }
            &-wrapper {
                grid-area: content;
            }
            &-sider {
                grid-area: sider;
                @media (pointer: coarse) {
                    display: none;
                }
            }
            &-count {
                display: block;
                position: sticky;
                top: rem(128);
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(240, 128, 480, 1920);
                line-height: 0.5;
                font-weight: $fw-bold;
                transition:
                    opacity $td $tf,
                    translate $td $tf;

                translate: 100% 0;
                opacity: 0;
                height: rem(64);
                overflow: visible;
                @media (pointer: fine) {
                    @at-root #{$p}__item:hover & {
                        translate: 0 0;
                        opacity: 1;
                    }
                }
                @at-root #{$p}__item--active & {
                    translate: 0 0;
                    opacity: 1;
                }
            }
            &-head {
                cursor: pointer;
                display: flex;
                align-items: flex-start;
                gap: rem(32);
                padding: rem(40) lineScale(24, 16, 480, 1920);
            }
            &-title {
                font-size: lineScale(24, 18, 480, 1920);
                font-weight: $fw-bold;
                color: $c-082605;
            }
            &-icon {
                min-width: rem(12);
                transition: transform $td $tf;
                @at-root #{$p}__item--active & {
                    transform: scaleY(-1);
                }
            }
            &-content {
                font-weight: $fw-semi;
                opacity: 0.5;
                padding: 0 lineScale(24, 16, 480, 1920) rem(40);
                overflow: hidden;
                transition: flex $td $tf;
                @include text-content(
                    $font-size: rem(16),
                    $h2-size: lineScale(22, 20, 480, 1920),
                    $h-size: lineScale(20, 18, 480, 1920)
                );
            }
        }
    }
</style>
