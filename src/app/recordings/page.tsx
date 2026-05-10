"use client";

import { useEffect, useState } from "react";
import { getSupabaseClient } from "@/lib/supabase";
import Link from "next/link";

const supabase = getSupabaseClient();
const ITEMS_PER_PAGE = 25;

export default function RecordingsPage() {
  const [recordings, setRecordings] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    fetchRecordings();
  }, []);

  async function fetchRecordings() {
    const { data } = await supabase
      .from("recordings")
      .select("id, title, recording_year, releases(cover_image_url)")
      .order("recording_year", { ascending: false });

    setRecordings(data || []);
    setLoading(false);
  }

  const totalPages = Math.ceil(recordings.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const endIndex = startIndex + ITEMS_PER_PAGE;
  const paginatedRecordings = recordings.slice(startIndex, endIndex);

  const goToPreviousPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
      window.scrollTo({ top: 0, behavior: "smooth" });
    }
  };

  const goToNextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
      window.scrollTo({ top: 0, behavior: "smooth" });
    }
  };

  return (
    <div className="max-w-5xl mx-auto px-6 py-10 font-outfit">

      <h1 className="text-3xl font-serif font-bold mb-6 text-ink">
        Recordings
      </h1>

      <p className="text-sm text-black/60 mb-8">
        Browse your music catalog
      </p>

      <div>
        {loading ? (
          <div className="text-center text-black/60 py-8">Loading...</div>
        ) : recordings.length === 0 ? (
          <p className="text-black/60">No recordings yet</p>
        ) : (
          <>
            {paginatedRecordings.map((rec) => (
              <Link key={rec.id} href={`/recordings/${rec.id}`}>
                <div className="p-4 mb-3 rounded-lg bg-white/40 backdrop-blur-sm border hover:bg-white/60 transition flex justify-between items-center">

                  <div className="flex items-center gap-4">
                    <img
                      src={rec.releases?.cover_image_url || "/placeholder.png"}
                      alt={rec.title}
                      className="w-14 h-14 rounded-md object-cover border"
                    />

                    <div>
                      <div className="text-lg font-semibold text-ink">
                        {rec.title}
                      </div>

                      <div className="text-sm text-black/60">
                        {rec.recording_year || "Unknown year"}
                      </div>
                    </div>
                  </div>

                  <div className="text-black/40 text-sm">
                    ▶
                  </div>

                </div>
              </Link>
            ))}

            <div className="mt-12 flex items-center justify-between">
              <button
                onClick={goToPreviousPage}
                disabled={currentPage === 1}
                className={`px-4 py-2 rounded-lg font-semibold transition ${
                  currentPage === 1
                    ? "bg-black/10 text-black/30 cursor-not-allowed"
                    : "bg-white/40 backdrop-blur-sm border hover:bg-white/60 text-ink"
                }`}
              >
                ← Previous
              </button>

              <div className="text-sm text-black/60">
                Page {currentPage} of {totalPages} ({recordings.length} total)
              </div>

              <button
                onClick={goToNextPage}
                disabled={currentPage === totalPages}
                className={`px-4 py-2 rounded-lg font-semibold transition ${
                  currentPage === totalPages
                    ? "bg-black/10 text-black/30 cursor-not-allowed"
                    : "bg-white/40 backdrop-blur-sm border hover:bg-white/60 text-ink"
                }`}
              >
                Next →
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  );
}
