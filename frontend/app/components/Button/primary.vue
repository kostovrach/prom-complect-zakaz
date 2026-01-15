<template>
    <component
        :is="componentTag"
        v-bind="{ ...attrs, ...$attrs }"
        :id="id || undefined"
        unstyled
        :style="{
            width: `${props.width}`,
            '--overlay-size': `${props.overlaySize / 16}rem`,
        }"
        ref="buttonRef"
        :class="['button-primary', `button-primary--${props.theme}`, props.class]"
        @mousemove="moveButton"
        @mouseout="resetButtonAnim"
    >
        <span>
            <slot></slot>
        </span>
    </component>
</template>

<script setup lang="ts">
    import { gsap, Power4 } from 'gsap';
    import { NuxtLink } from '#components';
    import type { RouteLocationAsPathGeneric, RouteLocationAsRelativeGeneric } from 'vue-router';

    const props = withDefaults(
        defineProps<{
            type?: 'button' | 'a' | 'NuxtLink';
            to?: RouteLocationAsRelativeGeneric | RouteLocationAsPathGeneric;
            href?: string;
            buttonType?: string;
            target?: '' | '_blank' | '_self' | '_parent' | '_top';
            id?: string;
            width?: 'fit-content' | '100%';
            class?: string | Record<string, any>;
            overlaySize?: number;
            theme?: 'gray' | 'accent' | 'yellow' | 'light';
        }>(),
        {
            type: 'a',
            to: () => ({ name: 'index' }),
            href: '/',
            buttonType: 'button',
            target: '',
            id: '',
            width: 'fit-content',
            class: '',
            overlaySize: 100,
            theme: 'accent',
        }
    );

    const componentTag = computed(() => {
        switch (props.type) {
            case 'NuxtLink':
                return NuxtLink;
            case 'button':
                return 'button';
            default:
                return 'a';
        }
    });

    const attrs = computed(() => {
        switch (props.type) {
            case 'NuxtLink':
                return { to: props.to };
            case 'button':
                return { type: props.buttonType };
            case 'a':
                return {
                    href: props.href,
                    target: props.target || undefined,
                    rel: props.target === '_blank' ? 'noopener noreferrer' : undefined,
                };
            default:
                return {};
        }
    });

    const STRENGTH = 30;
    const isClient = import.meta.client;
    const ease = Power4.easeOut;
    const buttonRef = ref<HTMLElement | null>(null);

    function moveButton(event: MouseEvent) {
        if (!isClient || window.matchMedia('(pointer: coarse)').matches || !buttonRef.value) return;

        const bounding = buttonRef.value.getBoundingClientRect();

        gsap.to(buttonRef.value, {
            x: ((event.clientX - bounding.left) / buttonRef.value.offsetWidth - 0.5) * STRENGTH,
            y: ((event.clientY - bounding.top) / buttonRef.value.offsetHeight - 0.5) * STRENGTH,
            ease,
        });
    }

    function resetButtonAnim() {
        if (!buttonRef.value) return;

        gsap.to(buttonRef.value, { duration: 1, x: 0, y: 0, ease });
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .button-primary {
        $p: &;

        cursor: pointer;
        position: relative;
        box-sizing: border-box;

        display: flex;
        align-items: center;
        justify-content: center;

        text-transform: uppercase;
        font-size: rem(14);
        // color: $color;
        font-weight: $fw-bold;
        padding: rem(18) rem(40);
        transition: color $td $tf;
        will-change: transform;
        white-space: nowrap;
        // @media (pointer: fine) {
        //     &:hover {
        //         color: $anim-text-color;
        //         &::before {
        //             background-color: $anim-color;
        //         }
        //     }
        // }
        &:active {
            scale: 0.99;
        }
        > span {
            position: relative;
            z-index: 3;
            margin: calc(var(--overlay-size) * -1);
            padding: var(--overlay-size);
        }
        &::before,
        &::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            translate: -50% -50%;
            width: 100%;
            height: 100%;
            clip-path: polygon(15% 0, 100% 0, 100% 60%, 85% 100%, 0 100%, 0 40%);
            pointer-events: none;
        }
        &::before {
            z-index: 2;
            // background-color: $background;
            transition: background-color $td $tf 0s;
        }
        &::after {
            z-index: 1;
            // background-color: $border-color;
            transform: scaleY(1.1) scaleX(1.025) translateX(0.25px);
        }
    }
</style>
