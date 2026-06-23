import { getRequestConfig } from "next-intl/server";
import { routing } from "./routing";

export default getRequestConfig(async ({ requestLocale }) => {
  // `requestLocale` is derived from the [locale] route segment (the URL),
  // which is the source of truth. Fall back to the default for non-localized
  // routes (admin, api, auth) where no segment is present.
  const requested = await requestLocale;
  const locale = routing.locales.includes(requested as (typeof routing.locales)[number])
    ? (requested as string)
    : routing.defaultLocale;

  return {
    locale,
    messages: (await import(`../../messages/${locale}.json`)).default,
  };
});
