import { useTranslations } from "next-intl"
import { isBornAbroadProvince } from "@/lib/provinceSlug"

type ArtistRegionProps = {
  region: string | null | undefined
  artistType?: string | null
}

export default function ArtistRegion({ region, artistType }: ArtistRegionProps) {
  const t = useTranslations("artistDirectory")

  if (!region) return null

  // Keep the stored sentinel; collective origin is not a person's birthplace.
  const isCollective = artistType === "group" || artistType === "duo"
  const label = isBornAbroadProvince(region)
    ? t(isCollective ? "fromAbroadLabel" : "abroadLabel")
    : region

  return (
    <p className="text-sm text-gray-600 truncate">
      {label}
    </p>
  )
}
