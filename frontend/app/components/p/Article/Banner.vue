<template>
    <div class="article-banner">
        <h3 class="article-banner__title">{{ content?.title }}</h3>
        <p class="article-banner__desc">{{ content?.description }}</p>
        <div class="article-banner__controls">
            <ButtonPrimary
                class="article-banner__button"
                data-modal="modal-request"
                type="button"
                button-type="button"
                theme="yellow"
                @click="openModalRequest"
            >
                ОБСУДИТЬ ПРОЕКТ
            </ButtonPrimary>
            <LinkPrimary class="article-banner__link" type="NuxtLink" :to="{ name: 'quiz' }">
                Подобрать оборудование
            </LinkPrimary>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { ModalsFormRequest } from '#components';
    import { useModal } from 'vue-final-modal';

    interface IContent {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        description: string;
    }

    const { content } = await useCms<IContent>('article_hint');

    const { open: openModalRequest, close: _closeModalRequest } = useModal({
        component: ModalsFormRequest,
        attrs: {
            onClose() {
                _closeModalRequest();
            },
        },
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .article-banner {
        width: 100%;
        color: $c-FFFFFF;
        background-color: $c-1C3A19;
        padding: rem(32) lineScale(32, 16, 480, 1920);
        margin-top: rem(64);
        &__title {
            font-family: 'Nuniti', sans-serif;
            font-size: lineScale(44, 24, 480, 1920);
            font-weight: $fw-bold;
        }
        &__desc {
            font-size: lineScale(18, 16, 480, 1920);
            text-wrap: balance;
            margin-top: rem(32);
        }
        &__controls {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(32);
            margin-top: rem(64);
        }
        &__link {
            display: flex;
            align-items: center;
            gap: rem(8);
            font-size: lineScale(18, 16, 480, 1920);
        }
    }
</style>
