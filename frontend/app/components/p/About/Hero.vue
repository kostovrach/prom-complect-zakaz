<template>
    <section class="about-hero">
        <div class="about-hero__container">
            <div class="about-hero__titlebox">
                <h1 class="about-hero__title">{{ props.title }}</h1>
                <p class="about-hero__subtitle" v-if="props.subtitle">{{ props.subtitle }}</p>
                <ButtonPrimary
                    class="about-hero__button"
                    type="a"
                    theme="accent"
                    href="#about-advant"
                >
                    УЗНАТЬ О НАС
                </ButtonPrimary>
            </div>
            <picture class="about-hero__image-container">
                <img
                    class="about-hero__image"
                    :src="props.image_url ?? ''"
                    :alt="props.title ?? '#'"
                />
            </picture>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string | null;
            image_url: string;
        }>(),
        {
            title: '',
            subtitle: null,
            image_url: '',
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .about-hero {
        @include content-block();
        &__container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            align-items: center;
            gap: rem(64);
            @include content-container;
            @media (max-width: 1024px) {
                display: flex;
                flex-direction: column-reverse;
            }
        }
        &__titlebox {
            padding: rem(64) 0;
        }
        &__title {
            text-transform: uppercase;
            font-family: 'Nuniti', sans-serif;
            font-size: lineScale(64, 32, 480, 1920);
            font-weight: $fw-bold;
            color: $c-1C3A19;
        }
        &__subtitle {
            font-size: lineScale(20, 16, 480, 1920);
            line-height: 1.2;
            margin-top: rem(32);
        }
        &__button {
            margin-top: rem(64);
        }
        &__image-container {
            width: 100%;
            height: rem(560);
            clip-path: polygon(rem(220) 0, 100% 0, 100% 60%, 65% 100%, 0 100%, 0 rem(190));
            @media (max-width: 1024px) {
                height: rem(360);
            }
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    }
</style>
