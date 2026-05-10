'use client';

import { useEffect, useState, Suspense } from 'react';
import { useSearchParams } from 'next/navigation';
import { getSupabaseClient } from '@/lib/supabase';
import Link from 'next/link';
import Image from 'next/image';

type Artist = {
  id: string | number;
  name: string;
  origin_region?: string | null;
  image_url?: string | null;
  views?: number;
};

function ArtistsContent() {
  const supabase = getSupabaseClient();
  const searchParams = useSearchParams();

  const [artists, setArtists] = useState<Artist[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);

  const region = searchParams.get('region');
  const search = searchParams.get('search');

  useEffect(() => {
    const fetchArtists = async () => {
      setLoading(true);
      try {
        let query = supabase
          .from('artists')
          .select('id, name, origin_region, image_url, views', { count: 'exact' });

        if (region) query = query.eq('origin_region', region);
        if (search) query = query.ilike('name', `%${search}%`);

        const { data, count, error } = await query
          .order('views', { ascending: false })
          .limit(100);

        if (!error && data) {
          setArtists(data);
          setTotalCount(count || 0);
        }
      } catch (err) {
        console.error('Error fetching artists:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchArtists();
  }, [region, search, supabase]);

  return (
    <div className="max-w-7xl mx-auto px-6 py-12">
      {/* HEADER */}
      <div className="mb-12 border-b border-black/5 pb-10">
        <h1 className="text-6xl font-black tracking-tighter text-[#002D62] mb-3">
          Artists
        </h1>
        <div className="flex items-center gap-4">
          <span className="bg-[#CE1126]/10 text-[#CE1126] text-[10px] font-black uppercase tracking-widest px-3 py-1 rounded-full">
            {region || (search ? 'Search' : 'Archive')}
          </span>
          <p className="text-xs font-bold text-gray-400 uppercase tracking-tight">
             {loading ? 'Consulting Ledger...' : `${totalCount} entries indexed`}
          </p>
        </div>
      </div>

      {/* ARTISTS GRID */}
      <div>
        {loading ? (
          <div className="grid gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
            {[...Array(10)].map((_, i) => (
              <div key={i} className="animate-pulse space-y-4">
                <div className="aspect-square bg-gray-100 rounded-4xl" />
                <div className="h-4 bg-gray-100 rounded w-2/3" />
              </div>
            ))}
          </div>
        ) : artists.length > 0 ? (
          <div className="grid gap-8 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
            {artists.map((artist) => (
              <Link key={artist.id} href={`/artists/${artist.id}`} className="group relative">
                <div className="aspect-square bg-white rounded-4xl overflow-hidden mb-4 relative shadow-sm group-hover:shadow-2xl transition-all duration-500 border border-black/5 group-hover:border-[#CE1126]/30">
                  {artist.image_url ? (
                    <Image
                      src={`${artist.image_url}?width=400`}
                      alt={artist.name}
                      fill
                      className="object-cover group-hover:scale-110 transition-transform duration-700"
                      sizes="(max-width: 768px) 100vw, 20vw"
                    />
                  ) : (
                    <div className="w-full h-full bg-gray-50 flex items-center justify-center text-gray-200">
                      <span className="text-4xl font-serif">M</span>
                    </div>
                  )}
                  {/* Hover Overlay */}
                  <div className="absolute inset-0 bg-linear-to-t from-[#002D62]/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-6">
                     <span className="text-white text-[10px] font-black uppercase tracking-[0.2em]">View Profile →</span>
                  </div>
                </div>

                <h3 className="text-lg font-bold text-[#002D62] group-hover:text-[#CE1126] transition-colors leading-tight">
                  {artist.name}
                </h3>
                <div className="flex items-center justify-between mt-2">
                  <p className="text-[10px] font-black text-gray-400 uppercase tracking-widest">
                    {artist.origin_region || 'Dominican Republic'}
                  </p>
                  <span className="text-[10px] font-bold text-gray-300">
                    {artist.views?.toLocaleString() || '0'} 👁️
                  </span>
                </div>
              </Link>
            ))}
          </div>
        ) : (
          <div className="py-32 text-center">
            <p className="text-gray-400 italic">No artists found in this sector of the archive.</p>
            <Link href="/artists" className="mt-4 inline-block text-[#CE1126] font-black text-xs uppercase tracking-widest border-b border-[#CE1126]">
              Reset Search
            </Link>
          </div>
        )}
      </div>
    </div>
  );
}

export default function ArtistsPage() {
  return (
    <Suspense fallback={<div className="max-w-7xl mx-auto px-6 py-24 text-center text-gray-400 font-black uppercase tracking-widest">Loading Mangulina Archive...</div>}>
      <ArtistsContent />
    </Suspense>
  );
}