<template>
    <BlockLiquidTitle
        :title="props.title"
        :subtitle="props.subtitle"
        class="co-about"
        layout="horizontal"
        alignment="left"
    >
        <template #button>
            <picture v-if="props.image_url" class="co-about__image-container">
                <img class="co-about__image" :src="props.image_url" :alt="props.title ?? '#'" />
            </picture>
            <a v-if="props.nextBlock" class="co-about__link" :href="`#${slugify(props.nextBlock)}`">
                <SvgSprite type="arrows" :size="14" />
                <span>{{ props.nextBlock }}</span>
            </a>
        </template>
        <template #default>
            <ul class="co-about__body">
                <li v-for="(item, idx) in props.cards" :key="idx" class="co-about__item">
                    <div class="co-about__item-wrapper">
                        <h3 class="co-about__item-title">{{ item.title }}</h3>
                        <div class="co-about__item-content" v-html="item.content"></div>
                    </div>
                </li>
            </ul>
        </template>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string | null;
            image_url: string | null;
            cards: {
                title: string;
                content: string;
            }[];
            nextBlock?: string | null;
        }>(),
        {
            title: '',
            subtitle: null,
            image_url: null,
            cards: () => [],
            nextBlock: null,
        }
    );
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .co-about {
        &__image-container {
            position: relative;
            width: 100%;
            aspect-ratio: 2/1;
            margin-top: rem(32);
            @include right-corner;
        }
        &__image {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__link {
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: rem(8);
            font-size: rem(14);
            margin-top: lineScale(64, 48, 480, 1920);
            opacity: 0.75;
            @media (pointer: fine) {
                &:hover {
                    opacity: 1;
                }
            }
        }
        &__body {
            display: flex;
            flex-direction: column;
            gap: lineScale(32, 16, 480, 1920);
        }
        &__item {
            background-color: $c-FFFFFF;
            padding: rem(132) lineScale(64, 16, 480, 1920);
            @include double-corner;
            @media (max-width: 768px) {
                clip-path: none;
            }
            &-title {
                text-transform: uppercase;
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(32, 24, 480, 1920);
                font-weight: $fw-bold;
                color: $c-1C3A19;
            }
            &-content {
                margin-top: rem(32);
                @include text-content(
                    $font-size: lineScale(18, 16, 480, 1920),
                    $h2-size: lineScale(22, 20, 480, 1920),
                    $h-size: lineScale(20, 18, 480, 1920)
                );
            }
        }
    }
</style>
