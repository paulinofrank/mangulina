import type { AppLocale } from "@/i18n/pathname";

const ONE_YEAR_IN_SECONDS = 365 * 24 * 60 * 60;

export function saveLocalePreference(locale: AppLocale) {
  document.cookie = `mangulina_locale=${locale}; Max-Age=${ONE_YEAR_IN_SECONDS}; Path=/; SameSite=Lax`;
}
