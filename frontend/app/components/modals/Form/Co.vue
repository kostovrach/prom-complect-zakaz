<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-co">
            <ButtonCross class="modal-co__close" @click="emit('close')" />
            <div class="modal-co__container">
                <div v-if="isLoading" class="modal-co__loading">
                    <LoadSpinner />
                </div>
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
                            v-model="formData.name"
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
                    <label class="modal-co__inputbox modal-co__inputbox--input" for="co-company">
                        <input
                            id="co-company"
                            type="text"
                            name="co-company"
                            placeholder="Название компании"
                            v-model="formData.companyName"
                        />
                        <span>Название компании</span>
                    </label>
                    <div class="modal-co__controls">
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
                            class="modal-co__button"
                            type="button"
                            button-type="submit"
                            width="100%"
                            :overlay-size="0"
                            @click.prevent="submitForm"
                        >
                            <span>Отправить заявку</span>
                        </ButtonPrimary>
                        <div class="modal-co__agreement">
                            <label for="co-agreement">
                                <input
                                    id="co-agreement"
                                    type="checkbox"
                                    name="co-agreement"
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
        companyName: '',
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
        formDataToSend.append('subject', 'Заявка на сотрудничество');
        formDataToSend.append('name', formData.name);
        formDataToSend.append('phone', formData.phone);
        formDataToSend.append('companyName', formData.companyName);

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
                formData.companyName = '';
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

    .modal-co {
        @include modal-form;
    }
</style>
