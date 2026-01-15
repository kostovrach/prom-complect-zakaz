<template>
    <component
        :is="componentTag"
        v-bind="{ ...attrs, ...$attrs }"
        :id="id || undefined"
        :class="['link-primary', props.class]"
        :style="{ '--overlay-size': `${props.overlaySize / 16}rem` }"
        unstyled
    >
        <span class="link-primary__icon">
            <SvgSprite type="arrow" :size="24" />
        </span>
        <span class="link-primary__text">
            <slot></slot>
        </span>
    </component>
</template>

<script setup lang="ts">
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
            class?: string | Record<string, any>;
            overlaySize?: number;
        }>(),
        {
            type: 'a',
            to: () => ({ name: 'index' }),
            href: '/',
            buttonType: 'button',
            target: '',
            id: '',
            class: '',
            overlaySize: 24,
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
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .link-primary {
        $p: &;

        cursor: pointer;
        width: fit-content;
        transition: color $td $tf;
        &__icon {
            display: flex;
            align-items: center;
            font-size: var(--overlay-size);
            font-weight: $fw-semi;
            overflow: clip;
            &::before {
                content: '(';
            }
            &::after {
                content: ')';
            }
            @media (pointer: fine) {
                @at-root #{$p}:hover & {
                    > svg {
                        animation: arrow-translate $td $tf;
                    }
                }
            }
        }
        @media (pointer: fine) {
            &:hover {
                color: $c-FFF3B0;
            }
        }
        @include arrow-translate;
    }
</style>
