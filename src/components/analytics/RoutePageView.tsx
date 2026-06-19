"use client";

import { useEffect, useRef } from "react";
import { usePathname } from "next/navigation";
import { trackPageView } from "@/lib/analytics";

function describeRoute(path: string) {
  if (path === "/") return { page_type: "home" };

  const segments = path.split("/").filter(Boolean);
  const section = segments[0] ?? "page";
  const entitySlug = segments.length > 1 ? segments.at(-1) : undefined;

  if (section === "releases") {
    if (segments.length === 1) return { page_type: "releases_hub" };
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
    page_type: segments.length > 1 ? singularSection : section,
    entity_slug: entitySlug,
  };
}

export default function RoutePageView() {
  const path = usePathname();
  const lastTrackedPath = useRef<string | null>(null);

  useEffect(() => {
    if (!path || path.startsWith("/admin") || path.startsWith("/auth")) return;
    if (lastTrackedPath.current === path) return;
    lastTrackedPath.current = path;

    trackPageView({
      path,
      ...describeRoute(path),
      referrer: document.referrer || undefined,
      source: "web",
    });
  }, [path]);

  return null;
}
