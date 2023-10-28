import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
    base: '/doc',
    markdown: {
        shikiConfig: {
            theme: 'dark-plus',
            wrap: true,
        }
    }
});
