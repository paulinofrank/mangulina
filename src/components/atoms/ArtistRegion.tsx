type ArtistRegionProps = {
  region: string | null | undefined
}

export default function ArtistRegion({ region }: ArtistRegionProps) {
  if (!region) return null

  return (
    <p className="text-sm text-gray-600 truncate">
      {region}
    </p>
  )
}
