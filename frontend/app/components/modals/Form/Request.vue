<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-request">
            <ButtonCross class="modal-request__close" @click="emit('close')" />
            <div class="modal-request__container">
                <div v-if="isLoading" class="modal-request__loading">
                    <LoadSpinner />
                </div>

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
                            v-model="formData.name"
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
                            v-model="formData.phone"
                            id="request-phone"
                            name="request-phone"
                            placeholder="Телефон"
                            mask="9 (999) 999-99-99"
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
                    <label class="modal-request__inputbox--file" for="request-file">
                        <input
                            ref="fileInputRef"
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
                            v-model="formData.message"
                            id="request-comment"
                            name="request-comment"
                            placeholder="Комментарий"
                        ></textarea>
                        <span>Комментарий</span>
                    </label>
                    <div class="modal-request__controls">
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
                            class="modal-request__button"
                            type="button"
                            button-type="submit"
                            theme="yellow"
                            :overlay-size="0"
                            width="100%"
                            @click.prevent="submitForm"
                        >
                            <span>Отправить заявку</span>
                        </ButtonPrimary>
                        <div class="modal-request__agreement">
                            <label for="request-agreement">
                                <input
                                    v-model="formData.agreement"
                                    id="request-agreement"
                                    type="checkbox"
                                    name="request-agreement"
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

    const fileInputRef = ref<HTMLInputElement | null>(null);

    const formData = reactive({
        name: '',
        phone: '',
        message: '',
        agreement: true,
    });

    const formErrors = reactive({
        phone: false,
        agreement: false,
        general: '',
    });

    async function submitForm() {
        const errorFallbackText = 'Ошибка сервера, попробуйте повторить попытку позже';

        formErrors.general = '';
        isSubmited.value = false;

        if (!formData.phone.length || !formData.agreement) {
            if (!formData.phone.length) formErrors.phone = true;
            if (!formData.agreement) formErrors.agreement = true;
            return;
        }

        isLoading.value = true;

        const formDataToSend = new FormData();
        formDataToSend.append('subject', 'Заявка на оборудование');
        formDataToSend.append('name', formData.name);
        formDataToSend.append('phone', formData.phone);
        formDataToSend.append('message', formData.message);

        const file = fileInputRef.value?.files?.[0];
        if (file) {
            formDataToSend.append('file', file);
        }
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
                if (fileInputRef.value) fileInputRef.value.value = '';
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

    .modal-request {
        @include modal-form;
    }
</style>
