export function getArtistImageUrl(artistId: string, version?: string | number | null) {
  const base = `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/artists-images`;
  const url = `${base}/${artistId}.webp`;
  return version ? `${url}?v=${encodeURIComponent(String(version))}` : url;
}
