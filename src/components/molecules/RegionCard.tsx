import Link from "next/link"
import RegionTag from "@/components/atoms/RegionTag"

type RegionCardProps = {
  region: string
  count: number
}

export default function RegionCard({ region, count }: RegionCardProps) {
  return (
    <Link
      href={`/artists?province=${encodeURIComponent(region)}`}
      className="group block rounded-lg px-3 py-2.5 bg-white border border-black/10 shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all w-full"
    >
      <RegionTag region={region} count={count} />
    </Link>
  )
}
