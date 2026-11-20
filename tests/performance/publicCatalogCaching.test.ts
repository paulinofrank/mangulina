import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";

import { createArtistDirectoryInitialDataKey } from "../../src/lib/artistDirectoryData";
import { PUBLIC_CATALOG_REVALIDATE_SECONDS } from "../../src/lib/publicCatalogCache";

const artistRoute = readFileSync("src/app/[locale]/artists/[slug]/page.tsx", "utf8");
const songRoute = readFileSync("src/app/[locale]/songs/[slug]/page.tsx", "utf8");
const releaseRoute = readFileSync("src/app/[locale]/releases/[slug]/page.tsx", "utf8");
const genreRoute = readFileSync("src/app/[locale]/genres/[slug]/page.tsx", "utf8");
const genreApi = readFileSync("src/lib/genreApi.ts", "utf8");
const directoryApi = readFileSync("src/lib/artistDirectoryData.ts", "utf8");
const searchApi = readFileSync("src/lib/searchApi.ts", "utf8");
const artistRevalidation = readFileSync("src/lib/revalidateArtistProfile.ts", "utf8");
const portfolioCache = readFileSync("src/lib/artistPortfolioCache.ts", "utf8");
const portfolio = readFileSync("src/lib/getArtistWorksPortfolio.ts", "utf8");

test("entity profiles use long fallback ISR with on-demand editorial revalidation", () => {
  assert.equal(PUBLIC_CATALOG_REVALIDATE_SECONDS, 600);

  for (const source of [artistRoute, songRoute, releaseRoute]) {
    assert.match(source, /export function generateStaticParams\(\) \{\s*return \[\];\s*\}/);
    assert.match(source, /setRequestLocale\(/);
    assert.doesNotMatch(source, /force-dynamic|noStore|unstable_noStore/);
  }

  // The clocks are fallbacks, not the freshness mechanism: admin mutations
  // revalidate the affected paths immediately and /api/revalidate covers work
  // written straight to Postgres. They are split by how often the rows change.
  //
  // An ISR write unit is 8 KB and a profile rebuild writes ~34 KB, so a full
  // pass over the ~41,700 cacheable profile URLs costs ~174K units against a
  // 200K monthly allowance. Songs and releases are ~40,400 of those URLs and
  // are essentially never edited after creation, so they carry a year. Artists
  // are ~1,286 URLs under constant editorial work, so a month costs little.
  assert.match(artistRoute, /export const revalidate = 2678400/);
  assert.match(songRoute, /export const revalidate = 31536000/);
  assert.match(releaseRoute, /export const revalidate = 31536000/);
});

test("directory cache keys are stable and isolate filters", () => {
  const first = createArtistDirectoryInitialDataKey({
    searchParams: { page: "2", genre: "merengue", sort: "name" },
    role: "musician",
  });
  const reordered = createArtistDirectoryInitialDataKey({
    searchParams: { sort: "name", genre: "merengue", page: "2" },
    role: "musician",
  });
  const otherRole = createArtistDirectoryInitialDataKey({
    searchParams: { page: "2", genre: "merengue", sort: "name" },
    role: "producer",
  });

  assert.equal(first, reordered);
  assert.notEqual(first, otherRole);
  assert.match(directoryApi, /\.eq\("status", "published"\)/);
  assert.match(directoryApi, /public-artist-directory-initial-data-v\d+/);
});

test("genre data caches isolate slug, subgenre, options, and media inputs", () => {
  // Version suffixes are cache-busting handles and change by design; assert
  // the cache exists rather than which generation it is on.
  assert.match(genreApi, /public-catalog-genre-v\d+/);
  assert.match(genreApi, /public-genre-artists-v\d+/);
  assert.match(genreApi, /public-top-genre-options-v\d+/);
  assert.match(genreApi, /public-genre-media-v\d+/);
  assert.doesNotMatch(genreApi, /public-genre-page-data-v\d+/);
  // Phase 3A moved genre profiles into the Full Route Cache: the route no
  // longer opts out of caching, and subgenre state moved to the client.
  // Detailed coverage lives in genreProfileCaching.test.ts.
  assert.doesNotMatch(genreRoute, /export const dynamic = "force-dynamic"/);
  assert.match(genreRoute, /export const revalidate = 86400/);
});

test("artist mutations invalidate profile paths and shared public directories", () => {
  assert.match(artistRevalidation, /revalidatePath\(path\)/);
  assert.match(artistRevalidation, /revalidateTag\(PUBLIC_ARTIST_DIRECTORY_CACHE_TAG, \{ expire: 0 \}\)/);
});

test("editing one artist does not sweep every artist profile", () => {
  // The regression this guards: every portfolio entry used to carry only the
  // shared tag, so revalidating one artist dropped all of them. One admin save
  // then rebuilt the whole artist catalogue -- ~5,400 ISR write units at 643
  // artists, and ~42,000 at 5,000.
  assert.match(artistRevalidation, /export function revalidateArtistProfile\(/);
  assert.match(artistRevalidation, /invalidateArtistPortfolio\(artistId\)/);

  // The targeted path must not reach for the catalogue-wide sweep.
  const targeted = artistRevalidation.slice(
    artistRevalidation.indexOf("export function revalidateArtistProfile("),
  );
  assert.doesNotMatch(targeted, /invalidateArtistPortfolioCache\(\)/);

  // And the portfolio cache must tag entries per artist for that to work.
  assert.match(portfolioCache, /export function artistPortfolioTag\(/);
  assert.match(portfolio, /tags: \[ARTIST_PORTFOLIO_CACHE_TAG, artistPortfolioTag\(artistId\)\]/);
});

test("public search retains its separate bounded query cache", () => {
  // Phase 3D wrapped the cache so its key is bounded; detailed coverage lives
  // in provinceAndSearchCaching.test.ts.
  assert.match(searchApi, /cachedGlobalSearchByKey = unstable_cache/);
  assert.match(searchApi, /revalidate: 300/);
  assert.match(searchApi, /searchCacheKey\(query\)/);
});
