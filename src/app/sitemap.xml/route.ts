import {
  buildChildSitemapUrls,
  buildSitemapIndexXml,
  getSitemapFamilyCounts,
} from "@/lib/sitemapCatalog";

/**
 * Sitemap index at https://mangulina.do/sitemap.xml — the same canonical entry
 * point crawlers and Search Console already know. It previously returned a
 * ~19.7 MB <urlset> covering the whole catalog, rebuilt hourly; it now returns
 * a ~1 KB <sitemapindex> pointing at independently cached child sitemaps under
 * /sitemaps/.
 *
 * Cost: three head-only COUNT queries, enough to know how many chunks each
 * family needs. No entity rows are read here.
 *
 * Caching (explicit, not inherited defaults): `force-static` opts this GET
 * handler into the full route cache, and `revalidate` gives it a 7-day fallback
 * TTL — so repeat crawler requests are served from cache without touching
 * Supabase. `revalidate` must be a literal Next.js can analyze statically,
 * which is why SITEMAP_REVALIDATE_SECONDS is mirrored rather than imported.
 *
 * lastmod is omitted on child entries: we do not track when a chunk last
 * changed, and asserting a date we cannot substantiate would misinform
 * crawlers.
 */
export const dynamic = "force-static";
export const revalidate = 604800; // SITEMAP_REVALIDATE_SECONDS

export async function GET() {
  const counts = await getSitemapFamilyCounts();
  const xml = buildSitemapIndexXml(buildChildSitemapUrls(counts));

  return new Response(xml, {
    headers: { "Content-Type": "application/xml; charset=utf-8" },
  });
}
