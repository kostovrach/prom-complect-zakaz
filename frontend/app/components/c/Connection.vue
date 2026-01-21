<template>
    <section v-if="content" class="c-connection">
        <div class="c-connection__container">
            <div class="c-connection__decor">
                <span class="c-connection__decor-title">пром комплект заказ</span>
            </div>
            <div class="c-connection__body">
                <div class="c-connection__titlebox">
                    <h2 class="c-connection__title">{{ content.title }}</h2>
                    <div class="c-connection__subtitle" v-html="content.subtitle"></div>
                </div>
                <form class="c-connection__form">
                    <div v-if="isLoading" class="c-connection__loading">
                        <LoadSpinner theme="dark" />
                    </div>
                    <label class="c-connection__form-inputbox" for="c-connection-email">
                        <span>Электронная почта</span>
                        <input
                            v-model="formData.email"
                            id="c-connection-email"
                            type="email"
                            name="c-connection-email"
                            placeholder="example@yandex.ru"
                            required
                            inputmode="email"
                            @focus="formErrors.email = false"
                        />
                        <FormNotifyInfo
                            v-if="formErrors.email"
                            :position="{ top: '105%', left: '15%' }"
                        >
                            Поле не может быть пустым
                        </FormNotifyInfo>
                    </label>
                    <ButtonPrimary
                        class="c-connection__form-button"
                        type="button"
                        button-type="submit"
                        theme="gray"
                        :overlay-size="0"
                        @click.prevent="submitForm"
                    >
                        Отправить
                    </ButtonPrimary>
                    <label class="c-connection__form-agreement" for="c-connection-agreement">
                        <div class="c-connection__form-agreement-checkbox">
                            <input
                                v-model="formData.agreement"
                                id="c-connection-agreement"
                                type="checkbox"
                                name="c-connection-agreement"
                                required
                                @input="formErrors.agreement = false"
                            />
                            <span class="c-connection__form-agreement-icon">
                                <SvgSprite type="checkmark" :size="14" />
                            </span>
                        </div>
                        <p class="c-connection__form-agreement-text">
                            Согласен(-а) с политикой конфиденциальности и обработкой персональных
                            данных
                        </p>
                        <FormNotifyInfo
                            v-if="formErrors.agreement"
                            :position="{ top: '125%', left: '-4.5%' }"
                        >
                            Без Вашего согласия мы не сможем продолжить
                        </FormNotifyInfo>
                    </label>
                </form>
                <FormNotifyError v-if="formErrors.general.length" class="c-connection__notify">
                    {{ formErrors.general }}
                </FormNotifyError>
                <FormNotifySuccess v-if="isSubmited" class="c-connection__notify">
                    <ul>
                        <li>Спасибо за заявку!</li>
                        <li>Наши менеджеры свяжутся с вами в бижайшее время.</li>
                    </ul>
                </FormNotifySuccess>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    interface IContent {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        subtitle: string | null;
    }

    const { content } = await useCms<IContent>('contact_form');

    const isLoading = ref(false);
    const isSubmited = ref(false);

    const formData = reactive({
        email: '',
        agreement: true,
    });

    const formErrors = reactive({
        email: false,
        agreement: false,
        general: '',
    });

    async function submitForm() {
        const errorFallbackText = 'Ошибка сервера, попробуйте повторить попытку позже';

        formErrors.general = '';
        isSubmited.value = false;

        if (!formData.email.length || !formData.agreement) {
            if (!formData.email.length) formErrors.email = true;
            if (!formData.agreement) formErrors.agreement = true;
            return;
        }

        isLoading.value = true;

        const formDataToSend = new FormData();
        formDataToSend.append('subject', 'Подписка на информационную рассылку');
        formDataToSend.append('email', formData.email);

        try {
            const { success, message } = await $fetch('/api/mail/request', {
                method: 'POST',
                body: formDataToSend,
            });

            if (!success) {
                formErrors.general = message ?? errorFallbackText;
            } else {
                formData.email = '';
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

    .c-connection {
        $p: &;

        @include content-block;
        &__container {
            display: grid;
            grid-template-columns: auto 55%;
            gap: lineScale(64, 32, 480, 1920);
            @include content-container;
            @media (max-width: 1024px) {
                grid-template-columns: 100%;
            }
        }
        &__decor {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: flex-end;
            background-color: $c-accent;
            mask-image: url('/img/masks/favicon-mask.svg');
            mask-size: 100%;
            mask-position: 100% 100%;
            mask-repeat: no-repeat;
            @media (max-width: 1024px) {
                display: none;
            }
            &-title {
                max-width: 10ch;
                text-transform: lowercase;
                font-family: 'Nuniti', sans-serif;
                color: $c-FFFFFF;
                font-size: lineScale(35, 20, 480, 1920);
                padding: rem(32);
            }
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__title {
            font-family: 'Nuniti', sans-serif;
            text-wrap: balance;
            font-size: lineScale(64, 32, 480, 1920);
            font-weight: $fw-bold;
        }
        &__subtitle {
            max-width: 65ch;
            @include text-content(
                $font-size: lineScale(18, 16, 480, 1920),
                $h2-size: lineScale(24, 20, 480, 1920),
                $h-size: lineScale(20, 18, 480, 1920)
            );
        }
        &__notify {
            margin-top: rem(16);
        }
        &__loading {
            position: absolute;
            z-index: 5;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgba($c-main, 0.5);
        }
        &__form {
            position: relative;
            max-width: rem(740);
            display: grid;
            grid-template-columns: auto min-content;
            grid-template-areas:
                'input button'
                'agreement agreement';
            gap: rem(16) rem(32);
            margin-top: lineScale(156, 96, 480, 1920);
            @media (max-width: 680px) {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: rem(32);
            }
            &-inputbox {
                grid-area: input;
                position: relative;
                width: 100%;
                @include inputbox;
            }
            &-button {
                grid-area: button;
                @media (max-width: 680px) {
                    width: 100%;
                }
            }
            &-agreement {
                grid-area: agreement;
                position: relative;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: rem(8);
                &-checkbox {
                    cursor: pointer;
                    position: relative;
                    width: rem(24);
                    min-width: rem(24);
                    max-width: rem(24);
                    aspect-ratio: 1;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    &::before {
                        content: '[';
                    }
                    &::after {
                        content: ']';
                    }
                    &::before,
                    &::after {
                        font-size: rem(18);
                    }
                    > input {
                        cursor: pointer;
                        position: absolute;
                        inset: 0;
                    }
                }
                &-icon {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    translate: -50% -46%;
                    #{$p}__form-agreement-checkbox:not(:has(input:checked)) & {
                        display: none;
                    }
                }
                &-text {
                    font-size: lineScale(16, 14, 480, 1920);
                    > a,
                    button {
                        cursor: pointer;
                        text-decoration: underline;
                        @media (pointer: fine) {
                            &:hover {
                                text-decoration: none;
                            }
                        }
                    }
                }
            }
        }
    }
</style>
