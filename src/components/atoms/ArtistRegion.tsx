type ArtistRegionProps = {
  region?: string | null
}

export default function ArtistRegion({ region }: ArtistRegionProps) {
  return (
    <p className="text-xs text-gray-600 mt-1">
      {region || "Falta lugar de origen"}
    </p>
  )
}
