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

const MOBILE_TAG_FILTERS = [
  { key: "christian", label: "Christian" },
  { key: "classical", label: "Classical" },
  { key: "emerging", label: "Emerging" },
];

const CONTEXT_FILTERS = [
  { key: "secular", label: "Secular" },
  { key: "christian", label: "Christian" },
];

const STATUS_FILTERS = [
  { key: "legend", label: "Legends" },
  { key: "emerging", label: "Emerging" },
];

const ARTIST_TAG_FILTERS = new Set(["christian", "secular", "legend", "emerging"]);
const CONTEXT_FILTER_KEYS = new Set(CONTEXT_FILTERS.map((item) => item.key));
const STATUS_FILTER_KEYS = new Set(STATUS_FILTERS.map((item) => item.key));
const ARTISTS_QUERY_TIMEOUT_MS = 20000;
const ARTIST_LIST_SELECT = [
  "id",
  "slug",
  "name",
  "status",
  "primary_role",
  "primary_genre",
  "stage_name",
  "date_of_birth",
  "province",
  "birth_place",
  "bio",
  "facebook",
  "instagram",
  "genres",
  "artist_tags",
  "views",
  "death_year",
].join(",");

type ProvinceOption = {
  province: string;
  count: number;
};

type GenreOption = {
  id: string | number;
  name: string;
  slug?: string | null;
  display_order?: number | null;
};

type SubgenreOption = {
  id: string | number;
  genre_id: string | number;
  name: string;
};

type AdminGenresResponse = {
  ok: boolean;
  genres?: GenreOption[];
  error?: string;
};

type AdminSubgenresResponse = {
  ok: boolean;
  subgenres?: SubgenreOption[];
  error?: string;
};

function Pagination({
  currentPage,
  totalPages,
  onPageChange,
  hideMobile = false,
  mobileOnly = false,
  insideBox = false,
}: {
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
  hideMobile?: boolean;
  mobileOnly?: boolean;
  insideBox?: boolean;
}) {
  if (totalPages <= 1) return null;

  const mobileWindowSize = Math.min(totalPages, 3);
  const mobileWindowStart =
    currentPage <= 3
      ? 1
      : Math.min(currentPage - 1, totalPages - mobileWindowSize + 1);
  const mobilePages = Array.from({ length: mobileWindowSize }).map(
    (_, index) => mobileWindowStart + index,
  );
  const showMobileLeadingEllipsis = mobilePages[0] > 1;
  const showMobileTrailingEllipsis = mobilePages[mobilePages.length - 1] < totalPages;
  const mobileClass = hideMobile ? "hidden sm:hidden" : mobileOnly ? "flex sm:hidden" : "flex sm:hidden";
  const desktopClass = mobileOnly ? "hidden" : "hidden sm:block";
  const sectionClass = mobileOnly
    ? "mb-4 mt-0 flex flex-wrap items-center justify-between gap-x-2 gap-y-1 sm:hidden"
    : hideMobile
      ? "hidden sm:my-7 sm:flex sm:flex-wrap sm:items-center sm:justify-center sm:gap-2"
      : insideBox
        ? "mt-6 mb-0 flex items-center justify-center gap-2 flex-wrap sm:mt-8"
        : "my-3 flex items-center justify-center gap-2 flex-wrap sm:my-7";

  return (
    <section className={sectionClass}>
      <button
        onClick={() => onPageChange(1)}
        disabled={currentPage === 1}
        className={`${mobileClass} cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30`}
      >
        First
      </button>

      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className={`${mobileClass} cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30`}
      >
        Previous
      </button>

      <div className={`${mobileClass} flex-1 items-center justify-center gap-2`}>
        {showMobileLeadingEllipsis && (
          <span className="px-1 text-sm text-gray-400" aria-hidden="true">
            ...
          </span>
        )}

        {mobilePages.map((page) => (
          <button
            key={page}
            onClick={() => onPageChange(page)}
            className={`cursor-pointer text-sm underline-offset-4 transition hover:underline
              ${
                currentPage === page
                  ? "font-semibold text-(--color-flagblue)"
                  : "text-gray-500 hover:text-(--color-flagblue)"
              }`}
          >
            {page}
          </button>
        ))}

        {showMobileTrailingEllipsis && (
          <span className="px-1 text-sm text-gray-400" aria-hidden="true">
            ...
          </span>
        )}
      </div>

      <button
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
        className={`${mobileClass} cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30`}
      >
        Next
      </button>

      <button
        onClick={() => onPageChange(totalPages)}
        disabled={currentPage === totalPages}
        className={`${mobileClass} cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30`}
      >
        Last
      </button>

      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className={`${desktopClass} cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30`}
      >
        Previous
      </button>

      {Array.from({ length: Math.min(totalPages, 5) }).map((_, i) => {
        const page = i + 1;
        return (
          <button
            key={page}
            onClick={() => onPageChange(page)}
            className={`${desktopClass} h-10 w-10 cursor-pointer rounded-full border text-sm transition
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
        className={`${desktopClass} cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30`}
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
        cursor-pointer rounded-full border px-4 py-1.5 text-center text-sm transition-all
        ${tone === "red" ? "flex-none basis-20" : "flex-1 basis-28"}
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

function ContextToggle({
  value,
  onChange,
}: {
  value: string;
  onChange: (key: string) => void;
}) {
  return (
    <div className="flex h-9 w-full max-w-64 rounded-full border border-[#8B0000]/20 bg-white p-0.5">
      {CONTEXT_FILTERS.map((item) => {
        const active = value === item.key;

        return (
          <button
            key={item.key}
            onClick={() => onChange(item.key)}
            className={`h-full flex-1 cursor-pointer rounded-full px-3 text-sm transition-all
              ${
                active
                  ? "bg-[#8B0000] text-white shadow-sm"
                  : "text-gray-600 hover:bg-[#8B0000]/5"
              }`}
          >
            {item.label}
          </button>
        );
      })}
    </div>
  );
}

function StatusToggleGroup({
  statuses,
  onChange,
}: {
  statuses: string[];
  onChange: (key: string) => void;
}) {
  return (
    <div className="grid w-full grid-cols-2 gap-3 lg:w-64">
      {STATUS_FILTERS.map((item) => (
        <button
          key={item.key}
          onClick={() => onChange(item.key)}
          className={`flex h-9 cursor-pointer items-center justify-center rounded-xl border px-4 text-sm transition
            ${
              statuses.includes(item.key)
                ? "border-[#8B0000] bg-[#8B0000] text-white"
                : "border-black/10 bg-white text-gray-600 hover:bg-[#8B0000]/5"
            }`}
        >
          {item.label}
        </button>
      ))}
    </div>
  );
}

function ArtistsContent() {
  const supabase = getSupabaseClient();
  const router = useRouter();
  const searchParams = useSearchParams();
  const searchParamsString = searchParams.toString();

  const [artists, setArtists] = useState<Artist[]>([]);
  const [provinces, setProvinces] = useState<ProvinceOption[]>([]);
  const [genreOptions, setGenreOptions] = useState<GenreOption[]>([]);
  const [subgenreOptions, setSubgenreOptions] = useState<SubgenreOption[]>([]);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [totalCount, setTotalCount] = useState(0);

  const role = searchParams.get("role");
  const tag = searchParams.get("tag");
  const context =
    searchParams.get("context") ??
    (tag && CONTEXT_FILTER_KEYS.has(tag) ? tag : null);
  const selectedContext = context ?? "secular";
  const artistStatusParam = searchParams.get("artist_status");
  const artistStatuses = useMemo(
    () =>
      artistStatusParam
        ? artistStatusParam
            .split(",")
            .map((item) => item.trim())
            .filter((item) => STATUS_FILTER_KEYS.has(item))
            .slice(0, 1)
        : tag && STATUS_FILTER_KEYS.has(tag)
          ? [tag]
          : [],
    [artistStatusParam, tag],
  );
  const genreFilter =
    searchParams.get("genre") ??
    (searchParams.get("classical") === "1" || tag === "classical" ? "classical" : null);
  const subgenreFilter = searchParams.get("subgenre");
  const legacyTag =
    tag && !CONTEXT_FILTER_KEYS.has(tag) && !STATUS_FILTER_KEYS.has(tag) && tag !== "classical"
      ? tag
      : null;
  const province = searchParams.get("province") ?? searchParams.get("region");
  const sort = searchParams.get("sort") ?? "views";
  const currentPage = parseInt(searchParams.get("page") ?? "1");

  const selectedGenreValue = subgenreFilter
    ? `subgenre:${subgenreFilter}`
    : genreFilter
      ? `genre:${genreFilter}`
      : "";

  const subgenresByGenreId = useMemo(() => {
    return subgenreOptions.reduce((map, subgenre) => {
      const key = String(subgenre.genre_id);
      const items = map.get(key) ?? [];
      items.push(subgenre);
      map.set(key, items);
      return map;
    }, new Map<string, SubgenreOption[]>());
  }, [subgenreOptions]);

  useEffect(() => {
    let isActive = true;

    async function loadGenreCatalog() {
      const [genresResponse, subgenresResponse] = await Promise.all([
        fetch("/api/admin/genres"),
        fetch("/api/admin/subgenres?all=1"),
      ]);
      const genresResult = (await genresResponse.json()) as AdminGenresResponse;
      const subgenresResult = (await subgenresResponse.json()) as AdminSubgenresResponse;

      if (!isActive) return;

      if (genresResponse.ok && genresResult.ok) {
        setGenreOptions(genresResult.genres ?? []);
      }

      if (subgenresResponse.ok && subgenresResult.ok) {
        setSubgenreOptions(subgenresResult.subgenres ?? []);
      }
    }

    async function loadProvinces() {
      if (!supabase) return;

      const { data, error } = await supabase
        .from("artists")
        .select("province")
        .eq("status", "published")
        .not("province", "is", null);

      if (error) {
        console.error(error);
        return;
      }

      if (!isActive) return;

      setProvinces(
        Array.from(
          ((data ?? []) as Array<{ province: string | null }>).reduce(
            (map, item) => {
              if (item.province) {
                map.set(item.province, (map.get(item.province) || 0) + 1);
              }

              return map;
            },
            new Map<string, number>()
          )
        )
          .map(([province, count]) => ({ province, count }))
          .sort((a, b) => a.province.localeCompare(b.province))
      );
    }

    void loadGenreCatalog();
    loadProvinces();

    return () => {
      isActive = false;
    };
  }, [supabase]);

  useEffect(() => {
    let isActive = true;
    const abortController = new AbortController();
    let timeoutId: number | undefined;

    async function loadArtists() {
      if (!supabase) {
        if (isActive) {
          setLoadError("Artist data is not configured.");
          setLoading(false);
        }
        return;
      }

      setLoading(true);
      setLoadError(null);
      timeoutId = window.setTimeout(() => {
        abortController.abort();
        if (isActive) {
          setArtists([]);
          setTotalCount(0);
          setLoadError("Artist data took too long to respond.");
          setLoading(false);
        }
      }, ARTISTS_QUERY_TIMEOUT_MS);

      try {
        const from = (currentPage - 1) * ITEMS_PER_PAGE;
        const to = from + ITEMS_PER_PAGE - 1;

        let query = supabase
          .from("artists")
          .select(ARTIST_LIST_SELECT, { count: "exact" })
          .eq("status", "published");

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
        if (selectedContext) {
          query = query.contains("artist_tags", [selectedContext]);
        }

        if (artistStatuses.length === 1) {
          query = query.contains("artist_tags", [artistStatuses[0]]);
        } else if (artistStatuses.length > 1) {
          query = query.overlaps("artist_tags", artistStatuses);
        }

        if (legacyTag) {
          query = ARTIST_TAG_FILTERS.has(legacyTag)
            ? query.contains("artist_tags", [legacyTag])
            : query.contains("genres", [legacyTag]);
        }

        if (genreFilter) {
          query = query.eq("primary_genre", genreFilter);
        }

        if (subgenreFilter) {
          query = query.contains("genres", [subgenreFilter]);
        }

        if (province) {
          query = query.eq("province", province);
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
          .abortSignal(abortController.signal)
          .range(from, to);

        if (!isActive || abortController.signal.aborted) return;

        if (error) {
          console.error(error);
          setArtists([]);
          setTotalCount(0);
          setLoadError("Unable to load artists right now.");
          return;
        }

        setArtists(((data ?? []) as unknown) as Artist[]);
        setTotalCount(count ?? 0);
      } catch (err) {
        if (!isActive) return;

        console.error(err);
        setArtists([]);
        setTotalCount(0);
        setLoadError(
          abortController.signal.aborted
            ? "Artist data took too long to respond."
            : "Unable to load artists right now."
        );
      } finally {
        if (timeoutId) window.clearTimeout(timeoutId);
        if (isActive) setLoading(false);
      }
    }

    loadArtists();

    return () => {
      isActive = false;
      abortController.abort();
      if (timeoutId) window.clearTimeout(timeoutId);
    };
  }, [
    supabase,
    searchParamsString,
    currentPage,
    role,
    selectedContext,
    artistStatuses,
    legacyTag,
    genreFilter,
    subgenreFilter,
    province,
    sort,
  ]);

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

  const handleRoleChange = (value: string) => {
    const params = new URLSearchParams(searchParams.toString());

    if (value) {
      params.set("role", value);
    } else {
      params.delete("role");
    }

    params.set("page", "1");
    router.push(`/artists?${params.toString()}`);
  };

  const handleContextFilter = (key: string) => {
    const params = new URLSearchParams(searchParams.toString());
    const current = params.get("context");

    params.delete("tag");

    if (current === key) {
      params.delete("context");
    } else {
      params.set("context", key);
    }

    params.set("page", "1");
    router.push(`/artists?${params.toString()}`);
  };

  const handleStatusFilter = (key: string) => {
    const params = new URLSearchParams(searchParams.toString());
    const currentStatus = params.get("artist_status")?.split(",")[0] ??
      (params.get("tag") && STATUS_FILTER_KEYS.has(params.get("tag")!) ? params.get("tag") : null);

    params.delete("tag");

    if (currentStatus === key) {
      params.delete("artist_status");
    } else {
      params.set("artist_status", key);
    }

    params.set("page", "1");
    router.push(`/artists?${params.toString()}`);
  };

  const handleMobileTagFilter = (key: string) => {
    const params = new URLSearchParams(searchParams.toString());

    if (key === "classical") {
      const current =
        params.get("genre") ??
        (params.get("classical") === "1" || params.get("tag") === "classical" ? "classical" : null);

      params.delete("tag");
      params.delete("classical");
      params.delete("subgenre");

      if (current === "classical") {
        params.delete("genre");
      } else {
        params.set("genre", "classical");
      }

      params.set("page", "1");
      router.push(`/artists?${params.toString()}`);
      return;
    }

    if (CONTEXT_FILTER_KEYS.has(key)) {
      handleContextFilter(key);
      return;
    } else if (STATUS_FILTER_KEYS.has(key)) {
      handleStatusFilter(key);
      return;
    } else {
      const current = params.get("tag");

      if (current === key) {
        params.delete("tag");
      } else {
        params.set("tag", key);
      }
    }

    params.set("page", "1");
    router.push(`/artists?${params.toString()}`);
  };

  const handleGenreSelection = (value: string) => {
    const params = new URLSearchParams(searchParams.toString());

    params.delete("tag");
    params.delete("classical");
    params.delete("genre");
    params.delete("subgenre");

    if (value.startsWith("genre:")) {
      params.set("genre", value.replace("genre:", ""));
    } else if (value.startsWith("subgenre:")) {
      params.set("subgenre", value.replace("subgenre:", ""));
    } else {
      params.delete("genre");
      params.delete("subgenre");
    }

    params.set("page", "1");
    router.push(`/artists?${params.toString()}`);
  };

  const handleProvinceChange = (value: string) => {
    const params = new URLSearchParams(searchParams.toString());

    if (value) {
      params.set("province", value);
    } else {
      params.delete("province");
    }

    params.delete("region");
    params.set("page", "1");
    router.push(`/artists?${params.toString()}`);
  };

  const clearFilters = () => {
    router.push("/artists?");
  };

  const retryLoad = () => {
    router.refresh();
    window.location.reload();
  };

  const activeFilters = useMemo(() => {
    return [
      role,
      selectedContext,
      ...artistStatuses,
      legacyTag,
      province,
      genreFilter,
      subgenreFilter,
    ].filter(Boolean).length;
  }, [role, selectedContext, artistStatuses, legacyTag, province, genreFilter, subgenreFilter]);

  const pageTitle = useMemo(() => {
    const roleLabel = ROLE_FILTERS.find((item) => item.key === role)?.label;
    const contextLabel = CONTEXT_FILTERS.find((item) => item.key === selectedContext)?.label;
    const statusLabel = artistStatuses
      .map((status) => STATUS_FILTERS.find((item) => item.key === status)?.label)
      .filter(Boolean)
      .join(" ");
    const legacyTagLabel = MOBILE_TAG_FILTERS.find((item) => item.key === legacyTag)?.label;
    const tagLabel = [contextLabel, statusLabel, legacyTagLabel].filter(Boolean).join(" ");
    const genreLabel =
      subgenreOptions.find((item) => item.name === subgenreFilter)?.name ??
      genreOptions.find((item) => (item.slug || item.name) === genreFilter)?.name ??
      null;

    if (province && genreLabel && tagLabel && roleLabel) {
      return `${province} ${genreLabel} ${tagLabel} ${roleLabel}`;
    }

    if (genreLabel && tagLabel && roleLabel) {
      return `All ${genreLabel} ${tagLabel} ${roleLabel}`;
    }

    if (genreLabel && roleLabel) {
      return `All ${genreLabel} ${roleLabel}`;
    }

    if (genreLabel && tagLabel) {
      return `All ${genreLabel} ${tagLabel} Artists`;
    }

    if (genreLabel) {
      return `All ${genreLabel} Artists`;
    }

    if (province && tagLabel && roleLabel) {
      return `${province} ${tagLabel} ${roleLabel}`;
    }

    if (province && tagLabel) {
      return `${province} ${tagLabel} Artists`;
    }

    if (province && roleLabel) {
      return `${province} ${roleLabel}`;
    }

    if (province) {
      return `Artists from ${province}`;
    }

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
  }, [
    role,
    selectedContext,
    artistStatuses,
    legacyTag,
    genreFilter,
    subgenreFilter,
    genreOptions,
    subgenreOptions,
    province,
  ]);

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <div className="h-10 w-10 rounded-full border-2 border-black/10 border-t-(--color-flagblue) animate-spin" />
      </div>
    );
  }

  return (
    <main className="mx-auto max-w-450 px-4 pb-4 pt-10 sm:px-6 sm:pb-6 lg:px-10 lg:pb-10">
      {/* HEADER */}
      <section className="mt-6 mb-3 sm:mb-1">
        {/* DISCOVERY PANEL */}
        <div className="rounded-4xl border border-black/5 bg-white/80 px-5 py-2.5 backdrop-blur-sm shadow-[0_4px_30px_rgba(0,0,0,0.03)] sm:px-7 sm:py-3.5">

          {/* TITLE + CONTROLS */}
          <div className="mb-2 flex flex-col gap-2 lg:mb-4 lg:gap-4">
            <div className="flex flex-row items-center justify-between gap-3 text-left lg:text-left">
              <h1 className="min-w-0 truncate text-xl font-bold tracking-tight text-(--color-flagblue) md:text-3xl">
                {pageTitle}
              </h1>

              <p className="shrink-0 text-right text-xs text-gray-500 sm:text-sm">
                Showing{" "}
                <span className="font-semibold text-(--color-flagblue)">
                  {artists.length}
                </span>{" "}
                of {totalCount.toLocaleString()} artists
              </p>
            </div>

            <div className="hidden flex-wrap items-center justify-center gap-3 lg:flex lg:justify-start">
              <label className="hidden min-w-64 lg:block">
                <span className="sr-only">Genre / Subgenre</span>
                <select
                  value={selectedGenreValue}
                  onChange={(event) => handleGenreSelection(event.target.value)}
                  className="h-9 w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
                >
                  <option value="">All Genres</option>
                  {genreOptions.map((genre) => {
                    const genreValue = genre.slug || genre.name;
                    const subgenres = subgenresByGenreId.get(String(genre.id)) ?? [];

                    return (
                      <optgroup key={genre.id} label={genre.name}>
                        <option value={`genre:${genreValue}`}>{genre.name}</option>
                        {subgenres.map((subgenre) => (
                          <option key={subgenre.id} value={`subgenre:${subgenre.name}`}>
                            {subgenre.name}
                          </option>
                        ))}
                      </optgroup>
                    );
                  })}
                </select>
              </label>

              <select
                onChange={(e) => handleProvinceChange(e.target.value)}
                value={province ?? ""}
                className="h-9 max-w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
              >
                <option value="">All Provinces</option>
                {provinces.map((item) => (
                  <option key={item.province} value={item.province}>
                    {item.province} ({item.count})
                  </option>
                ))}
              </select>

              <select
                onChange={(e) => {
                  const params = new URLSearchParams(searchParams.toString());
                  params.set("sort", e.target.value);
                  params.set("page", "1");
                  router.push(`/artists?${params.toString()}`);
                }}
                value={sort}
                className="h-9 rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
              >
                <option value="views">Sorted by Views</option>
                <option value="name">Name A-Z</option>
                <option value="newest">Newest</option>
              </select>

              <button className="flex h-9 cursor-pointer items-center gap-2 rounded-xl border border-black/10 px-5 text-sm text-gray-600">
                <SlidersHorizontal size={16} />
                Filters ({activeFilters})
              </button>

              {activeFilters > 0 && (
                <button
                  onClick={clearFilters}
                  className="flex h-9 cursor-pointer items-center rounded-xl border border-black/10 px-5 text-sm text-gray-600 transition hover:bg-gray-50 hover:text-(--color-flagblue)"
                >
                  Clear all
                </button>
              )}
            </div>
          </div>

          <div className="grid gap-2 lg:hidden">
            <div className="flex justify-center">
              <ContextToggle value={selectedContext} onChange={handleContextFilter} />
            </div>

            <label className="block">
              <span className="sr-only">Province</span>
              <select
                onChange={(event) => handleProvinceChange(event.target.value)}
                value={province ?? ""}
                className="h-9 w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
              >
                <option value="">All Provinces</option>
                {provinces.map((item) => (
                  <option key={item.province} value={item.province}>
                    {item.province} ({item.count})
                  </option>
                ))}
              </select>
            </label>

            <div className="grid grid-cols-2 gap-3">
              <select
                value={role ?? ""}
                onChange={(event) => handleRoleChange(event.target.value)}
                className="h-9 min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
              >
                <option value="">All Roles</option>
                {ROLE_FILTERS.map((item) => (
                  <option key={item.key} value={item.key}>
                    {item.label}
                  </option>
                ))}
              </select>

              <select
                onChange={(e) => {
                  const params = new URLSearchParams(searchParams.toString());
                  params.set("sort", e.target.value);
                  params.set("page", "1");
                  router.push(`/artists?${params.toString()}`);
                }}
                value={sort}
                className="h-9 min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
              >
                <option value="views">Sorted by Views</option>
                <option value="name">Name A-Z</option>
                <option value="newest">Newest</option>
              </select>
            </div>

            <StatusToggleGroup statuses={artistStatuses} onChange={handleStatusFilter} />

            <div className="grid grid-cols-2 gap-3">
              <button className="flex h-9 cursor-pointer items-center justify-center gap-2 rounded-xl border border-black/10 px-4 text-sm text-gray-600">
                <SlidersHorizontal size={16} />
                Filters ({activeFilters})
              </button>

              <button
                onClick={clearFilters}
                disabled={activeFilters === 0}
                className="flex h-9 cursor-pointer items-center justify-center rounded-xl border border-black/10 px-4 text-sm text-gray-600 transition hover:bg-gray-50 hover:text-(--color-flagblue) disabled:cursor-default disabled:opacity-40"
              >
                Clear all
              </button>
            </div>
          </div>

          <div className="hidden lg:block">
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

            <div className="flex flex-wrap items-center justify-center gap-3">
              <ContextToggle value={selectedContext} onChange={handleContextFilter} />

              <span
                aria-hidden="true"
                className="mx-1 h-6 w-px bg-linear-to-b from-transparent via-[#8B0000]/30 to-transparent"
              />

              <StatusToggleGroup statuses={artistStatuses} onChange={handleStatusFilter} />
            </div>
          </div>
        </div>
      </section>

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
        hideMobile
      />

      {/* GRID */}
      <section className="rounded-4xl border border-black/5 bg-white/80 backdrop-blur-sm p-6 sm:p-8 shadow-[0_4px_30px_rgba(0,0,0,0.03)]">
        <div className="sm:hidden">
          <Pagination
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={handlePageChange}
            mobileOnly
          />
        </div>

        {loadError ? (
          <div className="flex min-h-60 flex-col items-center justify-center gap-4 text-center">
            <p className="text-sm text-gray-500">{loadError}</p>
            <button
              onClick={retryLoad}
              className="cursor-pointer rounded-xl border border-black/10 bg-white px-5 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white"
            >
              Retry
            </button>
          </div>
        ) : artists.length > 0 ? (
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 lg:grid-cols-6 xl:grid-cols-7 2xl:grid-cols-8 gap-4 sm:gap-5">
            {artists.map((artist) => (
              <div key={artist.id} className="mx-auto w-[90%]">
                <ArtistCard artist={artist} />
              </div>
            ))}
          </div>
        ) : (
          <div className="flex min-h-60 items-center justify-center text-center">
            <p className="text-sm text-gray-500">No artists found.</p>
          </div>
        )}

        <Pagination
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={handlePageChange}
          insideBox
        />
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
