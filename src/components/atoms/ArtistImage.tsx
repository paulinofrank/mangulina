import Image from "next/image"

type ArtistImageProps = {
  imageUrl?: string | null
  name: string
}

export default function ArtistImage({ imageUrl, name }: ArtistImageProps) {
  const isInvalidImage = !imageUrl || imageUrl.includes("example.com");
  const finalSrc = isInvalidImage ? "/placeholder.png" : imageUrl;

  return (
    /* 
       The Frame: We keep 'overflow-hidden' and a fixed aspect ratio. 
       We REMOVED 'group-hover:scale-105' from here so the frame stays still.
    */
    <div className="aspect-square bg-white rounded-lg overflow-hidden mb-3 relative shadow-lg border border-black/15 transition-colors group-hover:border-[#8B0000]">
      <Image
        src={finalSrc}
        alt={name}
        fill 
        /* 
           The Magnifier: We apply the scale ONLY to the image. 
           'duration-500' makes the zoom smooth like your Featured section.
        */
        className="object-cover transition-transform duration-500 group-hover:scale-110"
        loading="lazy"
      />
    </div>
  )
}