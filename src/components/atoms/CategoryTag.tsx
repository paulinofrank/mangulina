import Link from "next/link"

type CategoryTagProps = {
  label: string
  item: string
  color: string
}

export default function CategoryTag({ label, item, color }: CategoryTagProps) {
  return (
    <Link
      href={`/genres/${label.toLowerCase()}/${item.toLowerCase()}`}
      className="flex items-center gap-2 py-1.5 px-2 rounded-lg hover:bg-gray-50 transition-colors group"
    >
      <span 
        className="w-2 h-2 rounded-full shrink-0"
        style={{ backgroundColor: color }}
      />
      <span className="text-sm text-gray-700 group-hover:text-gray-900 truncate">
        {item}
      </span>
    </Link>
  )
}
