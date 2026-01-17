<template>
    <section v-if="content && content.markers.length" class="c-points">
        <div class="c-points__container">
            <picture class="c-points__bg-container">
                <img class="c-points__bg" :src="content.cover_url" alt="#" />
            </picture>
            <div class="c-points__overlay">
                <template
                    v-for="(point, idx) in content.markers
                        .map((el) => el.points_markers_id)
                        .slice(0, 8)"
                    :key="point.id"
                >
                    <button
                        v-if="point.video"
                        class="c-points__item"
                        type="button"
                        :style="positions[idx % positions.length]"
                        @click="openVideoModal(point.video)"
                    >
                        <picture class="c-points__item-image-container">
                            <img
                                class="c-points__item-image"
                                :src="point.image_url"
                                :alt="point.title ?? '#'"
                            />
                        </picture>
                        <h3 class="c-points__item-title">{{ point.title }}</h3>
                    </button>
                </template>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import { ModalsVideo } from '#components';
    import { useModal } from 'vue-final-modal';
    import type { IDirectusFile } from '~~/interfaces/directus-file';

    interface IContent {
        id: string | number;
        date_created: string;
        date_updated: string | null;
        cover: string;
        cover_url?: string;
        markers: {
            id: string | number;
            points_id: any;
            points_markers_id: {
                id: string | number;
                date_created: string;
                date_updated: string | null;
                title: string;
                image: string;
                image_url?: string;
                video: IDirectusFile;
            };
        }[];
    }

    const { content } = await useCms<IContent>('points', [
        'markers.*',
        'markers.points_markers_id.*',
        'markers.points_markers_id.video.*',
    ]);

    const positions = [
        { top: '45%', left: '20%' },
        { top: '20%', left: '35%' },
        { top: '70%', left: '10%' },
        { top: '50%', left: '70%' },
        { top: '30%', left: '55%' },
        { top: '10%', left: '10%' },
        { top: '60%', left: '40%' },
        { top: '10%', left: '70%' },
    ];

    function openVideoModal(file: IDirectusFile) {
        const { open: _openVideo, close: _closeVideo } = useModal({
            component: ModalsVideo,
            attrs: {
                file,
                onClose() {
                    _closeVideo();
                },
            },
        });
        _openVideo();
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .c-points {
        $p: &;

        @include content-block;
        &__container {
            position: relative;
            height: 75lvh;
            min-height: rem(580);
            @media (max-width: 768px) {
                display: none;
            }
            @include content-container;
        }
        &__bg-container {
            width: 100%;
            height: 100%;
            pointer-events: none;
            filter: brightness(60%);
            @include double-corner;
        }
        &__bg {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__overlay {
            position: absolute;
            z-index: 2;
            inset: 0;
        }
        &__item {
            cursor: pointer;
            position: absolute;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(16);
            &-title {
                max-width: 22ch;
                font-size: lineScale(24, 18, 480, 1920);
                line-height: 1.2;
                text-align: center;
                font-weight: $fw-semi;
                color: $c-FFFFFF;
            }
            &-image-container {
                position: relative;
                width: rem(96);
                height: rem(60);
                mask-image: url('/img/masks/favicon-mask.svg');
                mask-size: cover;
                mask-position: center;
                mask-repeat: no-repeat;
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 1;
                    inset: 0;
                    background-color: $c-FFF3B0;
                    transition: background-color $td $tf;
                    #{$p}__item:hover & {
                        background-color: transparent;
                    }
                }
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
    }
</style>
