import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES, createArtistRoleMetadata } from "@/lib/artist-role-pages";

export const metadata = createArtistRoleMetadata("producers");

export default function ProducersPage() {
  return <ArtistRoleDirectoryPage config={ARTIST_ROLE_PAGES.producers} />;
}
