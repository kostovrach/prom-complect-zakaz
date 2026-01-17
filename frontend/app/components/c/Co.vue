<template>
    <BlockLiquidTitle
        v-if="content"
        class="c-co"
        :title="content.title"
        :subtitle="content.subtitle"
        layout="horizontal-reverse"
        alignment="left"
        large
    >
        <template #button>
            <div class="c-co__footer">
                <p v-if="content.description" class="c-co__desc">{{ content.description }}</p>
                <ButtonPrimary
                    class="c-co__button"
                    type="button"
                    button-type="button"
                    theme="light"
                    @click="openModalCo"
                >
                    Начать сотрудничество
                </ButtonPrimary>
            </div>
        </template>
        <template #default>
            <div class="c-co__map">
                <MapWrapper
                    :zoom="3"
                    :markers="content.map.coordinates.map((el) => ({ point: { coordinates: el } }))"
                />
            </div>
        </template>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    import { ModalsFormCo } from '#components';
    import type { LngLat } from '@yandex/ymaps3-types';
    import { useModal } from 'vue-final-modal';

    interface IContent {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        subtitle: string;
        description: string | null;
        map: {
            type: string;
            coordinates: LngLat[];
        };
    }

    const { content } = await useCms<IContent>('co');

    const { open: openModalCo, close: _closeModalCo } = useModal({
        component: ModalsFormCo,
        attrs: {
            onClose() {
                _closeModalCo();
            },
        },
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .c-co {
        &__map {
            width: 100%;
            height: 100%;
            mask-image: url('/img/masks/favicon-mask.svg');
            mask-size: cover;
            mask-position: center;
            mask-repeat: no-repeat;
            @media (max-width: 1024px) {
                height: rem(320);
            }
        }
        &__footer {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            margin-top: lineScale(128, 64, 480, 1920);
        }
        &__desc {
            max-width: 45ch;
            text-wrap: balance;
            font-size: lineScale(18, 16, 480, 1920);
            font-weight: $fw-semi;
            line-height: 1.2;
        }
    }
</style>
