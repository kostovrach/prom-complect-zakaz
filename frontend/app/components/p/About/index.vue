<template>
    <section v-if="props.title && props.content && props.imageUrl" class="about-about">
        <div class="about-about__container">
            <div class="about-about__wrapper">
                <picture class="about-about__image-container">
                    <img
                        class="about-about__image"
                        :src="props.imageUrl ?? ''"
                        :alt="props.title ?? '#'"
                    />
                </picture>
                <div class="about-about__body js_text-anim-block">
                    <h2 class="about-about__title js_text-anim">{{ props.title }}</h2>
                    <div class="about-about__content" v-html="props.content"></div>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string | null;
            content: string | null;
            imageUrl: string | null;
        }>(),
        {
            title: null,
            content: null,
            imageUrl: null,
        }
    );
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .about-about {
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
            clip-path: polygon(10% 0, 100% 0, 100% 80%, 90% 100%, 0 100%, 0 30%);
            @media (max-width: 1024px) {
                display: flex;
                flex-direction: column;
                clip-path: none;
            }
        }
        &__image-container {
            position: relative;
            width: 100%;
            height: 100%;
            @media (max-width: 1024px) {
                height: rem(360);
            }
        }
        &__image {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__body {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            padding: rem(96) lineScale(64, 16, 480, 1920);
            background-color: $c-FFFFFF;
        }
        &__title {
            font-family: 'Nuniti', sans-serif;
            text-transform: uppercase;
            font-weight: $fw-bold;
            font-size: lineScale(44, 30, 480, 1920);
            line-height: 1.2;
            max-width: 35ch;
        }
        &__content {
            @include text-content(
                $font-size: lineScale(18, 16, 480, 1920),
                $h2-size: lineScale(22, 20, 480, 1920),
                $h-size: lineScale(20, 18, 480, 1920)
            );
        }
    }
</style>
