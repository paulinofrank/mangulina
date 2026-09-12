import { setRequestLocale } from "next-intl/server";
import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES } from "@/lib/artist-role-pages";

// Canonical directory HTML is cacheable: the shell no longer depends on
// searchParams, so filtered/paginated views are handled client-side and cannot
// multiply Full Route Cache entries. Artist mutations invalidate this through
// PUBLIC_ARTIST_DIRECTORY_CACHE_TAG, so the TTL is a fallback.
export const revalidate = 86400;

type ArtistsPageProps = {
  params: Promise<{ locale: string }>;
};

export default async function ArtistsPage({ params }: ArtistsPageProps) {
  const { locale } = await params;
  setRequestLocale(locale);

  return (
    <ArtistRoleDirectoryPage
      config={ARTIST_ROLE_PAGES.artists}
    />
  );
}
