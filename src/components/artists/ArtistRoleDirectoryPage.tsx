import ArtistDirectory from "@/components/artists/ArtistDirectory";
import type { ArtistRolePageConfig } from "@/lib/artist-role-pages";
import { getArtistGenreOptions } from "@/lib/artistGenreOptions";
import { getArtistInstrumentOptions } from "@/lib/artistInstrumentOptions";

export default async function ArtistRoleDirectoryPage({
  config,
}: {
  config: ArtistRolePageConfig;
}) {
  const filteredGenreOptions = config.hideGenreFilter
    ? undefined
    : await getArtistGenreOptions({
        context: "secular",
        role: config.role,
      });
  const instrumentOptions = config.showInstrumentFilter
    ? await getArtistInstrumentOptions(config.role)
    : undefined;

  return (
    <ArtistDirectory
      {...config}
      filteredGenreOptions={filteredGenreOptions}
      instrumentOptions={instrumentOptions}
    />
  );
}
