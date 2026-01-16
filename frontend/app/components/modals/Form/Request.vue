<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-request">
            <ButtonCross class="modal-request__close" @click="emit('close')" />
            <div class="modal-request__container">
                <div class="modal-request__titlebox">
                    <p class="modal-request__title">Заявка</p>
                    <p class="modal-request__desc">
                        Передайте нам технические детали — наши инженеры предложат готовое решение и
                        помогут скорректировать ТЗ под реальные условия
                    </p>
                </div>
                <div class="modal-request__data">
                    <label
                        class="modal-request__inputbox modal-request__inputbox--input"
                        for="request-name"
                    >
                        <input
                            id="request-name"
                            type="text"
                            name="request-name"
                            placeholder="Как к Вам обращаться?"
                        />
                        <span>Как к Вам обращаться?</span>
                    </label>
                    <label
                        class="modal-request__inputbox modal-request__inputbox--input"
                        for="request-phone"
                    >
                        <InputMask
                            id="request-phone"
                            name="request-phone"
                            placeholder="Телефон"
                            mask="9 (999) 999-99-99"
                            unstyled
                        />
                        <span>Телефон</span>
                    </label>
                    <label class="modal-request__inputbox--file" for="request-file">
                        <input
                            id="request-file"
                            class=""
                            type="file"
                            name="request-file"
                            placeholder="Прикрепить ТЗ (опционально)"
                        />
                        <span>Прикрепить ТЗ (опционально)</span>
                        <hr />
                        <SvgSprite type="paper-clip" :size="32" />
                    </label>
                    <label
                        class="modal-request__inputbox modal-request__inputbox--tarea"
                        for="request-comment"
                    >
                        <textarea
                            id="request-comment"
                            name="request-comment"
                            placeholder="Комментарий"
                        ></textarea>
                        <span>Комментарий</span>
                    </label>
                    <div class="modal-request__controls">
                        <ButtonPrimary
                            class="modal-request__button"
                            type="button"
                            button-type="submit"
                            theme="yellow"
                            :overlay-size="0"
                            width="100%"
                            @click.prevent=""
                        >
                            <span>Отправить заявку</span>
                        </ButtonPrimary>
                        <div class="modal-request__agreement">
                            <label for="request-agreement">
                                <input
                                    id="request-agreement"
                                    type="checkbox"
                                    name="request-agreement"
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

    .modal-request {
        @include modal-form;
    }
</style>
