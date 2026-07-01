import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES, createArtistRoleMetadata } from "@/lib/artist-role-pages";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createArtistRoleMetadata("composers", locale);
}

type ComposersPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function ComposersPage({ searchParams }: ComposersPageProps) {
  return (
    <ArtistRoleDirectoryPage
      config={ARTIST_ROLE_PAGES.composers}
      searchParams={await searchParams}
    />
  );
}
