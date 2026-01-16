<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-question">
            <ButtonCross class="modal-question__close" @click="emit('close')" />
            <div class="modal-question__container">
                <div class="modal-question__titlebox">
                    <p class="modal-question__title">Остались вопросы?</p>
                    <p class="modal-question__desc">
                        Если Вы не нашли ответа на свой вопрос, наши специалисты с радостью помогут!
                    </p>
                </div>
                <div class="modal-question__data">
                    <label
                        class="modal-question__inputbox modal-question__inputbox--input"
                        for="question-name"
                    >
                        <input
                            id="question-name"
                            type="text"
                            name="question-name"
                            placeholder="Как к Вам обращаться?"
                        />
                        <span>Как к Вам обращаться?</span>
                    </label>
                    <label
                        class="modal-question__inputbox modal-question__inputbox--input"
                        for="question-phone"
                    >
                        <InputMask
                            id="question-phone"
                            type="tel"
                            name="question-phone"
                            placeholder="Телефон"
                            mask="9 (999) 999-99-99"
                            unstyled
                        />
                        <span>Телефон</span>
                    </label>
                    <label
                        class="modal-question__inputbox modal-question__inputbox--tarea"
                        for="question-comment"
                    >
                        <textarea
                            id="question-comment"
                            name="question-comment"
                            placeholder="Ваш вопрос"
                        ></textarea>
                        <span>Ваш вопрос</span>
                    </label>
                    <div class="modal-question__controls">
                        <ButtonPrimary
                            class="modal-question__button"
                            type="button"
                            button-type="submit"
                            theme="yellow"
                            width="100%"
                            :overlay-size="0"
                            @click.prevent=""
                        >
                            <span>Отправить заявку</span>
                        </ButtonPrimary>
                        <div class="modal-question__agreement">
                            <label for="question-agreement">
                                <input
                                    id="question-agreement"
                                    type="checkbox"
                                    name="question-agreement"
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

    .modal-question {
        @include modal-form;
    }
</style>
