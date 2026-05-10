type RegionTagProps = {
  region: string
  count: number
}

export default function RegionTag({ region, count }: RegionTagProps) {
  return (
    <span className="text-[#002D62] font-semibold group-hover:text-[#8B0000] transition-colors">
      → {region} ({count})
    </span>
  )
}
