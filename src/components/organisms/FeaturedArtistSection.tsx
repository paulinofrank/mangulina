import FeaturedArtistImage from "@/components/molecules/FeaturedArtistImage"
import FeaturedArtistInfo from "@/components/molecules/FeaturedArtistInfo"

export type FeaturedArtist = {
  id: string
  name: string
  origin_region?: string | null
  image_url?: string | null
}

type FeaturedArtistSectionProps = {
  featuredArtist: FeaturedArtist | null
}

export default function FeaturedArtistSection({ featuredArtist }: FeaturedArtistSectionProps) {
  if (!featuredArtist) return null

  return (
    <section className="relative mx-6 mt-8 overflow-hidden rounded-3xl border border-black/10 bg-white/90 shadow-xl sm:mx-12">
      <div className="px-8 py-10 sm:px-12 sm:py-12">
        <div className="max-w-4xl mx-auto">
          {/* FIX: Changed 'items-center' to 'items-stretch' on desktop 
              so the image matches the text height.
          */}
          <div className="flex flex-col sm:flex-row items-stretch gap-10">
            
            {/* FIX: Added 'shrink-0' to ensure the image container 
                never gives up its space to the text.
            */}
            <div className="w-full sm:w-5/12 shrink-0">
               <FeaturedArtistImage featuredArtist={featuredArtist} />
            </div>

            <div className="w-full sm:w-7/12 flex flex-col justify-center py-2">
               <FeaturedArtistInfo featuredArtist={featuredArtist} />
            </div>

          </div>
        </div>
      </div>
    </section>
  )
}