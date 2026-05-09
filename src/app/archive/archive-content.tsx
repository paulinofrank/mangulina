'use client';

import { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase';
import Link from 'next/link';
import { useRouter, useSearchParams } from 'next/navigation';
import { Play } from 'lucide-react';

export default function ArchiveContent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [songs, setSongs] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const currentYear = 2026;
  const currentDecade = 2020;

  const selectedDecade = searchParams.get('decade') || currentDecade.toString();
  const selectedYear = searchParams.get('year') ? parseInt(searchParams.get('year')!) : currentYear;
  const decadeButtons = [1940, 1950, 1960, 1970, 1980, 1990, 2000, 2010, 2020];

  useEffect(() => {
    async function fetchSongs() {
      setLoading(true);

      // Updated: songs → songs_old
      // Updated: artists → artists_old
      const { data } = await supabase
        .from('songs_old')
        .select('*, artists_old(id, name)')
        .eq('year', selectedYear)
        .order('title', { ascending: true });

      setSongs(data || []);
      setLoading(false);
    }
    fetchSongs();
  }, [selectedYear]);

  const updateParams = (updates: Record<string, string | number | null>) => {
    const params = new URLSearchParams(searchParams.toString());
    Object.entries(updates).forEach(([key, value]) => {
      if (value === null) params.delete(key);
      else params.set(key, value.toString());
    });
    router.push(`?${params.toString()}`, { scroll: false });
  };

  const getYearRange = () => {
    const decadeNum = parseInt(selectedDecade);
    return Array.from({ length: 10 }, (_, i) => decadeNum + i);
  };

  return (
    <main className="max-w-5xl mx-auto py-12 px-6">
      
      {/* HEADER */}
      <header className="mb-12 border-b border-wikicrimson/20 pb-6 flex justify-between items-end">
        <div>
          <h1 className="text-6xl text-ink">The Archive</h1>
          <p className="text-[11px] uppercase tracking-[0.4em] text-wikicrimson font-bold font-outfit mt-2">
            Dominican Musical Heritage Registry
          </p>
        </div>
        <div className="text-right hidden md:block">
          <p className="text-[10px] font-bold opacity-30 uppercase tracking-widest font-outfit">Active Index</p>
          <p className="text-2xl font-serif italic text-ink leading-none">{selectedYear}</p>
        </div>
      </header>

      {/* TWO-TIER NAVIGATION */}
      <nav className="mb-12 space-y-2 font-outfit">
        
        {/* ROW 1: DECADES */}
        <div className="grid grid-cols-10 gap-1">
          <div className="flex gap-1">
            {["1920", "1930"].map((d) => (
              <button 
                key={d}
                onClick={() => updateParams({ decade: d, year: parseInt(d) })}
                className={`btn-archive flex-1 py-3 text-[13px] tracking-tighter ${
                  selectedDecade === d ? 'btn-archive-active' : 'border-black/10 font-bold text-ink'
                }`}
              >
                {d.slice(2)}s
              </button>
            ))}
          </div>

          {decadeButtons.map((d) => (
            <button 
              key={d} 
              onClick={() => updateParams({ decade: d, year: d })} 
              className={`btn-archive py-3 text-base ${
                selectedDecade === d.toString() ? 'btn-archive-active' : 'border-black/10 font-bold text-ink'
              }`}
            >
              {d}s
            </button>
          ))}
        </div>

        {/* ROW 2: YEARS */}
        <div className="grid grid-cols-10 gap-1">
          {getYearRange().map((y) => (
            <button 
              key={y} 
              onClick={() => updateParams({ year: y })}
              className={`btn-archive py-1 text-[15px] font-normal transition-all ${
                selectedYear === y 
                  ? 'bg-flagblue text-white border-flagblue shadow-lg z-10' 
                  : 'border-wikicrimson/30 text-wikicrimson hover:border-wikicrimson hover:bg-wikicrimson/[0.02]'
              }`}
            >
              {y}
            </button>
          ))}
        </div>
      </nav>

      {/* DATA LEDGER */}
      <section className="animate-in fade-in slide-in-from-bottom-2 duration-700">
        <div className="border-t-2 border-ink pt-1">
          {loading ? (
            <div className="py-20 text-center opacity-20 text-[10px] uppercase font-bold tracking-widest font-outfit">
              Consulting Ledger...
            </div>
          ) : songs.length > 0 ? (
            <div className="divide-y divide-black/4">
              {songs.map((song) => (
                <div key={song.id} className="py-4 flex items-center group px-2 -mx-2 hover:bg-wikicrimson/[0.03] transition-all border-l-0 hover:border-l-4 border-wikicrimson">
                  
                  <Link href={`/artists/${song.artists_old?.id}`} className="text-[13px] font-bold font-outfit text-ink/40 group-hover:text-wikicrimson uppercase w-44 md:w-64 truncate tracking-tighter transition-colors">
                    {song.artists_old?.name}
                  </Link>

                  <Link href={`/songs/${song.id}`} className="flex-1 flex items-center gap-4 min-w-0 group/song">
                    <span className="text-xl font-serif italic text-ink/80 group-hover:text-ink truncate transition-colors">
                      {song.title}
                    </span>
                    <div className="w-8 h-8 rounded-full bg-wikicrimson text-white flex items-center justify-center opacity-0 group-hover:opacity-100 transition-all scale-75 group-hover:scale-100 shadow-md">
                      <Play size={12} fill="currentColor" className="ml-0.5" />
                    </div>
                  </Link>

                  <span className="hidden md:block text-[10px] font-bold font-outfit opacity-20 uppercase tracking-widest italic ml-auto">
                    {song.genre || 'Registry'}
                  </span>
                </div>
              ))}
            </div>
          ) : (
            <div className="py-32 text-center opacity-20 font-outfit uppercase font-bold tracking-[0.5em] text-[11px]">
              Inventory Empty for {selectedYear}
            </div>
          )}
        </div>
      </section>

      <footer className="mt-20 pt-6 border-t border-ink/10 flex justify-between items-center opacity-30 text-[9px] uppercase font-bold tracking-[0.3em] font-outfit">
        <p>© 2026 domidb DR</p>
        <p>Entry Count: {songs.length}</p>
      </footer>
    </main>
  );
}
