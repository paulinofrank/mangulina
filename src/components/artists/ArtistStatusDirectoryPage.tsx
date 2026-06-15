import ArtistDirectory from "@/components/artists/ArtistDirectory";

type ArtistStatusDirectoryPageProps = {
  path: string;
  heading: string;
  intro: string;
  artistStatus: "legend" | "emerging";
};

export default async function ArtistStatusDirectoryPage({
  path,
  heading,
  intro,
  artistStatus,
}: ArtistStatusDirectoryPageProps) {
  return (
    <ArtistDirectory
      path={path}
      heading={heading}
      intro={intro}
      fixedArtistStatus={artistStatus}
      hideGenreFilter
      hideProvinceSelector
    />
  );
}
