<template>
    <footer ref="containerRef" class="footer">
        <div class="footer__container">
            <div class="footer__wrapper">
                <a class="footer__anchor" href="#">
                    <span>Наверх</span>
                    <span class="footer__anchor-icon">
                        <SvgSprite type="arrow" :size="14" />
                    </span>
                </a>

                <NuxtLink class="footer__logo-container" :to="{ name: 'index' }">
                    <span class="footer__logo footer__logo--full">
                        <SvgSprite type="logo-full" size="100%" />
                    </span>
                    <span class="footer__logo footer__logo--horizontal">
                        <SvgSprite type="logo-horizontal" size="100%" />
                    </span>
                </NuxtLink>
                <div class="footer__body">
                    <nav v-if="services.length" class="footer__list">
                        <span class="footer__list-title">Продукция</span>
                        <NuxtLink
                            v-for="service in services.slice(0, 12)"
                            :key="service.id"
                            class="footer__nav-link"
                            :to="{
                                name: 'services-service',
                                params: { service: slugify(service.hero_title) },
                                query: { id: service.id },
                            }"
                        >
                            {{ service.hero_title }}
                        </NuxtLink>
                    </nav>
                    <nav class="footer__list">
                        <span class="footer__list-title">Карта сайта</span>
                        <NuxtLink class="footer__nav-link" :to="{ name: 'index' }">
                            Главная
                        </NuxtLink>
                        <NuxtLink class="footer__nav-link" :to="{ name: 'about' }">
                            О компании
                        </NuxtLink>
                        <NuxtLink class="footer__nav-link" :to="{ name: 'co' }">Партнерам</NuxtLink>
                        <NuxtLink class="footer__nav-link" :to="{ name: 'blog' }">
                            Полезные материалы
                        </NuxtLink>
                        <NuxtLink class="footer__nav-link" :to="{ name: 'quiz' }">
                            Подбор оборудования
                        </NuxtLink>
                        <button
                            v-for="doc in docs"
                            :key="doc.id"
                            class="footer__nav-link"
                            type="button"
                            @click="
                                openDocsModal(
                                    doc.date_updated ?? doc.date_created,
                                    doc.title,
                                    doc.content
                                )
                            "
                        >
                            {{ doc.title }}
                        </button>
                        <NuxtLink class="footer__nav-link" :to="{ name: 'contact' }">
                            Контакты
                        </NuxtLink>
                    </nav>
                    <div class="footer__list footer__list--contact">
                        <span class="footer__list-title">Контакты</span>
                        <ButtonRolling
                            v-if="contacts?.phone"
                            class="footer__link footer__link--tel"
                            type="a"
                            :href="`tel:${contacts.phone.trim().replace(/\s+/g, '')}`"
                        >
                            {{ contacts.phone }}
                        </ButtonRolling>
                        <ButtonRolling
                            v-if="contacts?.email"
                            class="footer__link footer__link--mail"
                            type="a"
                            :href="`mailto:${contacts.email.trim().replace(/\s+/g, '')}`"
                        >
                            {{ contacts.email }}
                        </ButtonRolling>
                        <div class="footer__socials">
                            <a
                                v-if="contacts?.vk"
                                class="footer__socials-item"
                                :href="contacts.vk.trim().replace(/\s+/g, '')"
                                target="_blank"
                                rel="noopener noreferrer"
                            >
                                <SvgSprite type="socials-vk" :size="44" />
                            </a>
                            <a
                                v-if="contacts?.tg"
                                class="footer__socials-item"
                                :href="contacts.tg.trim().replace(/\s+/g, '')"
                                target="_blank"
                                rel="noopener noreferrer"
                            >
                                <SvgSprite type="socials-telegram" :size="44" />
                            </a>
                            <a
                                v-if="contacts?.ok"
                                class="footer__socials-item"
                                :href="contacts.ok.trim().replace(/\s+/g, '')"
                                target="_blank"
                                rel="noopener noreferrer"
                            >
                                <SvgSprite type="socials-ok" :size="44" />
                            </a>
                        </div>
                    </div>
                </div>
                <div class="footer__info">
                    <span>{{ contacts?.copyright }}</span>
                    <template v-if="contacts?.legal_info">
                        <div v-html="contacts.legal_info"></div>
                    </template>
                </div>
            </div>
        </div>

        <iframe
            src="//intheplace.ru/brand-iframe"
            width="100%"
            height="62"
            scrolling="yes"
            frameborder="0"
        ></iframe>
    </footer>
</template>

<script setup lang="ts">
    import { ModalsDocs } from '#components';
    import { useModal } from 'vue-final-modal';
    import type { IDocument } from '~~/interfaces/document';
    import type { IContacts } from '~~/interfaces/contacts';

    const servicesStore = useServicesStore();

    const services = computed(() => servicesStore.services);

    const { content: docs, status: docsStatus } = await useCms<IDocument[]>('docs');
    const { content: contacts } = await useCms<IContacts>('contact', [
        'map_points.*',
        'map_points.contact_map_id.*',
    ]);

    function openDocsModal(date: string, title: string, content: string) {
        const { open: openPolicy, close: _closePolicy } = useModal({
            component: ModalsDocs,
            attrs: {
                dateUpdated: date,
                title,
                content,
                status: docsStatus.value,
                onClose() {
                    _closePolicy();
                },
            },
        });
        openPolicy();
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .footer {
        $p: &;
        $gap: rem(32);

        &__container {
            @include content-container;
        }
        &__wrapper {
            width: 100%;
            display: grid;
            grid-template-rows: repeat(3, auto);
            grid-template-areas:
                '. anchor'
                'logo body'
                'info body';
            gap: $gap;
            padding-bottom: rem(32);
            @media (max-width: 1240px) {
                grid-template-areas:
                    'logo anchor'
                    'body body'
                    'info info';
            }
            @media (max-width: 768px) {
                grid-template-areas:
                    'anchor anchor'
                    'logo logo'
                    'body body'
                    'info info';
            }
        }
        &__logo-container {
            grid-area: logo;
        }
        &__logo {
            display: block;
            &--full {
                width: rem(360);
                min-width: rem(360);
                height: rem(131);
                min-height: rem(131);
            }
            &--horizontal {
                width: rem(280);
                min-width: rem(280);
                height: rem(64);
                min-height: rem(64);
                display: none;
            }
            @media (max-width: 1240px) {
                &--full {
                    display: none;
                }
                &--horizontal {
                    display: block;
                }
            }
        }
        &__anchor {
            grid-area: anchor;
            align-items: flex-end;
            justify-self: flex-end;
            display: flex;
            align-items: center;
            gap: rem(4);
            font-size: lineScale(15, 13, 480, 1920);
            font-weight: $fw-bold;
            color: $c-082605;
            &-icon {
                rotate: -90deg;
                transition: translate $td $tf;
                @media (pointer: fine) {
                    @at-root #{$p}__anchor:hover & {
                        translate: 0 rem(-4);
                    }
                }
            }
        }
        &__body {
            grid-area: body;
            width: 100%;
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: $gap;
            @media (max-width: 768px) {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
            }
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(10);
            &--contact {
                align-items: flex-end;
                text-align: right;
                gap: rem(18);
                @media (max-width: 768px) {
                    text-align: initial;
                    align-items: initial;
                }
            }
            &-title {
                font-size: rem(14);
                font-weight: $fw-bold;
                opacity: 0.5;
                margin-bottom: rem(8);
            }
        }
        &__nav-link {
            cursor: pointer;
            font-family: 'Nuniti', sans-serif;
            font-size: lineScale(18, 16, 480, 1920);
            font-weight: $fw-semi;
            color: $c-082605;
            transition: translate $td $tf;
            @media (pointer: fine) {
                &:hover {
                    translate: rem(8) 0;
                }
            }
        }
        &__link {
            display: block;
            color: $c-082605;
            font-family: 'Nuniti', sans-serif;
            font-weight: $fw-semi;
            opacity: 0.8;
            white-space: nowrap;
            &--tel {
                font-size: lineScale(40, 24, 480, 1920);
            }
            &--mail {
                font-size: lineScale(24, 18, 480, 1920);
            }
        }
        &__socials {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            &-item {
                @media (pointer: fine) {
                    &:hover {
                        color: $c-082605;
                        &:nth-child(odd) {
                            rotate: -8.5deg;
                        }
                        &:nth-child(even) {
                            rotate: 5.5deg;
                        }
                    }
                }
            }
        }
        &__info {
            grid-area: info;
            display: flex;
            flex-direction: column;
            gap: rem(12);
            font-size: lineScale(16, 14, 480, 1920);
            opacity: 0.5;
        }
    }
</style>
