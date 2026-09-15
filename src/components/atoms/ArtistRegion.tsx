import { useTranslations } from "next-intl"
import { isBornAbroadProvince } from "@/lib/provinceSlug"

type ArtistRegionProps = {
  region: string | null | undefined
}

export default function ArtistRegion({ region }: ArtistRegionProps) {
  const t = useTranslations("artistDirectory")

  if (!region) return null

  // The born-abroad sentinel is stored in Spanish; show it in the page language.
  const label = isBornAbroadProvince(region) ? t("abroadLabel") : region

  return (
    <p className="text-sm text-gray-600 truncate">
      {label}
    </p>
  )
}
