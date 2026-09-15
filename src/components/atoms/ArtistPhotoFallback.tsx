// ArtistPhotoFallback.tsx  (Atom)
import Image from "next/image"

// Shown in place of an artist photo when the artist has none (or it fails to
// load). It fills whatever box a real photo would occupy — the parent sets the
// size, aspect ratio and corner radius — so swapping one for the other never
// shifts the layout. Decorative: the artist's name is always visible as text
// next to or under the image.
export default function ArtistPhotoFallback() {
  return (
    <div
      aria-hidden="true"
      className="relative flex h-full w-full items-center justify-center bg-linear-to-br from-[#F5F7FB] to-[#E6ECF4]"
    >
      {/* Sized as a share of the box, so the mark is small on cards and larger on the artist page hero. */}
      <div className="relative h-[38%] w-[38%]">
        <Image src="/icon.svg" alt="" fill unoptimized sizes="128px" className="object-contain" />
      </div>
    </div>
  )
}
