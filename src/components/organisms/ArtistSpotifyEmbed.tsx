import type { ArtistProfileData } from "@/lib/artistApi";
import { getSpotifyEmbedUrl } from "@/lib/artistSocialLinks";

// Generalized from the Covi Quintana pilot (docs/experiments/spotify-artist-embed-pilot.md):
// same card styling and official iframe, now driven by artists.spotify instead
// of a hardcoded artist ID. Renders nothing when the artist has no Spotify ID.
export default function ArtistSpotifyEmbed({
  artist,
}: {
  artist: Pick<ArtistProfileData, "name" | "spotify">;
}) {
  const embedUrl = getSpotifyEmbedUrl(artist.spotify);
  if (!embedUrl) return null;

  return (
    <section
      aria-label={`Spotify — ${artist.name}`}
      className="min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6"
    >
      <iframe
        title={`Spotify — ${artist.name}`}
        src={embedUrl}
        width="100%"
        height="352"
        className="block w-full rounded-xl border-0"
        allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture"
        allowFullScreen
        loading="lazy"
      />
    </section>
  );
}
