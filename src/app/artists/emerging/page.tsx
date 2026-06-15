import ArtistStatusDirectoryPage from "@/components/artists/ArtistStatusDirectoryPage";
import { createPageMetadata } from "@/lib/seo";

export const metadata = createPageMetadata({
  title: "Emerging Dominican Artists",
  description:
    "Discover emerging Dominican artists and rising talent across Dominican music in Mangulina, the Dominican Music Database.",
  path: "/artists/emerging",
});

export default function EmergingDominicanArtistsPage() {
  return (
    <ArtistStatusDirectoryPage
      path="/artists/emerging"
      heading="Emerging Dominican Artists"
      intro="Discover emerging Dominican artists and rising talent across Dominican music in Mangulina, the Dominican Music Database."
      artistStatus="emerging"
    />
  );
}
