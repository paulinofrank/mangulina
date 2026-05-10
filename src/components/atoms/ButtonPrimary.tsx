import { Play } from "lucide-react"

export default function ButtonPrimary() {
  return (
    <button className="flex items-center gap-2 bg-[#8B0000] hover:bg-[#6B0000] text-white font-semibold px-7 py-2.5 rounded-full shadow-sm transition-colors">
      <Play className="w-4 h-4 fill-current" /> Play
    </button>
  )
}
