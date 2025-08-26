// @ts-check
import { defineConfig } from 'astro/config';
import svelte from '@astrojs/svelte';
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';
import compress from 'astro-compress';
import vercel from '@astrojs/vercel/serverless';

// https://astro.build/config
export default defineConfig({
  site: process.env.VERCEL_URL ? `https://${process.env.VERCEL_URL}` : 'https://invoiceflow.com',
  output: 'server',
  adapter: vercel({
    webAnalytics: {
      enabled: true
    },
    imageService: true,
    imagesConfig: {
      sizes: [320, 640, 768, 1024, 1280, 1600],
      domains: ['invoiceflow.com'],
      formats: ['image/webp', 'image/avif']
    }
  }),
  integrations: [
    svelte(),
    sitemap({
      changefreq: 'weekly',
      priority: 0.7,
      lastmod: new Date(),
      entryLimit: 10000,
    }),
    compress({
      CSS: true,
      HTML: true,
      Image: false,
      JavaScript: true,
      SVG: true,
    })
  ],
  vite: {
    plugins: [tailwindcss()],
    build: {
      cssCodeSplit: true,
      rollupOptions: {
        output: {
          manualChunks: {
            vendor: ['astro']
          }
        }
      }
    }
  },
  build: {
    inlineStylesheets: 'auto'
  },
  compressHTML: true
});