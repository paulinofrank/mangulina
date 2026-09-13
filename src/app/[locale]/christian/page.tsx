import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistDirectoryInitialData } from "@/lib/artistDirectoryData";
import { getArtistGenreOptions } from "@/lib/artistGenreOptions";
import { createArtistDirectoryMetadata } from "@/lib/artist-role-pages";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createArtistDirectoryMetadata("christian", "/christian", locale);
}

type ChristianArtistsPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function ChristianArtistsPage({
  searchParams,
}: ChristianArtistsPageProps) {
  const filteredGenreOptions = await getArtistGenreOptions({
    context: "christian",
    artistTypes: ["solo_artist"],
  });
  const initialData = await getArtistDirectoryInitialData({
    searchParams: await searchParams,
    fixedContext: "christian",
    fixedArtistTypes: ["solo_artist"],
    filteredGenreOptions,
  });

  return (
    <ArtistDirectory
      path="/christian"
      i18nKey="christian"
      fixedContext="christian"
      fixedArtistTypes={["solo_artist"]}
      showRoleFilters
      filteredGenreOptions={filteredGenreOptions}
      initialData={initialData}
    />
  );
}
