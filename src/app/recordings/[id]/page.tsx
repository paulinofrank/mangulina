"use client";

import { useEffect, useState, useCallback } from "react";
import { getSupabaseClient } from "@/lib/supabase";
import Link from "next/link";

type RecordingCredit = {
  role: string;
  artists: { name: string; status?: string } | { name: string; status?: string }[] | null;
};

type RecordingWithCredits = {
  id: string;
  title: string;
  recording_credits?: RecordingCredit[] | null;
};

function mainArtistName(rec: RecordingWithCredits): string {
  const main = rec.recording_credits?.find((c) => c.role === "main");
  const raw = main?.artists;
  if (!raw) return "Unknown";
  const first = Array.isArray(raw) ? raw[0] : raw;
  return first?.name ?? "Unknown";
}

export default function RecordingsPage() {
  const [recordings, setRecordings] = useState<RecordingWithCredits[]>([]);
  const supabase = getSupabaseClient();

  const fetchRecordings = useCallback(async () => {
    const { data, error } = await supabase
      .from("recordings")
      .select(`
        id,
        title,
        youtube_id,
        recording_credits (
          role,
          artists!inner (
            name,
            status
          )
        )
      `)
      .eq("recording_credits.artists.status", "published")
      .order("created_at", { ascending: false });

    if (error) {
      console.error(error);
      return;
    }

    setRecordings((data as unknown as RecordingWithCredits[]) || []);
  }, [supabase]);

  useEffect(() => {
    queueMicrotask(() => {
      void fetchRecordings();
    });
  }, [fetchRecordings]);

  return (
    <div className="max-w-5xl mx-auto px-6 py-10 font-outfit">
      <h1 className="text-3xl font-serif font-bold mb-6 text-ink">Recordings</h1>

      <p className="text-sm text-black/60 mb-8">Browse your music catalog</p>

      <div>
        {recordings.map((rec) => {
          const artistName = mainArtistName(rec);

          return (
            <Link key={rec.id} href={`/recordings/${rec.id}`}>
              <div className="p-4 mb-3 rounded-lg bg-white/40 backdrop-blur-sm border hover:bg-white/60 transition flex justify-between items-center">
                <div>
                  <div className="text-lg font-semibold">{rec.title}</div>

                  <div className="text-sm text-black/60">Artist: {artistName}</div>
                </div>

                <div className="text-black/40 text-sm">▶</div>
              </div>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
