import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistOccupationOptions } from "@/lib/artistOccupationOptions";
import { createPageMetadata } from "@/lib/seo";

export const metadata = createPageMetadata({
  title: "Dominican Instrumental and Classical Artists",
  description:
    "Explore Dominican instrumentalists, classical musicians, orchestral performers, and related artists in Mangulina, the Dominican Music Database.",
  path: "/instrumental-classical",
});

export default async function InstrumentalClassicalPage() {
  const occupationOptions = await getArtistOccupationOptions("instrumentalist");

  return (
    <ArtistDirectory
      path="/instrumental-classical"
      i18nKey="instrumentalClassical"
      role="instrumentalist"
      hideGenreFilter
      hideProvinceSelector
      occupationOptions={occupationOptions}
    />
  );
}
