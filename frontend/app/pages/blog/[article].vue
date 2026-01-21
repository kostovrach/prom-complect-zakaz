<template>
    <NuxtLayout>
        <article class="article">
            <div class="article__container">
                <header class="article__header">
                    <div class="article__header-wrapper">
                        <ul v-if="article?.tags.length" class="article__chips">
                            <li
                                v-for="(chip, idx) in article?.tags"
                                :key="idx"
                                class="article__chips-item"
                            >
                                {{ chip }}
                            </li>
                        </ul>
                        <h1 class="article__title">{{ article?.title }}</h1>
                        <LinkPrimary
                            class="article__back-link"
                            type="NuxtLink"
                            :to="{ name: 'blog' }"
                            reverse
                        >
                            Назад
                        </LinkPrimary>
                    </div>
                </header>
                <div class="article__body">
                    <picture class="article__cover-container">
                        <img
                            class="article__cover"
                            :src="article?.cover_url ?? ''"
                            :alt="article?.title ?? '#'"
                        />
                    </picture>
                    <div class="article__content" v-html="article?.content"></div>
                    <PArticleBanner v-if="article?.hint_enabled" />
                </div>
                <aside v-if="suggest?.length" class="article__suggest">
                    <div class="article__suggest-titlebox">
                        <h4 class="article__suggest-title">РЕКОМЕНДУЕМ К ПРОЧТЕНИЮ</h4>
                    </div>
                    <div class="article__suggest-body">
                        <NuxtLink
                            v-for="item in suggest.slice(0, 3)"
                            :key="item.id"
                            class="article__suggest-item"
                            :to="{
                                name: 'blog-article',
                                params: { article: slugify(item.title) },
                                query: { id: item.id },
                            }"
                        >
                            <div class="article__suggest-item-wrapper">
                                <div class="article__suggest-item-titlebox">
                                    <h3 class="article__suggest-item-title">{{ item.title }}</h3>
                                    <div
                                        class="article__suggest-item-subtitle"
                                        v-html="item.content"
                                    ></div>
                                </div>
                                <LinkPrimary class="article__suggest-item-link" type="button">
                                    Читать
                                </LinkPrimary>
                            </div>
                        </NuxtLink>
                    </div>
                </aside>
            </div>
        </article>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IArticle } from '~~/interfaces/article';

    const route = useRoute();
    const queryArticleId = route.query.id;

    if (!queryArticleId || typeof queryArticleId !== 'string') {
        throw createError({
            status: 404,
            message: 'Page not found',
            fatal: true,
            data: { additionalInfo: 'Article ID is missing' },
        });
    }

    const articleId = queryArticleId;
    const { item: article } = await useCmsItem<IArticle>('articles', articleId);
    const { content: articles } = await useCms<IArticle[]>('articles');
    const suggest = computed(() => articles.value?.filter((el) => el.id !== articleId));

    if (!article || !article.value) {
        throw createError({
            status: 404,
            message: 'Page not found',
            fatal: true,
        });
    }

    // SEO & Meta ==================================================
    useHead({
        title: article.value?.meta_title ?? '',
        meta: [
            { name: 'description', content: article.value?.meta_description ?? '' },
            { name: 'robots', content: article.value?.meta_robots ?? 'index, follow' },
            { name: 'keywords', content: article.value?.meta_keywords ?? [] },

            { property: 'og:title', content: article.value?.meta_title ?? '' },
            { property: 'og:description', content: article.value?.meta_description ?? '' },
            { property: 'og:type', content: article.value?.og_type ?? 'website' },
            { property: 'og:image', content: article.value?.og_image_url ?? '' },
            { property: 'og:url', content: useRequestURL().href },

            { name: 'twitter:card', content: 'summary_large_image' },
            { name: 'twitter:title', content: article.value?.meta_title ?? '' },
        ],
    });

    if (article.value?.shema_markup) {
        useHead({
            script: [
                {
                    type: 'application/ld+json',
                    innerHTML: article.value.shema_markup || {},
                },
            ],
        });
    }
    // =============================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .article {
        @include content-block;
        &__container {
            display: grid;
            grid-template-columns: auto 60%;
            grid-template-areas:
                'header body'
                'suggest suggest';
            gap: lineScale(64, 32, 480, 1920);
            @include content-container;
            @media (max-width: 1024px) {
                display: flex;
                flex-direction: column;
            }
        }
        &__header {
            grid-area: header;
            position: relative;
            height: 100%;
            &-wrapper {
                position: sticky;
                top: rem(132);
                margin-top: rem(132);
            }
        }
        &__title {
            text-transform: uppercase;
            font-family: 'Nuniti', sans-serif;
            font-size: lineScale(32, 26, 480, 1920);
            font-weight: $fw-bold;
            color: $c-1C3A19;
            line-height: 1.2;
            margin-top: rem(24);
        }
        &__chips {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(8);
            &-item {
                text-transform: uppercase;
                font-size: rem(14);
                color: $c-FFFFFF;
                padding: rem(6) rem(16);
                background-color: $c-4E6A4C;
            }
        }
        &__back-link {
            display: flex;
            align-items: center;
            gap: rem(8);
            text-transform: uppercase;
            font-weight: $fw-bold;
            margin-top: rem(32);
        }
        &__cover-container {
            width: 100%;
            aspect-ratio: 2/1;
            @include right-corner;
        }
        &__cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__body {
            grid-area: body;
        }
        &__content {
            > h2 {
                text-transform: uppercase;
                font-weight: $fw-bold;
            }
            @include text-content(
                $font-size: lineScale(18, 16, 480, 1920),
                $h2-size: lineScale(32, 24, 480, 1920),
                $h-size: lineScale(22, 20, 480, 1920)
            );
        }
        &__suggest {
            grid-area: suggest;
            display: grid;
            grid-template-columns: max-content auto;
            gap: rem(32);
            margin-top: rem(32);
            @media (max-width: 768px) {
                display: flex;
                flex-direction: column;
            }
            &-title {
                max-width: 15ch;
                text-transform: uppercase;
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(40, 32, 480, 1920);
                font-weight: $fw-bold;
            }
            &-body {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(rem(320), auto));
                gap: rem(16);
            }
            &-item {
                display: block;
                width: 100%;
                min-width: rem(320);
                color: $c-FFFFFF;
                background-color: $c-1C3A19;
                clip-path: polygon(20% 0, 100% 0, 100% 80%, 80% 100%, 0 100%, 0 20%);
                &-wrapper {
                    box-sizing: border-box;
                    width: 100%;
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    gap: rem(32);
                    padding: rem(64) rem(48);
                }
                &-title {
                    font-family: 'Nuniti', sans-serif;
                    font-size: lineScale(24, 18, 480, 1920);
                    line-height: 1.2;
                    font-weight: $fw-bold;
                    @include lineClamp(2);
                }
                &-subtitle {
                    font-size: lineScale(18, 14, 480, 1920);
                    color: $c-EBEBEB;
                    line-height: 1.4;
                    opacity: 0.5;
                    margin-top: rem(24);
                    @include lineClamp(4);
                }
                &-link {
                    display: flex;
                    align-items: center;
                    gap: rem(8);
                    text-transform: uppercase;
                }
            }
        }
    }
</style>
