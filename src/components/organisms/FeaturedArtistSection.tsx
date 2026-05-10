import FeaturedArtistImage from "@/components/molecules/FeaturedArtistImage"
import FeaturedArtistInfo from "@/components/molecules/FeaturedArtistInfo"

// This matches your artists table structure
export type FeaturedArtist = {
  id: string
  name: string
  origin_region?: string | null
  image_url?: string | null
  // Add other fields from your artists table if needed
}

type FeaturedArtistSectionProps = {
  featuredArtist: FeaturedArtist | null
}

export default function FeaturedArtistSection({ featuredArtist }: FeaturedArtistSectionProps) {
  // If no artist is found in the featured_artist table, we hide the section
  if (!featuredArtist) return null

  return (
    <section className="relative mx-6 mt-8 overflow-hidden rounded-3xl border border-black/10 bg-white/90 shadow-xl sm:mx-12">
      <div className="h-120 px-8 py-10 sm:px-12 sm:py-12">
        <div className="max-w-4xl h-full">
          <div className="mb-4 flex flex-col sm:flex-row items-center gap-8 h-full">
            <FeaturedArtistImage featuredArtist={featuredArtist} />
            <FeaturedArtistInfo featuredArtist={featuredArtist} />
          </div>
        </div>
      </div>
    </section>
  )
}