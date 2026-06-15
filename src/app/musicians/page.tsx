import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES, createArtistRoleMetadata } from "@/lib/artist-role-pages";

export const metadata = createArtistRoleMetadata("musicians");

export default function MusiciansPage() {
  return <ArtistRoleDirectoryPage config={ARTIST_ROLE_PAGES.musicians} />;
}
