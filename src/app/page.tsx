'use client'

import Link from "next/link"
import Image from "next/image"
import { Play } from "lucide-react"
import { useEffect, useState } from "react"
import { supabase } from "@/lib/supabase"

export default function HomePage() {
  const [topArtists, setTopArtists] = useState<any[]>([])
  const [regions, setRegions] = useState<any[]>([])
  const [isLoadingArtists, setIsLoadingArtists] = useState(true)

  useEffect(() => {
    const fetchTopArtists = async () => {
      try {
        const { data, error } = await supabase
          .from('artists')
          .select('id, name, origin_region, image_url, views')
          .order('views', { ascending: false })
          .limit(6)

        if (!error && data) {
          setTopArtists(data)
        }
      } catch (err) {
        console.error(err)
      } finally {
        setIsLoadingArtists(false)
      }
    }

    const fetchRegions = async () => {
      const { data, error } = await supabase
        .from("artists")
        .select("origin_region")
        .not("origin_region", "is", null)

      if (error || !data) return

      const regionMap: Record<string, number> = {}

      data.forEach((row) => {
        if (!regionMap[row.origin_region]) {
          regionMap[row.origin_region] = 1
        } else {
          regionMap[row.origin_region]++
        }
      })

      // Convert to array + alphabetical sort
      const regions = Object.entries(regionMap)
        .map(([region, count]) => ({
          origin_region: region,
          count
        }))
        .sort((a, b) => a.origin_region.localeCompare(b.origin_region))

      setRegions(regions)
    }

    fetchTopArtists()
    fetchRegions()
  }, [])

  const featuredArtist = topArtists[0]

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
              <div className="aspect-square w-full max-w-55 sm:max-w-75 mx-auto overflow-hidden rounded-xl">
                {featuredArtist ? (
                  <Image
                    src={
                      featuredArtist.image_url
                        ? `${featuredArtist.image_url}?width=500`
                        : "/placeholder.png"
                    }
                    alt={featuredArtist.name}
                    width={500}
                    height={500}
                    className="object-cover w-full h-full"
                    priority
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
                    {featuredArtist?.origin_region || "DL"}
                  </span>
                  <span className="text-gray-600 font-semibold">
                    {featuredArtist?.genre || "Merengue"}
                  </span>
                </div>

                <p className="text-gray-700 max-w-lg text-base mb-8 leading-relaxed">
                  Discover the greatest artists from Dominican music history with detailed information and cultural context.
                </p>

                {/* Featured buttons (red + blue, rounded) */}
                <div className="flex items-center gap-3">
                  <button className="flex items-center gap-2 bg-[#8B0000] hover:bg-[#6B0000] text-white font-semibold px-7 py-2.5 rounded-full shadow-sm transition-colors">
                    <Play className="w-4 h-4 fill-current" /> Play
                  </button>

                  <Link
                    href={`/artists/${featuredArtist?.id || ""}`}
                    className="flex items-center bg-[#002D62] hover:bg-[#001A3A] text-white font-semibold px-7 py-2.5 rounded-full shadow-sm transition-colors"
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

          <div className="flex gap-3 overflow-x-auto snap-x snap-mandatory scrollbar-none sm:grid sm:grid-cols-3 lg:grid-cols-6 sm:gap-4">
            {topArtists.map((artist) => (
              <Link
                key={artist.id}
                href={`/artists/${artist.id}`}
                className="group snap-start shrink-0 w-32 sm:w-auto"
              >
                <div className="aspect-square bg-white rounded-lg overflow-hidden mb-3 relative shadow-lg hover:shadow-xl transition-all group-hover:scale-105 border border-black/15 group-hover:border-[#8B0000]">
                  {artist.image_url ? (
                    <Image
                      src={`${artist.image_url}?width=300`}
                      alt={artist.name}
                      width={300}
                      height={300}
                      className="object-cover w-full h-full"
                      loading="lazy"
                    />
                  ) : (
                    <div className="w-full h-full bg-gray-200" />
                  )}
                </div>
                <h3 className="text-sm font-semibold text-gray-900 group-hover:text-[#8B0000] line-clamp-2">
                  {artist.name}
                </h3>
                <p className="text-xs text-gray-600 mt-1">
                  {artist.origin_region || "Falta lugar de origen"}
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

          <div className="flex gap-3 overflow-x-auto snap-x snap-mandatory scrollbar-none sm:grid sm:grid-cols-3 lg:grid-cols-5 sm:gap-4">
            {topArtists.map((artist) => (
              <Link
                key={artist.id}
                href={`/artists/${artist.id}`}
                className="group snap-start shrink-0 w-32 sm:w-auto"
              >
                <div className="aspect-square bg-white rounded-lg overflow-hidden mb-3 relative shadow-lg hover:shadow-xl transition-all group-hover:scale-105 border border-black/15 group-hover:border-[#8B0000]">
                  {artist.image_url ? (
                    <Image
                      src={`${artist.image_url}?width=300`}
                      alt={artist.name}
                      width={300}
                      height={300}
                      className="object-cover w-full h-full"
                      loading="lazy"
                    />
                  ) : (
                    <div className="w-full h-full bg-gray-200" />
                  )}
                </div>
                <h4 className="text-sm font-semibold text-gray-900 group-hover:text-[#8B0000] line-clamp-2">
                  {artist.name}
                </h4>
                <p className="text-xs text-gray-600 mt-1">
                  {artist.origin_region || "Falta lugar de origen"}
                </p>
              </Link>
            ))}
          </div>
        </section>

        {/* Browse by Region (DYNAMIC + FIXED WIDTH + TIGHTER SPACING) */}
        <section className="rounded-3xl border border-black/10 bg-white/85 p-6 shadow-lg sm:p-8">
          <div className="flex items-center justify-between mb-6 pb-4 border-b border-[#002D62]/25">
            <h2 className="text-3xl font-semibold tracking-tight text-gray-900">Browse by Region</h2>
          </div>

          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {regions.map((r) => (
              <Link
                key={r.origin_region}
                href={`/artists?region=${encodeURIComponent(r.origin_region)}`}
                className="group block rounded-lg px-3 py-2.5 bg-white border border-black/10 shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all w-full"
              >
                <span className="text-[#002D62] font-semibold group-hover:text-[#8B0000] transition-colors">
                  → {r.origin_region} ({r.count})
                </span>
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
