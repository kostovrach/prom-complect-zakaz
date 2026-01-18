export default defineNuxtConfig({
    compatibilityDate: '2025-07-15',
    ssr: true,
    devtools: { enabled: false },

    typescript: {
        strict: true,
        typeCheck: true,
    },

    app: {
        head: {
            title: 'ПКЗ',
            htmlAttrs: {
                lang: 'ru',
            },
            link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.svg' }],
            meta: [
                { name: 'robots', content: 'index, follow' },
                { property: 'og:type', content: 'website' },
                { name: 'theme-color', content: '#EBEBEB' },
            ],
        },
    },

    runtimeConfig: {
        public: {
            cmsUrl: process.env.DIRECTUS_URL || 'http://localhost:8055',
            siteUrl: process.env.SITE_URL || 'http://localhost:3000',
            appEnv: (process.env.APP_ENV || 'prod') as 'dev' | 'prod',
        },
        smtp: {
            host: process.env.SMTP_HOST || '',
            port: process.env.SMTP_PORT || '',
            user: process.env.SMTP_USER || '',
            pass: process.env.SMTP_PASS || '',
            target: process.env.SMTP_TARGET || '',
        },
        directus: {
            url: process.env.DIRECTUS_URL || 'http://localhost:8055',
            readToken: process.env.DIRECTUS_READ_TOKEN || '',
            crudToken: process.env.DIRECTUS_CRUD_TOKEN || '',
        },
    },

    modules: [
        '@pinia/nuxt',
        '@nuxt/eslint',
        'nuxt-svg-sprite-icon',
        '@vueuse/nuxt',
        '@primevue/nuxt-module',
        '@vue-final-modal/nuxt',
        'vue-yandex-maps/nuxt',
    ],

    css: ['vue-final-modal/style.css', '~/assets/css/main.css'],

    // -------------------------svg-sprite--------------------------
    svgSprite: {
        input: './app/assets/svg',
        output: './app/assets/svg/gen',
        defaultSprite: 'icons',
        elementClass: 'icon',
        optimize: false,
    },
    // ------------------------------------------------------------

    // -------------------vue-yandex-maps--------------------------
    yandexMaps: {
        apikey: process.env.YANDEX_API_KEY || 'empty',
        strictMode: true,
        lang: 'ru_RU',
        version: 'v3',
    },
    // ------------------------------------------------------------

    // ------------------------Алиасы и тд.------------------------
    build: {
        transpile: ['@fancyapps/ui', 'fancyapps-ui'],
    },
    alias: {
        'fancyapps-ui': './@fancyapps/ui/dist/index.esm.js',
    },
    // ------------------------------------------------------------
});
