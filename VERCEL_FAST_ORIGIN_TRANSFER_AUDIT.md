# Vercel Audit: Fast Origin Transfer (FOT) & Analytics Breakdown

**Project:** Mangulina (`frankprojects/mangulina`)  
**Production URL:** https://mangulina.do  
**Date:** September 2026  
**Vercel Plan:** Hobby (10 GB Fast Origin Transfer threshold)

---

## 1. Executive Summary

Vercel alerted on high resource usage, triggering a self-serve 3x threshold modifier on August 31, 2026 (`startsAt: 1788309612424`) to keep the site online.

The metric exceeding limits is **Fast Origin Transfer (FOT)**, not Fast Data Transfer (FDT):
* **Fast Data Transfer (FDT):** Egress served directly from Vercel's Edge CDN cache to visitors (100 GB Hobby limit).
* **Fast Origin Transfer (FOT):** Data transferred from your **compute layer (Serverless Functions / Origin)** into Vercel's Edge Network whenever a request is not served from cache (10 GB Hobby limit).

Every cache miss, dynamic server render, ISR regeneration, uncompressed sitemap generation, and image optimization origin fetch streams data out of a Serverless Function into the edge network, consuming FOT.

---

## 2. Telemetry & Vercel Analytics Review

### A. Web Analytics Metrics (Last 30 Days)
* **Total Tracked Visitors:** 1,094 unique human visitors
* **Total Tracked Pageviews:** 7,336 pageviews
* **Traffic Spikes:**
  * **Aug 21:** 1,809 pageviews from 13 visitors (~139 views/visitor, indicating automated scraping or heavy catalog traversal).
  * **Aug 26–28:** Sustained surge reaching 189 visitors and 674 pageviews/day.
* **Device Breakdown:** **62.5% Mobile** (4,586 mobile views vs. 1,833 desktop views).
* **Top Referrers:** Direct / Internal (6,099 views), Google (369 views), Facebook (87 views).
* **Top Regions:** United States (5,823 views) and Dominican Republic (372 views).

### B. The "Invisible Bot" Traffic
Vercel Web Analytics only records browsers running JavaScript. Web crawlers (Googlebot, Amazonbot, Bingbot, ByteSpider, SEO tools) do not execute JavaScript and never appear in Web Analytics. However, live runtime logs reveal continuous requests every second across `/songs/*`, `/releases/*`, `/artists/*`, and legal pages.

---

## 3. Root Causes of High Fast Origin Transfer

### Problem 1: Main Directory & Listing Pages Completely Bypass Edge Cache
Every primary directory page in the application currently returns `Cache-Control: private, no-cache, no-store, max-age=0, must-revalidate` and `X-Vercel-Cache: MISS`:
* `/artists`
* `/christian`
* `/producers`
* `/composers`
* `/songwriters`
* `/arrangers`
* `/lyricists`
* `/musical-directors`
* `/musicians`
* `/djs`
* `/instrumental-classical`
* `/artists/birthdays`
* `/artists/emerging`, `/artists/legends`, `/artists/most-awarded`
* All release categories (`/releases/albums`, `/releases/singles`, `/releases/compilations`, `/releases/1950s`...`2020s`)

#### Why this happens:
These pages directly `await searchParams` in the top-level Server Component:
```typescript
// Example: src/app/[locale]/artists/page.tsx
export default async function ArtistsPage({ searchParams }: ArtistsPageProps) {
  return (
    <ArtistRoleDirectoryPage
      config={ARTIST_ROLE_PAGES.artists}
      searchParams={await searchParams}
    />
  );
}
```
In Next.js App Router, directly reading `searchParams` on the page component opts the route into **Dynamic Server Rendering** on every request, emitting `Cache-Control: private, no-cache, no-store`. Even where `export const revalidate = 600` is declared (e.g. `birthdays/page.tsx`), Next.js overrides it with `no-store`.

#### Cost:
* Page payload: **~134 KB HTML + ~57 KB RSC = ~191 KB per request**.
* Because the edge cache hit rate is **0%**, every visit from a human or crawler executes a cold Serverless Function and streams ~191 KB from Origin to Edge.

---

### Problem 2: Massive Catalog (~41,700 URLs) with Zero Build-Time Pre-rendering
* Routes for songs, artists, and releases define `export function generateStaticParams() { return []; }`.
* **The Reason:** This was implemented to prevent long build times during git deploys.
* **The Consequence:** None of the ~41,700 catalog URLs are cached when a new deployment is promoted.
* **Regional Edge Caching:** Vercel edge caches are per-region, not global. A hit in Europe or another US data center does not warm other regions.
* When crawlers or users hit unprimed URLs, the Serverless Function must cold-render the page:
  * HTML payload: **~186 KB**
  * RSC payload: **~92 KB**
  * **Total per cold hit: ~278 KB**
* A single full crawl of 30,000 catalog pages across edge nodes transfers **~8.3 GB from Origin**.

---

### Problem 3: Child Sitemaps Are 4.75 MB Each & Rebuilt Every 24 Hours
* `/sitemap.xml` references partitioned child sitemaps: `/sitemaps/songs-1.xml`, `/sitemaps/songs-2.xml`, `/sitemaps/songs-3.xml`, `/sitemaps/songs-4.xml`, `/sitemaps/artists-1.xml`, `/sitemaps/releases-1.xml`, `/sitemaps/static.xml`.
* Each song sitemap contains 5,000 records × 2 locales (10,000 URLs with alternate links).
* **Live response size:** `https://mangulina.do/sitemaps/songs-1.xml` has `Content-Length: 4,755,054 bytes` (**4.75 MB** uncompressed XML).
* The four song sitemaps alone total **~19 MB**.
* Both `src/app/sitemap.xml/route.ts` and `src/app/sitemaps/[name]/route.ts` define:
  ```typescript
  export const revalidate = 86400; // 24 hours
  ```
* Every 24 hours, when search crawlers request the sitemaps, the Serverless Function executes, queries Supabase, and transfers ~19 MB of raw XML to the edge. Repeated across multiple bots and edge nodes, sitemaps alone consume gigabytes of Origin Transfer each month.

---

### Problem 4: Lifted Crawler Restrictions in `robots.ts`
* In `src/app/robots.ts`, `BLOCKED_CRAWLERS` is currently empty:
  ```typescript
  const BLOCKED_CRAWLERS: string[] = [];
  ```
* Comments indicate Amazonbot was previously blocked because it consumed 60% of all function invocations walking the catalog, but was unblocked under the assumption that 7-day ISR caching made crawling free.
* Because directory pages are `no-store` (uncached) and cold catalog visits require serverless rendering, aggressive crawlers (Amazonbot, ByteSpider, Ahrefs, Semrush, PetalBot) walk the site and force thousands of uncached Serverless Function invocations.

---

### Problem 5: Missing `minimumCacheTTL` for Next.js Image Optimization
* In `next.config.ts`, remote image patterns are configured for Supabase Storage (`/storage/v1/object/public/**`), but `images.minimumCacheTTL` is not set.
* By default, Next.js caches optimized images based on the upstream `Cache-Control` header. If Supabase Storage serves short or missing cache headers, Vercel re-fetches the original images from Supabase Storage frequently, burning origin transfer.

---

### Problem 6: Duplicate Analytics Ingestion on Every Client Navigation
* In `src/components/layout/DocumentShell.tsx`:
  * `<RoutePageView />` fires on route change -> calls `POST /api/analytics/track` (`page_view`).
  * `<AnalyticsPageView />` on profile pages fires on mount -> calls `POST /api/analytics/track` (`artist_view`, `recording_view`, etc.).
* Both invoke the Serverless Function at `src/app/api/analytics/track/route.ts`. Even with small JSON responses, this doubles custom serverless invocations on every page navigation.

---

## 4. Solutions & Implementation Plan

### Solution 1: Enable Edge Caching on Directory & Listing Pages (Highest Impact)
Remove direct server-level `await searchParams` from the page component or isolate it inside a `<Suspense>` boundary so Next.js can generate and cache a static shell at the Edge CDN.

**Implementation with `<Suspense>` & Route Revalidation:**
In `src/app/[locale]/artists/page.tsx`:
```typescript
import { Suspense } from "react";
import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES } from "@/lib/artist-role-pages";

// Enable edge caching with a 24-hour TTL:
export const revalidate = 86400;

export default async function ArtistsPage({
  searchParams,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  return (
    <Suspense fallback={<div className="min-h-screen" />}>
      <DirectoryContent searchParams={searchParams} />
    </Suspense>
  );
}

async function DirectoryContent({
  searchParams,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  const resolvedParams = await searchParams;
  return (
    <ArtistRoleDirectoryPage
      config={ARTIST_ROLE_PAGES.artists}
      searchParams={resolvedParams}
    />
  );
}
```

* **Expected Result:** Edge cache hit rate changes from **0% to >90%**. Fast Origin Transfer drops by 50–70% immediately.

---

### Solution 2: Optimize and Lengthen Sitemap Revalidation
1. **Extend Revalidation:** Change sitemap revalidation from 24 hours (`86400`) to 7 days (`604800`) or 14 days in `src/app/sitemaps/[name]/route.ts` and `src/app/sitemap.xml/route.ts`:
   ```typescript
   export const revalidate = 604800; // 7 days instead of 24h
   ```
2. **Reduce Chunk Size:** In `src/lib/sitemapCatalog.ts`, reduce `SITEMAP_CHUNK_SIZE` from `5000` to `2000` or `2500` so individual XML payloads stay under 2 MB instead of 4.75 MB.
3. **Add Explicit Cache-Control Header:**
   In `src/app/sitemaps/[name]/route.ts`:
   ```typescript
   return new Response(buildUrlsetXml(paths), {
     headers: {
       "Content-Type": "application/xml; charset=utf-8",
       "Cache-Control": "public, max-age=86400, s-maxage=604800, stale-while-revalidate=86400",
     },
   });
   ```
* **Expected Result:** Sitemap origin data transfer drops by **~85%**.

---

### Solution 3: Re-block Aggressive Commercial & AI Scrapers in `robots.txt`
Reinstate the crawler blocklist in `src/app/robots.ts`:
```typescript
const BLOCKED_CRAWLERS = [
  "Amazonbot",
  "Bytespider",
  "PetalBot",
  "ClaudeBot",
  "SemrushBot",
  "AhrefsBot",
  "MJ12bot",
  "DataForSeoBot",
  "DotBot",
];
```
* Legitimate discovery search engines (Googlebot, Bingbot, Meta/Facebook) remain permitted.
* Aggressive non-search crawlers that exhaustively scrape the 41,700 catalog pages are stopped before triggering cold Serverless Function invocations.
* In the Vercel Dashboard, enable **Vercel Bot Protection / Firewall** to challenge automated bots at the edge before they hit Serverless Functions.

---

### Solution 4: Set `minimumCacheTTL` for Images in `next.config.ts`
Prevent Vercel from frequently re-fetching images from Supabase Storage:
```typescript
// next.config.ts
const nextConfig: NextConfig = {
  images: {
    minimumCacheTTL: 2592000, // 30 days
    remotePatterns: [ ... ],
  },
};
```
* **Expected Result:** Vercel caches transformed images at the edge for 30 days regardless of upstream storage headers, eliminating repetitive source fetches.

---

### Solution 5: Consolidate Analytics Ingestion
In `src/components/layout/DocumentShell.tsx`:
* Pass entity details to `RoutePageView` or suppress `RoutePageView` when an `AnalyticsPageView` is active on the page.
* Alternatively, run `/api/analytics/track` on the Edge runtime (`export const runtime = 'edge'`) to minimize Serverless Function execution overhead.

---

## 5. Action Checklist

- [ ] **1.** Wrap directory pages (`/artists`, `/christian`, `/producers`, `/releases/*`, `/birthdays`) in `<Suspense>` and export `revalidate = 86400` so they cache at Vercel's edge.
- [ ] **2.** Update `src/app/robots.ts` to block `Amazonbot`, `Bytespider`, `PetalBot`, `SemrushBot`, and `AhrefsBot`.
- [ ] **3.** Change sitemap `revalidate` from `86400` (24h) to `604800` (7d) in `src/app/sitemaps/[name]/route.ts`.
- [ ] **4.** Add `images: { minimumCacheTTL: 2592000 }` to `next.config.ts`.
- [ ] **5.** Consolidate client-side analytics calls to `/api/analytics/track`.
