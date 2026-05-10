"use client";

import { useState, useEffect } from 'react';
import { getSupabaseClient } from '@/lib/supabase';
import Link from 'next/link';
import { useRouter, useSearchParams } from 'next/navigation';
import { Play } from 'lucide-react';

const supabase = getSupabaseClient();

// ...rest of your component


export default function ArchiveContent() {
  const [items, setItems] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const router = useRouter();
  const searchParams = useSearchParams();
  const query = searchParams.get("q") || "";

  useEffect(() => {
    fetchArchive();
  }, [query]);

  async function fetchArchive() {
    const { data } = await supabase
      .from("recordings")
      .select("id, title, recording_year, releases(cover_image_url)")
      .ilike("title", `%${query}%`)
      .order("recording_year", { ascending: false });

    setItems(data || []);
    setLoading(false);
  }

  return (
    <div className="space-y-4">
      {loading ? (
        <div className="text-black/60">Loading…</div>
      ) : items.length === 0 ? (
        <div className="text-black/60">No results found</div>
      ) : (
        items.map((item) => (
          <Link
            key={item.id}
            href={`/recordings/${item.id}`}
            className="flex items-center justify-between p-4 bg-white/40 border rounded-lg hover:bg-white/60 transition"
          >
            <div className="flex items-center gap-4">
              <img
                src={item.releases?.cover_image_url || "/placeholder.png"}
                alt={item.title}
                className="w-14 h-14 rounded-md object-cover border"
              />

              <div>
                <div className="font-semibold text-ink">{item.title}</div>
                <div className="text-sm text-black/60">
                  {item.recording_year || "Unknown year"}
                </div>
              </div>
            </div>

            <Play className="text-black/40" size={18} />
          </Link>
        ))
      )}
    </div>
  );
}
