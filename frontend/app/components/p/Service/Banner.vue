<template>
    <section v-if="props.value && props.unit && props.content" class="service-banner">
        <div class="service-banner__container">
            <div class="service-banner__wrapper">
                <div class="service-banner__title">
                    <span class="service-banner__title-value">{{ props.value }}</span>
                    <span class="service-banner__title-unit">{{ props.unit }}</span>
                    <span class="service-banner__title-hint" v-if="props.description">
                        {{ props.description }}
                    </span>
                </div>
                <div class="service-banner__body">
                    <p class="service-banner__desc">{{ props.content }}</p>
                    <ButtonPrimary
                        v-if="props.article"
                        class="service-banner__button"
                        type="NuxtLink"
                        theme="dark"
                        :to="{
                            name: 'blog-article',
                            params: { article: slugify(props.article.title) },
                            query: { id: props.article.id },
                        }"
                    >
                        УЗНАТЬ БОЛЬШЕ
                    </ButtonPrimary>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { IArticle } from '~~/interfaces/article';

    const props = withDefaults(
        defineProps<{
            value: string | null;
            unit: string | null;
            description: string | null;
            content: string | null;
            article: IArticle | null;
        }>(),
        {
            value: null,
            unit: null,
            description: null,
            content: null,
            article: null,
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .service-banner {
        @include content-block;
        &__container {
            @include content-container;
            @media (max-width: 768px) {
                padding: 0;
            }
        }
        &__wrapper {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            border: rem(8) solid $c-4E6A4C;
            padding: lineScale(96, 64, 480, 1920) lineScale(32, 0, 480, 1920);
            @media (max-width: 1240px) {
                display: flex;
                flex-direction: column;
                gap: rem(32);
            }
            @media (max-width: 768px) {
                border: {
                    left: none;
                    right: none;
                }
            }
        }
        &__title,
        &__body {
            padding: 0 lineScale(64, 16, 480, 1920);
        }
        &__title {
            display: grid;
            grid-template-columns: repeat(2, max-content);
            grid-template-areas:
                'value unit'
                '. hint';
            gap: rem(16);
            font-family: 'Nuniti', sans-serif;
            font-size: lineScale(128, 48, 480, 1920);
            font-weight: $fw-bold;
            @media (max-width: 1240px) {
                justify-content: center;
            }
            &-value {
                grid-area: value;
                white-space: nowrap;
            }
            &-unit {
                grid-area: unit;
                font-weight: 900;
                @supports (-webkit-text-stroke: rem(4) $c-4E6A4C) {
                    color: transparent;
                    -webkit-text-stroke: rem(4) $c-4E6A4C;
                }
            }
            &-hint {
                grid-area: hint;
                font-size: lineScale(24, 16, 480, 1920);
                text-transform: lowercase;
                justify-self: flex-end;
                opacity: 0.9;
            }
        }
        &__body {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            border-left: rem(4) solid $c-4E6A4C;
            @media (max-width: 1240px) {
                border: none;
            }
        }
        &__desc {
            font-size: lineScale(24, 16, 480, 1920);
            font-weight: $fw-bold;
            line-height: 1.2;
        }
    }
</style>
