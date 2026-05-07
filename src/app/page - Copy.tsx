'use client'

import Link from "next/link"
import Image from "next/image"
import { Play } from "lucide-react"
import { useEffect, useState } from "react"
import { supabase } from "@/lib/supabase"

export default function HomePage() {
  const [artists, setArtists] = useState<any[]>([])
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const fetchArtists = async () => {
      try {
        const { data, error } = await supabase
          .from("artists")
          .select("id, name, origin_region, image_url, views")
          .order("views", { ascending: false })
          .limit(6)

        if (!error && data) {
          setArtists(data)
        }
      } catch (err) {
        console.error(err)
      } finally {
        setIsLoading(false)
      }
    }

    fetchArtists()
  }, [])

  const featuredArtist = artists[0]

  return (
    <div className="min-h-screen bg-transparent relative overflow-hidden">
      {/* Gradient Corners */}
      <div className="fixed inset-0 pointer-events-none">
        <div className="absolute top-0 left-0 w-96 h-96 bg-linear-to-br from-[#002D62] via-[#002D62]/50 to-transparent rounded-full blur-3xl opacity-20" />
        <div className="absolute top-0 right-0 w-96 h-96 bg-linear-to-bl from-[#8B0000] via-[#8B0000]/50 to-transparent rounded-full blur-3xl opacity-20" />
        <div className="absolute bottom-0 left-0 w-96 h-96 bg-linear-to-tr from-[#8B0000] via-[#8B0000]/50 to-transparent rounded-full blur-3xl opacity-20" />
        <div className="absolute bottom-0 right-0 w-96 h-96 bg-linear-to-tl from-[#002D62] via-[#002D62]/50 to-transparent rounded-full blur-3xl opacity-20" />
      </div>

      {/* Hero Banner */}
      <section className="relative mx-6 mt-8 overflow-hidden rounded-3xl border border-black/10 bg-white/90 shadow-xl sm:mx-12">
        <div className="h-120 px-8 py-10 sm:px-12 sm:py-12">
          <div className="max-w-4xl">
            <div className="mb-4 flex items-center gap-8">

              {/* Featured Artist Image */}
              <div className="w-100 h-100 rounded-lg shadow-2xl border border-black/20 overflow-hidden">
                {featuredArtist ? (
                  <Image
                    src={featuredArtist.image_url}
                    alt={featuredArtist.name}
                    width={300}
                    height={300}
                    className="object-cover w-full h-full"
                  />
                ) : (
                  <div className="w-full h-full bg-gray-200 animate-pulse" />
                )}
              </div>

              {/* Featured Artist Text */}
              <div className="flex-1">
                <p className="text-[#8B0000] text-sm font-semibold uppercase tracking-[0.16em]">
                  Featured Artist
                </p>

                <h1 className="text-5xl sm:text-6xl font-semibold tracking-tight text-gray-900 mt-3 mb-5">
                  {featuredArtist?.name || "Featured Artist"}
                </h1>

                <div className="flex items-center gap-4 mb-5 text-sm">
                  <span className="text-gray-600 font-semibold">
                    {featuredArtist?.origin_region || "Dominican Legend"}
                  </span>
                  <span className="text-gray-600 font-semibold">
                    {featuredArtist?.genre || "Merengue"}
                  </span>
                </div>

                <p className="text-gray-700 max-w-lg text-base mb-8 leading-relaxed">
                  Discover the greatest artists from Dominican music history with detailed information and cultural context.
                </p>

                <div className="flex gap-3">
                  <button className="flex items-center gap-2 bg-[#8B0000] hover:bg-[#6B0000] text-white font-semibold px-7 py-2.5 rounded-full shadow-sm transition-colors">
                    <Play className="w-4 h-4 fill-current" /> Play
                  </button>
                  <Link
                    href={`/artists/${featuredArtist?.id || ""}`}
                    className="bg-[#002D62] hover:bg-[#001A3A] text-white font-semibold px-7 py-2.5 rounded-full shadow-sm transition-colors"
                  >
                    More Info
                  </Link>
                </div>
              </div>

            </div>
          </div>
        </div>
      </section>

      {/* Main Content Container */}
      <div className="relative px-6 sm:px-12 py-14 space-y-14">

        {/* Top Artists */}
        <section className="rounded-3xl border border-black/10 bg-white/85 p-6 shadow-lg sm:p-8">
          <div className="flex items-center justify-between mb-6 pb-4 border-b border-[#002D62]/25">
            <h2 className="text-3xl font-semibold tracking-tight text-gray-900">Top Artists</h2>
            <Link href="/artists" className="text-[#8B0000] hover:text-[#6B0000] font-semibold text-sm">
              See All →
            </Link>
          </div>

          <div className="grid gap-5 grid-cols-2 sm:grid-cols-3 lg:grid-cols-6">
            {artists.map((artist) => (
              <Link key={artist.id} href={`/artists/${artist.id}`} className="group">
                <div className="aspect-square bg-white rounded-lg overflow-hidden mb-3 relative shadow-lg hover:shadow-xl transition-all group-hover:scale-105 border border-black/15 group-hover:border-[#8B0000]">
                  {artist.image_url ? (
                    <Image
                      src={artist.image_url}
                      alt={artist.name}
                      width={300}
                      height={300}
                      className="object-cover w-full h-full"
                    />
                  ) : (
                    <div className="w-full h-full bg-gray-200" />
                  )}
                </div>
                <h3 className="text-sm font-semibold text-gray-900 group-hover:text-[#8B0000] line-clamp-2">
                  {artist.name}
                </h3>
                <p className="text-xs text-gray-600 mt-1">
                  {artist.genre || "Dominican Artist"}
                </p>
              </Link>
            ))}
          </div>
        </section>

        {/* Trending Artists */}
        <section className="rounded-3xl border border-black/10 bg-white/85 p-6 shadow-lg sm:p-8">
          <div className="flex items-center justify-between mb-6 pb-4 border-b border-[#002D62]/25">
            <h2 className="text-3xl font-semibold tracking-tight text-gray-900">Trending Artists</h2>
            <Link href="/artists" className="text-[#8B0000] hover:text-[#6B0000] font-semibold text-sm">
              See All →
            </Link>
          </div>

          <div className="grid gap-5 grid-cols-2 sm:grid-cols-3 lg:grid-cols-5">
            {artists.map((artist) => (
              <Link key={artist.id} href={`/artists/${artist.id}`} className="group">
                <div className="aspect-square bg-white rounded-lg overflow-hidden mb-3 relative shadow-lg hover:shadow-xl transition-all group-hover:scale-105 border border-black/15 group-hover:border-[#8B0000]">
                  {artist.image_url ? (
                    <Image
                      src={artist.image_url}
                      alt={artist.name}
                      width={300}
                      height={300}
                      className="object-cover w-full h-full"
                    />
                  ) : (
                    <div className="w-full h-full bg-gray-200" />
                  )}
                </div>
                <h4 className="text-sm font-semibold text-gray-900 group-hover:text-[#8B0000] line-clamp-2">
                  {artist.name}
                </h4>
                <p className="text-xs text-gray-600 mt-1">
                  {artist.genre || "Dominican Legend"}
                </p>
              </Link>
            ))}
          </div>
        </section>

        {/* Browse Categories */}
        <section className="bg-white/90 rounded-3xl p-8 sm:p-10 border border-[#002D62]/20 shadow-xl">
          <h2 className="text-3xl font-semibold tracking-tight text-gray-900 mb-8 pb-4 border-b border-[#8B0000]/25">
            Browse Artists by Category
          </h2>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {[
              { label: "Genre", items: ["Merengue", "Bachata", "Salsa", "Dembow"], color: "#002D62" },
              { label: "Era", items: ["1950s-1970s", "1980s-1990s", "2000s-2010s", "Modern"], color: "#8B0000" },
              { label: "Region", items: ["Santo Domingo", "Cibao", "El Sur", "International"], color: "#002D62" },
              { label: "Style", items: ["Traditional", "Contemporary", "Fusion", "Innovative"], color: "#8B0000" }
            ].map((category) => (
              <div
                key={category.label}
                className="p-5 bg-white rounded-2xl border border-black/10 shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all"
                style={{ borderTop: `4px solid ${category.color}` }}
              >
                <h3 className="text-lg font-semibold text-gray-900 mb-4" style={{ color: category.color }}>
                  {category.label}
                </h3>
                <div className="space-y-2.5">
                  {category.items.map((item) => (
                    <Link
                      key={item}
                      href={`/artists?${category.label.toLowerCase()}=${encodeURIComponent(item)}`}
                      className="group block rounded-lg px-3 py-2 text-sm font-medium transition-all hover:bg-black/3"
                      style={{ color: category.color }}
                    >
                      <span className="inline-flex items-center transition-transform group-hover:translate-x-1">
                        → {item}
                      </span>
                    </Link>
                  ))}
                </div>
              </div>
            ))}
          </div>
        </section>
      </div>
    </div>
  )
}
