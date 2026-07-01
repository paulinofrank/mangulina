import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES, createArtistRoleMetadata } from "@/lib/artist-role-pages";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createArtistRoleMetadata("lyricists", locale);
}

type LyricistsPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function LyricistsPage({ searchParams }: LyricistsPageProps) {
  return (
    <ArtistRoleDirectoryPage
      config={ARTIST_ROLE_PAGES.lyricists}
      searchParams={await searchParams}
    />
  );
}
