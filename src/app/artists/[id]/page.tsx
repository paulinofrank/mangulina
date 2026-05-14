'use client';

import { useState, useEffect, use } from 'react';
import { notFound } from "next/navigation";
import Image from "next/image";

// 1. IMPORT SHARED LOGIC
import { Artist } from '@/types/music';
import { getSupabaseClient } from "@/lib/supabase";

export default function ArtistProfile({ params }: { params: Promise<{ id: string }> }) {
  // Unwrap params for Next.js 15+ compatibility
  const resolvedParams = use(params);
  const supabase = getSupabaseClient();

  // 2. DEFINE STATE WITH YOUR NEW INTERFACE
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
          console.error("Artist not found or error:", error);
          return;
        }

        // 3. CAST DATA TO YOUR INTERFACE
        setArtist(data as Artist);
      } catch (err) {
        console.error("Fetch error:", err);
      } finally {
        setLoading(false);
      }
    }

    fetchArtist();
  }, [resolvedParams.id, supabase]);

  if (loading) return <div className="p-10 text-center">Loading Artist...</div>;
  if (!artist) return notFound();

  return (
    <div className="max-w-4xl mx-auto p-6">
      <header className="mb-8">
        <h1 className="text-4xl font-black uppercase tracking-tighter text-[#002D62]">
          {artist.name}
        </h1>
      </header>

      <div className="grid md:grid-cols-2 gap-8">
        {/* 4. JSX NOW UNDERSTANDS THESE PROPERTIES */}
        <div className="relative aspect-3/4 overflow-hidden rounded-2xl bg-gray-100 shadow-lg">
          {artist.image_url ? (
            <Image 
              src={artist.image_url} 
              alt={artist.name} 
              fill
              className="object-cover"
            />
          ) : (
            <div className="flex items-center justify-center h-full text-gray-400">
              No Image Available
            </div>
          )}
        </div>

        <div className="space-y-4">
          <div className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
            <h3 className="text-xs font-bold text-[#CE1126] uppercase mb-2">Biography</h3>
            <p className="text-gray-700 leading-relaxed">
              {artist.bio || "No biography available for this artist."}
            </p>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="p-4 bg-gray-50 rounded-lg">
              <span className="block text-[10px] font-bold text-gray-400 uppercase">Province</span>
              <span className="font-semibold">{artist.province || "N/A"}</span>
            </div>
            <div className="p-4 bg-gray-50 rounded-lg">
              <span className="block text-[10px] font-bold text-gray-400 uppercase">Genres</span>
              <span className="font-semibold text-sm">{artist.genres?.join(', ') || "N/A"}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}