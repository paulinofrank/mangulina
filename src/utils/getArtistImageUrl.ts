export function getArtistImageUrl(artistId: string, version?: string | number | null) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
  const base = `${supabaseUrl}/storage/v1/object/public/artists-images`;
  const url = `${base}/${artistId}.webp`;
  return version ? `${url}?v=${encodeURIComponent(String(version))}` : url;
}

export function getArtistImageUrlIfAvailable(
  artist:
    | {
        id: string;
        has_image?: boolean | null;
        image_updated_at?: string | number | null;
      }
    | null
    | undefined,
) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;

  return artist?.has_image === true && Boolean(supabaseUrl)
    ? getArtistImageUrl(artist.id, artist.image_updated_at)
    : null;
}
