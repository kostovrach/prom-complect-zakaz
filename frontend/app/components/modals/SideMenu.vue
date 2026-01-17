<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-menu">
            <ButtonCross class="modal-menu__close" @click="emit('close')" />
            <div class="modal-menu__content">
                <nav class="modal-menu__nav">
                    <NuxtLink
                        v-for="(link, idx) in navLinks"
                        :key="idx"
                        :class="[
                            'modal-menu__nav-link',
                            { 'modal-menu__nav-link--current': route.name === link.to },
                        ]"
                        :to="{ name: link.to }"
                    >
                        <span>{{ link.label }}</span>
                    </NuxtLink>
                    <template v-if="docs?.length">
                        <button
                            v-for="doc in docs"
                            :key="doc.id"
                            class="modal-menu__nav-link"
                            @click="
                                openDocsModal(
                                    doc.date_updated ?? doc.date_created,
                                    doc.title,
                                    doc.content
                                )
                            "
                        >
                            <span>{{ doc.title }}</span>
                        </button>
                    </template>
                </nav>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import type { IDocument } from '~~/interfaces/document';

    import { useModal, VueFinalModal } from 'vue-final-modal';
    import { ModalsDocs } from '#components';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const route = useRoute();

    const { content: docs, status: docsStatus } = await useCms<IDocument[]>('docs');

    const navLinks: {
        label: string;
        to: string;
    }[] = [
        {
            label: 'Главная',
            to: 'index',
        },
        {
            label: 'О компании',
            to: 'about',
        },
        {
            label: 'Партнерам',
            to: 'co',
        },
        {
            label: 'Полезные материалы',
            to: 'blog',
        },
        {
            label: 'Подбор оборудования',
            to: 'quiz',
        },
        {
            label: 'Контакты',
            to: 'contact',
        },
    ];

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

    .modal-menu {
        $p: &;
        $px: rem(32);

        position: absolute;
        top: 0;
        right: 0;
        width: 100%;
        max-width: rem(540);
        height: 100vh;
        color: $c-FFFFFF;
        background-color: $c-accent;
        &__container {
            position: relative;
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: $px 0;
        }
        &__close {
            position: absolute;
            top: rem(32);
            right: rem(32);
            cursor: pointer;
        }
        &__content {
            padding: calc(rem(32) + rem(64)) 0 rem(32);
        }
        &__nav {
            display: flex;
            flex-direction: column;
            &-link {
                cursor: pointer;
                position: relative;
                width: 100%;
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(32, 24, 480, 1920);
                font-weight: $fw-semi;
                padding: rem(12) rem(32);
                transition: color $td $tf;
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 0;
                    top: 0;
                    left: 0;
                    width: 0;
                    height: 100%;
                    background-color: $c-FFF3B0;
                    clip-path: polygon(100% 0, 100% 60%, 90% 100%, 0 100%, 0 0);
                    transition: width $td $tf;
                }
                @media (pointer: fine) {
                    &:hover {
                        color: $c-1C3A19;
                        &::before {
                            width: 100%;
                        }
                    }
                }
                &--current {
                    color: $c-1C3A19;
                    pointer-events: none;
                    &::before {
                        width: 100%;
                    }
                }
                > span {
                    position: relative;
                    z-index: 1;
                }
            }
        }
    }
</style>
