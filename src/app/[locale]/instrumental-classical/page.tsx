import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistDirectoryInitialData } from "@/lib/artistDirectoryData";
import { createArtistDirectoryMetadata } from "@/lib/artist-role-pages";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createArtistDirectoryMetadata(
    "instrumentalClassical",
    "/instrumental-classical",
    locale,
  );
}

type InstrumentalClassicalPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

const INSTRUMENTAL_CLASSICAL_FILTER =
  "artist_tags.cs.{instrumental},primary_genre.eq.instrumental-classical,genres.cs.{instrumental-classical}";

export default async function InstrumentalClassicalPage({
  searchParams,
}: InstrumentalClassicalPageProps) {
  const initialData = await getArtistDirectoryInitialData({
    searchParams: await searchParams,
    fixedOrFilter: INSTRUMENTAL_CLASSICAL_FILTER,
  });

  return (
    <ArtistDirectory
      path="/instrumental-classical"
      i18nKey="instrumentalClassical"
      fixedOrFilter={INSTRUMENTAL_CLASSICAL_FILTER}
      hideGenreFilter
      hideProvinceSelector
      initialData={initialData}
    />
  );
}
