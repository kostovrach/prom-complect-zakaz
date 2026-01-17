<template>
    <BlockLiquidTitle
        v-if="content && content.items.length"
        :title="content.title"
        :subtitle="content.subtitle"
        alignment="left"
        layout="horizontal"
        large
        large-body
        class="c-faq"
    >
        <Accordion class="c-faq__list" unstyled>
            <AccordionPanel
                v-for="(item, idx) in content.items"
                :key="idx"
                :value="idx"
                :class="['c-faq__item', { 'c-faq__item--active': activeIdx === idx }]"
            >
                <div class="c-faq__item-wrapper">
                    <AccordionHeader class="c-faq__item-head">
                        <span>{{ item.title }}</span>
                        <template #toggleicon>
                            <SvgSprite type="triangle" :size="16" />
                        </template>
                    </AccordionHeader>
                    <AccordionContent class="c-faq__item-content">
                        <div class="c-faq__item-text" v-html="item.content"></div>
                    </AccordionContent>
                </div>
            </AccordionPanel>
        </Accordion>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    interface IContent {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        subtitle: string | null;
        items: {
            title: string;
            content: string;
        }[];
    }

    const { content } = await useCms<IContent>('faq');

    const activeIdx = ref<number | undefined>(undefined);
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .c-faq {
        $p: &;

        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__item {
            width: 100%;
            background-color: $c-FFFFFF;
            &-wrapper {
                width: 100%;
                display: flex;
                flex-direction: column;
                padding: 0 lineScale(32, 16, 480, 1920);
            }
            &-head {
                cursor: pointer;
                box-sizing: border-box;
                width: 100%;
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                gap: rem(32);
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(24, 18, 480, 1920);
                line-height: 1.2;
                color: $c-082605;
                font-weight: $fw-bold;
                padding: rem(32) 0;
            }
            &-icon {
                min-width: rem(12);
                transition: transform $td $tf;
                #{$p}__item--open & {
                    transform: scaleY(-1);
                }
            }
            &-text {
                padding-bottom: rem(32);
                @include text-content(
                    $font-size: lineScale(16, 14, 480, 1920),
                    $h2-size: lineScale(20, 18, 480, 1920),
                    $h-size: lineScale(18, 16, 480, 1920)
                );
            }
        }
    }
</style>
