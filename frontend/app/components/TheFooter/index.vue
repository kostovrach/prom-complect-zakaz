<template>
    <footer ref="containerRef" class="footer">
        <div class="footer__container"></div>
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
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .footer {
        $p: &;

        &__container {
            @include content-container;
        }
    }
</style>
