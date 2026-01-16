<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-co">
            <ButtonCross class="modal-co__close" @click="emit('close')" />
            <div class="modal-co__container">
                <div class="modal-co__titlebox">
                    <p class="modal-co__title">Начать сотрудничество</p>
                    <p class="modal-co__desc">
                        Оставьте заявку, и мы свяжемся с вами, чтобы обсудить условия сотрудничества
                    </p>
                </div>
                <div class="modal-co__data">
                    <label class="modal-co__inputbox modal-co__inputbox--input" for="co-name">
                        <input
                            id="co-name"
                            type="text"
                            name="co-name"
                            placeholder="Как к Вам обращаться?"
                        />
                        <span>Как к Вам обращаться?</span>
                    </label>
                    <label class="modal-co__inputbox modal-co__inputbox--input" for="co-phone">
                        <InputMask
                            id="co-phone"
                            type="tel"
                            name="co-phone"
                            placeholder="Телефон"
                            mask="9 (999) 999-99-99"
                            unstyled
                        />
                        <span>Телефон</span>
                    </label>
                    <label class="modal-co__inputbox modal-co__inputbox--input" for="co-company">
                        <input
                            id="co-company"
                            type="text"
                            name="co-company"
                            placeholder="Название компании"
                        />
                        <span>Название компании</span>
                    </label>
                    <div class="modal-co__controls">
                        <ButtonPrimary
                            class="modal-co__button"
                            type="button"
                            button-type="submit"
                            width="100%"
                            :overlay-size="0"
                            @click.prevent=""
                        >
                            <span>Отправить заявку</span>
                        </ButtonPrimary>
                        <div class="modal-co__agreement">
                            <label for="co-agreement">
                                <input id="co-agreement" type="checkbox" name="co-agreement" />
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

    .modal-co {
        @include modal-form;
    }
</style>
