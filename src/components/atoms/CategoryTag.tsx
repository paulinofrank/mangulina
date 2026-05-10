import Link from "next/link"

type CategoryTagProps = {
  label: string
  item: string
  color: string
}

export default function CategoryTag({ label, item, color }: CategoryTagProps) {
  return (
    <Link
      href={`/artists?${label.toLowerCase()}=${encodeURIComponent(item)}`}
      className="group block rounded-lg px-3 py-2 text-sm font-medium transition-all hover:bg-black/3"
      style={{ color }}
    >
      <span className="inline-flex items-center transition-transform group-hover:translate-x-1">
        → {item}
      </span>
    </Link>
  )
}
