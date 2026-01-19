<template>
    <button
        :class="['contact-overlay', `contact-overlay--${props.theme}`]"
        type="button"
        @click="openModalQuestion"
    >
        <div class="contact-overlay__icon">
            <SvgSprite type="pixel-chat" :size="24" />
        </div>
    </button>
</template>

<script setup lang="ts">
    import { ModalsFormQuestion } from '#components';
    import { useModal } from 'vue-final-modal';

    const props = withDefaults(
        defineProps<{
            theme?: 'dark' | 'light';
        }>(),
        {
            theme: 'dark',
        }
    );

    const { open: openModalQuestion, close: _close } = useModal({
        component: ModalsFormQuestion,
        attrs: {
            onClose() {
                _close();
            },
        },
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .contact-overlay {
        cursor: pointer;
        position: fixed;
        z-index: 10;
        right: rem(16);
        bottom: rem(16);
        width: rem(64);
        aspect-ratio: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        &--dark {
            color: $c-EBEBEB;
            background-color: $c-1C3A19;
        }
        &--light {
            color: $c-accent;
            background-color: $c-FFF3B0;
        }
        &::before {
            content: '';
            position: absolute;
            z-index: -1;
            inset: 0;
            background-color: inherit;
            border-radius: 50%;
            pointer-events: none;
            animation: action-button-blick 2s linear infinite;
        }
        @keyframes action-button-blick {
            0% {
                scale: 0;
                opacity: 0.7;
            }
            75% {
                scale: 1.5;
            }
            100% {
                scale: 1.7;
                opacity: 0;
            }
        }
    }
</style>
