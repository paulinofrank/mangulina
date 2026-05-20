import Link from "next/link"

type ButtonSecondaryProps = {
  href: string
  label?: string
}

export default function ButtonSecondary({ href, label = "View Full Profile" }: ButtonSecondaryProps) {
  return (
    <Link
      href={href}
      className="group inline-flex items-center gap-2 rounded-full border border-black/10 bg-white/70 px-4 py-2 text-sm font-normal text-[#002D62] transition-all hover:bg-[#002D62] hover:text-white hover:border-[#002D62]"
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
