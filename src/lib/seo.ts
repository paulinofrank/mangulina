import type { Metadata } from "next";

export const SITE_NAME = "Mangulina";
// Canonical public origin. Preview hosts must never leak into production SEO.
export const SITE_URL = "https://mangulina.do";

export const DEFAULT_DESCRIPTION =
  "Explore Dominican artists, songs, albums, genres, awards, and music history.";
export const DEFAULT_OG_IMAGE = `${SITE_URL}/og-image-v2.png`;

export type SeoLocale = "en" | "es";

// Normalize an arbitrary route locale (e.g. the raw `[locale]` param) to a
// supported SeoLocale. Anything that isn't Spanish falls back to English.
export function resolveSeoLocale(locale: string | null | undefined): SeoLocale {
  return locale === "es" ? "es" : "en";
}

export function buildCanonical(path: string) {
  const normalizedPath = path === "/" ? "" : `/${path.replace(/^\/+|\/+$/g, "")}`;
  return `${SITE_URL}${normalizedPath || "/"}`;
}

export function localizedPath(path: string, locale: SeoLocale) {
  const normalized = `/${path.replace(/^\/+|\/+$/g, "")}`;
  if (locale === "es") return normalized === "/" ? "/es" : `/es${normalized}`;
  // English is the default locale. Under next-intl `localePrefix: "as-needed"`
  // it is served WITHOUT a prefix (/artists, not /en/artists), and /en/* only
  // 307-redirects to the unprefixed URL. The canonical/hreflang must therefore
  // point at the unprefixed path, never at /en/*.
  return normalized;
}

export function buildLocalizedCanonical(path: string, locale: SeoLocale) {
  return buildCanonical(localizedPath(path, locale));
}

// Spanish twin of an English path: "/" -> "/es", "/artists" -> "/es/artists".
export function spanishPath(path: string) {
  const normalized = `/${path.replace(/^\/+|\/+$/g, "")}`;
  return normalized === "/" ? "/es" : `/es${normalized}`;
}

// hreflang alternates shared by an English page and its Spanish twin.
// `x-default` points at the unprefixed English URL so search engines have a
// canonical fallback for unmatched languages/regions.
export function localeAlternates(path: string) {
  const enUrl = buildCanonical(localizedPath(path, "en"));
  return {
    en: enUrl,
    es: buildCanonical(spanishPath(path)),
    "x-default": enUrl,
  };
}

export function truncateDescription(text: string | null | undefined, fallback: string) {
  const clean = text?.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
  if (!clean) return fallback;
  if (clean.length <= 160) return clean;
  return `${clean.slice(0, 157).replace(/\s+\S*$/, "").trim()}...`;
}

export function artistSeoTitle(artist: { name: string }, locale: SeoLocale | string = "en") {
  return resolveSeoLocale(locale) === "es"
    ? `${artist.name} - Biografía, canciones y discografía`
    : `${artist.name} - Biography, Songs & Discography`;
}

export function songSeoTitle(recording: { recording_title: string }, locale: SeoLocale | string = "en") {
  return resolveSeoLocale(locale) === "es"
    ? `${recording.recording_title} - Información de la canción`
    : `${recording.recording_title} - Song Information`;
}

export function releaseSeoTitle(release: {
  title: string;
  type?: string | null;
  artist?: { name: string } | null;
  artists?: { name: string }[];
}, locale: SeoLocale | string = "en") {
  const isSpanish = resolveSeoLocale(locale) === "es";
  const artistNames = release.artists?.length
    ? release.artists.map((artist) => artist.name).join(" · ")
    : release.artist?.name;
  if (!artistNames) return `${release.title} - ${isSpanish ? "Información del lanzamiento" : "Release Information"}`;
  const type = release.type?.trim() || "Release";
  const normalizedType = type.toLowerCase();
  const spanishTypes: Record<string, string> = {
    album: "Álbum",
    compilation: "Compilación",
    ep: "EP",
    live: "En vivo",
    release: "Lanzamiento",
    single: "Sencillo",
    soundtrack: "Banda sonora",
  };
  const formattedType = isSpanish
    ? spanishTypes[normalizedType] ?? type
    : type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();
  return isSpanish
    ? `${release.title} - ${formattedType} de ${artistNames}`
    : `${release.title} - ${formattedType} by ${artistNames}`;
}

export function genreSeoTitle(genre: { title?: string; name?: string }, locale: SeoLocale | string = "en") {
  const name = genre.title ?? genre.name ?? (resolveSeoLocale(locale) === "es" ? "Género" : "Genre");
  return resolveSeoLocale(locale) === "es"
    ? `${name} - Artistas, canciones y álbumes`
    : `${name} Artists, Songs & Albums`;
}

type PageMetadataOptions = {
  title: string;
  description: string;
  path: string;
  image?: string | null;
  // Accepts either a resolved SeoLocale or the raw `[locale]` route param;
  // anything that isn't "es" is treated as English.
  locale?: SeoLocale | string;
  openGraphType?: "website" | "profile" | "article" | "music.song" | "music.album";
  noIndex?: boolean;
};

export function createPageMetadata({
  title,
  description,
  path,
  image,
  locale: rawLocale = "en",
  openGraphType = "website",
  noIndex = false,
}: PageMetadataOptions): Metadata {
  const locale = resolveSeoLocale(rawLocale);
  const canonical = buildLocalizedCanonical(path, locale);
  const imageUrl = image
    ? image.startsWith("http")
      ? image
      : buildCanonical(image)
    : DEFAULT_OG_IMAGE;

  return {
    title,
    description,
    alternates: {
      canonical,
      // hreflang annotations so search engines treat /es/<path> as the Spanish
      // equivalent of the English canonical.
      languages: localeAlternates(path),
    },
    openGraph: {
      type: openGraphType,
      siteName: SITE_NAME,
      locale: locale === "es" ? "es_DO" : "en_US",
      title,
      description,
      url: canonical,
      images: [
        {
          url: imageUrl,
          width: 1200,
          height: 630,
          type: image ? undefined : "image/png",
          alt: title,
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: [imageUrl],
    },
    robots: noIndex ? { index: false, follow: false } : undefined,
  };
}
