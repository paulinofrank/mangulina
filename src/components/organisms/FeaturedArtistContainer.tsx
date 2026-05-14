import { getSupabaseClient } from '@/lib/supabase';
import FeaturedArtistImage from '@/components/molecules/FeaturedArtistImage';
import type { Artist } from '@/types/music';

export default async function FeaturedArtistContainer() {
  // 1. USE YOUR EXISTING SINGLETON
  const supabase = getSupabaseClient();

  // 2. FETCH THE FEATURED SLOT
  // We specify the type manually to avoid any "never" errors during build
  const { data } = await supabase
    .from('featured_artist')
    .select(`
      artists (
        id,
        name,
        image_url,
        birth_place,
        genres
      )
    `)
    .single();

  const row = data as { artists?: Artist | null } | null;
  const artist = row?.artists ?? null;

  return <FeaturedArtistImage featuredArtist={artist} />;
}