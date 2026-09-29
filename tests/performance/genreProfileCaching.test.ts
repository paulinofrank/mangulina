import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";

import { getGenreProfileRevalidationPaths } from "../../src/lib/revalidateGenre";

const read = (p: string) => readFileSync(p, "utf8");

const genreRoute = read("src/app/[locale]/genres/[slug]/page.tsx");
const provider = read("src/components/genres/GenreSubgenreProvider.tsx");
const sections = read("src/components/genres/GenreDynamicSections.tsx");
const selector = read("src/components/genres/SubgenreSelector.tsx");
const genreApi = read("src/lib/genreApi.ts");
const revalidateGenre = read("src/lib/revalidateGenre.ts");
const adminGenres = read("src/app/api/admin/genres/route.ts");
const adminSubgenres = read("src/app/api/admin/subgenres/route.ts");
const adminGenreMedia = read("src/app/api/admin/genre-media/route.ts");
const contextRoute = read("src/app/api/genres/subgenre-context/route.ts");

test("genre route is cacheable: no force-dynamic, explicit long TTL", () => {
  assert.doesNotMatch(
    genreRoute,
    /export const dynamic\s*=\s*"force-dynamic"/,
    "force-dynamic must be gone",
  );
  assert.doesNotMatch(genreRoute, /no-store|unstable_noStore/, "no dynamic opt-outs");
  assert.match(genreRoute, /export const revalidate = 86400/, "explicit 24h fallback TTL");
});

test("canonical server render never reads searchParams", () => {
  // Reading searchParams during render forces the whole route dynamic again,
  // which is the exact regression this phase removed.
  assert.doesNotMatch(genreRoute, /searchParams/, "server page must not reference searchParams");
  assert.doesNotMatch(genreRoute, /subgenre\?\?|requestedSubgenre/, "no server-side subgenre state");
  // getGenrePageData is called without a subgenre argument.
  assert.match(genreRoute, /getGenrePageData\(slug\)/);
});

test("query strings cannot multiply Full Route Cache entries", () => {
  // The server ignores the query string entirely, so /genres/x, /genres/x?subgenre=y
  // and /genres/x?anything=z all resolve to one cache entry.
  assert.doesNotMatch(genreRoute, /searchParams/);
  // Filter state lives in the client, and changing it must not navigate.
  assert.match(provider, /window\.history\.(pushState|replaceState)/);
  assert.doesNotMatch(provider, /router\.(push|replace)\(/, "filter changes must not trigger navigation");
  assert.doesNotMatch(selector, /router\.(push|replace)\(/);
});

test("prerendered HTML keeps the genre's indexable content", () => {
  // useSearchParams() under static rendering would push the consuming subtree
  // behind Suspense and strip genre content out of the prerender.
  assert.doesNotMatch(provider, /import[^;]*useSearchParams/, "provider must not import useSearchParams");
  assert.doesNotMatch(sections, /import[^;]*useSearchParams/, "sections must not import useSearchParams");
  // The provider starts unselected so first paint is the canonical genre.
  assert.match(provider, /useState<string \| null>\(null\)/);
  assert.match(sections, /soloArtists\.length > 0/);
  assert.match(sections, /groupArtists\.length > 0/);
});

test("subgenre filtering still works end to end", () => {
  assert.match(selector, /useGenreSubgenre\(\)/);
  assert.match(selector, /onValueChange=\{select\}/);
  assert.match(provider, /\/api\/genres\/subgenre-context/);
  assert.match(provider, /popstate/, "back/forward still moves through filter states");
  assert.match(sections, /subgenre=\{selected\}/, "songs list still receives the selected subgenre");
  assert.match(genreApi, /export async function getSubgenreContext/);
  assert.match(contextRoute, /getSubgenreContext/);
});

test("existing genre data caches are preserved", () => {
  // Matched without the version suffix on purpose: the suffix exists to be
  // bumped when a cache needs busting, so pinning it here would make routine
  // invalidation look like a regression. What must hold is that all four
  // caches still exist under their own distinct keys.
  assert.equal((genreApi.match(/unstable_cache\(/g) ?? []).length, 4, "all four genre caches remain");
  assert.match(genreApi, /public-catalog-genre-v\d+/);
  assert.match(genreApi, /public-genre-artists-v\d+/);
  assert.match(genreApi, /public-top-genre-options-v\d+/);
  assert.match(genreApi, /public-genre-media-v\d+/);
  // The subgenre endpoint reuses those caches rather than querying directly.
  assert.doesNotMatch(contextRoute, /getSupabaseClient|\.from\(/);
});

test("genre mutations invalidate the long-lived cache", () => {
  for (const [label, source] of [
    ["genres", adminGenres],
    ["subgenres", adminSubgenres],
    ["genre-media", adminGenreMedia],
  ] as const) {
    assert.match(source, /revalidateGenreContent\(/, `${label} must invalidate genre caches`);
  }
  // genre-media mutates on both create and delete.
  assert.equal((adminGenreMedia.match(/revalidateGenreContent\(/g) ?? []).length, 2);
  assert.match(adminGenres, /revalidateGenreContent\(payload\.slug\)/, "genre edit targets its own paths");
});

test("invalidation is genre-scoped, not broad", () => {
  assert.match(revalidateGenre, /PUBLIC_GENRE_CACHE_TAG/);
  assert.doesNotMatch(revalidateGenre, /revalidatePath\("\/"\)/, "never invalidate the site root");
  assert.doesNotMatch(revalidateGenre, /"layout"/, "page scope only");
});

test("genre invalidation covers both public locale variants", () => {
  assert.deepEqual(
    [...getGenreProfileRevalidationPaths(" bachata ")].sort(),
    ["/es/genres/bachata", "/genres/bachata"],
  );
  assert.equal(getGenreProfileRevalidationPaths("   ").size, 0);
});

test("canonical SEO is unchanged", () => {
  assert.match(genreRoute, /path: `\/genres\/\$\{data\.genre\.slug\}`/, "canonical stays the slug URL");
  assert.match(genreRoute, /createPageMetadata/);
  assert.match(genreRoute, /collectionPageSchema/);
  assert.match(genreRoute, /breadcrumbSchema/);
  // Metadata must not vary by filter state.
  const metadataBlock = genreRoute.slice(
    genreRoute.indexOf("export async function generateMetadata"),
    genreRoute.indexOf("export default async function GenrePage"),
  );
  assert.doesNotMatch(metadataBlock, /subgenre/i, "metadata is never subgenre-dependent");
});

test("genre slugs are prerendered from the existing bounded list", () => {
  assert.match(genreRoute, /export async function generateStaticParams/);
  assert.match(genreRoute, /getGenrePageSlugs/);
  assert.match(genreRoute, /genreDefinitions\.map/);
});
