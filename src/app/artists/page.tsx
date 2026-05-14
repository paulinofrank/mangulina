"use client";

import { useEffect, useState, Suspense } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { getSupabaseClient } from "@/lib/supabase";

import ArtistCard from "@/components/molecules/ArtistCard";
import type { Artist } from "@/components/molecules/ArtistCard";

const ITEMS_PER_PAGE = 16;

function ArtistsContent() {
  const supabase = getSupabaseClient();
  const searchParams = useSearchParams();
  const router = useRouter();

  const [artists, setArtists] = useState<Artist[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);

  const region = searchParams.get("region");
  const search = searchParams.get("search");
  const isReligiousFilter = searchParams.get("religious") === "true";
  const currentPage = parseInt(searchParams.get("page") || "1");

  useEffect(() => {
    async function loadArtists() {
      setLoading(true);
      try {
        const from = (currentPage - 1) * ITEMS_PER_PAGE;
        const to = from + ITEMS_PER_PAGE - 1;

        let query = supabase
          .from("artists")
          .select("*", { count: "exact" });

        if (region) query = query.eq("province", region);
        if (search) query = query.ilike("name", `%${search}%`);
        if (isReligiousFilter) query = query.eq("is_religious", true);

        const { data, count, error } = await query
          .order("views", { ascending: false })
          .range(from, to);

        if (!error && data) {
          setArtists(data as Artist[]);
          setTotalCount(count || 0);
        }
      } catch (err) {
        console.error("Archive fetch failed:", err);
      } finally {
        setLoading(false);
      }
    }
    loadArtists();
  }, [region, search, isReligiousFilter, currentPage, supabase]);

  const totalPages = Math.ceil(totalCount / ITEMS_PER_PAGE);

  const handlePageChange = (newPage: number) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set("page", newPage.toString());
    router.push(`/artists?${params.toString()}`);
  };

  /**
   * Renders the inscription with specific styling for the province name
   */
  const renderInscription = () => {
    if (isReligiousFilter) return "All Christian Artists";
    
    if (region) {
      return (
        <>
          All Artists from the Province{" "}
          <span className="text-[var(--color-wikicrimson)]">{region}</span>
        </>
      );
    }
    
    return "All Artists";
  };

  if (loading) {
    return (
      <div className="flex h-screen items-center justify-center text-gray-400">
        <div className="animate-pulse font-medium text-[var(--color-flagblue)]">
          Consulting Mangulina&trade; records…
        </div>
      </div>
    );
  }

  return (
    <main className="space-y-12 p-6 pb-[20vh] max-w-[1600px] mx-auto">
      
      {/* INSCRIPTION SECTION */}
      <section>
        <div className="border-t border-black/5" />
        <div className="py-4 flex justify-center">
          <h2 className="font-[family-name:var(--font-outfit)] text-4xl font-bold text-[var(--color-flagblue)] tracking-tight text-center">
            {renderInscription()}
          </h2>
        </div>
        <div className="border-b border-black/5" />
      </section>

      {/* PAGINATION SECTION */}
      {totalPages > 1 && (
        <section className="flex items-center justify-between">
          <div className="flex gap-2">
            <button onClick={() => handlePageChange(1)} disabled={currentPage === 1} className="btn-archive px-4 py-2 text-[10px] font-bold uppercase tracking-widest disabled:opacity-20">First</button>
            <button onClick={() => handlePageChange(currentPage - 1)} disabled={currentPage === 1} className="btn-archive px-4 py-2 text-[10px] font-bold uppercase tracking-widest disabled:opacity-20">Previous</button>
          </div>

          <div className="hidden sm:flex flex-col items-center">
            <span className="text-sm font-black text-[var(--color-flagblue)] uppercase tracking-tighter">
              Folio {currentPage} / {totalPages}
            </span>
          </div>

          <div className="flex gap-2">
            <button onClick={() => handlePageChange(currentPage + 1)} disabled={currentPage === totalPages} className="btn-archive px-4 py-2 text-[10px] font-bold uppercase tracking-widest disabled:opacity-20">Next</button>
            <button onClick={() => handlePageChange(totalPages)} disabled={currentPage === totalPages} className="btn-archive px-4 py-2 text-[10px] font-bold uppercase tracking-widest disabled:opacity-20">Last</button>
          </div>
        </section>
      )}

      {/* GRID SECTION */}
      <section className="grid grid-cols-2 gap-x-4 gap-y-10 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 xl:grid-cols-8">
        {artists.length > 0 ? (
          artists.map((artist) => (
            <div key={artist.id} className="flex justify-center sm:justify-start">
              <div className="w-full max-w-[160px] sm:max-w-none">
                <ArtistCard artist={artist} />
              </div>
            </div>
          ))
        ) : (
          <div className="col-span-full py-20 text-center">
            <p className="font-[family-name:var(--font-serif)] text-2xl italic text-gray-300">
              No matching records found in the archive.
            </p>
          </div>
        )}
      </section>
    </main>
  );
}

export default function ArtistsPage() {
  return (
    <Suspense fallback={null}>
      <ArtistsContent />
    </Suspense>
  );
}