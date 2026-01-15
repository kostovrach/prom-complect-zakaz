<template>
    <div class="page">
        <TheHeader />
        <main class="content">
            <slot></slot>
        </main>
        <TheFooter />
    </div>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .page {
        min-height: 100lvh;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        overflow-x: clip;
    }
    .content {
        position: relative;
        z-index: 2;
        background-color: $c-main;
        border-radius: 0 0 $border-radius $border-radius;
    }
</style>
