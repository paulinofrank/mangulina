import Link from "next/link"

type ButtonSecondaryProps = {
  href: string
}

export default function ButtonSecondary({ href }: ButtonSecondaryProps) {
  return (
    <Link
      href={href}
      className="flex items-center bg-[#002D62] hover:bg-[#001A3A] text-white font-semibold px-7 py-2.5 rounded-full shadow-sm transition-colors"
    >
      More Info
    </Link>
  )
}
