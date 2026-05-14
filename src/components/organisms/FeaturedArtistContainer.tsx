import { getSupabaseClient } from '@/lib/supabase';
import FeaturedArtistImage from '@/components/molecules/FeaturedArtistImage';

export default async function FeaturedArtistContainer() {
  // 1. USE YOUR EXISTING SINGLETON
  const supabase = getSupabaseClient();

  // 2. FETCH THE FEATURED SLOT
  // We specify the type manually to avoid any "never" errors during build
  const { data } = await supabase
    .from('featured_artist')
    .select(`
      artists (
        name,
        image_url
      )
    `)
    .single();

  // 3. EXTRACT THE ARTIST OBJECT
  // Using a cast to any here prevents strict type-checking from failing 
  // if the join relationship isn't fully defined in your types
  const artist = (data as any)?.artists;

  return <FeaturedArtistImage featuredArtist={artist} />;
}