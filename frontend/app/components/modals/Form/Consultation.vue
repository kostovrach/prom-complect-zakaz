<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-consultation">
            <ButtonCross class="modal-consultation__close" @click="emit('close')" />
            <div class="modal-consultation__container">
                <div class="modal-consultation__titlebox">
                    <p class="modal-consultation__title">Закажите консультацию</p>
                    <p class="modal-consultation__desc">
                        Мы свяжемся с Вами, чтобы назначить бесплатный выезд инженера и консультацию
                    </p>
                </div>
                <div class="modal-consultation__data">
                    <label
                        class="modal-consultation__inputbox modal-consultation__inputbox--input"
                        for="request-phone"
                    >
                        <InputMask
                            id="consultation-phone"
                            type="tel"
                            name="consultation-phone"
                            placeholder="Телефон"
                            mask="9 (999) 999-99-99"
                            unstyled
                        />
                        <span>Телефон</span>
                    </label>
                    <div class="modal-consultation__controls">
                        <ButtonPrimary
                            class="modal-consultation__button"
                            type="button"
                            button-type="submit"
                            width="100%"
                            theme="yellow"
                            :overlay-size="0"
                            @click.prevent=""
                        >
                            <span>Отправить заявку</span>
                        </ButtonPrimary>
                        <div class="modal-consultation__agreement">
                            <label for="consultation-agreement">
                                <input
                                    id="consultation-agreement"
                                    type="checkbox"
                                    name="consultation-agreement"
                                />
                            </label>
                            <p>Согласен(-а) с политикой обработки персональных данных</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-consultation {
        @include modal-form;
    }
</style>
