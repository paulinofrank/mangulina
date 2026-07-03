import type { AppLocale } from "@/i18n/pathname";
import { LOCALE_COOKIE_MAX_AGE, LOCALE_COOKIE_NAME } from "@/i18n/routing";

export function getSavedLocalePreference(): AppLocale | null {
  const value = document.cookie
    .split("; ")
    .find((cookie) => cookie.startsWith(`${LOCALE_COOKIE_NAME}=`))
    ?.split("=")[1];

  return value === "en" || value === "es" ? value : null;
}

export function getBrowserLocalePreference(): AppLocale | null {
  const languages = navigator.languages?.length ? navigator.languages : [navigator.language];
  const language = languages
    .map((value) => value.toLowerCase().split("-")[0])
    .find((value) => value === "en" || value === "es");

  return language === "en" || language === "es" ? language : null;
}

export function saveLocalePreference(locale: AppLocale) {
  const secure = window.location.protocol === "https:" ? "; Secure" : "";

  document.cookie = [
    `${LOCALE_COOKIE_NAME}=${locale}`,
    `Max-Age=${LOCALE_COOKIE_MAX_AGE}`,
    "Path=/",
    "SameSite=Lax",
  ].join("; ") + secure;
}
