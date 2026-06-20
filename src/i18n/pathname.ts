export type AppLocale = "en" | "es";

const SPANISH_PREFIX = /^\/es(?=\/|$)/;

function normalizePathname(pathname: string) {
  if (!pathname || pathname === "/") return "/";
  return pathname.startsWith("/") ? pathname : `/${pathname}`;
}

export function getLocaleFromPathname(pathname: string): AppLocale {
  return SPANISH_PREFIX.test(normalizePathname(pathname)) ? "es" : "en";
}

export function addSpanishPrefix(pathname: string): string {
  const normalizedPathname = normalizePathname(pathname);

  if (getLocaleFromPathname(normalizedPathname) === "es") {
    return normalizedPathname;
  }

  return normalizedPathname === "/" ? "/es" : `/es${normalizedPathname}`;
}

export function removeSpanishPrefix(pathname: string): string {
  const normalizedPathname = normalizePathname(pathname);

  if (getLocaleFromPathname(normalizedPathname) === "en") {
    return normalizedPathname;
  }

  return normalizedPathname.slice(3) || "/";
}

export function getAlternateLocalePath(pathname: string): string {
  return getLocaleFromPathname(pathname) === "es"
    ? removeSpanishPrefix(pathname)
    : addSpanishPrefix(pathname);
}

export function getPathForLocale(pathname: string, locale: AppLocale): string {
  return locale === "es"
    ? addSpanishPrefix(pathname)
    : removeSpanishPrefix(pathname);
}
