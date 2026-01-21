<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-consultation">
            <ButtonCross class="modal-consultation__close" @click="emit('close')" />
            <div class="modal-consultation__container">
                <div v-if="isLoading" class="modal-consultation__loading">
                    <LoadSpinner />
                </div>
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
                            v-model="formData.phone"
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
                    <div class="modal-consultation__controls">
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
                            class="modal-consultation__button"
                            type="button"
                            button-type="submit"
                            width="100%"
                            theme="yellow"
                            :overlay-size="0"
                            @click.prevent="submitForm"
                        >
                            <span>Отправить заявку</span>
                        </ButtonPrimary>
                        <div class="modal-consultation__agreement">
                            <label for="consultation-agreement">
                                <input
                                    id="consultation-agreement"
                                    type="checkbox"
                                    name="consultation-agreement"
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
        phone: '',
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
        formDataToSend.append('subject', 'Заявка на консультацию');
        formDataToSend.append('phone', formData.phone);

        try {
            const { success, message } = await $fetch('/api/mail/request', {
                method: 'POST',
                body: formDataToSend,
            });

            if (!success) {
                formErrors.general = message ?? errorFallbackText;
            } else {
                formData.phone = '';
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

    .modal-consultation {
        @include modal-form;
    }
</style>
