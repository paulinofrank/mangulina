import { defineRouting } from "next-intl/routing";

export const routing = defineRouting({
  locales: ["en", "es"],
  defaultLocale: "en",
  // English keeps clean URLs (/artists); Spanish is prefixed (/es/artists).
  localePrefix: "as-needed",
  // The URL is the single source of truth. The cookie only remembers a
  // preference for the switcher — it must never trigger an automatic redirect.
  localeDetection: false,
  localeCookie: {
    name: "mangulina_locale",
  },
});

export type AppLocale = (typeof routing.locales)[number];
