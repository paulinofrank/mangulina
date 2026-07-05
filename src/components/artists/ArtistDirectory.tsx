"use client";

import { useEffect, useMemo, useState, Suspense } from "react";
import { useSearchParams } from "next/navigation";
import { SlidersHorizontal } from "lucide-react";
import { useTranslations, useLocale } from "next-intl";
import { useRouter } from "@/i18n/navigation";
import { getSupabaseClient } from "@/lib/supabase";
import ArtistCard from "@/components/molecules/ArtistCard";
import JsonLd from "@/components/seo/JsonLd";
import type { Artist } from "@/types/music";
import type {
  ArtistGenreOption,
  ArtistSubgenreOption,
  FilteredArtistGenreOptions,
} from "@/lib/artistGenreOptions";
import type { AwardedArtistRanking, AwardFilterOption } from "@/lib/artistAwards";
import {
  ARTIST_DIRECTORY_ITEMS_PER_PAGE,
  ARTIST_LIST_SELECT,
  type ArtistDirectoryInitialData,
} from "@/lib/artistDirectoryShared";
import { isValidProvinceName, provinceToSlug } from "@/lib/provinceSlug";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

export type ArtistBrowseRole =
  | "singer"
  | "composer"
  | "songwriter"
  | "lyricist"
  | "musician"
  | "dj"
  | "producer"
  | "instrumentalist";

type ArtistDirectoryProps = {
  path: string;
  heading?: string;
  intro?: string;
  i18nKey?: string;
  role?: ArtistBrowseRole;
  roleLabel?: string;
  fixedContext?: "secular" | "christian";
  showRoleFilters?: boolean;
  filteredGenreOptions?: FilteredArtistGenreOptions;
  fixedProvince?: string;
  showProvinceSelector?: boolean;
  hideGenreFilter?: boolean;
  hideProvinceSelector?: boolean;
  mobileTitlePrefix?: string;
  mobileTitleHighlight?: string;
  fixedArtistStatus?: "legend" | "emerging";
  rankedArtistIds?: string[];
  awardRankings?: AwardedArtistRanking[];
  occupationOptions?: Array<{ value: string; label: string }>;
  instrumentOptions?: Array<{ value: string; label: string }>;
  rolePageOptions?: Array<{ href: string; label: string }>;
  awardOptions?: AwardFilterOption[];
  initialData?: ArtistDirectoryInitialData;
};

const ROLE_FILTERS: Array<{ key: ArtistBrowseRole; label: string }> = [
  { key: "singer", label: "Singers" },
  { key: "composer", label: "Composers" },
  { key: "songwriter", label: "Songwriters" },
  { key: "lyricist", label: "Lyricists" },
  { key: "musician", label: "Musicians" },
  { key: "dj", label: "DJs" },
  { key: "producer", label: "Producers" },
];
const ROLE_FILTER_KEYS = new Set<ArtistBrowseRole>(ROLE_FILTERS.map((item) => item.key));

// Maps a singular role to its plural key in the `filters.roleLabels` namespace.
const ROLE_LABEL_KEYS: Record<ArtistBrowseRole, string> = {
  singer: "singers",
  composer: "composers",
  songwriter: "songwriters",
  lyricist: "lyricists",
  musician: "musicians",
  dj: "djs",
  producer: "producers",
  instrumentalist: "musicians",
};

// Maps an artist status to its key in the `filters.statusLabels` namespace.
const STATUS_LABEL_KEYS: Record<string, string> = {
  legend: "legends",
  emerging: "emerging",
};

const ARTISTS_QUERY_TIMEOUT_MS = 20000;

type ProvinceOption = {
  province: string;
  count: number;
};

type GenreOption = ArtistGenreOption;

type GenreCatalogRow = {
  id: string | number;
  parent_id: string | number | null;
  name: string;
  slug: string | null;
  level: number;
  display_order: number | null;
  sort_order: number | null;
};

type SubgenreOption = ArtistSubgenreOption;

function quotePostgrestValue(value: string) {
  return `"${value.replace(/\\/g, "\\\\").replace(/"/g, '\\"')}"`;
}

function buildGenreMatchFilter(values: string[]) {
  return values
    .flatMap((value) => {
      const quoted = quotePostgrestValue(value);
      return [`primary_genre.eq.${quoted}`, `genres.cs.{${quoted}}`];
    })
    .join(",");
}

function buildRoleMatchFilter(role: ArtistBrowseRole) {
  return `primary_role.eq.${role},occupations.cs.${JSON.stringify([role])}`;
}

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
  const t = useTranslations("pagination");
  const locale = useLocale();

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
    ? "mb-6 mt-0 flex flex-wrap items-center justify-between gap-x-2 gap-y-1 sm:hidden"
    : hideMobile
      ? "hidden sm:mb-8 sm:mt-0 sm:flex sm:flex-wrap sm:items-center sm:justify-center sm:gap-2"
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
        {t("first")}
      </button>

      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className={`${mobileClass} cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30`}
      >
        {mobileOnly && locale === "es" ? t("previousMobile") : t("previous")}
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
        {mobileOnly && locale === "es" ? t("nextMobile") : t("next")}
      </button>

      <button
        onClick={() => onPageChange(totalPages)}
        disabled={currentPage === totalPages}
        className={`${mobileClass} cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30`}
      >
        {t("last")}
      </button>

      <button
        onClick={() => onPageChange(1)}
        disabled={currentPage === 1}
        className={`${desktopClass} cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30`}
      >
        {t("first")}
      </button>

      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className={`${desktopClass} cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30`}
      >
        {t("previous")}
      </button>

      {(() => {
        const desktopWindowSize = Math.min(totalPages, 3);
        const desktopWindowStart =
          currentPage <= 3
            ? 1
            : Math.min(currentPage - 1, totalPages - desktopWindowSize + 1);
        const desktopPages = Array.from({ length: desktopWindowSize }).map(
          (_, index) => desktopWindowStart + index,
        );
        const showDesktopLeadingEllipsis = desktopPages[0] > 1;
        const showDesktopTrailingEllipsis = desktopPages[desktopPages.length - 1] < totalPages;

        return (
          <>
            {showDesktopLeadingEllipsis && (
              <span className={`${desktopClass} px-1 text-sm text-gray-400`} aria-hidden="true">
                ...
              </span>
            )}

            {desktopPages.map((page) => (
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
            ))}

            {showDesktopTrailingEllipsis && (
              <span className={`${desktopClass} px-1 text-sm text-gray-400`} aria-hidden="true">
                ...
              </span>
            )}
          </>
        );
      })()}

      <button
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
        className={`${desktopClass} cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30`}
      >
        {t("next")}
      </button>

      <button
        onClick={() => onPageChange(totalPages)}
        disabled={currentPage === totalPages}
        className={`${desktopClass} cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30`}
      >
        {t("last")}
      </button>
    </section>
  );
}

function ArtistsContent({
  path: basePath,
  heading,
  intro,
  i18nKey,
  role: fixedRole,
  roleLabel: fixedRoleLabel,
  fixedContext,
  showRoleFilters = false,
  filteredGenreOptions,
  fixedProvince,
  showProvinceSelector = false,
  hideGenreFilter = false,
  hideProvinceSelector = false,
  mobileTitlePrefix,
  mobileTitleHighlight,
  fixedArtistStatus,
  rankedArtistIds,
  awardRankings = [],
  occupationOptions = [],
  instrumentOptions = [],
  rolePageOptions = [],
  awardOptions = [],
  initialData,
}: ArtistDirectoryProps) {
  const supabase = getSupabaseClient();
  const t = useTranslations();
  const router = useRouter();
  const searchParams = useSearchParams();
  const searchParamsString = searchParams.toString();

  // Localized heading/intro for the role directory pages; fall back to the
  // literal props for directory variants that don't pass an i18nKey.
  const displayHeading = i18nKey ? t(`artistDirectory.${i18nKey}.heading`) : (heading ?? "");
  const displayIntro = i18nKey ? t(`artistDirectory.${i18nKey}.intro`) : (intro ?? "");

  const [artists, setArtists] = useState<Artist[]>(initialData?.artists ?? []);
  const [provinces, setProvinces] = useState<ProvinceOption[]>([]);
  const [genreOptions, setGenreOptions] = useState<GenreOption[]>(
    filteredGenreOptions?.genres ?? [],
  );
  const [subgenreOptions, setSubgenreOptions] = useState<SubgenreOption[]>(
    filteredGenreOptions?.subgenres ?? [],
  );
  const [loading, setLoading] = useState(!initialData);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [totalCount, setTotalCount] = useState(initialData?.totalCount ?? 0);

  const roleParam = searchParams.get("role");
  const selectedRole =
    roleParam && ROLE_FILTER_KEYS.has(roleParam as ArtistBrowseRole)
      ? (roleParam as ArtistBrowseRole)
      : undefined;
  const role = fixedRole ?? (showRoleFilters ? selectedRole : undefined);
  const roleLabel = role
    ? t(`filters.roleLabels.${ROLE_LABEL_KEYS[role]}`)
    : fixedRoleLabel;
  // Role-page selector options come from config with English labels; translate
  // them via filters.roleLabels using the slug derived from the href.
  const rolePageLabel = (option: { href: string; label: string }) => {
    const key = `filters.roleLabels.${option.href.replace(/^\//, "")}`;
    return t.has(key) ? t(key) : option.label;
  };
  const tag = searchParams.get("tag");
  const selectedContext = fixedContext ?? "";
  const artistStatuses = useMemo(
    () => (fixedArtistStatus ? [fixedArtistStatus] : []),
    [fixedArtistStatus],
  );
  const genreFilter =
    searchParams.get("genre") ??
    (searchParams.get("classical") === "1" || tag === "classical" ? "classical" : null);
  const subgenreFilter = searchParams.get("subgenre");
  const occupationFilter = searchParams.get("occupation");
  const instrumentFilter = searchParams.get("instrument");
  const awardFilter = searchParams.get("award");
  const province = fixedProvince ?? searchParams.get("province") ?? searchParams.get("region");
  const sort = searchParams.get("sort") ?? "name";
  const currentPage = parseInt(searchParams.get("page") ?? "1");
  const letterFilter = searchParams.get("letter");
  const rankedArtistIdsKey = rankedArtistIds?.join(",") ?? "";
  const awardRankingsKey = awardRankings
    .map(
      (ranking) =>
        `${ranking.artist_id}:${ranking.award_count}:${ranking.nomination_count}`,
    )
    .join(",");
  const awardRankingsById = useMemo(
    () => new Map(awardRankings.map((ranking) => [ranking.artist_id, ranking])),
    [awardRankingsKey, awardRankings],
  );
  const showAwardRankings = awardRankings.length > 0;
  const hideGenreSelector =
    hideGenreFilter || Boolean(filteredGenreOptions && genreOptions.length === 0);
  const showProvinceControl =
    !hideProvinceSelector && (showProvinceSelector || !showRoleFilters);
  const desktopControlCount =
    (hideGenreSelector ? 0 : 1) +
    (showRoleFilters ? 1 : 0) +
    (showProvinceControl ? 1 : 0) +
    (occupationOptions.length > 0 ? 1 : 0) +
    (instrumentOptions.length > 0 ? 1 : 0) +
    (rolePageOptions.length > 0 ? 1 : 0) +
    (awardOptions.length > 0 ? 1 : 0) +
    (showAwardRankings ? 2 : 3);
  const desktopGridClass =
    desktopControlCount === 6
      ? "grid-cols-6"
      : desktopControlCount === 5
        ? "grid-cols-5"
        : desktopControlCount === 4
          ? "grid-cols-4"
          : "grid-cols-3";
  const routeWithParams = (params: URLSearchParams) => {
    const query = params.toString();
    return query ? `${basePath}?${query}` : basePath;
  };

  const selectedGenreValue = subgenreFilter
    ? `subgenre:${subgenreFilter}`
    : genreFilter
      ? `genre:${genreFilter}`
      : "";

  const formatAwardRankingLabel = (ranking?: AwardedArtistRanking) => {
    if (!ranking) return null;

    const parts = [
      t("artistDirectory.awardRanking.awards", {
        count: ranking.award_count,
      }),
    ];

    if (ranking.nomination_count > 0) {
      parts.push(
        t("artistDirectory.awardRanking.nominations", {
          count: ranking.nomination_count,
        }),
      );
    }

    return parts.join(" · ");
  };

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
      if (hideGenreFilter) return;
      if (filteredGenreOptions) return;
      if (!supabase) return;

      const { data, error } = await supabase
        .from("genres")
        .select("id,parent_id,name,slug,level,display_order,sort_order")
        .eq("active", true)
        .in("level", [0, 1])
        .order("display_order", { ascending: true, nullsFirst: false })
        .order("sort_order", { ascending: true })
        .order("name", { ascending: true });

      if (error) {
        console.error(error);
        return;
      }

      if (!isActive) return;

      const rows = (data ?? []) as GenreCatalogRow[];
      setGenreOptions(
        rows
          .filter((row) => row.level === 0 && row.parent_id === null)
          .map((row) => ({
            id: row.id,
            name: row.name,
            slug: row.slug,
            display_order: row.display_order,
          })),
      );
      setSubgenreOptions(
        rows
          .filter((row) => row.level === 1 && row.parent_id !== null)
          .map((row) => ({
            id: row.id,
            genre_id: row.parent_id as string | number,
            name: row.name,
          })),
      );
    }

    async function loadProvinces() {
      if (!showProvinceControl) return;
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
              if (isValidProvinceName(item.province)) {
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
  }, [
    supabase,
    filteredGenreOptions,
    hideGenreFilter,
    showProvinceControl,
  ]);

  useEffect(() => {
    let isActive = true;
    const abortController = new AbortController();
    let timeoutId: number | undefined;

    async function loadArtists() {
      if (!supabase) {
        if (isActive) {
          setLoadError(t("errors.artistDataNotConfigured"));
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
          setLoadError(t("errors.artistDataTimeout"));
          setLoading(false);
        }
      }, ARTISTS_QUERY_TIMEOUT_MS);

      try {
        const from = (currentPage - 1) * ARTIST_DIRECTORY_ITEMS_PER_PAGE;
        const to = from + ARTIST_DIRECTORY_ITEMS_PER_PAGE - 1;

        let query = supabase
          .from("artists")
          .select(ARTIST_LIST_SELECT, { count: "exact" })
          .eq("status", "published");

        const search = searchParams.get("search");
        if (search) {
          query = query.ilike("name", `%${search}%`);
        }

        // ROLE FILTER
        if (role) {
          query = query.or(buildRoleMatchFilter(role));
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

        if (genreFilter) {
          const option = genreOptions.find(
            (item) => (item.slug || item.name) === genreFilter,
          );
          query = option?.matchValues?.length
            ? query.or(buildGenreMatchFilter(option.matchValues))
            : query.eq("primary_genre", genreFilter);
        }

        if (subgenreFilter) {
          const option = subgenreOptions.find((item) => item.name === subgenreFilter);
          query = option?.matchValues?.length
            ? query.or(buildGenreMatchFilter(option.matchValues))
            : query.contains("genres", [subgenreFilter]);
        }

        if (occupationFilter) {
          query = query.filter(
            "occupations",
            "cs",
            JSON.stringify([occupationFilter]),
          );
        }

        if (instrumentFilter) {
          query = query.contains("instruments", [instrumentFilter]);
        }

        if (province) {
          query = query.eq("province", province);
        }

        if (letterFilter) {
          query = query.ilike("name", `${letterFilter}%`);
        }

        // Large-ID audit: award rankings are unbounded and can exceed 100 artist IDs;
        // the ranked/filterable directory should eventually be backed by an RPC.
        const response = rankedArtistIds?.length
          ? await query.in("id", rankedArtistIds).abortSignal(abortController.signal)
          : await query
              .order(
                sort === "name"
                  ? "name"
                  : sort === "newest"
                    ? "created_at"
                    : "views",
                { ascending: sort === "name" },
              )
              .abortSignal(abortController.signal)
              .range(from, to);

        const { data, error } = response;
        const count = rankedArtistIds?.length ? data?.length ?? 0 : response.count;

        if (!isActive || abortController.signal.aborted) return;

        if (error) {
          console.error(error);
          setArtists([]);
          setTotalCount(0);
          setLoadError(t("errors.unableToLoadArtists"));
          return;
        }

        const loadedArtists = ((data ?? []) as unknown) as Artist[];
        if (rankedArtistIds?.length) {
          const rank = new Map(rankedArtistIds.map((id, index) => [id, index]));
          loadedArtists.sort(
            (left, right) =>
              (rank.get(left.id) ?? Number.MAX_SAFE_INTEGER) -
              (rank.get(right.id) ?? Number.MAX_SAFE_INTEGER),
          );
          setArtists(loadedArtists.slice(from, to + 1));
        } else {
          setArtists(loadedArtists);
        }
        setTotalCount(count ?? 0);
      } catch (err) {
        if (!isActive) return;

        console.error(err);
        setArtists([]);
        setTotalCount(0);
        setLoadError(
          abortController.signal.aborted
            ? t("errors.artistDataTimeout")
            : t("errors.unableToLoadArtists")
        );
      } finally {
        if (timeoutId) window.clearTimeout(timeoutId);
        if (isActive) setLoading(false);
      }
    }

    const requestKey = [
      searchParamsString,
      currentPage,
      role ?? "",
      selectedContext,
      artistStatuses.join(","),
      genreFilter ?? "",
      subgenreFilter ?? "",
      occupationFilter ?? "",
      instrumentFilter ?? "",
      province ?? "",
      sort,
      letterFilter ?? "",
      rankedArtistIdsKey,
      genreOptions.map((item) => `${item.id}:${item.slug ?? item.name}`).join("|"),
      subgenreOptions.map((item) => `${item.id}:${item.name}`).join("|"),
    ].join("::");

    if (initialData?.cacheKey === requestKey) {
      setArtists(initialData.artists);
      setTotalCount(initialData.totalCount);
      setLoadError(null);
      setLoading(false);
      return () => {
        isActive = false;
        abortController.abort();
        if (timeoutId) window.clearTimeout(timeoutId);
      };
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
    genreFilter,
    subgenreFilter,
    occupationFilter,
    instrumentFilter,
    province,
    sort,
    letterFilter,
    rankedArtistIdsKey,
    genreOptions,
    subgenreOptions,
    initialData,
  ]);

  const totalPages = Math.ceil(totalCount / ARTIST_DIRECTORY_ITEMS_PER_PAGE);

  const handlePageChange = (page: number) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set("page", page.toString());
    router.push(routeWithParams(params));
  };

  const handleRoleChange = (value: string) => {
    const params = new URLSearchParams(searchParams.toString());

    if (value && ROLE_FILTER_KEYS.has(value as ArtistBrowseRole)) {
      params.set("role", value);
    } else {
      params.delete("role");
    }

    params.set("page", "1");
    router.push(routeWithParams(params));
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
    router.push(routeWithParams(params));
  };

  const handleProvinceChange = (value: string) => {
    const params = new URLSearchParams(searchParams.toString());
    params.delete("province");
    params.delete("region");
    params.delete("page");
    const query = params.toString();
    const destination = value ? `/provinces/${provinceToSlug(value)}` : "/artists";
    router.push(query ? `${destination}?${query}` : destination);
  };

  const handleOccupationChange = (value: string) => {
    const params = new URLSearchParams(searchParams.toString());
    if (value) params.set("occupation", value);
    else params.delete("occupation");
    params.set("page", "1");
    router.push(routeWithParams(params));
  };

  const handleInstrumentChange = (value: string) => {
    const params = new URLSearchParams(searchParams.toString());
    if (value) params.set("instrument", value);
    else params.delete("instrument");
    params.set("page", "1");
    router.push(routeWithParams(params));
  };

  const handleAwardChange = (value: string) => {
    const params = new URLSearchParams(searchParams.toString());
    if (value) params.set("award", value);
    else params.delete("award");
    params.set("page", "1");
    router.push(routeWithParams(params));
  };

  const handleLetterChange = (letter: string) => {
    const params = new URLSearchParams(searchParams.toString());
    if (letter) params.set("letter", letter);
    else params.delete("letter");
    params.set("page", "1");
    router.push(routeWithParams(params));
  };

  const clearFilters = () => {
    router.push(basePath);
  };

  const retryLoad = () => {
    router.refresh();
    window.location.reload();
  };

  const activeFilters = useMemo(() => {
    return [
      showRoleFilters ? role : null,
      fixedProvince ? null : province,
      genreFilter,
      subgenreFilter,
      occupationFilter,
      instrumentFilter,
      awardFilter,
      letterFilter,
    ].filter(Boolean).length;
  }, [
    role,
    showRoleFilters,
    province,
    fixedProvince,
    genreFilter,
    subgenreFilter,
    occupationFilter,
    instrumentFilter,
    awardFilter,
    letterFilter,
  ]);

  const pageTitle = useMemo(() => {
    const contextLabel = selectedContext
      ? t(`filters.contextLabels.${selectedContext}`)
      : undefined;
    const statusLabel = artistStatuses
      .map((status) =>
        STATUS_LABEL_KEYS[status]
          ? t(`filters.statusLabels.${STATUS_LABEL_KEYS[status]}`)
          : null,
      )
      .filter(Boolean)
      .join(" ");
    const tagLabel = [contextLabel, statusLabel].filter(Boolean).join(" ");
    const genreLabel =
      subgenreOptions.find((item) => item.name === subgenreFilter)?.name ??
      genreOptions.find((item) => (item.slug || item.name) === genreFilter)?.name ??
      null;

    if (fixedContext && !role && !province && !genreLabel && artistStatuses.length === 0) {
      return displayHeading;
    }

    if (fixedArtistStatus && !province && !genreLabel) {
      return displayHeading;
    }

    if (
      fixedRole &&
      !province &&
      !genreLabel &&
      artistStatuses.length === 0
    ) {
      return displayHeading;
    }

    if (
      fixedProvince &&
      !role &&
      !genreLabel &&
      !selectedContext &&
      artistStatuses.length === 0
    ) {
      return displayHeading;
    }

    if (province && genreLabel && tagLabel && roleLabel) {
      return t("directoryTitles.provinceGenreTagRole", {
        province,
        genre: genreLabel,
        tag: tagLabel,
        role: roleLabel,
      });
    }

    if (genreLabel && tagLabel && roleLabel) {
      return t("directoryTitles.dominicanGenreTagRole", {
        genre: genreLabel,
        tag: tagLabel,
        role: roleLabel,
      });
    }

    if (genreLabel && roleLabel) {
      return t("directoryTitles.dominicanGenreRole", {
        genre: genreLabel,
        role: roleLabel,
      });
    }

    if (genreLabel && tagLabel) {
      return t("directoryTitles.allGenreTagArtists", {
        genre: genreLabel,
        tag: tagLabel,
      });
    }

    if (genreLabel) {
      return t("directoryTitles.allGenreArtists", { genre: genreLabel });
    }

    if (province && tagLabel && roleLabel) {
      return t("directoryTitles.provinceTagRole", {
        province,
        tag: tagLabel,
        role: roleLabel,
      });
    }

    if (province && tagLabel) {
      return t("directoryTitles.provinceTagArtists", { province, tag: tagLabel });
    }

    if (province && roleLabel) {
      return t("directoryTitles.provinceRole", { province, role: roleLabel });
    }

    if (province) {
      return t("directoryTitles.artistsFromProvince", { province });
    }

    if (tagLabel && roleLabel) {
      return t("directoryTitles.dominicanTagRole", { tag: tagLabel, role: roleLabel });
    }

    if (tagLabel) {
      return t("directoryTitles.allTagArtists", { tag: tagLabel });
    }

    if (roleLabel) {
      return t("directoryTitles.roleOnly", { role: roleLabel });
    }

    return displayHeading;
  }, [
    t,
    displayHeading,
    fixedContext,
    fixedRole,
    fixedArtistStatus,
    fixedProvince,
    roleLabel,
    selectedContext,
    artistStatuses,
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
      <JsonLd
        data={[
          collectionPageSchema({ name: displayHeading, description: displayIntro, path: basePath }),
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: displayHeading, path: basePath },
          ]),
        ]}
      />
      {/* HEADER */}
      <section className="mt-6 mb-3 sm:mb-1">
        {/* DISCOVERY PANEL */}
        <div className="rounded-4xl border border-black/5 bg-white/80 px-5 py-2.5 backdrop-blur-sm shadow-[0_4px_30px_rgba(0,0,0,0.03)] sm:px-7 sm:py-3.5">

          {/* TITLE + CONTROLS */}
          <div className="mb-2 flex flex-col gap-2 lg:mb-4 lg:gap-4">
            <div className="flex flex-row items-center justify-between gap-3 text-left lg:text-left">
              <h1
                className={`min-w-0 text-xl font-bold tracking-tight text-(--color-flagblue) md:text-3xl ${
                  fixedProvince ? "leading-tight" : "truncate"
                }`}
              >
                {mobileTitlePrefix && mobileTitleHighlight && pageTitle === displayHeading ? (
                  <>
                    <span className="hidden lg:inline">{pageTitle}</span>
                    <span className="block text-center lg:hidden">
                      <span className="block">{mobileTitlePrefix}</span>
                      <span className="block">{mobileTitleHighlight}</span>
                    </span>
                  </>
                ) : (
                  pageTitle
                )}
              </h1>

              <p className="hidden shrink-0 text-right text-xs text-gray-500 lg:block lg:text-sm">
                {t("pagination.showingTotal", {
                  total: totalCount.toLocaleString(),
                })}
              </p>
            </div>

            <p className="max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
              {displayIntro}
            </p>

            <div
              className={`hidden w-full items-center gap-2 lg:grid xl:gap-3 ${desktopGridClass}`}
            >
              {!hideGenreSelector && (
              <label className="block min-w-0">
                <span className="sr-only">{t("filters.genreSubgenre")}</span>
                <select
                  value={selectedGenreValue}
                  onChange={(event) => handleGenreSelection(event.target.value)}
                  className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                >
                  <option value="">{t("filters.allGenres")}</option>
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
              )}

              {showRoleFilters && (
                <select
                  value={role ?? ""}
                  onChange={(event) => handleRoleChange(event.target.value)}
                  className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                  aria-label={t("filters.ariaRole")}
                >
                  <option value="">{t("filters.allRoles")}</option>
                  {ROLE_FILTERS.map((item) => (
                    <option key={item.key} value={item.key}>
                      {t(`filters.roleLabels.${ROLE_LABEL_KEYS[item.key]}`)}
                    </option>
                  ))}
                </select>
              )}

              {showProvinceControl && (
                <select
                  onChange={(e) => handleProvinceChange(e.target.value)}
                  value={province ?? ""}
                  className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                >
                  <option value="">{t("filters.allProvinces")}</option>
                  {provinces.map((item) => (
                    <option key={item.province} value={item.province}>
                      {item.province} ({item.count})
                    </option>
                  ))}
                </select>
              )}

              {occupationOptions.length > 0 && (
                <select
                  value={occupationFilter ?? ""}
                  onChange={(event) => handleOccupationChange(event.target.value)}
                  className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                  aria-label={t("filters.ariaOtherRole")}
                >
                  <option value="">{t("filters.role")}</option>
                  {occupationOptions.map((option) => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </select>
              )}

              {instrumentOptions.length > 0 && (
                <select
                  value={instrumentFilter ?? ""}
                  onChange={(event) => handleInstrumentChange(event.target.value)}
                  className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                  aria-label={t("filters.ariaInstrument")}
                >
                  <option value="">{t("filters.instrument")}</option>
                  {instrumentOptions.map((option) => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </select>
              )}

              {rolePageOptions.length > 0 && (
                <select
                  value={basePath}
                  onChange={(event) => router.push(event.target.value)}
                  className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                  aria-label={t("filters.ariaBrowseRole")}
                >
                  {rolePageOptions.map((option) => (
                    <option key={option.href} value={option.href}>
                      {rolePageLabel(option)}
                    </option>
                  ))}
                </select>
              )}

              {awardOptions.length > 0 && (
                <select
                  value={awardFilter ?? ""}
                  onChange={(event) => handleAwardChange(event.target.value)}
                  className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                  aria-label={t("filters.ariaAward")}
                >
                  <option value="">{t("filters.allAwards")}</option>
                  {awardOptions.map((option) => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </select>
              )}

              {!showAwardRankings && (
                <select
                  onChange={(e) => {
                    const params = new URLSearchParams(searchParams.toString());
                    params.set("sort", e.target.value);
                    params.set("page", "1");
                    router.push(routeWithParams(params));
                  }}
                  value={sort}
                  className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                >
                  <option value="views">{t("sortOptions.sortedByViews")}</option>
                  <option value="name">{t("sortOptions.nameAZ")}</option>
                  <option value="newest">{t("sortOptions.newest")}</option>
                </select>
              )}

              <button className="flex h-9 w-full min-w-0 cursor-pointer items-center justify-center gap-2 rounded-xl border border-black/10 px-3 text-sm text-gray-600">
                <SlidersHorizontal size={16} />
                {t("buttons.filters", { count: activeFilters })}
              </button>

              <button
                onClick={clearFilters}
                disabled={activeFilters === 0}
                className="flex h-9 w-full min-w-0 cursor-pointer items-center justify-center rounded-xl border border-black/10 px-3 text-sm text-gray-600 transition hover:bg-gray-50 hover:text-(--color-flagblue) disabled:cursor-default disabled:opacity-40"
              >
                {t("buttons.clearAll")}
              </button>
            </div>

            <div className="hidden w-full pt-2 lg:block">
              <div className="flex gap-0.5">
                <button
                  onClick={() => handleLetterChange("")}
                  className={`flex-1 py-1 text-xs font-medium rounded transition ${
                    !letterFilter
                      ? "bg-(--color-flagblue) text-white"
                      : "bg-gray-100 text-gray-600 hover:bg-gray-200"
                  }`}
                >
                  {t("filters.all")}
                </button>
                {Array.from({ length: 26 }).map((_, i) => {
                  const letter = String.fromCharCode(65 + i);
                  return (
                    <button
                      key={letter}
                      onClick={() => handleLetterChange(letter)}
                      className={`flex-1 py-1 rounded text-xs font-medium transition ${
                        letterFilter === letter
                          ? "bg-(--color-flagblue) text-white"
                          : "bg-gray-100 text-gray-600 hover:bg-gray-200"
                      }`}
                    >
                      {letter}
                    </button>
                  );
                })}
              </div>
            </div>
          </div>

          <div className="grid gap-2 lg:hidden">
            {(!hideGenreSelector || showRoleFilters || showProvinceControl) && (
            <div
              className={`grid gap-2 ${
                hideGenreSelector
                  ? showRoleFilters && showProvinceSelector
                    ? "grid-cols-2"
                    : "grid-cols-1"
                  : showRoleFilters || showProvinceControl
                    ? "grid-cols-2"
                    : "grid-cols-1"
              }`}
            >
              {!hideGenreSelector && (
                <label className="min-w-0">
                  <span className="sr-only">{t("filters.genreSubgenre")}</span>
                  <select
                    value={selectedGenreValue}
                    onChange={(event) => handleGenreSelection(event.target.value)}
                    className="h-9 w-full min-w-0 rounded-xl border border-black/10 bg-white px-3 text-sm text-gray-600 outline-none"
                  >
                    <option value="">{t("filters.allGenres")}</option>
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
              )}

              {showRoleFilters && (
                <label className="block min-w-0">
                  <span className="sr-only">{t("filters.role")}</span>
                  <select
                    value={role ?? ""}
                    onChange={(event) => handleRoleChange(event.target.value)}
                    className="h-9 w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
                  >
                    <option value="">{t("filters.allRoles")}</option>
                    {ROLE_FILTERS.map((item) => (
                      <option key={item.key} value={item.key}>
                        {t(`filters.roleLabels.${ROLE_LABEL_KEYS[item.key]}`)}
                      </option>
                    ))}
                  </select>
                </label>
              )}

              {showProvinceControl && (
                <label
                  className={`block min-w-0 ${
                    showProvinceSelector && showRoleFilters && !hideGenreSelector
                      ? "col-span-2"
                      : ""
                  }`}
                >
                  <span className="sr-only">{t("filters.province")}</span>
                  <select
                    onChange={(event) => handleProvinceChange(event.target.value)}
                    value={province ?? ""}
                    className="h-9 w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
                  >
                    <option value="">{t("filters.allProvinces")}</option>
                    {provinces.map((item) => (
                      <option key={item.province} value={item.province}>
                        {item.province} ({item.count})
                      </option>
                    ))}
                  </select>
                </label>
              )}
            </div>
            )}

            {occupationOptions.length > 0 && (
              <select
                value={occupationFilter ?? ""}
                onChange={(event) => handleOccupationChange(event.target.value)}
                className="h-9 w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
                aria-label={t("filters.ariaOtherRole")}
              >
                <option value="">{t("filters.role")}</option>
                {occupationOptions.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            )}

            {instrumentOptions.length > 0 && (
              <select
                value={instrumentFilter ?? ""}
                onChange={(event) => handleInstrumentChange(event.target.value)}
                className="h-9 w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
                aria-label={t("filters.ariaInstrument")}
              >
                <option value="">{t("filters.instrument")}</option>
                {instrumentOptions.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            )}

            {rolePageOptions.length > 0 && (
              <select
                value={basePath}
                onChange={(event) => router.push(event.target.value)}
                className="h-9 w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
                aria-label={t("filters.ariaBrowseRole")}
              >
                {rolePageOptions.map((option) => (
                  <option key={option.href} value={option.href}>
                    {rolePageLabel(option)}
                  </option>
                ))}
              </select>
            )}

            {awardOptions.length > 0 && (
              <select
                value={awardFilter ?? ""}
                onChange={(event) => handleAwardChange(event.target.value)}
                className="h-9 w-full rounded-xl border border-black/10 bg-white px-4 text-sm text-gray-600 outline-none"
                aria-label={t("filters.ariaAward")}
              >
                <option value="">{t("filters.allAwards")}</option>
                {awardOptions.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            )}

            <div className={`grid gap-2 ${showAwardRankings ? "grid-cols-2" : "grid-cols-3"}`}>
              {!showAwardRankings && (
                <select
                  onChange={(e) => {
                    const params = new URLSearchParams(searchParams.toString());
                    params.set("sort", e.target.value);
                    params.set("page", "1");
                    router.push(routeWithParams(params));
                  }}
                  value={sort}
                  className="h-9 min-w-0 rounded-xl border border-black/10 bg-white px-2 text-xs text-gray-600 outline-none sm:text-sm"
                >
                  <option value="views">{t("sortOptions.viewsMobile")}</option>
                  <option value="name">{t("sortOptions.nameAZ")}</option>
                  <option value="newest">{t("sortOptions.newest")}</option>
                </select>
              )}
              <button className="flex h-9 min-w-0 cursor-pointer items-center justify-center gap-1 rounded-xl border border-black/10 px-2 text-xs text-gray-600 sm:text-sm">
                <SlidersHorizontal size={16} />
                {t("buttons.filters", { count: activeFilters })}
              </button>

              <button
                onClick={clearFilters}
                disabled={activeFilters === 0}
                className="flex h-9 min-w-0 cursor-pointer items-center justify-center rounded-xl border border-black/10 px-2 text-xs text-gray-600 transition hover:bg-gray-50 hover:text-(--color-flagblue) disabled:cursor-default disabled:opacity-40 sm:text-sm"
              >
                {t("buttons.clear")}
              </button>
            </div>

            <p className="pt-1 text-center text-xs text-gray-500 sm:text-sm">
              {t("pagination.showingTotal", {
                total: totalCount.toLocaleString(),
              })}
            </p>
          </div>

        </div>
      </section>

      {/* GRID */}
      <section className="rounded-4xl border border-black/5 bg-white/80 backdrop-blur-sm p-6 sm:p-8 shadow-[0_4px_30px_rgba(0,0,0,0.03)]">
        <Pagination
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={handlePageChange}
          hideMobile
          insideBox
        />

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
              {t("buttons.retry")}
            </button>
          </div>
        ) : artists.length > 0 ? (
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 lg:grid-cols-6 xl:grid-cols-7 2xl:grid-cols-8 gap-4 sm:gap-5 mb-8 sm:mb-12">
            {artists.map((artist) => (
              <div key={artist.id} className="mx-auto w-[90%]">
                <ArtistCard artist={artist} showViews={!showAwardRankings} />
                {showAwardRankings ? (
                  <p className="mt-1 text-[11px] font-medium leading-tight text-[#8B0000]">
                    {formatAwardRankingLabel(awardRankingsById.get(artist.id))}
                  </p>
                ) : null}
              </div>
            ))}
          </div>
        ) : (
          <div className="flex min-h-60 items-center justify-center text-center">
            <NoArtistsMessage />
          </div>
        )}

        <div className="sm:hidden">
          <Pagination
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={handlePageChange}
            mobileOnly
            insideBox
          />
        </div>

        <Pagination
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={handlePageChange}
          hideMobile
          insideBox
        />
      </section>
    </main>
  );
}

function NoArtistsMessage() {
  const t = useTranslations("components");
  return <p className="text-sm text-gray-500">{t("noArtistsFound")}</p>;
}

export default function ArtistDirectory(props: ArtistDirectoryProps) {
  return (
    <Suspense fallback={null}>
      <ArtistsContent {...props} />
    </Suspense>
  );
}
