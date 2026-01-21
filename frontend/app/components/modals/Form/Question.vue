<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-question">
            <ButtonCross class="modal-question__close" @click="emit('close')" />
            <div class="modal-question__container">
                <div v-if="isLoading" class="modal-question__loading">
                    <LoadSpinner />
                </div>
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
                            v-model="formData.name"
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
                            inputmode="tel"
                            v-model="formData.phone"
                            unstyled
                            @focus="formErrors.phone = false"
                        />
                        <span>Телефон</span>
                        <FormNotifyInfo
                            v-if="formErrors.phone"
                            :position="{ top: '110%', left: '-2%' }"
                            theme="light"
                        >
                            Поле не может быть пустым
                        </FormNotifyInfo>
                    </label>
                    <label
                        class="modal-question__inputbox modal-question__inputbox--tarea"
                        for="question-comment"
                    >
                        <textarea
                            id="question-comment"
                            name="question-comment"
                            placeholder="Ваш вопрос"
                            v-model="formData.message"
                            @focus="formErrors.message = false"
                        ></textarea>
                        <span>Ваш вопрос</span>
                        <FormNotifyInfo
                            v-if="formErrors.message"
                            :position="{ top: '110%', left: '-2%' }"
                            theme="light"
                        >
                            Поле не может быть пустым
                        </FormNotifyInfo>
                    </label>
                    <div class="modal-question__controls">
                        <FormNotifyError v-if="formErrors.general">
                            {{ formErrors.general }}
                        </FormNotifyError>
                        <FormNotifySuccess v-if="isSubmited">
                            <ul>
                                <li>Спасибо за заявку!</li>
                                <li>Наши менеджеры свяжутся с вами в бижайшее время.</li>
                            </ul>
                        </FormNotifySuccess>
                        <ButtonPrimary
                            class="modal-question__button"
                            type="button"
                            button-type="submit"
                            theme="yellow"
                            width="100%"
                            :overlay-size="0"
                            @click.prevent="submitForm"
                        >
                            <span>Отправить заявку</span>
                        </ButtonPrimary>
                        <div class="modal-question__agreement">
                            <label for="question-agreement">
                                <input
                                    id="question-agreement"
                                    type="checkbox"
                                    name="question-agreement"
                                    v-model="formData.agreement"
                                    @input="formErrors.agreement = false"
                                />
                            </label>
                            <p>Согласен(-а) с политикой обработки персональных данных</p>
                            <FormNotifyInfo
                                v-if="formErrors.agreement"
                                :position="{ top: '130%', left: '-6%' }"
                                theme="light"
                            >
                                Без Вашего согласия мы не сможем продолжить
                            </FormNotifyInfo>
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

    const isLoading = ref(false);
    const isSubmited = ref(false);

    const formData = reactive({
        name: '',
        phone: '',
        message: '',
        agreement: true,
    });

    const formErrors = reactive({
        phone: false,
        agreement: false,
        message: false,
        general: '',
    });

    async function submitForm() {
        const errorFallbackText = 'Ошибка сервера, попробуйте повторить попытку позже';

        formErrors.general = '';
        isSubmited.value = false;

        if (!formData.phone.length || !formData.agreement || !formData.message) {
            if (!formData.phone.length) formErrors.phone = true;
            if (!formData.agreement) formErrors.agreement = true;
            if (!formData.message) formErrors.message = true;
            return;
        }

        isLoading.value = true;

        const formDataToSend = new FormData();
        formDataToSend.append('subject', 'Вопрос');
        formDataToSend.append('name', formData.name);
        formDataToSend.append('phone', formData.phone);
        formDataToSend.append('message', formData.message);

        try {
            const { success, message } = await $fetch('/api/mail/request', {
                method: 'POST',
                body: formDataToSend,
            });

            if (!success) {
                formErrors.general = message ?? errorFallbackText;
            } else {
                formData.name = '';
                formData.phone = '';
                formData.message = '';
                isSubmited.value = true;
            }
        } catch {
            formErrors.general = errorFallbackText;
        } finally {
            isLoading.value = false;
        }
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-question {
        @include modal-form;
    }
</style>
