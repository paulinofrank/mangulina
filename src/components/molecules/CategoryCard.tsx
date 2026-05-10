import CategoryTag from "@/components/atoms/CategoryTag"

type CategoryCardProps = {
  label: string
  items: string[]
  color: string
}

export default function CategoryCard({ label, items, color }: CategoryCardProps) {
  return (
    <div
      className="p-5 bg-white rounded-2xl border border-black/10 shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all"
      style={{ borderTop: `4px solid ${color}` }}
    >
      <h3 className="text-lg font-semibold text-gray-900 mb-4" style={{ color }}>
        {label}
      </h3>

      <div className="space-y-2.5">
        {items.map((item) => (
          <CategoryTag key={item} label={label} item={item} color={color} />
        ))}
      </div>
    </div>
  )
}
