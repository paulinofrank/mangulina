import ButtonSecondary from "@/components/atoms/ButtonSecondary"
import type { Artist } from "@/types/music"

type FeaturedArtistInfoProps = {
  featuredArtist?: Artist | null
}

export default function FeaturedArtistInfo({ featuredArtist }: FeaturedArtistInfoProps) {
  return (
    <div className="flex-1">
      <p className="text-[#8B0000] text-sm font-semibold uppercase tracking-[0.16em]">
        Featured Artist
      </p>

      <h1 className="text-5xl sm:text-6xl font-semibold tracking-tight text-gray-900 mt-3 mb-5">
        {featuredArtist?.name || "Featured Artist"}
      </h1>

      <div className="flex items-center gap-4 mb-5 text-sm font-medium">
        {featuredArtist?.birth_place && (
          <span className="text-gray-600">
            <span className="text-gray-400 mr-1">From:</span>
            <span className="bg-gray-100 px-2 py-1 rounded">
              {featuredArtist.birth_place}
            </span>
          </span>
        )}

        {featuredArtist?.genres && featuredArtist.genres.length > 0 && (
          <span className="text-gray-600">
            <span className="text-gray-400 mr-1">Genre:</span>
            <span className="bg-gray-100 px-2 py-1 rounded">
              {featuredArtist.genres.join(", ")}
            </span>
          </span>
        )}
      </div>

      <p className="text-gray-700 max-w-lg text-base mb-8 leading-relaxed">
        Discover the greatest artists from Dominican music history with detailed information and cultural context.
      </p>

      <div className="flex items-center gap-3">
        <ButtonSecondary 
          href={featuredArtist ? `/artists/${featuredArtist.id}` : "#"} 
        />
      </div>
    </div>
  )
}