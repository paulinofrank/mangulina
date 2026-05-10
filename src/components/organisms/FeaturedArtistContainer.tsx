import { createClient } from '@/utils/supabase/server'
import FeaturedArtistImage from './FeaturedArtistImage'

export default async function FeaturedArtistContainer() {
  const supabase = createClient()

  // Fetch the single featured slot and join the artist details
  const { data } = await supabase
    .from('featured_artist')
    .select(`
      artists (
        name,
        image_url
      )
    `)
    .single()

  // If no artist is featured, the UI component handles the skeleton/placeholder
  const artist = data?.artists

  return <FeaturedArtistImage featuredArtist={artist} />
}