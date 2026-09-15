"use client"

// ArtistImage.tsx  (Molecule)
import Image from "next/image"
import { useEffect, useState } from "react"
import ArtistPhotoFallback from "@/components/atoms/ArtistPhotoFallback"

type ArtistImageProps = {
  imageUrl: string | null | undefined
  name: string
  priority?: boolean
  sizes?: string
}

export default function ArtistImage({
  imageUrl,
  name,
  priority = false,
  sizes = "(max-width: 640px) 112px, (max-width: 1024px) 128px, 144px",
}: ArtistImageProps) {
  const [hasError, setHasError] = useState(false)

  useEffect(() => {
    setHasError(false)
  }, [imageUrl])

  if (!imageUrl || hasError) {
    return <ArtistPhotoFallback />
  }

  return (
    <Image
      src={imageUrl}
      alt={name}
      fill
      className="object-cover"
      sizes={sizes}
      loading={priority ? "eager" : "lazy"}
      fetchPriority={priority ? "high" : "auto"}
      unoptimized={true}
      onError={() => setHasError(true)}
    />
  )
}
