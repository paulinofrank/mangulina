// ArtistImage.tsx  (Molecule)
import Image from "next/image"
import { useTranslations } from "next-intl"

type ArtistImageProps = {
  imageUrl: string | null | undefined
  name: string
}

export default function ArtistImage({ imageUrl, name }: ArtistImageProps) {
  const t = useTranslations("common")

  if (!imageUrl) {
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
      sizes="(max-width: 640px) 70vw, (max-width: 1024px) 35vw, 22vw"
    />
  )
}
