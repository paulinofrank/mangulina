"use client";

import { useEffect, useState } from "react";
import { getSupabaseClient } from "@/lib/supabase";
import Link from "next/link";

export default function RecordingsPage() {
  const [recordings, setRecordings] = useState<any[]>([]);
  const supabase = getSupabaseClient();

  useEffect(() => {
    fetchRecordings();
  }, []);

  async function fetchRecordings() {
    const { data, error } = await supabase
      .from("recordings")
      .select(`
        id,
        title,
        youtube_id,
        recording_credits (
          role,
          artists (
            name
          )
        )
      `)
      .order("created_at", { ascending: false });

    if (error) {
      console.error(error);
      return;
    }

    setRecordings(data || []);
  }

  return (
    <div className="max-w-5xl mx-auto px-6 py-10 font-outfit">

      {/* HEADER */}
      <h1 className="text-3xl font-serif font-bold mb-6 text-ink">
        Recordings
      </h1>

      <p className="text-sm text-black/60 mb-8">
        Browse your music catalog
      </p>

      {/* LIST */}
      <div>
        {recordings.map((rec) => (
          <Link key={rec.id} href={`/recordings/${rec.id}`}>
            <div className="p-4 mb-3 rounded-lg bg-white/40 backdrop-blur-sm border hover:bg-white/60 transition flex justify-between items-center">

              {/* LEFT */}
              <div>
                <div className="text-lg font-semibold">
                  {rec.title}
                </div>

                <div className="text-sm text-black/60">
                  Artist:{" "}
                  {rec.recording_credits?.find((c: any) => c.role === "main")?.artists?.name
                    || "Unknown"}
                </div>
              </div>

              {/* RIGHT ICON */}
              <div className="text-black/40 text-sm">
                ▶
              </div>

            </div>
          </Link>
        ))}
      </div>
    </div>
  );
}