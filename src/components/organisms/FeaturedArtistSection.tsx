//FeaturedArtistSection.tsx
import FeaturedArtistImage from "@/components/molecules/FeaturedArtistImage"
import FeaturedArtistInfo from "@/components/molecules/FeaturedArtistInfo"
import type { Artist } from "@/types/music"

type FeaturedArtistSectionProps = {
  featuredArtist: Artist | null
}

export default function FeaturedArtistSection({ featuredArtist }: FeaturedArtistSectionProps) {
  if (!featuredArtist) return null

  return (
    <section className="relative overflow-hidden rounded-xl border border-black/5 bg-white/60">
      <div className="px-5 py-6 sm:px-6">
        <div className="flex flex-col md:flex-row items-start gap-6">
          <FeaturedArtistImage featuredArtist={featuredArtist} />
          <FeaturedArtistInfo featuredArtist={featuredArtist} />
        </div>
      </div>
    </section>
  )
}
