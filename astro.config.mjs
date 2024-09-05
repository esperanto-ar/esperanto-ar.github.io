import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";

import preact from "@astrojs/preact";




// https://astro.build/config
export default defineConfig({
  server: {
    port: 3000,
    host: true
  },
  integrations: [tailwind(), preact()]
});