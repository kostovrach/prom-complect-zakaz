<template>
    <NuxtLayout>
        <section class="contact">
            <div class="contact__container">
                <div class="contact__map">
                    <MapWrapper
                        :markers="
                            content?.map_points.map((el) => ({
                                title: el.contact_map_id.title ?? '',
                                subtitle: el.contact_map_id.subtitle ?? null,
                                point: el.contact_map_id.point,
                            })) ?? []
                        "
                    />
                </div>
                <div class="contact__body">
                    <h1 class="contact__title">Контакты</h1>
                    <ul class="contact__list">
                        <li v-if="content?.phone" class="contact__item">
                            <div class="contact__item-body">
                                <ButtonRolling
                                    class="contact__item-link"
                                    type="a"
                                    :href="`tel:${content.phone.trim().replace(/\s+/g, '')}`"
                                >
                                    {{ content.phone }}
                                </ButtonRolling>
                            </div>
                            <p class="contact__item-desc">Наш номер</p>
                        </li>
                        <li v-if="content?.email" class="contact__item">
                            <div class="contact__item-body">
                                <ButtonRolling
                                    class="contact__item-link"
                                    type="a"
                                    :href="`mailto:${content.email.trim().replace(/\s+/g, '')}`"
                                >
                                    {{ content.email }}
                                </ButtonRolling>
                            </div>
                            <p class="contact__item-desc">Для обратной связи и предложений</p>
                        </li>
                        <li v-if="content?.vk || content?.ok || content?.tg" class="contact__item">
                            <div class="contact__item-body contact__item-body--socials">
                                <ButtonRolling
                                    v-if="content.vk"
                                    class="contact__item-link"
                                    type="a"
                                    target="_blank"
                                    :href="content.vk.trim().replace(/\s+/g, '')"
                                    rel="noopener noreferrer"
                                >
                                    VK
                                </ButtonRolling>
                                <ButtonRolling
                                    v-if="content.tg"
                                    class="contact__item-link"
                                    type="a"
                                    target="_blank"
                                    :href="content.tg.trim().replace(/\s+/g, '')"
                                    rel="noopener noreferrer"
                                >
                                    Telegram
                                </ButtonRolling>
                                <ButtonRolling
                                    v-if="content.ok"
                                    class="contact__item-link"
                                    type="a"
                                    target="_blank"
                                    :href="content.ok.trim().replace(/\s+/g, '')"
                                    rel="noopener noreferrer"
                                >
                                    OK
                                </ButtonRolling>
                            </div>
                            <p class="contact__item-desc">Мы в соцсетях</p>
                        </li>
                        <li v-if="content?.address" class="contact__item">
                            <div class="contact__item-body">
                                <ButtonRolling
                                    type="button"
                                    class="contact__item-link contact__item-link--static"
                                    button-type="button"
                                >
                                    {{ content.address }}
                                </ButtonRolling>
                            </div>
                            <p v-if="content.address_description" class="contact__item-desc">
                                {{ content.address_description }}
                            </p>
                        </li>
                    </ul>
                    <ButtonPrimary
                        v-if="content?.map_link"
                        class="contact__button"
                        type="a"
                        target="_blank"
                        :href="content.map_link.trim().replace(/\s+/g, '')"
                        :overlay-size="75"
                    >
                        <span>Построить маршрут</span>
                    </ButtonPrimary>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IContacts } from '~~/interfaces/contacts';
    import type { ISeoSettings } from '~~/interfaces/seo-settings';

    interface IPage extends ISeoSettings {
        id: string | number;
        date_created: string;
        date_updated: string | null;
    }

    const { content } = await useCms<IContacts>('contact', [
        'map_points.*',
        'map_points.contact_map_id.*',
    ]);

    const { content: page } = await useCms<IPage>('contact_page');

    // SEO & Meta ==================================================
    useHead({
        title: page.value?.meta_title ?? '',
        meta: [
            { name: 'description', content: page.value?.meta_description ?? '' },
            { name: 'robots', content: page.value?.meta_robots ?? 'index, follow' },
            { name: 'keywords', content: page.value?.meta_keywords ?? [] },

            { property: 'og:title', content: page.value?.meta_title ?? '' },
            { property: 'og:description', content: page.value?.meta_description ?? '' },
            { property: 'og:type', content: page.value?.og_type ?? 'website' },
            { property: 'og:image', content: page.value?.og_image_url ?? '' },
            { property: 'og:url', content: useRequestURL().href },

            { name: 'twitter:card', content: 'summary_large_image' },
            { name: 'twitter:title', content: page.value?.meta_title ?? '' },
        ],
    });

    if (page.value?.shema_markup) {
        useHead({
            script: [
                {
                    type: 'application/ld+json',
                    innerHTML: page.value.shema_markup || {},
                },
            ],
        });
    }
    // =============================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .contact {
        @include content-block;
        &__container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(64);
            margin: rem(64) 0;
            overflow: visible;
            @include content-container;
            @media (max-width: 1024px) {
                display: flex;
                flex-direction: column-reverse;
            }
        }
        &__map {
            width: 100%;
            height: 100%;
            clip-path: polygon(40% 0, 100% 0, 100% 60%, 60% 100%, 0 100%, 0 40%);
            @media (max-width: 1024px) {
                height: rem(480);
            }
        }
        &__body {
            display: flex;
            flex-direction: column;
            gap: lineScale(48, 32, 480, 1920);
        }
        &__title {
            font-family: 'Nuniti', sans-serif;
            text-transform: uppercase;
            font-weight: $fw-bold;
            font-size: lineScale(44, 30, 480, 1920);
            line-height: 1.2;
            max-width: 35ch;
            @media (max-width: 1024px) {
                max-width: initial;
                text-align: center;
            }
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__item {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            &-body {
                &--socials {
                    display: flex;
                    align-items: center;
                    flex-wrap: wrap;
                    gap: rem(16);
                }
            }
            &-link {
                cursor: pointer;
                display: block;
                overflow: hidden;
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(40, 24, 480, 1920);
                font-weight: $fw-bold;
                &--static {
                    pointer-events: none;
                }
            }
            &-desc {
                font-size: lineScale(18, 16, 480, 1920);
            }
        }
    }
</style>
