// src/app/artists/page.tsx
"use client";

import { useEffect, useState, Suspense } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { getSupabaseClient } from "@/lib/supabase";
import ArtistCard from "@/components/molecules/ArtistCard";
import type { Artist } from "@/types/music";

const ITEMS_PER_PAGE = 24;

function Pagination({
  currentPage,
  totalPages,
  onPageChange,
}: {
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
}) {

  if (totalPages <= 1) return null;

  return (
    <section className="mb-8 flex items-center justify-between w-full">

      {/* LEFT */}
      <div className="flex gap-2">
        <button
          onClick={() => onPageChange(1)}
          disabled={currentPage === 1}
          className="rounded-md border border-black/5 bg-white/80 px-3 py-2 
                     text-[9px] uppercase tracking-[0.25em] text-gray-500 
                     transition-all hover:bg-black hover:text-white 
                     disabled:opacity-25"
        >
          First
        </button>

        <button
          onClick={() => onPageChange(currentPage - 1)}
          disabled={currentPage === 1}
          className="rounded-md border border-black/5 bg-white/80 px-3 py-2 
                     text-[9px] uppercase tracking-[0.25em] text-gray-500 
                     transition-all hover:bg-black hover:text-white 
                     disabled:opacity-25"
        >
          Previous
        </button>
      </div>

      {/* CENTER */}
      <div className="hidden sm:flex flex-col items-center">
        <span className="text-[10px] uppercase tracking-[0.3em] text-gray-400">
          Page {currentPage} of {totalPages}
        </span>
      </div>

      {/* RIGHT */}
      <div className="flex gap-2">
        <button
          onClick={() => onPageChange(currentPage + 1)}
          disabled={currentPage === totalPages}
          className="rounded-md border border-black/5 bg-white/80 px-3 py-2 
                     text-[9px] uppercase tracking-[0.25em] text-gray-500 
                     transition-all hover:bg-black hover:text-white 
                     disabled:opacity-25"
        >
          Next
        </button>

        <button
          onClick={() => onPageChange(totalPages)}
          disabled={currentPage === totalPages}
          className="rounded-md border border-black/5 bg-white/80 px-3 py-2 
                     text-[9px] uppercase tracking-[0.25em] text-gray-500 
                     transition-all hover:bg-black hover:text-white 
                     disabled:opacity-25"
        >
          Last
        </button>
      </div>

    </section>
  );
}

function ArtistsContent() {
  const supabase = getSupabaseClient();
  const searchParams = useSearchParams();
  const router = useRouter();

  const [artists, setArtists] = useState<Artist[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);

  const region = searchParams.get("region");
  const search = searchParams.get("search");
  const occupation = searchParams.get("occupation");

  const currentPage = parseInt(searchParams.get("page") || "1");

  useEffect(() => {
    async function loadArtists() {
      if (!supabase) return;

      setLoading(true);

      try {
        const from = (currentPage - 1) * ITEMS_PER_PAGE;
        const to = from + ITEMS_PER_PAGE - 1;

        let query = supabase
          .from("artists")
          .select("*", { count: "exact" });

        if (region) {
          query = query.eq("province", region);
        }

        if (search) {
          query = query.ilike("name", `%${search}%`);
        }

        // ⭐ Strict composer filter
        if (occupation === "composer_strict") {
          query = query.eq("occupations", ["composer"]);
        }

        // ⭐ Normal occupation filter
        else if (occupation) {
          query = query.filter("occupations", "cs", `["${occupation}"]`);
        }

        const { data, count, error } = await query
          .order("views", { ascending: false })
          .range(from, to);

        if (error) {
          console.error(error);
          return;
        }

        setArtists((data || []) as Artist[]);
        setTotalCount(count || 0);
      } catch (err) {
        console.error("Archive fetch failed:", err);
      } finally {
        setLoading(false);
      }
    }

    loadArtists();
  }, [region, search, occupation, currentPage, supabase]);

  const totalPages = Math.ceil(totalCount / ITEMS_PER_PAGE);

  const handlePageChange = (newPage: number) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set("page", newPage.toString());
    router.push(`/artists?${params.toString()}`);
  };

  const renderInscription = () => {
    if (occupation === "composer_strict") return "Composers (Only)";

    if (occupation)
      return `${occupation.charAt(0).toUpperCase() + occupation.slice(1)} Artists`;

    if (region)
      return (
        <>
          Artists from{" "}
          <span className="text-(--color-wikicrimson)/80">{region}</span>
        </>
      );

    return "All Artists";
  };

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-white">
        <div className="flex flex-col items-center gap-4">
          <div className="relative">
            <div className="h-9 w-9 rounded-full border border-black/10" />
            <div className="absolute inset-0 h-9 w-9 animate-spin rounded-full border border-transparent border-t-(--color-flagblue)" />
          </div>

          <p className="text-[10px] uppercase tracking-[0.3em] text-gray-400">
            Consulting Mangulina™ Archives
          </p>
        </div>
      </div>
    );
  }

  return (
    <main className="mx-auto max-w-400 px-4 sm:px-8 lg:px-12 py-16 pb-32">

      {/* HEADER */}
      <section className="mb-10">
        <div className="border-t border-black/5 mb-4" />

        <div className="flex flex-col gap-2">
          <p className="text-[10px] uppercase tracking-[0.3em] text-gray-400">
            Mangulina™ Musical Archive
          </p>

          <div className="flex flex-col gap-1 md:flex-row md:items-end md:justify-between">
            <h1 className="font-(family-name:--font-outfit) text-2xl sm:text-3xl lg:text-4xl font-bold tracking-tight text-(--color-flagblue)">
              {renderInscription()}
            </h1>

            <div className="text-[11px] uppercase tracking-[0.25em] text-gray-400">
              {totalCount.toLocaleString()} Records
            </div>
          </div>
        </div>

        <div className="border-b border-black/5 mt-4" />
      </section>

      {/* OCCUPATION FILTERS */}
      <section className="mb-8 flex flex-wrap gap-2 w-full">

        {[
          { key: "singer", label: "Singer" },
          { key: "composer", label: "Composer" },
          { key: "composer_strict", label: "Composer Only" },
          { key: "lyricist", label: "Lyricist" },
          { key: "producer", label: "Producer" },
          { key: "musician", label: "Musician" },
          { key: "christian", label: "Christian" },
          { key: "emerging", label: "Emerging" },
        ].map(({ key, label }) => {
          const isActive = occupation === key;

          return (
            <button
              key={key}
              onClick={() => {
                const params = new URLSearchParams(searchParams.toString());

                if (isActive) {
                  params.delete("occupation");
                } else {
                  params.set("occupation", key);
                  params.set("page", "1");
                }

                router.push(`/artists?${params.toString()}`);
              }}
              className={`flex-1 min-w-30 text-center px-4 py-2 rounded-full cursor-pointer text-sm border transition-all
  ${isActive
                  ? "bg-(--color-flagblue) text-white border-(--color-flagblue)"
                  : "bg-white text-gray-600 border-gray-300 hover:bg-gray-100"
                }
`}

            >
              {label}
            </button>
          );
        })}
      </section>

      {/* TOP PAGINATION */}
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />

      {/* GRID */}
      <section className="grid grid-cols-2 gap-x-4 gap-y-8 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 xl:grid-cols-8">
        {artists.length > 0 ? (
          artists.map((artist) => (
            <div key={artist.id} className="flex justify-center sm:justify-start">
              <div className="w-full max-w-42.5">
                <ArtistCard artist={artist} />
              </div>
            </div>
          ))
        ) : (
          <div className="col-span-full py-24 text-center">
            <p className="font-serif text-xl italic text-gray-300">
              No matching records found in the archive.
            </p>
          </div>
        )}
      </section>

      {/* BOTTOM PAGINATION */}
      <div className="mt-12"></div>
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />

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
