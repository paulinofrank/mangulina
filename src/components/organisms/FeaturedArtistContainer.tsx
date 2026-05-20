//FeaturedArtistContainer.tsx
import { getSupabaseClient } from '@/lib/supabase';
import FeaturedArtistImage from '@/components/molecules/FeaturedArtistImage';
import type { Artist } from '@/types/music';

export default async function FeaturedArtistContainer() {
  // 1. USE YOUR EXISTING SINGLETON
  const supabase = getSupabaseClient();

  // 2. FETCH THE FEATURED SLOT
  // We specify the type manually to avoid any "never" errors during build
const featured = await supabase
  .from("featured_artist")
  .select(`
    artist:artists!fk_featured_artist_artist (
      id,
      name,
      stage_name,
      province,
      birth_place,
      bio,
      image_url,
      is_religious,
      facebook,
      instagram,
      genres,
      views
    )
  `)
  .eq("id", 1)
  .single();

const featuredArtist =
  (featured.data as any)?.artist ?? null;

  return <FeaturedArtistImage featuredArtist={featuredArtist} />;
}