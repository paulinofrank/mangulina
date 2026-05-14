"use client";

import { useState, useEffect, useCallback } from "react";
import { getSupabaseClient } from "@/lib/supabase";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import Image from "next/image";
import { Play } from "lucide-react";

const supabase = getSupabaseClient();

type ReleaseRow = { cover_image_url?: string | null };

export type ArchiveRecordingItem = {
  id: string;
  title: string;
  recording_year?: number | null;
  releases?: ReleaseRow | ReleaseRow[] | null;
};

function coverForItem(item: ArchiveRecordingItem): string {
  const r = item.releases;
  if (!r) return "/placeholder.png";
  const rel = Array.isArray(r) ? r[0] : r;
  return rel?.cover_image_url || "/placeholder.png";
}

export default function ArchiveContent() {
  const [items, setItems] = useState<ArchiveRecordingItem[]>([]);
  const [loading, setLoading] = useState(true);

  const searchParams = useSearchParams();
  const query = searchParams.get("q") || "";

  const fetchArchive = useCallback(async () => {
    const { data } = await supabase
      .from("recordings")
      .select("id, title, recording_year, releases(cover_image_url)")
      .ilike("title", `%${query}%`)
      .order("recording_year", { ascending: false });

    setItems((data as ArchiveRecordingItem[]) || []);
    setLoading(false);
  }, [query]);

  useEffect(() => {
    queueMicrotask(() => {
      void fetchArchive();
    });
  }, [fetchArchive]);

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
              <div className="relative w-14 h-14 shrink-0 rounded-md overflow-hidden border">
                <Image
                  src={coverForItem(item)}
                  alt={item.title}
                  fill
                  className="object-cover"
                  sizes="56px"
                  unoptimized
                />
              </div>

              <div>
                <div className="font-semibold text-ink">{item.title}</div>
                <div className="text-sm text-black/60">
                  {item.recording_year ?? "Unknown year"}
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
