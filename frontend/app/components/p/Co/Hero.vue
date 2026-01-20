<template>
    <section class="co-hero">
        <div class="co-hero__container">
            <div class="co-hero__wrapper">
                <div class="co-hero__titlebox">
                    <h1 class="co-hero__title">{{ props.title }}</h1>
                    <p class="co-hero__desc">{{ props.subtitle }}</p>
                    <ButtonPrimary
                        class="co-hero__button js_button"
                        type="button"
                        button-type="button"
                        @click="openModalCo"
                    >
                        Стать партнером
                    </ButtonPrimary>
                </div>
                <picture class="co-hero__image-container">
                    <img class="co-hero__image" :src="props.image_url" :alt="props.title ?? '#'" />
                </picture>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import { ModalsFormCo } from '#components';
    import { useModal } from 'vue-final-modal';

    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string;
            image_url: string;
        }>(),
        {
            title: '',
            subtitle: '',
            image_url: '',
        }
    );

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

    .co-hero {
        position: relative;
        &__wrapper {
            position: relative;
            width: 100%;
            height: 100%;
            min-height: 80lvh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: $c-FFFFFF;
        }
        &__image-container {
            position: absolute;
            inset: 0;
            z-index: 0;
            filter: brightness(70%);
            @include fullscreen-double-corner;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__titlebox {
            max-width: 75ch;
            position: relative;
            z-index: 1;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        &__title {
            color: $c-FFFFFF;
            @include title-primary;
        }
        &__desc {
            font-size: lineScale(18, 16, 480, 1920);
            color: $c-EBEBEB;
            line-height: 1.2;
            margin-top: rem(24);
        }
        &__button {
            margin-top: rem(64);
        }
    }
</style>
