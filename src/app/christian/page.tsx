import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistGenreOptions } from "@/lib/artistGenreOptions";
import { createPageMetadata } from "@/lib/seo";

const description =
  "Explore Dominican Christian artists, singers, musicians, composers, and worship leaders in Mangulina, the Dominican Music Database.";

export const metadata = createPageMetadata({
  title: "Dominican Christian Artists",
  description,
  path: "/christian",
});

export default async function ChristianArtistsPage() {
  const filteredGenreOptions = await getArtistGenreOptions({ context: "christian" });

  return (
    <ArtistDirectory
      path="/christian"
      heading="Dominican Christian Artists"
      intro="Explore Dominican Christian artists across worship, merengue, bachata, contemporary Christian music, and other expressions of faith-based Dominican music in Mangulina, the Dominican Music Database."
      fixedContext="christian"
      showRoleFilters
      filteredGenreOptions={filteredGenreOptions}
    />
  );
}
