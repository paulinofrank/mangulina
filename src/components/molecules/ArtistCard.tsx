import Link from "next/link"
import ArtistImage from "@/components/atoms/ArtistImage"
import ArtistName from "@/components/atoms/ArtistName"
import ArtistRegion from "@/components/atoms/ArtistRegion"

export type Artist = {
  id: string
  name: string
  origin_region: string | null
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
      className="group snap-start shrink-0 w-32 sm:w-auto"
    >
      <ArtistImage imageUrl={artist.image_url} name={artist.name} />
      <ArtistName name={artist.name} as={titleAs} />
      <ArtistRegion region={artist.origin_region} />
    </Link>
  )
}
