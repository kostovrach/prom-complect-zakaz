<template>
    <div :class="['load-spinner', `load-spinner--${props.theme}`]">
        <span></span>
    </div>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            theme?: 'dark' | 'light';
        }>(),
        {
            theme: 'light',
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .load-spinner {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        pointer-events: none;
        > span {
            position: relative;
            display: block;
            width: rem(40);
            aspect-ratio: 1;
            &::before {
                content: '';
                position: absolute;
                inset: 0;
                border-radius: 50%;
                animation: loader 1s linear infinite;
            }
        }
        &--dark {
            > span::before {
                border: {
                    top: rem(2) solid $c-accent;
                    right: rem(2) solid transparent;
                }
            }
        }
        &--light {
            > span::before {
                border: {
                    top: rem(2) solid $c-FFF3B0;
                    right: rem(2) solid transparent;
                }
            }
        }
        @keyframes loader {
            to {
                rotate: 360deg;
            }
        }
    }
</style>
