export const PUBLIC_CATALOG_REVALIDATE_SECONDS = 600;

/**
 * Artist directory data lives as long as the directory HTML above it.
 *
 * Next.js resolves a route's revalidate as the minimum across everything it
 * reads, so leaving this at PUBLIC_CATALOG_REVALIDATE_SECONDS would cap the
 * canonical directory pages at 10 minutes. Artist mutations already invalidate
 * PUBLIC_ARTIST_DIRECTORY_CACHE_TAG through revalidateArtistProfilePaths, so a
 * 24h fallback is a safety net rather than the freshness mechanism.
 */
export const PUBLIC_ARTIST_DIRECTORY_REVALIDATE_SECONDS = 86400;

export const PUBLIC_ARTIST_DIRECTORY_CACHE_TAG = "public-artist-directories";
export const PUBLIC_GENRE_CACHE_TAG = "public-genres";

/**
 * Genre data lives longer than the rest of the public catalog.
 *
 * Next.js resolves a route's revalidate as the minimum across everything it
 * reads, so leaving genre data at PUBLIC_CATALOG_REVALIDATE_SECONDS capped the
 * genre page's Full Route Cache at 10 minutes and undercut Phase 3A. These
 * caches are read only by the genre profile, and admin genre, subgenre and
 * genre-media mutations now invalidate PUBLIC_GENRE_CACHE_TAG on demand, so a
 * 24h fallback is a safety net rather than the freshness mechanism.
 */
export const PUBLIC_GENRE_REVALIDATE_SECONDS = 86400;

/**
 * Fallback freshness for the profile routes, split by how often the underlying
 * rows actually change.
 *
 * Same minimum rule as above, and the same trap: a route declares a TTL, but
 * any shorter revalidate on a cache it reads silently becomes the route's real
 * TTL. The artist works portfolio once hardcoded 600, which is exactly the kind
 * of cap that quietly defeats the export, so the portfolio cache must carry the
 * artist value below and not a shorter one.
 *
 * WHY THESE ARE LONG. The clock is not the freshness mechanism and has not been
 * since the on-demand path was built: admin mutations revalidate what they
 * touch, and /api/revalidate closes the gap after work written straight to
 * Postgres. The TTL only bounds how long a *missed* revalidation can persist.
 *
 * Paying for it as though it were the freshness mechanism is expensive, because
 * an ISR write unit is 8 KB and a profile rebuild writes roughly 34 KB — about
 * 4.2 units. The catalogue is ~41,700 cacheable profile URLs, so a full pass
 * costs around 174,000 write units against a 200,000 monthly Hobby allowance.
 * At a 7-day clock that pass repeats four times a month on rows nobody edited.
 *
 * Hence the split. Artists are the rows under constant editorial work and are
 * only ~1,286 URLs, so they keep a month-long safety net cheaply. Songs and
 * releases are ~40,400 URLs that are essentially never edited after creation,
 * and a year costs almost nothing.
 *
 * THE OLD VERIFICATION NO LONGER WORKS. At 2592000 the artist route once served
 * s-maxage=600 instead of the declared value, for reasons bisection never
 * established; at 604800 it honoured it. That history is why the artist value
 * below is 31 days rather than exactly 2592000 — it stays off the number that
 * misbehaved.
 *
 * But the check that history prescribes cannot be run any more: as of the
 * deploy of 63a54e8, none of the three profile routes serves s-maxage. Vercel
 * keeps the ISR entry behind x-vercel-cache rather than announcing its lifetime,
 * so these values cannot be read back off a response. See the longer note on
 * the artist route for what the headers do say and what to check instead.
 */
export const ARTIST_PROFILE_REVALIDATE_SECONDS = 2678400; // 31 days
export const CATALOG_PROFILE_REVALIDATE_SECONDS = 31536000; // 365 days
