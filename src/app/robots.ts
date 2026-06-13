import type { MetadataRoute } from "next";

import { buildCanonical } from "@/lib/seo";

const isProductionDomain =
  process.env.VERCEL_ENV === "production" &&
  process.env.NEXT_PUBLIC_SITE_URL?.includes("mangulina");

export default function robots(): MetadataRoute.Robots {
  if (!isProductionDomain) {
    return {
      rules: {
        userAgent: "*",
        disallow: "/",
      },
    };
  }

  return {
    rules: {
      userAgent: "*",
      allow: "/",
      disallow: ["/admin", "/admin/", "/api/", "/auth/", "/debug"],
    },
    sitemap: buildCanonical("/sitemap.xml"),
    host: buildCanonical("/"),
  };
}