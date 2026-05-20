export default function GradientBackground() {
  return (
    <div className="fixed inset-0 pointer-events-none">
      <div className="absolute top-0 left-0 w-96 h-96 bg-linear-to-br from-[#002D62] via-[#002D62]/50 to-transparent rounded-full blur-3xl opacity-20" />
      <div className="absolute top-0 right-0 w-96 h-96 bg-linear-to-bl from-[#8B0000] via-[#8B0000]/50 to-transparent rounded-full blur-3xl opacity-20" />
      <div className="absolute bottom-0 left-0 w-96 h-96 bg-linear-to-tr from-[#8B0000] via-[#8B0000]/50 to-transparent rounded-full blur-3xl opacity-20" />
      <div className="absolute bottom-0 right-0 w-96 h-96 bg-linear-to-tl from-[#002D62] via-[#002D62]/50 to-transparent rounded-full blur-3xl opacity-20" />
    </div>
  )
}
