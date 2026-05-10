import SectionTitle from "@/components/atoms/SectionTitle"
import CategoryCard from "@/components/molecules/CategoryCard"

const categories = [
  { label: "Genre", items: ["Merengue", "Bachata", "Salsa", "Dembow"], color: "#002D62" },
  { label: "Era", items: ["1950s-1970s", "1980s-1990s", "2000s-2010s", "Modern"], color: "#8B0000" },
  { label: "Region", items: ["Santo Domingo", "Cibao", "El Sur", "International"], color: "#002D62" },
  { label: "Style", items: ["Traditional", "Contemporary", "Fusion", "Innovative"], color: "#8B0000" }
]

export default function BrowseCategoriesSection() {
  return (
    <section className="bg-white/90 rounded-3xl p-8 sm:p-10 border border-[#002D62]/20 shadow-xl">
      <SectionTitle className="mb-8 pb-4 border-b border-[#8B0000]/25">
        Browse Artists by Category
      </SectionTitle>

      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {categories.map((category) => (
          <CategoryCard
            key={category.label}
            label={category.label}
            items={category.items}
            color={category.color}
          />
        ))}
      </div>
    </section>
  )
}
