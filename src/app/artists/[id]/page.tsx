import { supabase } from '@/lib/supabase';
import Image from 'next/image';
import Link from 'next/link';
import { notFound } from 'next/navigation';

const STORAGE_URL = "https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/artist-images/";

export default async function ArtistPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;

  // Updated: artists → artists_old
  // songs_old stays the same
  const { data: artist, error } = await supabase
    .from('artists_old')
    .select(`
      *,
      songs_old (*)
    `)
    .eq('id', id)
    .single();

  if (error || !artist) return notFound();

  // Increment views when page is visited using RPC
  if (artist.id) {
    await supabase.rpc('increment_artist_views', { row_id: artist.id }).catch(() => {
      // Silently fail if RPC doesn't exist, don't block rendering
    });
  }

  return (
    <div className="min-h-screen bg-[#fbfbfd] font-outfit text-[#1d1d1f]">
      <header className="fixed top-0 w-full z-50 p-8 md:p-12 flex justify-between items-center mix-blend-difference text-white pointer-events-none">
        <Link href="/" className="font-serif italic text-2xl pointer-events-auto">domidb</Link>
        <Link href="/" className="text-[10px] font-bold uppercase tracking-[0.3em] pointer-events-auto border border-white/20 px-4 py-2 rounded-full hover:bg-white hover:text-black transition-all">
          Back to Home
        </Link>
      </header>

      <section className="relative h-[80vh] w-full bg-black overflow-hidden">
        {artist.image_url && (
          <Image 
            src={`${STORAGE_URL}${encodeURIComponent(artist.image_url)}`}
            alt={artist.name}
            fill
            priority
            className="object-cover opacity-70 grayscale-20"
          />
        )}
        <div className="absolute inset-0 bg-linear-to-t from-[#fbfbfd] via-transparent to-black/20" />
        
        <div className="absolute bottom-16 left-8 md:left-20">
          <div className="flex items-center gap-4 mb-6">
            <span className="h-px w-12 bg-wikicrimson" />
            <span className="text-[11px] font-bold uppercase tracking-[0.4em] text-wikicrimson">
              {artist.origin_region} • {artist.genre}
            </span>
          </div>
          <h1 className="text-7xl md:text-[10rem] font-serif italic leading-[0.8] tracking-tighter">
            {artist.name}
          </h1>
        </div>
      </section>

      <main className="max-w-7xl mx-auto px-8 md:px-20 py-32 grid lg:grid-cols-12 gap-16 md:gap-24">
        
        <div className="lg:col-span-4 space-y-12">
          <section>
            <h3 className="text-[11px] font-bold uppercase tracking-[0.3em] opacity-30 mb-10 border-b border-black/5 pb-4">Biography</h3>
            <p className="text-2xl leading-relaxed italic font-serif opacity-80">
              {artist.bio}
            </p>
          </section>
          
          <section className="grid grid-cols-2 gap-8 pt-8">
             <div>
                <span className="block text-[9px] font-bold uppercase opacity-40 mb-2 tracking-widest">Born / Formed</span>
                <span className="text-xl font-medium">{artist.birth_year}</span>
             </div>
             {artist.death_year && (
               <div>
                  <span className="block text-[9px] font-bold uppercase opacity-40 mb-2 tracking-widest">Status</span>
                  <span className="text-xl font-medium">Passed {artist.death_year}</span>
               </div>
             )}
          </section>
        </div>

        <div className="lg:col-span-8">
          <div className="flex justify-between items-end mb-12 border-b border-black/5 pb-6">
            <h3 className="text-[11px] font-bold uppercase tracking-[0.3em] opacity-30">Archive Records</h3>
            <span className="text-[10px] opacity-40 uppercase tracking-widest">{artist.songs_old?.length || 0} Tracks Indexed</span>
          </div>

          <div className="space-y-1">
            {artist.songs_old && artist.songs_old.length > 0 ? (
              artist.songs_old
                .sort((a: any, b: any) => (b.year || 0) - (a.year || 0))
                .map((song: any, index: number) => (
                  <Link 
                    href={`/songs/${song.id}`}
                    key={song.id} 
                    className="group flex items-center justify-between py-8 border-b border-black/5 hover:px-6 transition-all duration-500 hover:bg-white rounded-2xl"
                  >
                    <div className="flex items-baseline gap-8">
                      <span className="text-[10px] font-mono opacity-20">{(index + 1).toString().padStart(2, '0')}</span>
                      <div>
                        <h4 className="text-3xl font-serif group-hover:text-wikicrimson transition-colors duration-300">
                          {song.title}
                        </h4>
                        <div className="flex items-center gap-3 mt-2">
                          <span className="text-[10px] opacity-40 uppercase tracking-widest">{song.album}</span>
                          <span className="w-1 h-1 rounded-full bg-black/10" />
                          <span className="text-[10px] opacity-40 uppercase tracking-widest">{song.year}</span>
                        </div>
                      </div>
                    </div>
                    <div className="bg-wikicrimson text-white text-[9px] font-bold uppercase tracking-[0.2em] px-6 py-3 rounded-full opacity-0 group-hover:opacity-100 transition-all duration-300 transform translate-x-4 group-hover:translate-x-0">
                      View Lyrics
                    </div>
                  </Link>
                ))
            ) : (
              <div className="py-20 text-center border-2 border-dashed border-black/5 rounded-[40px]">
                <p className="text-sm opacity-30 italic">No songs found in the archive for this artist.</p>
              </div>
            )}
          </div>
        </div>
      </main>

      <footer className="p-20 text-center border-t border-black/5">
        <div className="text-[10px] font-bold uppercase tracking-[0.4em] opacity-20">
          domidb © 2026
        </div>
      </footer>
    </div>
  );
}
