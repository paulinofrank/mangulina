import { getSupabaseClient } from "@/lib/supabase"
import Image from "next/image"
import Link from "next/link"
import { notFound } from "next/navigation"

// 1. Define the Artist interface to fix 'never' type errors
interface Artist {
  id: string;
  name: string;
  bio?: string;
  image_url?: string;
  origin_region?: string;
  views?: number;
  recordings?: any[];
}

export default async function ArtistDetailPage({
  params,
}: {
  // 2. CRITICAL: In Next.js 15, params is a Promise
  params: Promise<{ id: string }>
}) {
  // 3. Await the params before accessing 'id'
  const { id } = await params
  const supabase = getSupabaseClient()

  // 4. Fetch data from Supabase
  const { data, error } = await supabase
    .from("artists")
    .select(`
      *,
      recordings (*)
    `)
    .eq("id", id)
    .single()

  // Cast data to Artist type so TS recognizes the properties
  const artist = data as Artist | null;

  // If there's a Supabase error or no artist is found, return the Next.js 404 page
  if (error || !artist) return notFound()

  // 5. Update views via RPC
  await (supabase.rpc as any)("increment_artist_views", { row_id: artist.id })

  // 6. Sort Recordings by year (Metadata stored on recordings)
  const recordings = (artist.recordings || [])
    .map((rec: any) => ({
      ...rec,
      year: rec.metadata?.year || "—",
    }))
    .sort((a: any, b: any) => {
      const yearA = a.year === "—" ? 0 : Number(a.year);
      const yearB = b.year === "—" ? 0 : Number(b.year);
      return yearB - yearA;
    })

  return (
    <div className="min-h-screen bg-[#fcfcfc] relative overflow-hidden pb-24">
      
      {/* Visual Identity Gradients */}
      <div className="fixed inset-0 pointer-events-none">
        <div className="absolute top-0 left-0 w-200 h-200 bg-linear-to-br from-[#002D62] via-[#002D62]/10 to-transparent rounded-full blur-[120px] opacity-20" />
        <div className="absolute bottom-0 right-0 w-200 h-200 bg-linear-to-tl from-[#CE1126] via-[#CE1126]/10 to-transparent rounded-full blur-[120px] opacity-15" />
      </div>

      <header className="relative z-20 flex items-center justify-between px-6 sm:px-12 pt-8">
        <Link href="/" className="font-serif italic text-3xl text-[#002D62]">domidb</Link>
        <Link href="/artists" className="text-[10px] font-black uppercase tracking-[0.3em] bg-white/80 backdrop-blur-md border border-black/5 px-6 py-2.5 rounded-full shadow-sm hover:bg-[#002D62] hover:text-white transition-all">
          ← Back to Artists
        </Link>
      </header>

      <main className="relative z-10 max-w-7xl mx-auto mt-12 px-6 sm:px-12">
        <div className="grid gap-12 lg:grid-cols-[1fr_1.5fr] items-start">
          
          {/* Artist Bio Section */}
          <div className="space-y-8 lg:sticky lg:top-12">
            <div className="relative aspect-square w-full overflow-hidden rounded-[3rem] shadow-2xl border border-black/5">
              {artist.image_url ? (
                <Image 
                  src={artist.image_url} 
                  alt={artist.name} 
                  fill 
                  className="object-cover" 
                  priority 
                />
              ) : (
                <div className="w-full h-full bg-gray-100 flex items-center justify-center text-gray-300">
                  <span className="text-6xl font-serif">M</span>
                </div>
              )}
            </div>

            <div className="bg-white/90 backdrop-blur-xl p-10 rounded-[2.5rem] border border-black/5 shadow-sm">
              <h1 className="text-5xl font-black tracking-tighter text-[#002D62] mb-4">{artist.name}</h1>
              <div className="flex flex-wrap gap-2 mb-8">
                <span className="bg-[#f8fafc] border border-black/5 px-4 py-1.5 rounded-full text-[10px] font-black uppercase text-gray-500">
                  📍 {artist.origin_region || 'Dominican Republic'}
                </span>
                <span className="bg-[#002D62]/5 border border-[#002D62]/10 px-4 py-1.5 rounded-full text-[10px] font-black uppercase text-[#002D62]">
                  👁️ {artist.views?.toLocaleString() || 0} Views
                </span>
              </div>
              <h2 className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-400 mb-4 border-b pb-2">Biography</h2>
              <p className="text-gray-700 leading-relaxed font-medium">
                {artist.bio || `Archived documentation for ${artist.name} via Mangulina.`}
              </p>
            </div>
          </div>

          {/* Discography Section */}
          <div className="bg-white rounded-[3rem] p-8 sm:p-14 shadow-2xl border border-black/5">
            <div className="flex items-center justify-between mb-12 border-b border-black/5 pb-6">
              <h2 className="text-3xl font-black text-[#002D62] tracking-tighter">Discography</h2>
              <span className="text-[10px] font-black text-gray-400 uppercase tracking-widest">{recordings.length} Indexed Tracks</span>
            </div>

            <div className="space-y-2">
              {recordings.length > 0 ? recordings.map((rec: any, i: number) => (
                <Link key={rec.id} href={`/recordings/${rec.id}`} className="group flex items-center justify-between p-6 rounded-4xl hover:bg-[#f8fafc] transition-all">
                  <div className="flex items-center gap-6">
                    <span className="text-[10px] font-mono text-gray-300">{(i + 1).toString().padStart(2, '0')}</span>
                    <div>
                      <h3 className="text-xl font-bold text-[#002D62] group-hover:text-[#CE1126] transition-colors line-clamp-1">{rec.title}</h3>
                      <p className="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mt-1">{rec.year}</p>
                    </div>
                  </div>
                  <span className="text-[#CE1126] opacity-0 group-hover:opacity-100 transition-all font-black text-xs uppercase tracking-widest">Details →</span>
                </Link>
              )) : (
                <p className="text-gray-400 italic text-center py-12 border-2 border-dashed border-gray-50 rounded-3xl">No recordings currently indexed.</p>
              )}
            </div>
          </div>
        </div>
      </main>
    </div>
  )
}