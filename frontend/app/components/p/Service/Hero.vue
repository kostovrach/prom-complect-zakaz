<template>
    <section class="service-hero">
        <div class="service-hero__container">
            <h1 class="service-hero__title">{{ props.title }}</h1>
            <ul class="service-hero__advant">
                <li
                    v-for="(item, idx) in props.advant"
                    :key="idx"
                    class="service-hero__advant-item"
                >
                    <div class="service-hero__advant-icon">
                        <SvgSprite :type="icons[idx % icons.length] ?? ''" :size="40" />
                    </div>
                    <p class="service-hero__advant-text">{{ item }}</p>
                </li>
            </ul>
            <div class="service-hero__content">
                <p v-if="props.subtitle" class="service-hero__desc">{{ props.subtitle }}</p>
                <ButtonPrimary
                    class="service-hero__button"
                    type="button"
                    button-type="button"
                    theme="yellow"
                    @click="openModalConsultation"
                >
                    ПОЛУЧИТЬ КОНСУЛЬТАЦИЮ
                </ButtonPrimary>
            </div>
        </div>
        <picture class="service-hero__bg-container">
            <img class="service-hero__bg" :src="props.background_url" :alt="props.title ?? '#'" />
        </picture>
    </section>
</template>

<script setup lang="ts">
    import { ModalsFormConsultation } from '#components';
    import { useModal } from 'vue-final-modal';

    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string | null;
            advant: string[];
            background_url: string;
        }>(),
        {
            title: '',
            subtitle: null,
            advant: () => [],
            background_url: '',
        }
    );

    const { icons } = getIconsArray();

    const { open: openModalConsultation, close: _closeModalConsultation } = useModal({
        component: ModalsFormConsultation,
        attrs: {
            onClose() {
                _closeModalConsultation();
            },
        },
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .service-hero {
        position: relative;
        padding: {
            top: rem(256);
            bottom: rem(96);
        }
        @include content-block($margin: rem(72));
        &__container {
            display: grid;
            grid-template-columns: 60% auto;
            grid-template-areas:
                'title .'
                'advant content';
            gap: rem(96) rem(32);
            color: $c-FFFFFF;
            @include content-container;
            @media (max-width: 1024px) {
                display: flex;
                flex-direction: column;
            }
        }
        &__bg-container {
            position: absolute;
            inset: 0;
            z-index: -1;
            filter: brightness(60%);
            pointer-events: none;
            @include fullscreen-double-corner;
        }
        &__bg {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__title {
            grid-area: title;
            text-transform: uppercase;
            font-family: 'Nuniti', sans-serif;
            font-size: lineScale(80, 32, 480, 1920);
            font-weight: $fw-bold;
        }
        &__advant {
            grid-area: advant;
            width: fit-content;
            display: grid;
            grid-template-columns: repeat(2, minmax(auto, rem(260)));
            gap: rem(32);
            color: $c-FFF3B0;
            &-item {
                display: flex;
                align-items: center;
                gap: rem(16);
            }
            &-icon {
                min-width: fit-content;
            }
            &-text {
                font-size: rem(14);
                line-height: 1.2;
            }
        }
        &__content {
            grid-area: content;
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__desc {
            max-width: 45ch;
            text-wrap: balance;
            font-size: lineScale(20, 16, 480, 1920);
            line-height: 1.4;
        }
    }
</style>
