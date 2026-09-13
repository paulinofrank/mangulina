import {
  buildUrlsetXml,
  loadArtistSitemapPaths,
  loadReleaseSitemapPaths,
  loadSongSitemapPaths,
  loadStaticSitemapPaths,
  parseChildSitemapName,
  type SitemapPath,
} from "@/lib/sitemapCatalog";

/**
 * Child sitemaps on the public sitemap namespace:
 *
 *   /sitemaps/static.xml
 *   /sitemaps/artists-1.xml, /sitemaps/songs-3.xml, /sitemaps/releases-1.xml…
 *
 * These paths contain a dot, so the locale proxy's matcher skips them
 * (src/proxy.ts) — no middleware change was needed to expose them.
 *
 * Each request runs only the bounded queries for its own family window (see
 * sitemapCatalog.ts). Caching is explicit and per-URL: `force-static` puts each
 * generated child in the full route cache and `revalidate` gives it a 7-day
 * fallback TTL, so a repeat crawler request for the same chunk is served from
 * cache without re-querying Supabase, and each chunk ages on its own clock.
 *
 * generateStaticParams returns [] deliberately: nothing is prebuilt at deploy
 * time (a build must never serialize the catalog), and chunks are generated
 * on first request via dynamicParams, exactly like the profile routes.
 */
export const dynamic = "force-static";
export const revalidate = 604800; // SITEMAP_REVALIDATE_SECONDS

export function generateStaticParams() {
  return [];
}

export async function GET(
  _request: Request,
  { params }: { params: Promise<{ name: string }> },
) {
  const { name } = await params;
  const target = parseChildSitemapName(name);
  if (!target) return new Response(null, { status: 404 });

  let paths: SitemapPath[] | null;
  if (target.kind === "static") {
    paths = await loadStaticSitemapPaths();
  } else if (target.family === "artists") {
    paths = await loadArtistSitemapPaths(target.chunk);
  } else if (target.family === "songs") {
    paths = await loadSongSitemapPaths(target.chunk);
  } else {
    paths = await loadReleaseSitemapPaths(target.chunk);
  }

  // null means the window lies past the end of its family (a stale index
  // reference, or probing) — that chunk genuinely does not exist. An empty
  // array is different: the window exists but nothing in it is public, so it
  // is served as a valid empty urlset rather than a 404 the index contradicts.
  if (paths === null) return new Response(null, { status: 404 });

  return new Response(buildUrlsetXml(paths), {
    headers: { "Content-Type": "application/xml; charset=utf-8" },
  });
}
