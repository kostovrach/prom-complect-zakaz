<template>
    <NuxtLayout name="dark">
        <section class="quiz">
            <div class="quiz__container">
                <div class="quiz__header">
                    <h1 class="quiz__title">
                        {{ quiz?.title }}
                    </h1>
                    <div
                        class="quiz__progressbar"
                        :style="{ '--progress': Math.min(progress, 100) + '%' }"
                    >
                        <span class="quiz__progressbar-inner"></span>
                        <span class="quiz__progressbar-percent">{{ progress + '%' }}</span>
                    </div>
                </div>
                <form class="quiz__form" @submit.prevent="submitQuiz">
                    <div
                        v-for="(section, idx) in quizSections"
                        :key="section.id"
                        :class="[
                            'quiz__section',
                            { 'quiz__section--prev': activeIdx - 1 === idx },
                            { 'quiz__section--current': activeIdx === idx },
                            {
                                'quiz__section--next':
                                    activeIdx + 1 === idx || activeIdx === quizLength,
                            },
                        ]"
                    >
                        <div class="quiz__section-titlebox">
                            <div class="quiz__section-count">
                                <span class="quiz__section-count-title">Вопрос</span>
                                <span class="quiz__section-count-current">{{ idx + 1 }}</span>
                                <span class="quiz__section-count-separator"></span>
                                <span class="quiz__section-count-total">
                                    {{ quizLength }}
                                </span>
                            </div>
                            <h2 class="quiz__section-title">{{ section.question }}</h2>
                            <p class="quiz__section-desc">
                                Выберите наиболее подходящий вариант ответа
                            </p>
                            <LinkPrimary
                                v-if="idx > 0"
                                class="quiz__section-back-link"
                                type="button"
                                button-type="button"
                                reverse
                                @click="prevQuestion"
                            >
                                <span>Назад</span>
                            </LinkPrimary>
                        </div>
                        <div class="quiz__section-content">
                            <div class="quiz__section-data">
                                <label
                                    v-for="(answer, idx) in section.answers.flatMap(
                                        (el) => el.content
                                    )"
                                    :key="idx"
                                    class="quiz__section-option"
                                    :for="answerIdBuilder(section.question, answer, idx)"
                                >
                                    <span class="quiz__section-option-icon">
                                        <SvgSprite type="pixel-checkmark" :size="32" />
                                    </span>
                                    <input
                                        :id="answerIdBuilder(section.question, answer, idx)"
                                        type="radio"
                                        :name="section.question"
                                        :value="answer"
                                        v-model="answers[String(section.id)]"
                                        @input="clearCustom(String(section.id))"
                                    />
                                    <span>{{ answer }}</span>
                                </label>
                                <label
                                    v-if="section.custom"
                                    class="quiz__section-option quiz__section-option--custom"
                                    :for="`${section.question}-custom`"
                                >
                                    <span class="quiz__section-option-icon">
                                        <SvgSprite type="pixel-checkmark" :size="32" />
                                    </span>
                                    <input
                                        :id="`${section.question}-custom`"
                                        type="radio"
                                        :name="section.question"
                                        value="custom"
                                        v-model="answers[String(section.id)]"
                                    />
                                    <span>Другое</span>
                                </label>
                            </div>
                            <label
                                v-if="answers[String(section.id)] === 'custom'"
                                class="quiz__section-inputbox quiz__section-inputbox--tarea"
                                :for="`${slugify(section.question)}-custom-input`"
                            >
                                <span>Напишите свой вариант</span>
                                <textarea
                                    :id="`${slugify(section.question)}-custom-input`"
                                    placeholder="Напишите свой вариант"
                                    v-model="customAnswers[String(section.id)]"
                                ></textarea>
                            </label>
                            <ButtonPrimary
                                class="quiz__section-button"
                                type="button"
                                button-type="button"
                                :overlay-size="0"
                                width="100%"
                                theme="accent"
                                @click="nextQuestion"
                            >
                                <span>Следующий вопрос</span>
                            </ButtonPrimary>
                            <span v-if="section.hint" class="quiz__section-hint">
                                {{ section.hint }}
                            </span>
                        </div>
                    </div>
                    <div
                        :class="[
                            'quiz__section',
                            {
                                'quiz__section--prev':
                                    activeIdx === (quizSections?.length || 0) + 1,
                            },
                            { 'quiz__section--current': activeIdx === quizSections?.length },
                            {
                                'quiz__section--next':
                                    activeIdx === (quizSections?.length || 0) - 1,
                            },
                        ]"
                    >
                        <div v-if="isLoading" class="quiz__section-loading">
                            <LoadSpinner />
                        </div>
                        <div class="quiz__section-titlebox">
                            <div class="quiz__section-count">
                                <span class="quiz__section-count-title">Вопрос</span>
                                <span class="quiz__section-count-current">
                                    {{ (quizSections?.length || 0) + 1 }}
                                </span>
                                <span class="quiz__section-count-separator"></span>
                                <span class="quiz__section-count-total">{{ quizLength }}</span>
                            </div>
                            <h2 class="quiz__section-title">Как нам с вами связаться?</h2>
                            <p class="quiz__section-desc">
                                Заполните все поля для оформления заявки. Мы рассмотрим вашу задачу
                                и&nbsp;оперативно предложим решение.
                            </p>
                            <LinkPrimary
                                class="quiz__section-back-link"
                                type="button"
                                button-type="button"
                                reverse
                                @click="prevQuestion"
                            >
                                <span>Назад</span>
                            </LinkPrimary>
                        </div>
                        <div class="quiz__section-content">
                            <label
                                class="quiz__section-inputbox quiz__section-inputbox--input"
                                for="quiz-name"
                            >
                                <span>Имя</span>
                                <input
                                    v-model="userContacts.name"
                                    id="quiz-name"
                                    type="text"
                                    placeholder="Имя"
                                />
                            </label>
                            <label
                                class="quiz__section-inputbox quiz__section-inputbox--input"
                                for="quiz-phone"
                            >
                                <span>Номер телефона</span>
                                <InputMask
                                    v-model="userContacts.phone"
                                    id="quiz-phone"
                                    placeholder="Номер телефона"
                                    unstyled
                                    mask="9 (999) 999-99-99"
                                    @focus="userContactsErrors.phone = false"
                                />
                                <FormNotifyInfo
                                    v-if="userContactsErrors.phone"
                                    :position="{ top: '110%', left: '-2%' }"
                                    theme="light"
                                >
                                    Поле не может быть пустым
                                </FormNotifyInfo>
                            </label>
                            <label
                                class="quiz__section-inputbox quiz__section-inputbox--tarea"
                                for="quiz-comment"
                            >
                                <span>Хотите что-либо добавить? (необязательно)</span>
                                <textarea
                                    v-model="userContacts.comment"
                                    id="quiz-comment"
                                    placeholder="Хотите что-либо добавить? (необязательно)"
                                ></textarea>
                            </label>
                            <ButtonPrimary
                                class="quiz__section-button quiz__section-button--submit"
                                type="button"
                                button-type="submit"
                                :overlay-size="0"
                                width="100%"
                                theme="yellow"
                            >
                                Отправить
                            </ButtonPrimary>
                            <div class="quiz__section-agreement">
                                <label for="quiz-agreement">
                                    <input
                                        v-model="userContacts.agreement"
                                        id="quiz-agreement"
                                        type="checkbox"
                                        @input="userContactsErrors.agreement = false"
                                    />
                                </label>
                                <p>Согласен(-а) с политикой обработки персональных данных</p>
                                <FormNotifyInfo
                                    v-if="userContactsErrors.agreement"
                                    :position="{ top: '125%', left: '-5%' }"
                                    theme="light"
                                >
                                    Без Вашего согласия мы не сможем продолжить
                                </FormNotifyInfo>
                            </div>
                            <FormNotifyError
                                v-if="userContactsErrors.general.length"
                                class="quiz__error"
                            >
                                {{ userContactsErrors.general }}
                            </FormNotifyError>
                        </div>
                    </div>
                    <div
                        :class="[
                            'quiz__complete',
                            {
                                'quiz__complete--current':
                                    activeIdx === (quizSections?.length || 0) + 1,
                            },
                            {
                                'quiz__complete--next': activeIdx === quizSections?.length,
                            },
                        ]"
                    >
                        <div class="quiz__complete-titlebox">
                            <div class="quiz__complete-icon">
                                <SvgSprite type="pixel-checkmark" :size="96" />
                            </div>
                            <p class="quiz__complete-title">Заявка успешно отправлена</p>
                            <p class="quiz__complete-subtitle">Ожидайте звонка специалиста</p>
                        </div>
                        <div class="quiz__complete-controls">
                            <LinkPrimary
                                class="quiz__complete-back-link"
                                type="button"
                                button-type="button"
                                @click="activeIdx = 0"
                            >
                                Заполнить заново
                            </LinkPrimary>
                            <ButtonPrimary
                                class="quiz__complete-button"
                                type="NuxtLink"
                                :to="{ name: 'index' }"
                                theme="yellow"
                            >
                                На главную
                            </ButtonPrimary>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    interface IQuiz {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        title: string;
        sections: {
            id: string | number;
            quiz_page_id: any;
            quiz_page_section_id: {
                id: string | number;
                date_created: string;
                date_updated: string | null;
                question: string;
                answers: {
                    content: string;
                }[];
                custom: boolean;
                hint: string | null;
            };
        }[];
    }

    // Data ==========================================================
    const { content: quiz } = await useCms<IQuiz>('quiz_page', [
        'sections.*',
        'sections.quiz_page_section_id.*',
    ]);
    const quizSections = computed(() => quiz.value?.sections.map((el) => el.quiz_page_section_id));
    // ===============================================================

    // State =========================================================
    const isLoading = ref(false);
    const isSubmited = ref(false);

    const activeIdx = ref(0);
    const progress = computed(() => {
        if (!quizLength.value) return 0;
        return Math.round(((activeIdx.value + 1) / quizLength.value) * 100);
    });

    const quizLength = computed(() => {
        if (!quizSections.value) return 2;

        return quizSections.value.length + 2;
    });

    // ===============================================================

    // UserData =======================================================
    const answers = ref<Record<string, string>>({});
    const customAnswers = ref<Record<string, string>>({});

    const answersToSend = computed(() => {
        const result: Record<string, string> = {};

        quizSections.value?.forEach((section) => {
            const id = String(section.id);
            const selected = answers.value[id];
            result[section.question] =
                selected === 'custom' ? (customAnswers.value[id] ?? '') : (selected ?? '');
        });

        return result;
    });

    const userContacts = reactive({
        name: '',
        phone: '',
        comment: '',
        agreement: true,
    });

    const userContactsErrors = reactive({
        phone: false,
        agreement: false,
        general: '',
    });
    // ================================================================

    // Methods ========================================================
    function answerIdBuilder(question: string, answer: string, index: string | number) {
        return `${slugify(question)}-${slugify(answer)}-${index}`;
    }

    function nextQuestion() {
        if (!quizSections.value) return;
        if (activeIdx.value < quizLength.value - 1) {
            activeIdx.value++;
        }
    }

    function prevQuestion() {
        if (activeIdx.value > 0) {
            activeIdx.value--;
        }
    }

    function clearCustom(id: string | number) {
        if (customAnswers.value[id]) {
            customAnswers.value[id] = '';
        }
    }

    function clearForm() {
        answers.value = {};
        customAnswers.value = {};
        userContacts.name = '';
        userContacts.phone = '';
        userContacts.comment = '';
    }

    async function submitQuiz() {
        const errorFallbackText = 'Ошибка сервера, попробуйте повторить попытку позже';

        userContactsErrors.general = '';
        isSubmited.value = false;

        if (!userContacts.phone.length || !userContacts.agreement) {
            if (!userContacts.phone.length) userContactsErrors.phone = true;
            if (!userContacts.agreement) userContactsErrors.agreement = true;
            return;
        }
        isLoading.value = true;

        try {
            const { success, message } = await $fetch('/api/mail/quiz', {
                method: 'POST',
                body: {
                    name: userContacts.name,
                    phone: userContacts.phone,
                    comment: userContacts.comment,
                    payload: answersToSend.value,
                },
            });

            if (!success) {
                userContactsErrors.general = message ?? errorFallbackText;
            } else {
                clearForm();
                isSubmited.value = true;
                activeIdx.value = (quizSections.value?.length || 0) + 1;
            }
        } catch {
            userContactsErrors.general = errorFallbackText;
        } finally {
            isLoading.value = false;
        }
    }
    // ================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .quiz {
        $p: &;

        position: relative;
        min-height: 100lvh;
        color: $c-FFFFFF;
        background-color: $c-accent;
        padding-top: rem(96);
        margin-bottom: rem(64);
        @media (max-width: 768px) {
            padding-top: rem(96);
        }
        &__container {
            @include content-container($max-width: rem(1440));
        }
        &__header {
            display: flex;
            flex-direction: column;
            gap: rem(48);
        }
        &__title {
            align-self: flex-end;
            display: flex;
            align-items: center;
            gap: rem(8);
            text-align: right;
            font-weight: $fw-bold;
            &::after {
                content: '';
                display: block;
                width: rem(16);
                min-width: rem(16);
                aspect-ratio: 1;
                background-color: currentColor;
                clip-path: polygon(0 0, 0% 100%, 100% 100%);
            }
        }
        &__progressbar {
            position: relative;
            width: 100%;
            height: rem(8);
            background-color: rgba($c-FFF3B0, 0.25);
            margin-top: rem(32);
            &-inner {
                position: absolute;
                top: 0;
                left: 0;
                width: var(--progress);
                height: 100%;
                background-color: $c-FFF3B0;
                transition: width $td $tf;
                &::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    right: 0;
                    height: 100%;
                    aspect-ratio: 1;
                    translate: 99% 0;
                    background-color: inherit;
                    clip-path: polygon(0 0, 0% 100%, 100% 100%);
                }
            }
            &-percent {
                display: block;
                width: 100%;
                font-size: rem(18);
                font-weight: $fw-semi;
                margin-top: rem(24);
                color: $c-FFF3B0;
                translate: var(--progress) 0;
                pointer-events: none;
                transition: translate $td $tf;
            }
        }
        &__form {
            position: relative;
            display: flex;
            gap: rem(64);
            margin-top: rem(32);
            overflow: hidden;
        }
        &__section,
        &__complete {
            position: absolute;
            z-index: 0;
            inset: 0;
            pointer-events: none;
            translate: 110% 0;
            transition: translate $td $tf;
            will-change: translate;
            background-color: $c-accent;
            &::before {
                content: '';
                position: absolute;
                top: 0;
                left: 100%;
                height: 100%;
                width: 15%;
                background-color: inherit;
                pointer-events: none;
            }
            &--prev {
                translate: -110% 0;
            }
            &--current {
                position: relative;
                z-index: 2;
                translate: 0 0;
                pointer-events: auto;
            }
            &--next {
                translate: 110% 0;
            }
        }
        &__section {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(64);
            padding-top: rem(32);
            padding-bottom: rem(164);
            @media (max-width: 768px) {
                display: flex;
                flex-direction: column;
            }
            &-loading {
                position: absolute;
                inset: 0;
                z-index: 5;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: rgba($c-accent, 0.75);
            }
            &-titlebox {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-count {
                display: flex;
                align-items: center;
                gap: rem(8);
                font-size: lineScale(16, 14, 480, 1920);
                opacity: 0.5;
                &-separator {
                    width: rem(16);
                    height: rem(1);
                    background-color: currentColor;
                }
            }
            &-title {
                text-transform: uppercase;
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(44, 24, 480, 1920);
                font-weight: $fw-bold;
                line-height: 1.2;
            }
            &-desc {
                font-size: rem(16);
                line-height: 1.2;
            }
            &-back-link {
                cursor: pointer;
                width: fit-content;
                display: flex;
                align-items: center;
                gap: rem(8);
                text-transform: uppercase;
                font-weight: $fw-bold;
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(32);
            }
            &-data {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-option {
                cursor: pointer;
                width: 100%;
                display: flex;
                align-items: center;
                color: $c-1C3A19;
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(20, 18, 480, 1920);
                font-weight: $fw-bold;
                padding: rem(20) rem(24);
                background-color: $c-FFFFFF;
                clip-path: polygon(100% 0, 100% 60%, 95% 100%, 0 100%, 0 0);
                transition: gap $td $tf;
                &-icon {
                    width: 0;
                    color: $c-FFF3B0;
                    overflow: hidden;
                    transition: width $td $tf;
                    @at-root #{$p}__section-option:has(input:checked) & {
                        width: rem(32);
                    }
                }
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                        background-color: $c-4E6A4C;
                    }
                }
                &:has(input:checked) {
                    color: $c-FFFFFF;
                    background-color: $c-082605;
                    gap: rem(4);
                }
            }
            &-inputbox {
                position: relative;
                border-bottom: rem(1) solid $c-FFF3B0;
                padding: rem(24) 0;
                &::before {
                    content: '';
                    position: absolute;
                    bottom: 0;
                    width: 0;
                    height: rem(2);
                    background-color: $c-FFF3B0;
                    transition: width $td $tf;
                    will-change: width;
                }
                > input,
                > textarea {
                    position: absolute;
                    inset: 0;
                    width: 100%;
                    height: 100%;
                    appearance: none;
                    font-family: inherit;
                    color: inherit;
                    font-size: lineScale(20, 18, 480, 1920);
                    background-color: transparent;
                    &::placeholder {
                        color: transparent;
                    }
                }
                > span {
                    position: absolute;
                    left: 0;
                    font-family: 'Nuniti', sans-serif;
                    font-size: lineScale(24, 20, 480, 1920);
                    opacity: 0.5;
                    will-change: translate, opacity, font-size;
                    transition: all $td $tf;
                    pointer-events: none;
                }
                &--tarea {
                    height: rem(160);
                    > textarea {
                        width: 100%;
                        height: 100%;
                        resize: none;
                    }
                    > span {
                        top: 0;
                    }
                    &:has(textarea:focus),
                    &:not(:has(textarea:placeholder-shown)) {
                        > span {
                            font-size: rem(14);
                            color: $c-FFF3B0;
                            font-weight: $fw-bold;
                            translate: 0 rem(-16);
                            opacity: 1;
                        }
                        &::before {
                            width: 100%;
                        }
                    }
                }
                &--input {
                    > span {
                        top: 50%;
                        left: 0;
                        translate: 0 -50%;
                    }
                    &:has(input:focus),
                    &:not(:has(input:placeholder-shown)) {
                        > span {
                            font-size: rem(14);
                            color: $c-FFF3B0;
                            font-weight: $fw-bold;
                            translate: 0 rem(-32);
                            opacity: 1;
                        }
                        &::before {
                            width: 100%;
                        }
                    }
                }
            }
            &-hint {
                color: $c-FFF3B0;
                font-style: lineScale(16, 14, 480, 1920);
                font-weight: $fw-bold;
            }
            &-agreement {
                position: relative;
                @include agreement;
            }
        }
        &__complete {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(64);
            padding: rem(64) 0;
            &-titlebox {
                max-width: 85ch;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                gap: rem(16);
                text-align: center;
            }
            &-icon {
                min-width: rem(96);
                color: $c-FFF3B0;
            }
            &-title {
                text-transform: uppercase;
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(44, 30, 480, 1920);
                font-weight: $fw-bold;
            }
            &-controls {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-wrap: wrap-reverse;
                gap: rem(32);
            }
            &-back-link {
                cursor: pointer;
                max-width: 15ch;
                display: flex;
                align-items: center;
                gap: rem(8);
            }
        }
    }
</style>
