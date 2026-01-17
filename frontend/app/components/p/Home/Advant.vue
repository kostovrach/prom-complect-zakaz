<template>
    <BlockLiquidTitle :title="props.title" :subtitle="props.subtitle" class="home-advant">
        <ul class="home-advant__body">
            <li v-for="(card, idx) in props.cards" :key="idx" class="home-advant__item">
                <span class="home-advant__item-icon">
                    <SvgSprite :type="icons[idx % icons.length] ?? ''" :size="64" />
                </span>
                <h3 class="home-advant__item-title">{{ card.title }}</h3>
                <p class="home-advant__item-desc">{{ card.content }}</p>
            </li>
        </ul>
    </BlockLiquidTitle>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle: string | null;
            cards: {
                title: string;
                content: string;
            }[];
        }>(),
        {
            title: '',
            subtitle: null,
            cards: () => [],
        }
    );

    const { icons } = getIconsArray();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-advant {
        &__body {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: rem(16);
            margin-top: rem(64);
            @media (max-width: 1240px) {
                grid-template-columns: repeat(2, 1fr);
            }
            @media (max-width: 768px) {
                grid-template-columns: 100%;
            }
        }
        &__item {
            height: 100%;
            padding: lineScale(64, 32, 480, 1920) lineScale(32, 16, 480, 1920);
            background-color: $c-FFFFFF;
            @include right-corner;
            &-icon {
                color: $c-4E6A4C;
            }
            &-title {
                font-size: lineScale(24, 20, 480, 1920);
                font-weight: $fw-bold;
                color: $c-082605;
                margin-top: rem(32);
            }
            &-desc {
                max-width: 90%;
                text-wrap: balance;
                font-size: lineScale(18, 16, 480, 1920);
                opacity: 0.8;
                margin-top: rem(16);
            }
        }
    }
</style>
