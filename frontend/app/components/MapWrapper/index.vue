<template>
    <ClientOnly>
        <YandexMap
            class="map"
            @click="markersIdx = null"
            @mouseleave="markersIdx = null"
            :settings="{
                location: {
                    center: props.center,
                    zoom: props.zoom,
                },
                theme: 'dark',
            }"
        >
            <YandexMapDefaultSchemeLayer />
            <YandexMapDefaultFeaturesLayer />
            <YandexMapControls :settings="{ position: 'right' }">
                <YandexMapZoomControl />
                <YandexMapGeolocationControl />
            </YandexMapControls>
            <YandexMapControls :settings="{ position: 'left top' }">
                <YandexMapOpenMapsButton />
            </YandexMapControls>
            <YandexMapUiMarker
                v-for="(marker, idx) in props.markers"
                :key="idx"
                :settings="{
                    onClick: () => (markersIdx === idx ? (markersIdx = null) : (markersIdx = idx)),
                    coordinates: marker.point.coordinates,
                    color: 'blue',
                    popup: { show: markersIdx === idx, position: 'bottom right', offset: 10 },
                }"
            >
                <template #popup>
                    <div class="map__marker">
                        <div class="map__marker-title">
                            {{ marker.title }}
                        </div>
                        <div class="map__marker-subtitle" v-if="marker.subtitle">
                            {{ marker.subtitle }}
                        </div>
                    </div>
                </template>
            </YandexMapUiMarker>
            <YandexMapSignpost
                :settings="{
                    points: props.markers.map((el) => el.point.coordinates),
                }"
            />
        </YandexMap>
    </ClientOnly>
</template>

<script setup lang="ts">
    import type { LngLat } from '@yandex/ymaps3-types';

    import {
        YandexMap,
        YandexMapDefaultSchemeLayer,
        YandexMapDefaultFeaturesLayer,
        YandexMapUiMarker,
        YandexMapControls,
        YandexMapZoomControl,
        YandexMapSignpost,
        YandexMapGeolocationControl,
        YandexMapOpenMapsButton,
    } from 'vue-yandex-maps';

    const props = withDefaults(
        defineProps<{
            markers: {
                title: string;
                subtitle: string | null;
                point: {
                    coordinates: LngLat;
                    type: string;
                };
            }[];
            center?: LngLat;
            zoom?: number;
        }>(),
        {
            markers: () => [],
            center: () => [50.18, 53.22],
            zoom: 8,
        }
    );

    // state
    const markersIdx = ref<number | null>(null);
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .map {
        $p: &;
        &__marker {
            &-title {
            }
            &-subtitle {
            }
        }
    }
</style>
