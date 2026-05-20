import Link from "next/link"

type ButtonPrimaryProps = {
  href: string
  label?: string
}

export default function ButtonPrimary({ href, label = "Explore" }: ButtonPrimaryProps) {
  return (
    <Link
      href={href}
      className="group inline-flex items-center gap-2 rounded-full bg-[#8B0000] px-6 py-3 text-sm font-semibold text-white shadow-lg shadow-[#8B0000]/20 transition-all hover:bg-[#6B0000] hover:shadow-xl hover:shadow-[#8B0000]/30"
    >
      <span>{label}</span>
      <svg 
        width="14" 
        height="14" 
        viewBox="0 0 24 24" 
        fill="none" 
        stroke="currentColor" 
        strokeWidth="2.5" 
        strokeLinecap="round" 
        strokeLinejoin="round"
        className="transition-transform group-hover:translate-x-0.5"
      >
        <path d="M5 12h14M12 5l7 7-7 7"/>
      </svg>
    </Link>
  )
}
