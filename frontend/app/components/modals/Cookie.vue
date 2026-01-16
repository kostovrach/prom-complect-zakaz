<template>
    <div v-if="!isAccepted" class="modal-cookie">
        <div class="modal-cookie__content">
            <p class="modal-cookie__text">
                Мы&nbsp;сохраняем файлы 🍪 cookie для быстрой и&nbsp;удобной работы сайта. Продолжая
                использовать сайт, вы&nbsp;предоставляете согласие на&nbsp; обработку ваших
                персональных данных с&nbsp;помощью сервисов веб-аналитики.
            </p>
            <ButtonPrimary
                class="modal-cookie__button"
                type="button"
                button-type="button"
                :overlay-size="0"
                theme="light"
                compact
                @click="setAgreement"
            >
                Принять
            </ButtonPrimary>
        </div>
    </div>
</template>

<script setup lang="ts">
    const STORAGE_KEY = 'cookie-agreement';

    const isAccepted = ref(true);

    function setAgreement() {
        localStorage.setItem(STORAGE_KEY, 'true');
        isAccepted.value = true;
    }

    onMounted(() => {
        if (!localStorage.getItem(STORAGE_KEY)) {
            isAccepted.value = false;
        }
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-cookie {
        position: fixed;
        z-index: 100;
        bottom: lineScale(16, 8, 480, 1920);
        right: lineScale(16, 8, 480, 1920);
        width: calc(100% - lineScale(32, 16, 480, 1920));
        max-width: rem(440);
        background-color: $c-FFFFFF;
        padding: rem(16);
        opacity: 0;
        translate: rem(64) 0;
        animation: slide-up $td $tf 2s forwards;
        &__content {
            font-size: rem(14);
            font-weight: $fw-semi;
            line-height: 1.4;
        }
        &__button {
            margin-top: rem(16);
        }

        @keyframes slide-up {
            from {
                opacity: 0;
                translate: 0 rem(64);
            }
            to {
                opacity: 1;
                translate: 0 0;
            }
        }
    }
</style>
