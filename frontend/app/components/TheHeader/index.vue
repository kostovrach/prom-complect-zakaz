<template>
    <header :class="['header', { 'header--scroll': scrollY > 16 }]">
        <div class="header__container">
            <div class="header__row">
                <NuxtLink class="header__logo-container" :to="{ name: 'index' }">
                    <div class="header__logo">
                        <span class="header__logo-vertical">
                            <SvgSprite type="logo-vertical" size="100%" />
                        </span>
                        <span class="header__logo-horizontal">
                            <SvgSprite type="logo-horizontal" size="100%" />
                        </span>
                    </div>
                </NuxtLink>
                <nav class="header__nav">
                    <ButtonRolling class="header__nav-item" type="NuxtLink" :to="{ name: 'about' }">
                        О КОМПАНИИ
                    </ButtonRolling>
                    <div v-if="services.length" class="header__nav-item header__dropdown">
                        <button class="header__dropdown-button">
                            <ButtonRolling>ОБОРУДОВАНИЕ</ButtonRolling>
                            <SvgSprite type="chevron" :size="16" />
                        </button>
                        <div class="header__dropdown-list">
                            <LinkPrimary
                                v-for="service in services"
                                :key="service.id"
                                class="header__dropdown-item"
                                type="NuxtLink"
                                :icon-size="20"
                                :to="{
                                    name: 'service',
                                    params: { service: slugify(service.hero_title) },
                                    query: { id: service.id },
                                }"
                            >
                                {{ service.hero_title }}
                            </LinkPrimary>
                        </div>
                    </div>
                    <ButtonRolling class="header__nav-item" type="NuxtLink" :to="{ name: 'co' }">
                        ПАРТНЁРАМ
                    </ButtonRolling>
                    <ButtonRolling class="header__nav-item" type="NuxtLink" :to="{ name: 'blog' }">
                        БЛОГ
                    </ButtonRolling>
                    <ButtonRolling
                        class="header__nav-item"
                        type="NuxtLink"
                        :to="{ name: 'contact' }"
                    >
                        КОНТАКТЫ
                    </ButtonRolling>
                </nav>
                <div class="header__controls">
                    <ButtonRolling class="header__link" href="tel:" type="a">
                        +7 987 654-32-17
                    </ButtonRolling>
                    <ButtonPrimary
                        class="header__button"
                        type="button"
                        theme="transparent"
                        :overlay-size="50"
                        @click="openModalConsultation"
                    >
                        ЗАКАЗАТЬ ЗВОНОК
                    </ButtonPrimary>
                    <button class="header__burger burger-icon _burger-icon" data-modal="hide-menu">
                        <span></span>
                    </button>
                </div>
            </div>
        </div>
    </header>
</template>

<script setup lang="ts">
    import { ModalsFormConsultation } from '#components';
    import { useModal } from 'vue-final-modal';

    const { y: scrollY } = useWindowScroll();

    const servicesStore = useServicesStore();
    const services = computed(() => servicesStore.services);

    const { open: openModalConsultation, close: _closeModalConsultation } = useModal({
        component: ModalsFormConsultation,
        attrs: {
            onClose() {
                _closeModalConsultation();
            },
        },
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .header {
        $p: &;
        --header-bgcolor: #{$c-accent};
        $row-gap: rem(32);

        position: fixed;
        z-index: 4;
        top: 0;
        width: 100%;
        height: var(--header-height);
        transition:
            translate $td $tf,
            box-shadow $td $tf;
        background-color: $c-main;

        &--scroll {
            box-shadow: 0 1px 15px rgba($c-main, 0.5);
            #{$p}__row {
                padding: rem(8) 0;
            }
            #{$p}__logo {
                &-vertical {
                    display: none;
                }
                &-horizontal {
                    display: initial;
                }
            }
        }
        &__row {
            // height: var(--header-height);

            @at-root body.scroll & {
                // height: var(--header-scroll-height);
            }
        }

        &__container {
            // display: flex;
            // align-items: center;
            // justify-content: space-between;
            // gap: lineScale(32, 16, 480, 1440);
            @include content-container;
        }

        &__row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: $row-gap;
            padding: rem(16) 0;
            transition: padding $td $tf;
        }
        &__logo-container {
            display: block;
        }
        &__logo {
            color: $c-1C3A19;
            height: rem(32);
            > * {
                max-height: initial;
            }
            &-horizontal {
                > svg {
                    width: rem(227);
                    height: rem(32);
                    min-width: rem(227);
                    min-height: rem(32);
                }
                display: none;
            }
            &-vertical {
                > svg {
                    width: rem(96);
                    height: rem(159);
                    min-width: rem(96);
                    min-height: rem(159);
                }
            }

            @media (max-width: 768px) {
                &-horizontal {
                    display: initial;
                }
                &-vertical {
                    display: none;
                }
            }
        }
        &__nav {
            display: flex;
            align-items: center;
            gap: $row-gap;
            &-item {
                text-transform: uppercase;
                font-size: rem(14);
                font-weight: $fw-bold;
                white-space: nowrap;
            }
        }
        &__dropdown {
            position: relative;
            @media (pointer: fine) {
                &:hover {
                    #{$p}__dropdown {
                        &-button {
                            > svg {
                                transform: scaleY(-1);
                            }
                        }
                        &-list {
                            visibility: visible;
                        }
                    }
                }
            }
            &-button {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: rem(8);
                margin: -15px 0;
                padding: 15px 0;
                > svg {
                    transition: transform $td $tf;
                }
            }
            &-list {
                position: absolute;
                top: rem(32);
                left: -25%;
                width: max-content;
                display: flex;
                flex-direction: column;
                text-transform: uppercase;
                color: $c-FFFFFF;
                padding: lineScale(40, 32, 480, 1920) lineScale(32, 16, 480, 1920);
                background-color: $c-1C3A19;
                visibility: hidden;
            }
            &-item {
                width: fit-content;
                display: flex;
                align-items: center;
                gap: rem(16);
                padding: rem(8) 0;
                span:not(:has(svg)) {
                    transition: translate $td $tf;
                }
                @media (pointer: fine) {
                    &:hover {
                        span:not(:has(svg)) {
                            translate: rem(16) 0;
                        }
                    }
                }
            }
        }
        &__controls {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: $row-gap;
            white-space: nowrap;
        }
        &__link {
            font-weight: $fw-bold;
        }
        &__button {
            @media (max-width: 768px) {
                display: none;
            }
        }
    }
</style>
