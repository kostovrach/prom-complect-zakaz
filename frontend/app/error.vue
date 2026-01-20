<template>
    <NuxtLayout name="dark">
        <section class="not-found" @mousemove="mouseMoveHandler" @mouseleave="mouseLeaveHandler">
            <div class="not-found__container">
                <div class="not-found__content">
                    <h1 class="not-found__title">Страница не найдена</h1>
                    <p class="not-found__desc">
                        Мы не смогли найти запрашиваемую вами страницу. При проблемах работы с
                        сайтом напишите в службу технической поддержки
                    </p>
                    <ButtonPrimary
                        class="not-found__button"
                        type="NuxtLink"
                        :to="{ name: 'index' }"
                        theme="yellow"
                    >
                        <span>На главную</span>
                    </ButtonPrimary>
                </div>
                <div class="not-found__anim">
                    <span
                        v-for="(n, idx) in intensities"
                        :key="n"
                        :style="{
                            transition: transitionEnabled
                                ? `transform ${RETURN_DIRATION} ease-out`
                                : 'none',
                            transform: `translate(${animOffsets[idx]?.x ?? 0}px, ${animOffsets[idx]?.y ?? 0}px)`,
                        }"
                    >
                        404
                    </span>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    const MAX_OFFSET = 64;
    const RETURN_DIRATION = '0.6s';
    const transitionEnabled = ref(false);

    const { width: windowWidth, height: windowHeight } = useWindowSize();

    const intensities = [0, 0.2, 0.4, 0.6, 0.8, 1];
    const initialOffsets = reactive([
        { x: -3, y: 3 },
        { x: -6, y: 6 },
        { x: -9, y: 9 },
        { x: -12, y: 12 },
        { x: -15, y: 15 },
        { x: -18, y: 18 },
    ]);

    const animOffsets = reactive([...initialOffsets]);

    function mouseMoveHandler(event: MouseEvent) {
        const centerX = windowWidth.value / 2;
        const centerY = windowHeight.value / 2;

        const mouseX = (event.clientX - centerX) / centerX;
        const mouseY = (event.clientY - centerY) / centerY;

        initialOffsets.forEach((layer, index) => {
            const intensity = intensities[index] ?? 0;
            const initialOffset = layer ?? { x: 0, y: 0 };

            const offsetX = mouseX * MAX_OFFSET * intensity + initialOffset.x;
            const offsetY = mouseY * MAX_OFFSET * intensity + initialOffset.y;

            transitionEnabled.value = false;
            animOffsets[index] = { x: offsetX, y: offsetY };
        });
    }

    function mouseLeaveHandler() {
        transitionEnabled.value = true;

        initialOffsets.forEach((layer, index) => {
            animOffsets[index] = layer;
        });
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;
    @use 'sass:math';

    .not-found {
        width: 100vw;
        color: $c-FFFFFF;
        background-color: $c-1C3A19;
        margin: 0;
        overflow-x: clip;
        @include right-corner;
        &__container {
            min-height: 100lvh;
            display: grid;
            grid-template-columns: 40% auto;
            align-items: center;
            gap: rem(64);
            @include content-container($max-width: rem(1440));
            @media (max-width: 768px) {
                grid-template-columns: 100%;
                grid-template-rows: 60% 20%;
                gap: 0;
            }
        }
        &__title {
            color: $c-FFFFFF;
            line-height: 1.2;
            @include title-primary($text-align: initial);
        }
        &__desc {
            color: $c-EBEBEB;
            font-size: lineScale(18, 16, 480, 1920);
            line-height: 1.2;
            margin-top: rem(24);
        }
        &__button {
            margin-top: rem(96);
        }
        &__anim {
            --return-duration: #{$td};

            position: relative;
            user-select: none;
            > span {
                display: block;
                position: absolute;
                top: 50%;
                left: 50%;
                translate: -50% -50%;
                font-family: 'Nuniti', sans-serif;
                font-size: lineScale(320, 180, 480, 1440);
                line-height: 1;
                font-weight: $fw-bold;
                text-stroke: rem(4) $c-FFF3B0;
                -webkit-text-stroke: rem(4) $c-FFF3B0;
                color: rgba($c-4E6A4C, 0.5);
                color: transparent;

                $count: 6;
                $step: math.div(1, $count - 1);

                @for $i from 1 through $count {
                    &:nth-child(#{$i}) {
                        opacity: #{1 - ($i - 1) * $step};
                    }
                }
                &:last-child {
                    opacity: 0.1;
                }
            }
        }
    }
</style>
