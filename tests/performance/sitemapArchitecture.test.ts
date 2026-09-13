import assert from "node:assert/strict";
import { existsSync, readFileSync } from "node:fs";
import test from "node:test";

import {
  buildChildSitemapUrls,
  buildLocaleUrlEntries,
  buildSitemapIndexXml,
  buildUrlsetXml,
  chunkCountFor,
  chunkRange,
  escapeXml,
  parseChildSitemapName,
  SITEMAP_CHUNK_SIZE,
  SITEMAP_REVALIDATE_SECONDS,
  STATIC_SITEMAP_PATHS,
} from "../../src/lib/sitemapCatalog";

const catalogLib = readFileSync("src/lib/sitemapCatalog.ts", "utf8");
const indexRoute = readFileSync("src/app/sitemap.xml/route.ts", "utf8");
const childRoute = readFileSync("src/app/sitemaps/[name]/route.ts", "utf8");
const robots = readFileSync("src/app/robots.ts", "utf8");
const proxy = readFileSync("src/proxy.ts", "utf8");

test("/sitemap.xml remains the canonical sitemap entry point", () => {
  // The established, already-indexed URL must keep serving the sitemap.
  assert.ok(existsSync("src/app/sitemap.xml/route.ts"), "/sitemap.xml route must exist");
  assert.equal(existsSync("src/app/sitemap.ts"), false, "monolithic metadata sitemap must be gone");
  assert.equal(
    existsSync("src/app/api/sitemaps"),
    false,
    "sitemaps must not live under /api",
  );
  assert.match(robots, /buildCanonical\("\/sitemap\.xml"\)/, "robots advertises /sitemap.xml");

  // Nothing publicly advertised may point at an /api/ sitemap path.
  for (const source of [catalogLib, indexRoute, childRoute, robots]) {
    assert.doesNotMatch(source, /["'`]\/api\/sitemaps/, "no /api sitemap URL is advertised");
  }
});

test("/sitemap.xml produces a sitemap index over the public /sitemaps namespace", () => {
  const urls = buildChildSitemapUrls({ artists: 1, songs: 16794, releases: 5000 });
  assert.deepEqual(urls, [
    "https://mangulina.do/sitemaps/static.xml",
    "https://mangulina.do/sitemaps/artists-1.xml",
    "https://mangulina.do/sitemaps/songs-1.xml",
    "https://mangulina.do/sitemaps/songs-2.xml",
    "https://mangulina.do/sitemaps/songs-3.xml",
    "https://mangulina.do/sitemaps/songs-4.xml",
    "https://mangulina.do/sitemaps/releases-1.xml",
  ]);
  assert.equal(new Set(urls).size, urls.length, "index must not list duplicates");

  const xml = buildSitemapIndexXml(urls);
  assert.match(xml, /^<\?xml version="1\.0" encoding="UTF-8"\?>/);
  assert.match(xml, /<sitemapindex xmlns="http:\/\/www\.sitemaps\.org\/schemas\/sitemap\/0\.9">/);
  assert.match(xml, /<\/sitemapindex>$/);
  assert.equal((xml.match(/<sitemap>/g) ?? []).length, urls.length);
  assert.doesNotMatch(xml, /<urlset/, "the index is not a urlset");
  assert.doesNotMatch(xml, /<lastmod>/, "index entries must not fabricate lastmod");

  assert.match(indexRoute, /buildSitemapIndexXml/, "the route returns the index document");
  assert.match(indexRoute, /getSitemapFamilyCounts/, "index derives chunks from counts only");
});

test("sitemap URLs bypass the locale proxy without a middleware change", () => {
  // Rebuild the proxy's real matcher from source and exercise it, rather than
  // asserting on its text: the claim being protected is behavioural — dotted
  // paths skip next-intl's rewrite pipeline, so .xml resources serve directly.
  const matcherSource = /"(\/\(\(\?!_next[^"]*)"/.exec(proxy)?.[1];
  assert.ok(matcherSource, "proxy exposes a locale matcher");
  const matcher = new RegExp(`^${matcherSource.replace(/\\\\/g, "\\")}$`);

  assert.equal(matcher.test("/sitemap.xml"), false, "/sitemap.xml is not localized");
  for (const url of buildChildSitemapUrls({ artists: 1, songs: 1, releases: 1 })) {
    const path = url.replace("https://mangulina.do", "");
    assert.match(path, /\.xml$/, `child sitemap must carry a .xml suffix: ${path}`);
    assert.equal(matcher.test(path), false, `${path} is not localized`);
  }
  // Sanity check the matcher still governs ordinary public pages.
  assert.equal(matcher.test("/artists/juan-luis-guerra"), true);
});

test("chunk math is deterministic with no overlaps, gaps, or oversized chunks", () => {
  assert.equal(chunkCountFor(0), 0);
  assert.equal(chunkCountFor(1), 1);
  assert.equal(chunkCountFor(SITEMAP_CHUNK_SIZE), 1, "exactly-full family stays one chunk");
  assert.equal(chunkCountFor(SITEMAP_CHUNK_SIZE + 1), 2, "one over spills into a partial chunk");

  for (let chunk = 1; chunk <= 4; chunk += 1) {
    const range = chunkRange(chunk);
    assert.equal(range.to - range.from + 1, SITEMAP_CHUNK_SIZE, "window is exactly one chunk");
    if (chunk > 1) {
      assert.equal(range.from, chunkRange(chunk - 1).to + 1, "windows are contiguous: no gap, no overlap");
    }
  }

  // Locale expansion doubles entries: keep a wide margin under protocol caps.
  const maxEntriesPerChild = SITEMAP_CHUNK_SIZE * 2;
  assert.ok(maxEntriesPerChild <= 10000, "≤10k entries per child (5x under the 50k cap)");
});

test("child sitemap names parse strictly", () => {
  assert.deepEqual(parseChildSitemapName("static.xml"), { kind: "static" });
  assert.deepEqual(parseChildSitemapName("artists-1.xml"), {
    kind: "family",
    family: "artists",
    chunk: 1,
  });
  assert.deepEqual(parseChildSitemapName("songs-12.xml"), {
    kind: "family",
    family: "songs",
    chunk: 12,
  });
  for (const bad of [
    "artists-0.xml",
    "artists-01.xml",
    "artists.xml",
    "songs-1",
    "admin-1.xml",
    "artists-1.xml.gz",
    "../artists-1.xml",
    "",
  ]) {
    assert.equal(parseChildSitemapName(bad), null, `rejects ${JSON.stringify(bad)}`);
  }
});

test("urlset entries carry canonical EN/ES locs with reciprocal hreflang", () => {
  const [en, es] = buildLocaleUrlEntries({ path: "/artists/juan-luis-guerra", priority: 0.8 });

  assert.match(en, /<loc>https:\/\/mangulina\.do\/artists\/juan-luis-guerra<\/loc>/);
  assert.match(es, /<loc>https:\/\/mangulina\.do\/es\/artists\/juan-luis-guerra<\/loc>/);
  for (const entry of [en, es]) {
    assert.match(entry, /hreflang="en" href="https:\/\/mangulina\.do\/artists\/juan-luis-guerra"/);
    assert.match(entry, /hreflang="es" href="https:\/\/mangulina\.do\/es\/artists\/juan-luis-guerra"/);
    assert.match(entry, /hreflang="x-default" href="https:\/\/mangulina\.do\/artists\/juan-luis-guerra"/);
    assert.match(entry, /<changefreq>weekly<\/changefreq>/);
    assert.match(entry, /<priority>0\.8<\/priority>/);
  }

  // Homepage special case: ES twin is /es, x-default is the EN root.
  const [enRoot, esRoot] = buildLocaleUrlEntries({ path: "/", priority: 1 });
  assert.match(enRoot, /<loc>https:\/\/mangulina\.do\/<\/loc>/);
  assert.match(esRoot, /<loc>https:\/\/mangulina\.do\/es<\/loc>/);

  const xml = buildUrlsetXml([{ path: "/songs/a-donde-vayas", priority: 0.7 }]);
  assert.match(xml, /<urlset xmlns="http:\/\/www\.sitemaps\.org\/schemas\/sitemap\/0\.9" xmlns:xhtml="http:\/\/www\.w3\.org\/1999\/xhtml">/);
  assert.match(xml, /<\/urlset>$/);
  assert.equal((xml.match(/<url>/g) ?? []).length, 2, "one logical path = EN + ES entries");
  assert.doesNotMatch(xml, /<lastmod>/, "urlset entries must not fabricate lastmod");

  // An empty family window still yields a well-formed document.
  assert.match(buildUrlsetXml([]), /<urlset[^>]*>\s*<\/urlset>/);
});

test("XML special characters are escaped", () => {
  assert.equal(escapeXml(`a&b<c>"d"'e'`), "a&amp;b&lt;c&gt;&quot;d&quot;&apos;e&apos;");
  const xml = buildUrlsetXml([{ path: "/songs/q-a" }]);
  assert.doesNotMatch(xml, /<loc>[^<]*&(?!amp;|lt;|gt;|quot;|apos;)/);
});

test("no private, parameterized, preview, or search URLs can enter the sitemap", () => {
  const urls = buildChildSitemapUrls({ artists: 10, songs: 10, releases: 10 });
  const staticPaths = STATIC_SITEMAP_PATHS.map((item) => item.path);
  assert.equal(new Set(staticPaths).size, staticPaths.length, "static paths are unique");

  for (const value of [...urls, ...staticPaths]) {
    assert.doesNotMatch(value, /[?=&]/, `no query parameters: ${value}`);
    assert.doesNotMatch(
      value,
      /\/(admin|api|auth|debug|search)(\/|$)/,
      `no private routes: ${value}`,
    );
    assert.doesNotMatch(value, /vercel\.app|localhost|http:\/\//, `canonical https origin only: ${value}`);
  }
  for (const source of [catalogLib, indexRoute, childRoute]) {
    assert.doesNotMatch(source, /vercel\.app|localhost/);
  }
  assert.match(catalogLib, /\.eq\("status", "published"\)/, "artist publication filter enforced");
  assert.match(catalogLib, /release_artist_id/, "release publication filter enforced");
});

test("chunk windows are never silently truncated by the PostgREST row cap", () => {
  // Regression guard: PostgREST caps any single response at 1000 rows, so a
  // chunk wider than that must be read in slices and reassembled. Requesting
  // range(from, to) directly for a 5000-record chunk returns 1000 rows and
  // reports success — silently dropping 80% of the family's URLs.
  assert.ok(
    SITEMAP_CHUNK_SIZE > 1000,
    "this guard matters precisely because a chunk exceeds the row cap",
  );
  assert.match(catalogLib, /const SUPABASE_MAX_ROWS = 1000/);
  assert.match(catalogLib, /start \+= SUPABASE_MAX_ROWS/, "windows are read in capped slices");
  assert.match(
    catalogLib,
    /Math\.min\(start \+ SUPABASE_MAX_ROWS - 1, to\)/,
    "slices never exceed the row cap or overrun the window",
  );
  assert.doesNotMatch(
    catalogLib,
    /\.range\(from, to\)/,
    "no loader may range across a full chunk in one request",
  );
  // Every family window goes through the slicing helper.
  assert.equal(
    (catalogLib.match(/await fetchChunkWindow</g) ?? []).length,
    3,
    "artists, songs, and releases all read windows through fetchChunkWindow",
  );
});

test("chunk queries are bounded, deterministically ordered, and range-paginated", () => {
  // Stable total ordering must be applied before every range window.
  const orderedRangeQueries = catalogLib.match(
    /\.order\("created_at", \{ ascending: true, nullsFirst: false \}\)\s*\.order\("id", \{ ascending: true \}\)\s*\.range\(start, end\)/g,
  );
  assert.equal(orderedRangeQueries?.length, 3, "artists, songs, and releases all order before range");
  assert.match(catalogLib, /head: true/, "index uses head-only count queries");

  // The artist family resolves publication in its single window query; only
  // song/release families need the owning-artist lookup.
  const artistChunkBody = catalogLib.slice(
    catalogLib.indexOf("export async function loadArtistSitemapPaths"),
    catalogLib.indexOf("type RecordingSitemapRow"),
  );
  assert.match(artistChunkBody, /\.eq\("status", "published"\)/);
  assert.doesNotMatch(
    artistChunkBody,
    /fetchPublishedArtistIdSet/,
    "artist chunks must not run a redundant second publication query",
  );
});

test("caching is explicit: force-static route handlers with a 7d fallback TTL", () => {
  assert.equal(SITEMAP_REVALIDATE_SECONDS, 604800);

  for (const [label, source] of [
    ["index", indexRoute],
    ["child", childRoute],
  ] as const) {
    // force-static opts the GET handler into the full route cache; revalidate
    // must be a literal Next.js can analyze statically (an imported constant
    // fails the build), so assert the literal matches the shared constant.
    assert.match(source, /export const dynamic = "force-static"/, `${label} opts into the route cache`);
    const revalidate = /export const revalidate = (\d+)/.exec(source);
    assert.ok(revalidate, `${label} declares an explicit revalidate`);
    assert.equal(
      Number(revalidate[1]),
      SITEMAP_REVALIDATE_SECONDS,
      `${label} TTL must match SITEMAP_REVALIDATE_SECONDS`,
    );
    assert.doesNotMatch(source, /new Date\(\)/, `${label} fabricates no modification timestamps`);
    assert.match(source, /application\/xml/, `${label} serves an XML content type`);
  }

  // Deploys must never prebuild the catalog.
  assert.match(childRoute, /export function generateStaticParams\(\) \{\s*return \[\];\s*\}/);
  assert.match(childRoute, /status: 404/, "unknown or past-the-end chunks return 404");
});

test("the static family keeps its own 7d cache entry", () => {
  // Next.js resolves a route's revalidate as the MINIMUM across everything it
  // reads. The archive/genre/province helpers are shared with the hub pages
  // and carry a 600s TTL, which silently dragged /sitemaps/static.xml down to
  // s-maxage=600 (144 regenerations a day). Isolating them in a dedicated
  // cache entry restores the intended TTL without altering the shared helpers.
  assert.match(
    catalogLib,
    /export const loadStaticSitemapPaths = unstable_cache\(\s*buildStaticSitemapPaths,\s*\["public-sitemap-static-v1"\],\s*\{ revalidate: SITEMAP_REVALIDATE_SECONDS \},?\s*\)/,
    "static family is wrapped in its own cache entry at the sitemap TTL",
  );
});
