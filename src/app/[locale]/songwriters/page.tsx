import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES, createArtistRoleMetadata } from "@/lib/artist-role-pages";

export const metadata = createArtistRoleMetadata("songwriters");

export default function SongwritersPage() {
  return <ArtistRoleDirectoryPage config={ARTIST_ROLE_PAGES.songwriters} />;
}
