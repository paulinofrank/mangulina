import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistDirectoryInitialData } from "@/lib/artistDirectoryData";

type ArtistStatusDirectoryPageProps = {
  path: string;
  heading?: string;
  intro?: string;
  i18nKey?: string;
  artistStatus: "legend" | "emerging";
  searchParams?: Record<string, string | string[] | undefined>;
};

export default async function ArtistStatusDirectoryPage({
  path,
  heading,
  intro,
  i18nKey,
  artistStatus,
  searchParams,
}: ArtistStatusDirectoryPageProps) {
  const initialData = await getArtistDirectoryInitialData({
    searchParams,
    fixedArtistStatus: artistStatus,
  });

  return (
    <ArtistDirectory
      path={path}
      heading={heading}
      intro={intro}
      i18nKey={i18nKey}
      fixedArtistStatus={artistStatus}
      hideGenreFilter
      hideProvinceSelector
      initialData={initialData}
    />
  );
}
