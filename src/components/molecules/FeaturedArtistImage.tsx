import Image from "next/image"

type FeaturedArtist = {
  name: string
  image_url: string | null
}

type FeaturedArtistImageProps = {
  featuredArtist?: FeaturedArtist | null
}

export default function FeaturedArtistImage({ featuredArtist }: FeaturedArtistImageProps) {
  return (
    <div className="aspect-square w-full max-w-55 sm:max-w-75 mx-auto overflow-hidden rounded-xl bg-gray-100">
      {featuredArtist ? (
        <Image
          src={
            featuredArtist.image_url
              ? `${featuredArtist.image_url}?width=500`
              : "/placeholder.png"
          }
          alt={featuredArtist.name || "Featured Artist"}
          width={500}
          height={500}
          className="object-cover w-full h-full transition-opacity duration-500"
          priority
        />
      ) : (
        // Loading state: shows while Supabase is fetching the data
        <div className="w-full h-full bg-gray-200 animate-pulse" />
      )}
    </div>
  )
}