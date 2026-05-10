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

  const filterLabel = region
    ? `Region: ${region}`
    : search
      ? `Search: ${search}`
      : 'All Artists';

  return (
    <div className="max-w-7xl mx-auto px-6 py-12">
      {/* HEADER */}
      <div className="mb-12 border-b border-black/10 pb-8">
        <h1 className="text-5xl font-semibold tracking-tight text-ink mb-2">
          Artists
        </h1>
        <p className="text-sm text-black/60">
          {filterLabel} • {loading ? '...' : `${totalCount} artist${totalCount !== 1 ? 's' : ''}`}
        </p>
      </div>

      {(region || search) && (
        <div className="mb-8 inline-block">
          <Link
            href="/artists"
            className="text-sm px-4 py-2 rounded-full bg-wikicrimson/10 text-wikicrimson hover:bg-wikicrimson/20 transition-colors border border-wikicrimson/30"
          >
            ✕ Clear Filters
          </Link>
        </div>
      )}

      {/* ARTISTS GRID */}
      <div>
        {loading ? (
          <div className="text-center py-20 text-black/40">
            <div className="inline-block animate-spin">⏳</div> Loading artists...
          </div>
        ) : artists.length > 0 ? (
          <div className="grid gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
            {artists.map((artist) => (
              <Link key={artist.id} href={`/artists/${artist.id}`} className="group">
                <div className="aspect-square bg-white rounded-lg overflow-hidden mb-3 relative shadow-lg hover:shadow-xl transition-all group-hover:scale-105 border border-black/15 group-hover:border-wikicrimson">
                  {artist.image_url ? (
                    <Image
                      src={`${artist.image_url}?width=400`}
                      alt={artist.name}
                      width={400}
                      height={400}
                      className="object-cover w-full h-full"
                      loading="lazy"
                    />
                  ) : (
                    <div className="w-full h-full bg-gray-200 flex items-center justify-center">
                      <span className="text-gray-400 text-sm">No Image</span>
                    </div>
                  )}
                </div>

                <h3 className="text-sm font-semibold text-ink group-hover:text-wikicrimson line-clamp-2 transition-colors">
                  {artist.name}
                </h3>

                <p className="text-xs text-black/60 mt-1">
                  {artist.origin_region || 'Dominican Republic'}
                </p>

                <p className="text-xs text-black/40 mt-1">
                  {artist.views?.toLocaleString() || '0'} views
                </p>
              </Link>
            ))}
          </div>
        ) : (
          <div className="text-center py-20 text-black/40">
            <p className="text-base mb-4">No artists found</p>
            <Link
              href="/artists"
              className="text-sm text-wikicrimson hover:text-wikicrimson/80 underline"
            >
              View all artists
            </Link>
          </div>
        )}
      </div>
    </div>
  );
}

export default function ArtistsPage() {
  return (
    <Suspense fallback={<div className="max-w-7xl mx-auto px-6 py-12 text-center text-black/40">Loading artists...</div>}>
      <ArtistsContent />
    </Suspense>
  );
}
