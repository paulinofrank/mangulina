"use client";

import { useEffect, useRef } from "react";
import { usePathname } from "next/navigation";
import { trackPageView } from "@/lib/analytics";
import { describeAnalyticsRoute } from "@/lib/analyticsRoute";

export default function RoutePageView() {
  const path = usePathname();
  const lastTrackedPath = useRef<string | null>(null);

  useEffect(() => {
    if (!path) return;
    if (lastTrackedPath.current === path) return;

    const route = describeAnalyticsRoute(path);
    if (!route) return;

    lastTrackedPath.current = path;

    trackPageView({
      path,
      ...route,
      referrer: document.referrer || undefined,
      source: "web",
    });
  }, [path]);

  return null;
}
