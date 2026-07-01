import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES, createArtistRoleMetadata } from "@/lib/artist-role-pages";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createArtistRoleMetadata("producers", locale);
}

type ProducersPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function ProducersPage({ searchParams }: ProducersPageProps) {
  return (
    <ArtistRoleDirectoryPage
      config={ARTIST_ROLE_PAGES.producers}
      searchParams={await searchParams}
    />
  );
}
