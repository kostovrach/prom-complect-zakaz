<template>
    <component
        :is="componentTag"
        v-bind="{ ...attrs, ...$attrs }"
        :id="id || undefined"
        unstyled
        :style="{
            width: `${props.width}`,
        }"
        :class="[
            'button-rolling',
            { 'button-rolling--hovered': isHovered },
            { 'button-rolling--leaving': isLeaving },
            props.class,
        ]"
        @mouseenter="mouseenterHandler"
        @mouseleave="mouseleaveHandler"
    >
        <span :data-text="slotText">
            {{ slotText }}
        </span>
    </component>
</template>

<script setup lang="ts">
    import { NuxtLink } from '#components';
    import type { RouteLocationAsPathGeneric, RouteLocationAsRelativeGeneric } from 'vue-router';

    const props = withDefaults(
        defineProps<{
            type?: 'button' | 'a' | 'NuxtLink' | string;
            to?: RouteLocationAsRelativeGeneric | RouteLocationAsPathGeneric;
            href?: string;
            buttonType?: 'button' | 'submit' | 'reset';
            target?: '' | '_blank' | '_self' | '_parent' | '_top';
            id?: string;
            width?: 'fit-content' | '100%';
            class?: string | Record<string, any>;
        }>(),
        {
            type: 'div',
            to: () => ({ name: 'index' }),
            href: '/',
            buttonType: 'button',
            target: '',
            id: '',
            width: 'fit-content',
            class: '',
        }
    );

    const slots = useSlots();

    const slotText = computed(() => {
        const raw = slots.default?.()[0]?.children || '';
        return typeof raw === 'string' ? raw : '';
    });

    const componentTag = computed(() => {
        switch (props.type) {
            case 'NuxtLink':
                return NuxtLink;
            case 'button':
                return 'button';
            case 'a':
                return 'a';
            default:
                return props.type;
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

    const isHovered = ref(false);
    const isLeaving = ref(false);
    const timeoutId = ref<NodeJS.Timeout | null>(null);

    function mouseenterHandler() {
        if (timeoutId.value) clearTimeout(timeoutId.value);

        isLeaving.value = false;
        isHovered.value = true;
    }

    function mouseleaveHandler() {
        isHovered.value = false;
        isLeaving.value = true;

        timeoutId.value = setTimeout(() => {
            isLeaving.value = false;
        }, 800);
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .button-rolling {
        overflow: hidden;
        & > span {
            position: relative;
            display: inline-block;
            line-height: 1.2;
            transition: translate $td $tf-spring;
            &::before {
                content: attr(data-text);
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                translate: 0 120%;
                transition: translate $td $tf-spring;
                pointer-events: none;
            }
        }
        &--hovered > span {
            translate: 0 -120%;
            &::before {
                translate: 0 120%;
                pointer-events: auto;
            }
        }
        &--leaving > span {
            translate: 0 0;
            &::before {
                translate: 0 120%;
                pointer-events: none;
            }
        }
    }
</style>
