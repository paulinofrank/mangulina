export function getArtistImageUrl(artistId: string) {
  const base = `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/artists-images`;
  return `${base}/${artistId}.webp`; // or .webp if that's your new standard
}
