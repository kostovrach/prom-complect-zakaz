<template>
    <SvgIcon :name="props.type" :width="props.size" :height="props.size" :style="`color: ${props.color}`" />
</template>

<script setup lang="ts">
    const props = withDefaults(defineProps<{
        type: string;
        size?: string | number;
        color?: string;
    }>(), {
        type: '',
        size: 24,
        color: 'currentColor'
    });
</script>
