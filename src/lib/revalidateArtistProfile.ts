import { revalidatePath, revalidateTag } from "next/cache";
import { routing } from "@/i18n/routing";
import {
  invalidateArtistPortfolio,
  invalidateArtistPortfolioCache,
} from "@/lib/artistPortfolioCache";
import { PUBLIC_ARTIST_DIRECTORY_CACHE_TAG } from "@/lib/publicCatalogCache";

export function getArtistProfileRevalidationPaths(slug: string) {
  const normalizedSlug = slug.trim();
  const paths = new Set<string>();

  if (!normalizedSlug) return paths;

  paths.add(`/artists/${normalizedSlug}`);
  paths.add(`/en/artists/${normalizedSlug}`);
  paths.add(`/es/artists/${normalizedSlug}`);

  for (const locale of routing.locales) {
    paths.add(
      locale === routing.defaultLocale
        ? `/artists/${normalizedSlug}`
        : `/${locale}/artists/${normalizedSlug}`,
    );
  }

  return paths;
}

/**
 * Refreshes the listings an artist appears in, without touching any profile.
 *
 * The directory tag is read by the artist directories, the province and role
 * listings and the paginated pages behind them — never by a profile page. So
 * clearing it rebuilds a few hundred listing URLs and leaves every profile
 * cached. Publication must also invalidate the named profile: its public URL
 * may already hold a cached 404 from a request made while the artist was draft.
 */
export function revalidateArtistDirectories() {
  revalidateTag(PUBLIC_ARTIST_DIRECTORY_CACHE_TAG, { expire: 0 });
}

/**
 * Invalidates every artist profile and directory in one call.
 *
 * Both tags are shared across all artists — the portfolio cache is read by
 * every profile page, the directory cache by every listing — so clearing them
 * sweeps the whole set without naming a slug.
 *
 * That breadth is the point when the portfolio's shape changes for everyone: a
 * schema change, a layout change, a credit-role change. It is the wrong tool
 * for editing one artist, and it used to be the only tool, which is why a
 * single admin save rebuilt the entire artist catalogue. Prefer
 * revalidateArtistProfile below.
 *
 * The cost is the whole catalogue: at ~4.2 ISR write units per profile rebuild
 * and two locales, 643 artists is roughly 5,400 units and 5,000 artists would
 * be roughly 42,000.
 */
export function revalidateAllArtistProfiles() {
  invalidateArtistPortfolioCache();
  revalidateArtistDirectories();
}

/**
 * Refreshes one artist and the listings that show them. Nothing else.
 *
 * Pass the artist id whenever it is known: it targets that artist's portfolio
 * entry instead of dropping all of them. Without it the portfolio cannot be
 * targeted, so callers that only hold a slug should resolve the id first —
 * every caller in this repo now does.
 */
export function revalidateArtistProfile(slug: string, artistId?: string | null, previousSlugs: readonly string[] = []) {
  if (artistId) invalidateArtistPortfolio(artistId);
  revalidateArtistDirectories();

  const paths = new Set([slug, ...previousSlugs].flatMap((value) => [...getArtistProfileRevalidationPaths(value)]));
  for (const path of paths) {
    // Concrete URLs need their pathname tag, without the route-pattern suffix.
    // This also removes a cached 404 created before the artist was published.
    revalidatePath(path);
  }
}

/**
 * Back-compatible alias.
 *
 * It no longer sweeps every profile — that behaviour moved to
 * revalidateAllArtistProfiles, which callers must now ask for explicitly.
 */
export function revalidateArtistProfilePaths(slug: string, artistId?: string | null, previousSlugs: readonly string[] = []) {
  revalidateArtistProfile(slug, artistId, previousSlugs);
}
