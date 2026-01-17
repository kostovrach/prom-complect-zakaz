<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-down"
        swipe-to-close="down"
        @opened="init"
        @closed="reset"
    >
        <div class="modal-video">
            <div class="modal-video__close" @mouseenter="isButtonVisible = false">
                <ButtonCross @click="emit('close')" />
            </div>
            <div
                ref="containerRef"
                class="modal-video__content"
                @click="toggleMute"
                @mouseenter="isButtonVisible = true"
                @mouseleave="isButtonVisible = false"
            >
                <div
                    ref="buttonRef"
                    class="modal-video__button"
                    :style="{
                        top: `${buttonY}px`,
                        left: `${buttonX}px`,
                        opacity: isButtonVisible ? '1' : '0',
                    }"
                >
                    <span
                        ref="iconRef"
                        class="modal-video__button-icon"
                        :style="{ transform: `translate(${iconX}px, ${iconY}px)` }"
                    >
                        <SvgSprite
                            :type="isMuted ? 'pixel-sound-on' : 'pixel-sound-mute'"
                            :size="32"
                        />
                    </span>
                </div>
                <video ref="videoRef" class="modal-video__body" loop playsinline>
                    <source :src="`/api/cms/assets/${props.file.id}`" :type="props.file.type" />
                </video>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';
    import type { IDirectusFile } from '~~/interfaces/directus-file';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const props = defineProps<{ file: IDirectusFile }>();

    // Refs ================================================
    const containerRef = ref<HTMLElement | null>(null);
    const videoRef = ref<HTMLVideoElement | null>(null);
    const buttonRef = ref<HTMLElement | null>(null);
    const iconRef = ref<HTMLElement | null>(null);
    // =====================================================

    // State ===============================================
    const isClient = import.meta.client;
    const isDesktop = computed(() => {
        if (!isClient) return false;
        return window.matchMedia('(pointer: fine)').matches;
    });

    const buttonX = ref(0);
    const buttonY = ref(0);
    const iconX = ref(0);
    const iconY = ref(0);

    const isPlaying = ref(false);
    const isMuted = ref(false);
    const isButtonVisible = ref(false);
    const rafButtonId = ref<number | null>(null);
    const rafIconId = ref<number | null>(null);

    const { elementX: mouseX, elementY: mouseY } = useMouseInElement(containerRef);
    // =====================================================

    // Methods =============================================
    function toggleMute() {
        if (!isPlaying.value || !videoRef.value) return;

        isMuted.value = !isMuted.value;
        videoRef.value.muted = isMuted.value;
    }

    async function playVideo() {
        if (!isClient || !videoRef.value) return;

        try {
            videoRef.value.muted = false;
            videoRef.value.volume = 0.4;
            await videoRef.value.play();
            isMuted.value = false;
        } catch {
            videoRef.value.muted = true;
            await videoRef.value.play().catch(() => {});
            isMuted.value = true;
        }

        isPlaying.value = true;
    }

    function animateButton() {
        if (!isDesktop.value || !containerRef.value || !buttonRef.value) return;

        const rect = containerRef.value.getBoundingClientRect();
        const targetX = mouseX.value - rect.left - 64;
        const targetY = mouseY.value - rect.top - 64;

        const currentX = buttonX.value;
        const currentY = buttonY.value;

        const newX = currentX + (targetX - currentX) * 0.1;
        const newY = currentY + (targetY - currentY) * 0.1;

        buttonX.value = newX;
        buttonY.value = newY;

        rafButtonId.value = requestAnimationFrame(animateButton);
    }

    function animateIcon() {
        if (!isDesktop.value || !containerRef.value || !iconRef.value) return;

        const rect = containerRef.value.getBoundingClientRect();
        const btnLeft = buttonX.value;
        const btnTop = buttonY.value;

        const deltaX = mouseX.value - rect.left - btnLeft - 64;
        const deltaY = mouseY.value - rect.top - btnTop - 64;

        const targetX = deltaX * 0.2;
        const targetY = deltaY * 0.2;

        const easedX = targetX * 0.7;
        const easedY = targetY * 0.7;

        iconX.value = easedX;
        iconY.value = easedY;

        rafIconId.value = requestAnimationFrame(animateIcon);
    }

    function init() {
        playVideo();

        if (isDesktop.value) {
            animateButton();
            animateIcon();
        }
    }

    function reset() {
        if (rafButtonId.value) cancelAnimationFrame(rafButtonId.value);
        if (rafIconId.value) cancelAnimationFrame(rafIconId.value);

        videoRef.value?.pause();
    }
    // =====================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-video {
        position: fixed;
        inset: 0;
        width: 100vw;
        height: 100vh;
        overflow: hidden;
        color: $c-FFFFFF;
        background-color: $c-accent;
        transition: all 0.6s;
        &__close {
            cursor: pointer;
            position: absolute;
            z-index: 2;
            top: rem(32);
            right: rem(32);
            width: rem(64);
            height: rem(64);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: rgba($c-082605, 0.5);
        }
        &__content {
            width: 100%;
            height: 100%;
        }
        &__button {
            position: absolute;
            z-index: 2;
            width: rem(128);
            height: rem(128);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: rem(32);
            color: $c-082605;
            background-color: $c-FFFFFF;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.2s;
            box-shadow: 0 0 15px rgba($c-secondary, 0.25);
            @media (pointer: coarse) {
                display: none;
            }
        }
        &__body {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    }
</style>
