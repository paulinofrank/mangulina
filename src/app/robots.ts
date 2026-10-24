import type { MetadataRoute } from "next";

import { buildCanonical } from "@/lib/seo";

// Indexing is deliberately opt-in so connecting or previewing a deployment
// cannot expose the site to crawlers before the official launch.
const allowSearchIndexing =
  process.env.VERCEL_ENV === "production" &&
  process.env.ALLOW_SEARCH_INDEXING === "true";

const INTERNAL_PATHS = [
  "/admin",
  "/admin/",
  "/api/",
  "/auth/",
  "/debug",
  "/_next/image",
];

/**
 * Paths crawlers are kept out of: everything internal, plus site search.
 *
 * Search result pages are user-driven and effectively unbounded — every query
 * is another crawlable URL with no standalone value, and the catalog they
 * point at is already covered by the sitemap. Blocking the crawl is the
 * smallest mechanism that works: metadata `noindex` would fight the existing
 * canonical to /search, and the site publishes no SearchAction markup that
 * depends on /search being crawlable.
 */
/**
 * Faceted-navigation parameters, blocked wherever they appear.
 *
 * The public listings — release types and decades, the artist role
 * directories, provinces, the birthday hub — are server-rendered per request
 * and accept sort/page/filter query strings. A crawler following their own
 * pagination and filter links multiplies those into an effectively unbounded
 * set of distinct URLs, every one an uncached origin render. None of them is
 * separately indexable: each listing canonicalises to its bare path (see
 * metadataForReleaseType and createArtistDirectoryMetadata), so the
 * parameterised forms are duplicates by construction.
 *
 * Discovery does not depend on them either. Every artist, song and release
 * profile is enumerated directly in the segmented child sitemaps
 * (sitemapCatalog.ts), so a crawler never needs to page through a listing to
 * reach the catalogue. This is the argument that already keeps crawlers out
 * of /search, applied to the same problem one level up.
 *
 * The bare listing paths stay fully crawlable — only the query forms are
 * denied.
 *
 * Two parameters are deliberately absent:
 *
 * `page`, because it is linear rather than multiplicative and is the site's
 * real crawl path into the catalogue. Listings show 24 items
 * (ARTIST_DIRECTORY_ITEMS_PER_PAGE, RELEASE_LIST_PAGE_SIZE), so blocking it
 * would leave 610 of 634 artists reachable only from the sitemap. Sitemaps
 * give discovery; internal links give crawl paths and link equity, and this
 * catalogue exists to be found. Allowing it costs a few hundred bounded URLs
 * against the many thousands the filter matrix would generate.
 *
 * `year`, because /archive?year=1990 permanently redirects to /archive/1990
 * (see redirectLegacyArchiveQuery in proxy.ts), and that redirect must stay
 * crawlable for the legacy URL to consolidate onto its canonical form.
 */
const FACETED_QUERY_PARAMS = [
  "sort",
  "genre",
  "subgenre",
  "province",
  "region",
  "tag",
  "classical",
  "decade",
  "view",
];

const FACETED_QUERY_DISALLOWED = FACETED_QUERY_PARAMS.map(
  (param) => `/*?*${param}=`,
);

const CRAWLER_DISALLOWED = [
  ...INTERNAL_PATHS,
  "/search",
  ...FACETED_QUERY_DISALLOWED,
];
const META_CRAWLERS = ["facebookexternalhit", "Facebot", "meta-externalagent"];

/**
 * Crawlers denied the whole site. Currently none.
 *
 * Amazonbot was denied here in August 2026 on cost grounds: it walked the
 * catalogue exhaustively — 3.3K edge requests in a 12h window at a 2% cache
 * hit rate — and because the profile routes were effectively uncached at the
 * time, almost every request forced a cold origin render. It accounted for
 * roughly 60% of all function invocations.
 *
 * That reasoning no longer holds. Profiles now sit in the full route cache
 * behind a 7-day fallback, so an exhaustive walk is answered from cache rather
 * than by rendering, and the cost of being crawled thoroughly has collapsed.
 *
 * The denial is lifted because this catalogue exists to be found. Amazonbot
 * sends no organic search traffic back, but it is an indexer rather than a
 * content scraper, and a Dominican music record that nobody can discover
 * fails at its purpose. A crawler is only worth denying here when it takes
 * something without giving discovery in return.
 *
 * The mechanism stays. Add a user agent to this list to deny it outright,
 * scoped to that agent and changing no path rule for anyone else. Note that
 * robots.txt is advisory: an agent that ignores it needs the Vercel firewall,
 * not this file.
 */
const BLOCKED_CRAWLERS: string[] = [];

export function createRobotsPolicy(indexingEnabled: boolean): MetadataRoute.Robots {
  if (!indexingEnabled) {
    return {
      rules: {
        userAgent: "*",
        disallow: "/",
      },
    };
  }

  return {
    rules: [
      {
        userAgent: "*",
        allow: "/",
        disallow: CRAWLER_DISALLOWED,
      },
      ...META_CRAWLERS.map((userAgent) => ({
        userAgent,
        allow: "/",
        disallow: CRAWLER_DISALLOWED,
      })),
      ...BLOCKED_CRAWLERS.map((userAgent) => ({
        userAgent,
        disallow: "/",
      })),
    ],
    sitemap: buildCanonical("/sitemap.xml"),
    host: buildCanonical("/"),
  };
}

export default function robots(): MetadataRoute.Robots {
  return createRobotsPolicy(allowSearchIndexing);
}
