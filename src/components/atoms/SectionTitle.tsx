type SectionTitleProps = {
  children: React.ReactNode
  className?: string
}

export default function SectionTitle({ children, className = "" }: SectionTitleProps) {
  return (
    <h2 className={`text-3xl font-semibold tracking-tight text-gray-900 ${className}`}>
      {children}
    </h2>
  )
}
