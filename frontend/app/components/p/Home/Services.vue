<template>
    <BlockLiquidTitle
        v-if="services.length"
        :title="props.title"
        :subtitle="props.subtitle"
        class="home-services"
        alignment="left"
        layout="horizontal"
        large
    >
        <template #button>
            <ButtonPrimary
                class="home-services__button"
                theme="light"
                type="button"
                button-type="button"
                @click="openRequestModal"
            >
                Оформить заказ
            </ButtonPrimary>
        </template>
        <template #default>
            <div class="home-services__body">
                <NuxtLink
                    v-for="service in services"
                    :key="service.id"
                    class="home-services__item"
                    :to="{
                        name: 'service',
                        params: { service: slugify(service.hero_title) },
                        query: { id: service.id },
                    }"
                >
                    <picture class="home-services__item-image-container">
                        <img
                            class="home-services__item-image"
                            :src="service.hero_image_url"
                            :alt="service.hero_title ?? '#'"
                        />
                    </picture>
                    <div class="home-services__item-wrapper">
                        <span class="home-services__item-icon">
                            <SvgSprite type="arrow" :size="20" />
                        </span>
                        <h3 class="home-services__item-title">{{ service.hero_title }}</h3>
                    </div>
                </NuxtLink>
            </div>
        </template>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    import { ModalsFormRequest } from '#components';
    import { useModal } from 'vue-final-modal';

    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string | null;
        }>(),
        {
            title: '',
            subtitle: null,
        }
    );

    const servicesStore = useServicesStore();

    const services = computed(() => servicesStore.services);

    const { open: openRequestModal, close: _closeRequestModal } = useModal({
        component: ModalsFormRequest,
        attrs: {
            onClose() {
                _closeRequestModal();
            },
        },
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-services {
        $p: &;

        &__body {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__item {
            cursor: pointer;
            position: relative;
            display: block;
            width: 100%;
            aspect-ratio: 1.75/1;
            @include right-corner;
            @media (pointer: fine) {
                &:hover {
                    #{$p}__item-image-container {
                        scale: 1.05;
                    }
                }
            }
            &-image-container {
                position: absolute;
                z-index: 0;
                inset: 0;
                transition: scale $td $tf;
                will-change: scale;
                > img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    filter: grayscale(80%);
                }
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 1;
                    inset: 0;
                    background: linear-gradient(to top, rgba($c-1C3A19, 0.75) 0%, transparent 100%);
                }
            }
            &-wrapper {
                width: 100%;
                max-width: 90%;
                height: 100%;
                position: relative;
                z-index: 1;
                display: flex;
                flex-direction: column;
                justify-content: flex-end;
                gap: rem(8);
                color: $c-FFFFFF;
                padding: lineScale(32, 16, 480, 1920);
            }
            &-icon {
                display: flex;
                align-items: center;
                gap: rem(4);
                font-size: rem(24);
                color: $c-FFF3B0;
                &::before {
                    content: '(';
                }
                &::after {
                    content: ')';
                }
            }
            &-title {
                font-family: 'Nuniti', sans-serif;
                text-transform: uppercase;
                font-size: lineScale(44, 20, 480, 1920);
                font-weight: $fw-bold;
                line-height: 1.2;
            }
        }
    }
</style>
