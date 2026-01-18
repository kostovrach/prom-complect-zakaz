<template>
    <div
        :class="['form-notify-info', `form-notify-info--${props.theme}`]"
        :style="{ top: props.position.top, left: props.position.left }"
    >
        <span class="form-notify-info__icon">i</span>
        <span class="form-notify-info__text"><slot></slot></span>
    </div>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            position: { top: string; left: string };
            theme?: 'dark' | 'light';
        }>(),
        {
            position: () => ({ top: '100%', left: '0%' }),
            theme: 'dark',
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .form-notify-info {
        $p: &;

        position: absolute;
        z-index: 5;
        display: flex;
        align-items: center;
        gap: rem(8);
        padding: rem(8) rem(16);
        border-radius: rem(8);
        pointer-events: none;
        &--dark {
            color: $c-FFFFFF;
            background-color: $c-accent;
        }
        &--light {
            color: $c-secondary;
            background-color: $c-main;
            font-weight: $fw-semi;
        }
        &::before {
            content: '';
            position: absolute;
            top: 0;
            left: 10%;
            width: rem(12);
            aspect-ratio: 1;
            background-color: inherit;
            translate: 0 -50%;
            rotate: 45deg;
        }
        &__icon {
            width: rem(20);
            min-width: rem(20);
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: rem(16);
            @at-root #{$p}--dark & {
                color: $c-accent;
                background-color: $c-FFFFFF;
            }
            @at-root #{$p}--light & {
                color: $c-main;
                background-color: $c-accent;
            }
        }
        &__text {
            font-size: rem(14);
        }
    }
</style>
