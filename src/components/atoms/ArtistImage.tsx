import Image from "next/image"

type ArtistImageProps = {
  imageUrl?: string | null
  name: string
}

export default function ArtistImage({ imageUrl, name }: ArtistImageProps) {
  return (
    <div className="aspect-square bg-white rounded-lg overflow-hidden mb-3 relative shadow-lg hover:shadow-xl transition-all group-hover:scale-105 border border-black/15 group-hover:border-[#8B0000]">
      {imageUrl ? (
        <Image
          src={`${imageUrl}?width=300`}
          alt={name}
          width={300}
          height={300}
          className="object-cover w-full h-full"
          loading="lazy"
        />
      ) : (
        <div className="w-full h-full bg-gray-200" />
      )}
    </div>
  )
}
