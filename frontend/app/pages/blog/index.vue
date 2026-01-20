<template>
    <NuxtLayout>
        <section class="blog">
            <div class="blog__container">
                <div class="blog__titlebox">
                    <h1 class="blog__title">Полезные материалы</h1>
                    <div class="blog__chips">
                        <button
                            :class="[
                                'blog__chips-item',
                                { 'blog__chips-item--active': checkCategory('all') },
                            ]"
                            type="button"
                            @click="setCategory('all')"
                        >
                            Все
                        </button>
                        <button
                            v-for="(chip, idx) in tags"
                            :key="idx"
                            :class="[
                                'blog__chips-item',
                                { 'blog__chips-item--active': checkCategory(chip) },
                            ]"
                            type="button"
                            @click="setCategory(chip)"
                        >
                            {{ chip }}
                        </button>
                    </div>
                </div>
                <div class="blog__list">
                    <template v-for="article in articles" :key="article.id">
                        <NuxtLink
                            v-if="
                                article.tags.some((el) => slugify(el) === currentCategory) ||
                                currentCategory === 'all'
                            "
                            class="blog__item"
                            :to="{
                                name: 'blog-article',
                                params: { article: slugify(article.title) },
                                query: { id: article.id },
                            }"
                        >
                            <picture class="blog__item-image-container">
                                <img
                                    class="blog__item-image"
                                    :src="article.cover_url ?? ''"
                                    :alt="article.title ?? '#'"
                                />
                            </picture>
                            <div class="blog__item-wrapper">
                                <div class="blog__item-titlebox">
                                    <h2 class="blog__item-title">{{ article.title }}</h2>
                                    <div class="blog__item-desc" v-html="article.content"></div>
                                </div>
                                <LinkPrimary class="blog__item-link" type="button">
                                    Читать
                                </LinkPrimary>
                            </div>
                        </NuxtLink>
                    </template>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    const blogStore = useBlogStore();

    const tags = computed(() => blogStore.tags);
    const articles = computed(() => blogStore.articles);

    const currentCategory = ref<string | 'all'>('all');

    function setCategory(category: string) {
        currentCategory.value = slugify(category);
    }

    function checkCategory(category: string): boolean {
        return currentCategory.value === slugify(category);
    }
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .blog {
        @include content-block;
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(16);
        }
        &__title {
            font-family: 'Nuniti', sans-serif;
            text-transform: uppercase;
            font-weight: $fw-bold;
            font-size: lineScale(44, 30, 480, 1920);
            line-height: 1.2;
            max-width: 35ch;
        }
        &__chips {
            max-width: 65ch;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            gap: rem(8);
            &-item {
                cursor: pointer;
                text-transform: uppercase;
                color: $c-FFFFFF;
                font-size: lineScale(16, 14, 480, 1920);
                background-color: $c-4E6A4C;
                padding: rem(4) rem(16);
                &--active {
                    background-color: $c-1C3A19;
                }
                @media (pointer: fine) {
                    &:hover {
                        background-color: $c-1C3A19;
                    }
                }
            }
        }
        &__list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: rem(16);
            margin-top: rem(64);
            :nth-child(8n + 2) {
                grid-column: 3 / span 2;
            }
            :nth-child(8n + 3) {
                grid-column: 1 / span 2;
            }
            :nth-child(8n + 5) {
                grid-column: 1;
            }
            @media (max-width: 1024px) {
                grid-template-columns: repeat(2, 1fr);
                :nth-child(8n + 2) {
                    grid-column: 1 / span 2;
                }
            }
            @media (max-width: 660px) {
                display: flex;
                flex-direction: column;
            }
        }
        &__item {
            position: relative;
            display: block;
            width: 100%;
            height: 100%;
            transition: color $td $tf 0s;
            @include right-corner;
            @media (pointer: fine) {
                &:hover {
                    color: $c-FFFFFF;
                    &::before {
                        opacity: 0;
                    }
                }
            }
            &-image-container {
                position: absolute;
                z-index: 0;
                inset: 0;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                filter: grayscale(80%) brightness(60%);
            }
            &::before {
                content: '';
                position: absolute;
                z-index: 1;
                inset: 0;
                background-color: $c-FFFFFF;
                pointer-events: none;
                transition: opacity $td $tf;
            }
            &-wrapper {
                position: relative;
                z-index: 2;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                gap: rem(40);
                padding: rem(24);
            }
            &-title {
                font-size: lineScale(24, 18, 480, 1920);
                font-family: 'Nuniti', sans-serif;
                font-weight: $fw-bold;
            }
            &-desc {
                font-size: lineScale(18, 16, 480, 1920);
                opacity: 0.8;
                margin-top: rem(24);
                @include text-content(
                    $font-size: lineScale(18, 16, 480, 1920),
                    $h-size: lineScale(20, 18, 480, 1920),
                    $h2-size: lineScale(22, 20, 480, 1920)
                );
                @include lineClamp(6);
                > p {
                    margin: rem(16) 0;
                }
            }
            &-link {
                width: fit-content;
                display: flex;
                align-items: center;
                gap: rem(8);
                text-transform: uppercase;
                font-weight: $fw-bold;
            }
        }
    }
</style>
