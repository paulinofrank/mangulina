import Link from "next/link"
import ArtistImage from "@/components/atoms/ArtistImage"
import ArtistName from "@/components/atoms/ArtistName"
import ArtistRegion from "@/components/atoms/ArtistRegion"

export type Artist = {
  id: string
  name: string
  // UPDATED: Changed from origin_region to birth_place
  birth_place: string | null
  image_url: string | null
}

type ArtistCardProps = {
  artist: Artist
  titleAs?: "h3" | "h4"
}

export default function ArtistCard({ artist, titleAs = "h3" }: ArtistCardProps) {
  return (
    <Link
      href={`/artists/${artist.id}`}
      // "group" is essential here so the image knows when the mouse is over the card
      className="group block w-full" 
    >
      {/* 1. THE FRAME: This stays exactly the same size always */}
      <div className="relative aspect-square w-full overflow-hidden rounded-xl bg-gray-100 border border-black/5 shadow-sm">
        
        {/* 2. THE IMAGE: The magnifier effect happens only here */}
        <div className="h-full w-full transition-transform duration-500 ease-out group-hover:scale-110">
          <ArtistImage 
            imageUrl={artist.image_url} 
            name={artist.name} 
          />
        </div>

      </div>

      {/* 3. THE TEXT: Since the frame above is locked, this never moves */}
      <div className="mt-3">
        <ArtistName name={artist.name} as={titleAs} />
        <ArtistRegion region={artist.birth_place} />
      </div>
    </Link>
  )
}