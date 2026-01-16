<template>
    <button class="burger">
        <span></span>
        <span></span>
        <span></span>
    </button>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .burger {
        $p: &;
        $width: rem(48);
        $line-height: rem(2);
        $color: $c-FFFFFF;

        cursor: pointer;
        position: relative;
        width: $width;
        aspect-ratio: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: rem(6);
        // background-color: rgba($c-DFDFDF, 0.5);
        backdrop-filter: blur(5px);
        border-radius: $border-radius;
        transition: background-color $td $tf;
        > span {
            width: calc($width / 2);
            background-color: $c-secondary;
            transition: all $td $tf;
        }
        @media (pointer: fine) {
            &:hover {
                background-color: $c-accent;
                > span {
                    background-color: $color;
                }
                > span:nth-of-type(1),
                > span:nth-of-type(3) {
                    transform: scaleX(0.7);
                }
            }
        }
        > span:nth-of-type(2) {
            display: block;
            height: $line-height;
            border-radius: rem(16);
        }
        > span:nth-of-type(1),
        > span:nth-of-type(3) {
            display: block;
            height: $line-height;
            border-radius: inherit;
        }
        > span:nth-of-type(1) {
            will-change: transform;
            transform-origin: left;
        }
        > span:nth-of-type(3) {
            will-change: transform;
            transform-origin: right;
        }
    }
</style>
