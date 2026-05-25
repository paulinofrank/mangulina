"use client";

import { useEffect, useMemo, useState, Suspense } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { Search, SlidersHorizontal } from "lucide-react";
import { getSupabaseClient } from "@/lib/supabase";
import ArtistCard from "@/components/molecules/ArtistCard";
import type { Artist } from "@/types/music";

const ITEMS_PER_PAGE = 24;

const ROLE_FILTERS = [
  { key: "singer", label: "Singer" },
  { key: "musician", label: "Musician" },
  { key: "songwriter", label: "Songwriter" },
  { key: "composer", label: "Composer" },
  { key: "composer_strict", label: "Composer Only" },
  { key: "producer", label: "Producer" },
  { key: "lyricist", label: "Lyricist" },
];

const TAG_FILTERS = [
  { key: "christian", label: "Christian" },
  { key: "emerging", label: "Emerging" },
  { key: "independent", label: "Independent" },
];

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
    <section className="mt-14 flex items-center justify-center gap-2 flex-wrap">
      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className="rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:opacity-30"
      >
        Previous
      </button>

      {Array.from({ length: Math.min(totalPages, 5) }).map((_, i) => {
        const page = i + 1;
        return (
          <button
            key={page}
            onClick={() => onPageChange(page)}
            className={`h-10 w-10 rounded-full border text-sm transition
              ${
                currentPage === page
                  ? "bg-(--color-flagblue) text-white border-(--color-flagblue)"
                  : "border-black/10 bg-white text-gray-600 hover:bg-gray-100"
              }`}
          >
            {page}
          </button>
        );
      })}

      <button
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
        className="rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:opacity-30"
      >
        Next
      </button>
    </section>
  );
}

function FilterPill({
  active,
  label,
  onClick,
}: {
  active: boolean;
  label: string;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className={`
        rounded-full px-4 py-2 text-sm border transition-all
        ${
          active
            ? "bg-(--color-flagblue) text-white border-(--color-flagblue)"
            : "bg-white border-black/10 text-gray-600 hover:bg-gray-50"
        }
      `}
    >
      {label}
    </button>
  );
}

function ArtistsContent() {
  const supabase = getSupabaseClient();
  const router = useRouter();
  const searchParams = useSearchParams();

  const [artists, setArtists] = useState<Artist[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);

  const [searchInput, setSearchInput] = useState(
    searchParams.get("search") ?? ""
  );

  const role = searchParams.get("role");
  const tag = searchParams.get("tag");
  const sort = searchParams.get("sort") ?? "views";
  const currentPage = parseInt(searchParams.get("page") ?? "1");

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

        const search = searchParams.get("search");
        if (search) {
          query = query.ilike("name", `%${search}%`);
        }

        // ROLE FILTER
        if (role === "composer_strict") {
          query = query.eq("occupations", ["composer"]);
        } else if (role) {
          query = query.filter(
            "occupations",
            "cs",
            `["${role}"]`
          );
        }

        // TAG FILTER
        if (tag) {
          query = query.filter("tags", "cs", `["${tag}"]`);
        }

        const { data, count, error } = await query
          .order(
            sort === "name"
              ? "name"
              : sort === "newest"
              ? "created_at"
              : "views",
            {
              ascending: sort === "name",
            }
          )
          .range(from, to);

        if (error) {
          console.error(error);
          return;
        }

        setArtists((data ?? []) as Artist[]);
        setTotalCount(count ?? 0);
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    }

    loadArtists();
  }, [supabase, searchParams, currentPage, role, tag, sort]);

  const totalPages = Math.ceil(totalCount / ITEMS_PER_PAGE);

  const handlePageChange = (page: number) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set("page", page.toString());
    router.push(`/debug?${params.toString()}`);
  };

  const handleFilter = (type: "role" | "tag", key: string) => {
    const params = new URLSearchParams(searchParams.toString());
    const current = params.get(type);

    if (current === key) {
      params.delete(type);
    } else {
      params.set(type, key);
    }

    params.set("page", "1");
    router.push(`/debug?${params.toString()}`);
  };

  const clearFilters = () => {
    router.push("/debug?");
  };

  const activeFilters = useMemo(() => {
    return [role, tag].filter(Boolean).length;
  }, [role, tag]);

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <div className="h-10 w-10 rounded-full border-2 border-black/10 border-t-(--color-flagblue) animate-spin" />
      </div>
    );
  }

  return (
    <main className="mx-auto max-w-450 px-4 sm:px-6 lg:px-10 py-10 pb-28">
      {/* HEADER */}
      <section className="mb-8">
        <div className="flex items-start justify-between gap-6 mb-6">
          <div>
            <p className="mb-2 text-[10px] uppercase tracking-[0.3em] text-gray-400">
              Mangulina™ Musical Archive
            </p>
            <h1 className="text-4xl md:text-5xl font-bold tracking-tight text-(--color-flagblue)">
              All Artists
            </h1>
          </div>
          <div className="hidden sm:block text-[11px] uppercase tracking-[0.25em] text-gray-400">
            {totalCount.toLocaleString()} Records
          </div>
        </div>

        {/* DISCOVERY PANEL */}
        <div className="rounded-4xl border border-black/5 bg-white/80 backdrop-blur-sm p-5 sm:p-7 shadow-[0_4px_30px_rgba(0,0,0,0.03)]">

          {/* SEARCH */}
          <div className="flex flex-col lg:flex-row gap-4 mb-8">
            <div className="relative flex-1">
              <Search
                className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"
                size={16}
              />
              <input
                value={searchInput}
                onChange={(e) => setSearchInput(e.target.value)}
                onKeyDown={(e) => {
                  if (e.key === "Enter") {
                    const params = new URLSearchParams(searchParams.toString());
                    if (searchInput.trim()) {
                      params.set("search", searchInput);
                    } else {
                      params.delete("search");
                    }
                    params.set("page", "1");
                    router.push(`/debug?${params.toString()}`);
                  }
                }}
                placeholder="Search artists, songs, albums..."
                className="h-10 w-full rounded-xl border border-black/8 bg-white pl-10 pr-4 text-sm outline-none transition focus:border-(--color-flagblue)"
              />
            </div>

            <div className="flex items-center gap-3">
              <button className="flex items-center gap-2 rounded-xl border border-black/10 px-5 h-10 text-sm text-gray-600">
                <SlidersHorizontal size={16} />
                Filters ({activeFilters})
              </button>

              {activeFilters > 0 && (
                <button
                  onClick={clearFilters}
                  className="text-sm text-(--color-flagblue)"
                >
                  Clear all
                </button>
              )}
            </div>
          </div>

          {/* ROLES */}
          <div className="mb-6">
            <p className="mb-3 text-[11px] uppercase tracking-[0.25em] text-gray-400">
              Roles
            </p>
            <div className="flex flex-wrap gap-3">
              {ROLE_FILTERS.map((item) => (
                <FilterPill
                  key={item.key}
                  label={item.label}
                  active={role === item.key}
                  onClick={() => handleFilter("role", item.key)}
                />
              ))}
            </div>
          </div>

          {/* TAGS */}
          <div>
            <p className="mb-3 text-[11px] uppercase tracking-[0.25em] text-gray-400">
              Tags
            </p>
            <div className="flex flex-wrap gap-3">
              {TAG_FILTERS.map((item) => (
                <FilterPill
                  key={item.key}
                  label={item.label}
                  active={tag === item.key}
                  onClick={() => handleFilter("tag", item.key)}
                />
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* RESULTS BAR */}
      <section className="mb-7 flex items-center justify-between gap-4">
        <p className="text-sm text-gray-500">
          Showing{" "}
          <span className="font-semibold text-(--color-flagblue)">
            {artists.length}
          </span>{" "}
          of {totalCount.toLocaleString()} artists
        </p>

        <select
          onChange={(e) => {
            const params = new URLSearchParams(searchParams.toString());
            params.set("sort", e.target.value);
            params.set("page", "1");
            router.push(`/artists?${params.toString()}`);
          }}
          value={sort}
          className="h-10 rounded-xl border border-black/10 bg-white px-4 text-sm outline-none"
        >
          <option value="views">Most Viewed</option>
          <option value="name">Name A-Z</option>
          <option value="newest">Newest</option>
        </select>
      </section>

      {/* GRID */}
      <section className="rounded-4xl border border-black/5 p-4">
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 lg:grid-cols-6 xl:grid-cols-7 2xl:grid-cols-8 gap-3">
          {artists.map((artist) => (
            <ArtistCard key={artist.id} artist={artist} />
          ))}
        </div>
      </section>

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