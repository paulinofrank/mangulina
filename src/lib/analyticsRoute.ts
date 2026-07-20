import { routing } from "@/i18n/routing";

export type AnalyticsRouteDescription = {
  page_type: string;
  entity_slug?: string;
};

function isSupportedLocale(segment: string | undefined): boolean {
  return Boolean(segment && routing.locales.some((locale) => locale === segment));
}

export function describeAnalyticsRoute(path: string): AnalyticsRouteDescription | null {
  const pathname = path.split(/[?#]/, 1)[0] || "/";
  const segments = pathname.split("/").filter(Boolean);
  const normalizedSegments = isSupportedLocale(segments[0]) ? segments.slice(1) : segments;

  const section = normalizedSegments[0];
  if (section === "admin" || section === "auth") return null;
  if (!section) return { page_type: "home" };

  const entitySlug = normalizedSegments.length > 1 ? normalizedSegments.at(-1) : undefined;

  if (section === "releases") {
    if (normalizedSegments.length === 1) return { page_type: "releases_hub" };
    if (/^\d{4}s$/.test(entitySlug ?? "")) {
      return { page_type: "release_decade", entity_slug: entitySlug };
    }
    if (["albums", "singles", "eps", "compilations", "live", "soundtracks"].includes(entitySlug ?? "")) {
      return { page_type: "release_type", entity_slug: entitySlug };
    }
    if (["essential", "most-viewed", "recent"].includes(entitySlug ?? "")) {
      return { page_type: `release_${entitySlug}`, entity_slug: entitySlug };
    }
    return { page_type: "release", entity_slug: entitySlug };
  }

  const singularSection = section.endsWith("s") ? section.slice(0, -1) : section;
  return {
    page_type: normalizedSegments.length > 1 ? singularSection : section,
    entity_slug: entitySlug,
  };
}
