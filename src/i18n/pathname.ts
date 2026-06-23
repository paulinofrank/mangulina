// Locale type re-exported from the routing config (single source of truth).
// URL/locale manipulation now lives in next-intl's middleware and the
// `@/i18n/navigation` helpers, so the old /es string helpers were removed.
export type { AppLocale } from "./routing";
