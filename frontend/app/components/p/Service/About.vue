<template>
    <BlockLiquidTitle
        class="service-about"
        :title="props.title"
        layout="horizontal"
        alignment="left"
    >
        <div class="service-about__body">
            <div class="service-about__content" v-html="props.content"></div>
        </div>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            content: string;
        }>(),
        {
            title: '',
            content: '',
        }
    );
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .service-about {
        @include content-block;
        &__container {
            @include content-container;
        }
        &__content {
            > h2,
            h3,
            h4,
            h5,
            h6 {
                color: $c-082605;
                text-transform: uppercase;
                font-weight: $fw-bold;
            }
            @include text-content(
                $font-size: lineScale(18, 16, 480, 1920),
                $h2-size: lineScale(24, 20, 480, 1920),
                $h-size: lineScale(20, 18, 480, 1920)
            );
        }
    }
</style>
