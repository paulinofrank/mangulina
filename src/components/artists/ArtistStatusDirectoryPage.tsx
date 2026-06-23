import ArtistDirectory from "@/components/artists/ArtistDirectory";

type ArtistStatusDirectoryPageProps = {
  path: string;
  heading?: string;
  intro?: string;
  i18nKey?: string;
  artistStatus: "legend" | "emerging";
};

export default async function ArtistStatusDirectoryPage({
  path,
  heading,
  intro,
  i18nKey,
  artistStatus,
}: ArtistStatusDirectoryPageProps) {
  return (
    <ArtistDirectory
      path={path}
      heading={heading}
      intro={intro}
      i18nKey={i18nKey}
      fixedArtistStatus={artistStatus}
      hideGenreFilter
      hideProvinceSelector
    />
  );
}
