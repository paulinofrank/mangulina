import ArtistStatusDirectoryPage from "@/components/artists/ArtistStatusDirectoryPage";
import { createPageMetadata } from "@/lib/seo";

export const metadata = createPageMetadata({
  title: "Dominican Music Legends",
  description:
    "Explore legendary Dominican artists and influential figures who shaped Dominican music history in Mangulina, the Dominican Music Database.",
  path: "/artists/legends",
});

export default function DominicanMusicLegendsPage() {
  return (
    <ArtistStatusDirectoryPage
      path="/artists/legends"
      i18nKey="legends"
      artistStatus="legend"
    />
  );
}
