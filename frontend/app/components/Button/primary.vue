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
        :class="[
            'button-primary',
            `button-primary--${props.theme}`,
            { 'button-primary--compact': props.compact },
            props.class,
        ]"
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
            buttonType?: 'button' | 'submit' | 'reset';
            target?: '' | '_blank' | '_self' | '_parent' | '_top';
            id?: string;
            width?: 'fit-content' | '100%';
            class?: string | Record<string, any>;
            overlaySize?: number;
            theme?: 'gray' | 'accent' | 'yellow' | 'light' | 'dark' | 'transparent';
            compact?: boolean;
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
            compact: false,
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
    const buttonRef = ref<HTMLElement | ComponentPublicInstance<{ $el: HTMLElement }> | null>(null);

    const moveButton = ref((event: MouseEvent): void => {});
    const resetButtonAnim = ref((): void => {});

    onMounted(() => {
        moveButton.value = (event: MouseEvent) => {
            if (!isClient || window.matchMedia('(pointer: coarse)').matches || !buttonRef.value)
                return;

            let bounding: DOMRect;
            let offsetWidth: number;
            let offsetHeight: number;
            let target: HTMLElement;

            if (buttonRef.value instanceof HTMLElement) {
                bounding = buttonRef.value.getBoundingClientRect();
                offsetWidth = buttonRef.value.offsetWidth;
                offsetHeight = buttonRef.value.offsetHeight;
                target = buttonRef.value;
            } else {
                bounding = buttonRef.value.$el.getBoundingClientRect();
                offsetWidth = buttonRef.value.$el.offsetWidth;
                offsetHeight = buttonRef.value.$el.offsetHeight;
                target = buttonRef.value.$el;
            }

            gsap.to(target, {
                x: ((event.clientX - bounding.left) / offsetWidth - 0.5) * STRENGTH,
                y: ((event.clientY - bounding.top) / offsetHeight - 0.5) * STRENGTH,
                ease,
            });
        };

        resetButtonAnim.value = () => {
            if (!buttonRef.value) return;

            const gsapVars = { duration: 1, x: 0, y: 0, ease };

            if (buttonRef.value instanceof HTMLElement) {
                gsap.to(buttonRef.value, gsapVars);
            } else {
                gsap.to(buttonRef.value.$el, gsapVars);
            }
        };
    });
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
        color: $c-082605;
        font-weight: $fw-bold;
        padding: rem(18) rem(40);
        transition: color $td $tf;
        will-change: transform;
        white-space: nowrap;
        &--yellow {
            &::before {
                background-color: $c-FFF3B0;
            }
            &::after {
                background-color: transparent;
            }

            @media (pointer: fine) {
                &:hover {
                    color: $c-082605;
                    &::before {
                        background-color: $c-FFFFFF;
                    }
                }
            }
        }
        &--light {
            color: $c-FFFFFF;
            &::before {
                background-color: $c-secondary;
            }
            &::after {
                background-color: $c-secondary;
            }

            @media (pointer: fine) {
                &:hover {
                    color: $c-082605;
                    &::before {
                        background-color: $c-main;
                    }
                }
            }
        }
        &--transparent {
            padding: rem(12) rem(40);
            color: $c-secondary;
            &::before {
                background-color: $c-main;
            }
            &::after {
                background-color: $c-secondary;
            }

            @media (pointer: fine) {
                &:hover {
                    color: $c-FFFFFF;
                    &::before {
                        background-color: $c-secondary;
                    }
                }
            }
        }
        &--gray {
            padding: rem(12) rem(40);
            color: $c-secondary;
            &::before {
                background-color: $c-D9D9D9;
            }
            &::after {
                background-color: transparent;
            }

            @media (pointer: fine) {
                &:hover {
                    color: $c-FFFFFF;
                    &::before {
                        background-color: $c-accent;
                    }
                }
            }
        }
        &--compact {
            padding: rem(10) rem(48);
            font-size: rem(12);
        }
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
            transition: background-color $td $tf 0s;
        }
        &::after {
            z-index: 1;
            transform: scaleY(1.1) scaleX(1.025) translateX(0.25px);
        }
    }
</style>
