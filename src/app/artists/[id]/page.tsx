import { getSupabaseClient } from "@/lib/supabase"
import Image from "next/image"
import Link from "next/link"
import { notFound } from "next/navigation"

export default async function ArtistPage({
  params,
}: {
  params: { id: string }
}) {
  const { id } = params
  const supabase = getSupabaseClient()

  // Fetch from NEW artists table + NEW recordings table
  const { data: artist, error } = await supabase
    .from("artists")
    .select(
      `
      *,
      recordings (*)
    `
    )
    .eq("id", id)
    .single()

  if (error || !artist) return notFound()

  // Increment views using RPC (fixed)
  if ((artist as any).id) {
    const { error: rpcError } = await supabase.rpc("increment_artist_views", {
      row_id: (artist as any).id,
    } as any)
    if (rpcError) {
      // silently fail
    }
  }

  // Normalize recordings + extract year from metadata if present
  const recordings = ((artist as any).recordings || [])
    .map((rec: any) => ({
      ...rec,
      year: rec.metadata?.year || null,
    }))
    .sort((a: any, b: any) => (b.year || 0) - (a.year || 0))

  return (
    <div className="min-h-screen bg-transparent relative overflow-hidden">

      {/* Gradient Corners (same as homepage) */}
      <div className="fixed inset-0 pointer-events-none">
        <div className="absolute top-0 left-0 w-96 h-96 bg-gradient-to-br from-[#002D62] via-[#002D62]/50 to-transparent rounded-full blur-3xl opacity-20" />
        <div className="absolute top-0 right-0 w-96 h-96 bg-gradient-to-bl from-[#8B0000] via-[#8B0000]/50 to-transparent rounded-full blur-3xl opacity-20" />
        <div className="absolute bottom-0 left-0 w-96 h-96 bg-gradient-to-tr from-[#8B0000] via-[#8B0000]/50 to-transparent rounded-full blur-3xl opacity-20" />
        <div className="absolute bottom-0 right-0 w-96 h-96 bg-gradient-to-tl from-[#002D62] via-[#002D62]/50 to-transparent rounded-full blur-3xl opacity-20" />
      </div>

      {/* Header */}
      <header className="relative z-20 flex items-center justify-between px-6 sm:px-12 pt-6 sm:pt-8">
        <Link
          href="/"
          className="font-serif italic text-2xl text-[#002D62]"
        >
          domidb
        </Link>
        <Link
          href="/"
          className="text-[10px] font-bold uppercase tracking-[0.3em] border border-black/10 px-4 py-2 rounded-full hover:bg-[#002D62] hover:text-white transition-all bg-white/80 backdrop-blur"
        >
          Back to Home
        </Link>
      </header>

      {/* Artist Hero */}
      <section className="relative mx-6 mt-6 sm:mt-8 overflow-hidden rounded-3xl border border-black/10 bg-white/90 shadow-xl sm:mx-12">
        <div className="px-8 py-10 sm:px-12 sm:py-12">
          <div className="grid gap-10 lg:grid-cols-[minmax(0,1.1fr)_minmax(0,1.2fr)] items-center">

            {/* Artist Image */}
            <div className="aspect-square w-full max-w-80 mx-auto overflow-hidden rounded-2xl border border-black/10 shadow-lg">
              {(artist as any).image_url ? (
                <Image
                  src={`${(artist as any).image_url}?width=600`}
                  alt={(artist as any).name}
                  width={600}
                  height={600}
                  className="object-cover w-full h-full"
                  priority
                />
              ) : (
                <div className="w-full h-full bg-gray-200" />
              )}
            </div>

            {/* Artist Info */}
            <div className="space-y-5">
              <p className="text-[#8B0000] text-sm font-semibold uppercase tracking-[0.16em]">
                Dominican Artist
              </p>

              <h1 className="text-4xl sm:text-5xl md:text-6xl font-semibold tracking-tight text-gray-900">
                {(artist as any).name}
              </h1>

              <div className="flex flex-wrap items-center gap-3 text-sm font-semibold text-gray-700">
                {(artist as any).origin_region && (
                  <span className="inline-flex items-center rounded-full border border-black/10 px-3 py-1 bg-white/80">
                    {(artist as any).origin_region}
                  </span>
                )}
                {(artist as any).genre && (
                  <span className="inline-flex items-center rounded-full border border-black/10 px-3 py-1 bg-white/80">
                    {(artist as any).genre}
                  </span>
                )}
                {(artist as any).birth_year && (
                  <span className="inline-flex items-center rounded-full border border-black/10 px-3 py-1 bg-white/80">
                    Born / Formed: {(artist as any).birth_year}
                  </span>
                )}
                {(artist as any).death_year && (
                  <span className="inline-flex items-center rounded-full border border-black/10 px-3 py-1 bg-white/80">
                    Passed: {(artist as any).death_year}
                  </span>
                )}
              </div>

              {(artist as any).bio && (
                <p className="text-gray-700 text-base leading-relaxed max-w-xl">
                  {(artist as any).bio}
                </p>
              )}
            </div>
          </div>
        </div>
      </section>

      {/* Main Content */}
      <main className="relative px-6 sm:px-12 py-14 space-y-10 max-w-7xl mx-auto">
        <div className="grid gap-10 lg:grid-cols-[minmax(0,0.9fr)_minmax(0,1.4fr)]">

          {/* Biography */}
          <section className="rounded-3xl border border-black/10 bg-white/90 p-6 sm:p-8 shadow-lg space-y-8">
            <div className="border-b border-black/10 pb-4 mb-4">
              <h2 className="text-2xl font-semibold tracking-tight text-gray-900">
                Biography
              </h2>
            </div>

            <p className="text-base leading-relaxed text-gray-800">
              {(artist as any).bio || "No biography available for this artist yet."}
            </p>

            <div className="grid grid-cols-2 gap-6 pt-4">
              <div>
                <span className="block text-[10px] font-bold uppercase tracking-[0.25em] text-gray-400 mb-2">
                  Born / Formed
                </span>
                <span className="text-lg font-medium text-gray-900">
                  {(artist as any).birth_year || "Unknown"}
                </span>
              </div>
              <div>
                <span className="block text-[10px] font-bold uppercase tracking-[0.25em] text-gray-400 mb-2">
                  Status
                </span>
                <span className="text-lg font-medium text-gray-900">
                  {(artist as any).death_year ? `Passed ${(artist as any).death_year}` : "Active / Unknown"}
                </span>
              </div>
            </div>
          </section>

          {/* Recordings */}
          <section className="rounded-3xl border border-black/10 bg-white/90 p-6 sm:p-8 shadow-lg">
            <div className="flex items-center justify-between mb-6 pb-4 border-b border-black/10">
              <h2 className="text-2xl font-semibold tracking-tight text-gray-900">
                Recordings
              </h2>
              <span className="text-[11px] uppercase tracking-[0.2em] text-gray-500">
                {recordings.length} Indexed
              </span>
            </div>

            {recordings.length > 0 ? (
              <div className="space-y-1">
                {recordings.map((rec: any, index: number) => (
                  <Link
                    href={`/recordings/${rec.id}`}
                    key={rec.id}
                    className="group flex items-center justify-between py-5 px-3 sm:px-4 border-b border-black/5 hover:bg-black/2 rounded-2xl transition-all"
                  >
                    <div className="flex items-baseline gap-5">
                      <span className="text-[10px] font-mono text-gray-300">
                        {(index + 1).toString().padStart(2, "0")}
                      </span>
                      <div>
                        <h3 className="text-lg sm:text-xl font-semibold text-gray-900 group-hover:text-[#8B0000] transition-colors">
                          {rec.title}
                        </h3>
                        <div className="flex flex-wrap items-center gap-2 mt-1 text-[11px] uppercase tracking-[0.16em] text-gray-500">
                          {rec.year && <span>{rec.year}</span>}
                          {rec.duration && (
                            <>
                              <span className="w-1 h-1 rounded-full bg-gray-300" />
                              <span>{Math.floor(rec.duration / 60)}:{String(rec.duration % 60).padStart(2, "0")}</span>
                            </>
                          )}
                        </div>
                      </div>
                    </div>

                    <div className="hidden sm:inline-flex bg-[#8B0000] text-white text-[9px] font-bold uppercase tracking-[0.2em] px-5 py-2 rounded-full opacity-0 group-hover:opacity-100 transition-all translate-x-2 group-hover:translate-x-0">
                      View Recording
                    </div>
                  </Link>
                ))}
              </div>
            ) : (
              <div className="py-16 text-center border-2 border-dashed border-black/5 rounded-4xl">
                <p className="text-sm text-gray-400 italic">
                  No recordings found for this artist.
                </p>
              </div>
            )}
          </section>
        </div>
      </main>

      <footer className="relative px-6 sm:px-12 pb-10 pt-4 text-center text-[10px] font-bold uppercase tracking-[0.3em] text-gray-400">
        domidb © 2026
      </footer>
    </div>
  )
}
