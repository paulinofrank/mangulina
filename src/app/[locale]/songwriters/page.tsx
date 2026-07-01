import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES, createArtistRoleMetadata } from "@/lib/artist-role-pages";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createArtistRoleMetadata("songwriters", locale);
}

type SongwritersPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function SongwritersPage({ searchParams }: SongwritersPageProps) {
  return (
    <ArtistRoleDirectoryPage
      config={ARTIST_ROLE_PAGES.songwriters}
      searchParams={await searchParams}
    />
  );
}
