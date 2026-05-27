"use client";

import { useEffect, useMemo, useState, Suspense } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { SlidersHorizontal } from "lucide-react";
import { getSupabaseClient } from "@/lib/supabase";
import ArtistCard from "@/components/molecules/ArtistCard";
import type { Artist } from "@/types/music";

const ITEMS_PER_PAGE = 24;

const ROLE_FILTERS = [
  { key: "singer", label: "Singer" },
  { key: "composer", label: "Composer" },
  { key: "songwriter", label: "Songwriter" },
  { key: "lyricist", label: "Lyricist" },
  { key: "dj", label: "DJs" },
  { key: "musician", label: "Musician" },
];

const TAG_FILTERS = [
  { key: "christian", label: "Christian" },
  { key: "classical", label: "Classical" },
  { key: "emerging", label: "Emerging" },
];

const ARTIST_TAG_FILTERS = new Set(["christian", "emerging"]);

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
    <section className="my-10 flex items-center justify-center gap-2 flex-wrap">
      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className="cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30"
      >
        Previous
      </button>

      {Array.from({ length: Math.min(totalPages, 5) }).map((_, i) => {
        const page = i + 1;
        return (
          <button
            key={page}
            onClick={() => onPageChange(page)}
            className={`h-10 w-10 cursor-pointer rounded-full border text-sm transition
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
        className="cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30"
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
  tone = "blue",
}: {
  active: boolean;
  label: string;
  onClick: () => void;
  tone?: "blue" | "red";
}) {
  const inactiveClass =
    tone === "red"
      ? "bg-white border-[#8B0000]/20 text-gray-600 hover:bg-[#8B0000]/5"
      : "bg-white border-(--color-flagblue)/20 text-gray-600 hover:bg-(--color-flagblue)/5";
  const activeClass =
    tone === "red"
      ? "bg-[#8B0000] text-white border-[#8B0000]"
      : "bg-(--color-flagblue) text-white border-(--color-flagblue)";

  return (
    <button
      onClick={onClick}
      className={`
        flex-1 basis-28 cursor-pointer rounded-full px-4 py-2 text-sm border text-center transition-all
        ${
          active
            ? activeClass
            : inactiveClass
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
          query = query.eq("primary_role", "composer");
        } else if (role) {
          query = query.eq("primary_role", role);
        }

        // Classification tags live in artist_tags; musical genres stay in genres.
        if (tag) {
          query = ARTIST_TAG_FILTERS.has(tag)
            ? query.contains("artist_tags", [tag])
            : query.contains("genres", [tag]);
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
    router.push(`/artists?${params.toString()}`);
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
    router.push(`/artists?${params.toString()}`);
  };

  const clearFilters = () => {
    router.push("/artists?");
  };

  const activeFilters = useMemo(() => {
    return [role, tag].filter(Boolean).length;
  }, [role, tag]);

  const pageTitle = useMemo(() => {
    const roleLabel = ROLE_FILTERS.find((item) => item.key === role)?.label;
    const tagLabel = TAG_FILTERS.find((item) => item.key === tag)?.label;

    if (tagLabel && roleLabel) {
      return `All ${tagLabel} ${roleLabel}`;
    }

    if (tagLabel) {
      return `All ${tagLabel} Artists`;
    }

    if (roleLabel) {
      return `All ${roleLabel}`;
    }

    return "All Artists";
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
      <section className="mt-6 mb-2">
        {/* DISCOVERY PANEL */}
        <div className="rounded-4xl border border-black/5 bg-white/80 backdrop-blur-sm p-5 sm:p-7 shadow-[0_4px_30px_rgba(0,0,0,0.03)]">

          {/* TITLE + CONTROLS */}
          <div className="flex flex-col gap-4 mb-8 lg:flex-row lg:items-center">
            <div className="flex flex-1 flex-col justify-center text-center lg:text-left">
              <h1 className="text-2xl font-bold tracking-tight text-(--color-flagblue) md:text-3xl">
                {pageTitle}
              </h1>
            </div>

            <div className="flex flex-1 items-center justify-center lg:justify-start">
              <p className="text-sm text-gray-500">
                Showing{" "}
                <span className="font-semibold text-(--color-flagblue)">
                  {artists.length}
                </span>{" "}
                of {totalCount.toLocaleString()} artists
              </p>
            </div>

            <div className="flex items-center justify-center gap-3 lg:justify-end">
              <select
                onChange={(e) => {
                  const params = new URLSearchParams(searchParams.toString());
                  params.set("sort", e.target.value);
                  params.set("page", "1");
                  router.push(`/artists?${params.toString()}`);
                }}
                value={sort}
                className="h-10 rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
              >
                <option value="views">Most Viewed</option>
                <option value="name">Name A-Z</option>
                <option value="newest">Newest</option>
              </select>

              <button className="flex cursor-pointer items-center gap-2 rounded-xl border border-black/10 px-5 h-10 text-sm text-gray-600">
                <SlidersHorizontal size={16} />
                Filters ({activeFilters})
              </button>

              {activeFilters > 0 && (
                <button
                  onClick={clearFilters}
                  className="cursor-pointer text-sm text-(--color-flagblue)"
                >
                  Clear all
                </button>
              )}
            </div>
          </div>

          {/* ROLES */}
          <div className="mb-3 flex flex-wrap gap-3">
            <div className="flex w-full flex-wrap gap-3">
              {ROLE_FILTERS.map((item) => (
                <FilterPill
                  key={item.key}
                  label={item.label}
                  active={role === item.key}
                  onClick={() => handleFilter("role", item.key)}
                  tone="blue"
                />
              ))}
            </div>
          </div>

          <div className="my-4 h-px w-full bg-linear-to-r from-transparent via-[#8B0000]/25 to-transparent" />

          {/* TAGS */}
          <div className="flex flex-wrap gap-3">
            <div className="flex w-full flex-wrap gap-3">
              {TAG_FILTERS.map((item) => (
                <FilterPill
                  key={item.key}
                  label={item.label}
                  active={tag === item.key}
                  onClick={() => handleFilter("tag", item.key)}
                  tone="red"
                />
              ))}
            </div>
          </div>
        </div>
      </section>

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />

      {/* GRID */}
      <section className="rounded-4xl border border-black/5 bg-white/80 backdrop-blur-sm p-6 sm:p-8 shadow-[0_4px_30px_rgba(0,0,0,0.03)]">
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 lg:grid-cols-6 xl:grid-cols-7 2xl:grid-cols-8 gap-4 sm:gap-5">
          {artists.map((artist) => (
            <div key={artist.id} className="mx-auto w-[90%]">
              <ArtistCard artist={artist} />
            </div>
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
