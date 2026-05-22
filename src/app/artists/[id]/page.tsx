'use client';

import { useState, useEffect, use } from 'react';
import { notFound } from "next/navigation";
import Image from "next/image";
import MainWrapper from "@/components/layout/MainWrapper";
import type { Artist } from '@/types/music';
import { getSupabaseClient } from "@/lib/supabase";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

export default function ArtistProfile({ params }: { params: Promise<{ id: string }> }) {
  const resolvedParams = use(params);
  const supabase = getSupabaseClient();

  const [artist, setArtist] = useState<Artist | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchArtist() {
      try {
        const { data, error } = await supabase
          .from('artists')
          .select('*')
          .eq('id', resolvedParams.id)
          .single();

        if (error || !data) {
          console.error("Artist not found:", error);
          return;
        }

        setArtist(data as Artist);
      } catch (err) {
        console.error("Fetch error:", err);
      } finally {
        setLoading(false);
      }
    }

    fetchArtist();
  }, [resolvedParams.id, supabase]);

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center text-gray-500">
        Loading Artist…
      </div>
    );
  }

  if (!artist) return notFound();

  const imageUrl = getArtistImageUrl(artist.id);

  return (
    <MainWrapper>
      <div className="max-w-5xl mx-auto px-6 py-12">
        {/* HEADER */}
        <header className="mb-10">
          <h1 className="text-4xl sm:text-5xl font-black uppercase tracking-tight text-(--color-flagblue)">
            {artist.name}
          </h1>
      </header>

      {/* GRID */}
      <div className="grid md:grid-cols-2 gap-10">

        {/* IMAGE */}
<div className="relative w-75 h-75 overflow-hidden rounded-2xl bg-gray-100 shadow-lg">
  <Image
    src={imageUrl}
    alt={artist.name}
    fill
    className="object-cover"
    priority
  />
</div>


        {/* DETAILS */}
        <div className="space-y-6">

          {/* BIO */}
          <section className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
            <h3 className="text-xs font-bold text-(--color-wikicrimson) uppercase mb-2">
              Biography
            </h3>
            <p className="text-gray-700 leading-relaxed">
              {artist.bio || "No biography available for this artist."}
            </p>
          </section>

          {/* INFO GRID */}
          <section className="grid grid-cols-2 gap-4">

            <div className="p-4 bg-gray-50 rounded-lg">
              <span className="block text-[10px] font-bold text-gray-400 uppercase">
                Province
              </span>
              <span className="font-semibold">
                {artist.province || "N/A"}
              </span>
            </div>

            <div className="p-4 bg-gray-50 rounded-lg">
              <span className="block text-[10px] font-bold text-gray-400 uppercase">
                Genres
              </span>
              <span className="font-semibold text-sm">
                {artist.genres?.join(', ') || "N/A"}
              </span>
            </div>

          </section>

        </div>
      </div>
    </div>
    </MainWrapper>
  );
}
