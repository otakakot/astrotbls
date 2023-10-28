import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
    site: "https://otakakot.github.io",
    base: '/doc',
    markdown: {
        shikiConfig: {
            theme: 'dark-plus',
            wrap: true,
        }
    }
});
