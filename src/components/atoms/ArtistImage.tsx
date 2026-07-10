"use client"

// ArtistImage.tsx  (Molecule)
import Image from "next/image"
import { useTranslations } from "next-intl"
import { useEffect, useState } from "react"

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
  const t = useTranslations("common")
  const [hasError, setHasError] = useState(false)

  useEffect(() => {
    setHasError(false)
  }, [imageUrl])

  if (!imageUrl || hasError) {
    return (
      <div className="relative h-full w-full flex items-center justify-center bg-gray-100 text-gray-400 text-xs italic">
        {t("noImage")}
      </div>
    )
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
