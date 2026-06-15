import ArtistRoleDirectoryPage from "@/components/artists/ArtistRoleDirectoryPage";
import { ARTIST_ROLE_PAGES } from "@/lib/artist-role-pages";

export default function ArtistsPage() {
  return <ArtistRoleDirectoryPage config={ARTIST_ROLE_PAGES.artists} />;
}
