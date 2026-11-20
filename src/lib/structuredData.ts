import { buildCanonical, buildLocalizedCanonical, resolveSeoLocale, SITE_NAME, SITE_URL, type SeoLocale } from "@/lib/seo";

export type BreadcrumbItem = {
  name: string;
  path: string;
};

export const websiteReference = {
  "@type": "WebSite",
  name: SITE_NAME,
  url: SITE_URL,
};

export function absoluteUrl(pathOrUrl: string, locale?: SeoLocale | string) {
  return /^https?:\/\//i.test(pathOrUrl)
    ? pathOrUrl
    : locale
      ? buildLocalizedCanonical(pathOrUrl, resolveSeoLocale(locale))
      : buildCanonical(pathOrUrl);
}

export function breadcrumbSchema(items: BreadcrumbItem[], locale?: SeoLocale | string) {
  return {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: items.map((item, index) => ({
      "@type": "ListItem",
      position: index + 1,
      name: item.name,
      item: absoluteUrl(item.path, locale),
    })),
  };
}

export function collectionPageSchema({
  name,
  description,
  path,
}: {
  name: string;
  description: string;
  path: string;
}) {
  return {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name,
    description,
    url: buildCanonical(path),
    isPartOf: websiteReference,
  };
}

export function isoDuration(milliseconds: number | null | undefined) {
  if (!milliseconds || milliseconds <= 0) return undefined;
  const totalSeconds = milliseconds < 1000 ? Math.round(milliseconds) : Math.round(milliseconds / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;
  return `PT${minutes ? `${minutes}M` : ""}${seconds}S`;
}
