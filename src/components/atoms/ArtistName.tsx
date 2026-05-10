type ArtistNameProps = {
  name: string
  as?: "h3" | "h4"
}

export default function ArtistName({ name, as = "h3" }: ArtistNameProps) {
  if (as === "h4") {
    return (
      <h4 className="text-sm font-semibold text-gray-900 group-hover:text-[#8B0000] line-clamp-2">
        {name}
      </h4>
    )
  }

  return (
    <h3 className="text-sm font-semibold text-gray-900 group-hover:text-[#8B0000] line-clamp-2">
      {name}
    </h3>
  )
}
