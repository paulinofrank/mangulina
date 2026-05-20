import { getSupabaseClient } from '@/lib/supabase';
import Image from 'next/image';
import Link from 'next/link';
import { notFound } from 'next/navigation';
import MusicPlayer from '@/components/organisms/MusicPlayer';

const STORAGE_URL = "https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/artist-images/";

type SongMetadata = {
  trivia?: string[];
  composer?: string;
  studio?: string;
};

type ArtistsOld = {
  name: string;
  image_url?: string | null;
};

type SongRow = {
  id: string;
  title: string;
  album?: string | null;
  year?: number | null;
  artist_id: string;
  youtube_id?: string | null;
  lyrics_raw?: string | null;
  metadata?: unknown;
  artists_old?: ArtistsOld | null;
};

function parseMetadata(raw: unknown): SongMetadata {
  if (!raw || typeof raw !== 'object') return {};
  const o = raw as Record<string, unknown>;
  const trivia = Array.isArray(o.trivia) ? o.trivia.filter((x): x is string => typeof x === 'string') : undefined;
  return {
    trivia,
    composer: typeof o.composer === 'string' ? o.composer : undefined,
    studio: typeof o.studio === 'string' ? o.studio : undefined,
  };
}

export default async function SongPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const supabase = getSupabaseClient();

  const { data: song, error } = await supabase
    .from('songs_old')
    .select(`
      *,
      artists_old (*)
    `)
    .eq('id', id)
    .single();

  if (error || !song) return notFound();

  const s = song as SongRow;
  const metadata = parseMetadata(s.metadata);
  const artist = s.artists_old;

  return (
    <div className="min-h-screen bg-black text-white font-outfit overflow-hidden">
      <div className="fixed inset-0 z-0">
        {artist?.image_url && (
          <Image 
            src={`${STORAGE_URL}${encodeURIComponent(artist.image_url)}`}
            alt=""
            fill
            priority
            sizes="100vw"
            className="object-cover opacity-20 blur-3xl scale-110"
          />
        )}
        <div className="absolute inset-0 bg-linear-to-b from-black/60 via-black/80 to-black" />
      </div>

      <header className="relative z-50 p-8 flex justify-between items-center">
        <Link href={`/artists/${s.artist_id}`} className="group flex items-center gap-4">
          <div className="w-10 h-10 rounded-full overflow-hidden relative border border-white/20">
            {artist?.image_url && (
              <Image 
                src={`${STORAGE_URL}${encodeURIComponent(artist.image_url)}`}
                alt={artist.name}
                fill
                sizes="40px"
                className="object-cover"
              />
            )}
          </div>
          <span className="text-[10px] font-bold uppercase tracking-[0.3em] opacity-60 group-hover:opacity-100 transition-opacity">
            Return to {artist?.name ?? 'Artist'}
          </span>
        </Link>
        <div className="text-wikicrimson font-serif italic text-xl">domidb</div>
      </header>

      <main className="relative z-10 max-w-5xl mx-auto px-8 pt-12 pb-40 grid md:grid-cols-2 gap-20 items-start">
        
        <div className="sticky top-12 space-y-12">
          <section>
            <span className="text-wikicrimson text-[11px] font-bold uppercase tracking-[0.5em] block mb-4">
              Now Playing
            </span>
            <h1 className="text-6xl md:text-8xl font-serif italic mb-6 leading-tight">
              {s.title}
            </h1>
            <div className="flex items-center gap-6 opacity-40 text-sm tracking-widest uppercase">
              <span>{s.album ?? ''}</span>
              <span className="w-1 h-1 bg-white rounded-full" />
              <span>{s.year ?? ''}</span>
            </div>
          </section>

          {s.youtube_id ? (
            <MusicPlayer videoId={s.youtube_id} />
          ) : (
            <div className="p-8 rounded-3xl border border-white/10 bg-white/5 backdrop-blur-md opacity-40 italic text-center text-xs tracking-widest">
              Audio retrieval in progress...
            </div>
          )}

          {(metadata.trivia || metadata.composer) && (
            <section className="space-y-8 pt-8 animate-in fade-in slide-in-from-bottom-4 duration-1000">
              <div className="h-px bg-linear-to-r from-wikicrimson/50 to-transparent w-full" />
              
              {metadata.composer && (
                <div>
                  <h4 className="text-[10px] font-bold uppercase tracking-[0.3em] opacity-40 mb-2">Composer</h4>
                  <p className="text-xl font-serif italic text-white/90">{metadata.composer}</p>
                </div>
              )}

              {metadata.trivia && (
                <div className="space-y-4">
                  <h4 className="text-[10px] font-bold uppercase tracking-[0.3em] opacity-40">Liner Notes</h4>
                  <div className="space-y-3">
                    {metadata.trivia.map((fact, i) => (
                      <div key={i} className="p-5 rounded-2xl bg-white/3 border border-white/5 text-sm text-white/70 leading-relaxed hover:border-white/10 transition-colors">
                        {fact}
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </section>
          )}
        </div>

        <section className="md:pt-20">
          <h3 className="text-[11px] font-bold uppercase tracking-[0.3em] opacity-30 mb-12 border-b border-white/10 pb-4">
            Lyrics Archive
          </h3>
          <div className="space-y-8">
            {s.lyrics_raw ? (
              <pre className="font-serif text-2xl md:text-4xl leading-[1.6] whitespace-pre-wrap text-white/95 italic">
                {s.lyrics_raw}
              </pre>
            ) : (
              <div className="py-20 text-center opacity-20 italic">
                Lyrics for this record are currently being transcribed.
              </div>
            )}
          </div>

          <div className="mt-20 pt-12 border-t border-white/10">
              <button className="text-[10px] font-bold uppercase tracking-[0.3em] text-wikicrimson hover:tracking-[0.5em] transition-all">
                View Community Discussions →
              </button>
          </div>
        </section>
      </main>
    </div>
  );
}
