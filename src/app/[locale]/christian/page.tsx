import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistDirectoryInitialData } from "@/lib/artistDirectoryData";
import { getArtistGenreOptions } from "@/lib/artistGenreOptions";
import { createPageMetadata } from "@/lib/seo";

const description =
  "Explore Dominican Christian artists, singers, musicians, composers, and worship leaders in Mangulina, the Dominican Music Database.";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createPageMetadata({
    title: "Dominican Christian Artists",
    description,
    path: "/christian",
    locale,
  });
}

type ChristianArtistsPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function ChristianArtistsPage({
  searchParams,
}: ChristianArtistsPageProps) {
  const filteredGenreOptions = await getArtistGenreOptions({ context: "christian" });
  const initialData = await getArtistDirectoryInitialData({
    searchParams: await searchParams,
    fixedContext: "christian",
    filteredGenreOptions,
  });

  return (
    <ArtistDirectory
      path="/christian"
      i18nKey="christian"
      fixedContext="christian"
      showRoleFilters
      filteredGenreOptions={filteredGenreOptions}
      initialData={initialData}
    />
  );
}
