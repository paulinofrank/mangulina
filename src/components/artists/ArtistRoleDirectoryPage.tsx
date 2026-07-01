import ArtistDirectory from "@/components/artists/ArtistDirectory";
import type { ArtistRolePageConfig } from "@/lib/artist-role-pages";
import { getArtistDirectoryInitialData } from "@/lib/artistDirectoryData";
import { getArtistGenreOptions } from "@/lib/artistGenreOptions";
import { getArtistInstrumentOptions } from "@/lib/artistInstrumentOptions";

export default async function ArtistRoleDirectoryPage({
  config,
  searchParams,
}: {
  config: ArtistRolePageConfig;
  searchParams?: Record<string, string | string[] | undefined>;
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
  const initialData = await getArtistDirectoryInitialData({
    searchParams,
    role: config.role,
    filteredGenreOptions,
  });

  return (
    <ArtistDirectory
      {...config}
      filteredGenreOptions={filteredGenreOptions}
      instrumentOptions={instrumentOptions}
      initialData={initialData}
    />
  );
}
