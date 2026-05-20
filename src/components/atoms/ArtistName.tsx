type ArtistNameProps = {
  name: string
  as?: "h3" | "h4"
}

export default function ArtistName({ name, as: Tag = "h3" }: ArtistNameProps) {
  return (
    <Tag className="font-normal text-[#002D62] leading-snug truncate text-base">
      {name}
    </Tag>
  )
}
