"use client";

import { createContext, useCallback, useContext, useEffect, useMemo, useState } from "react";

import type { GenreMedia } from "@/lib/genreApi";
import { ALL_SUBGENRES, type GenreLabelSet, type GenreLabels } from "@/lib/genreLabels";
import type { GenreSubgenre } from "@/lib/genres";
import type { ArtistSummary } from "@/types/home";

/**
 * Holds the selected-subgenre state for a genre page.
 *
 * The genre route is statically cached, so the server always renders the
 * unfiltered genre and never reads `?subgenre=`. This provider owns that
 * filter entirely on the client:
 *
 *  - It starts unselected, so the prerendered HTML is the canonical genre —
 *    which is what gets cached and what crawlers index.
 *  - On mount it restores a `?subgenre=` value from the URL, so shared and
 *    bookmarked filtered links still open filtered.
 *  - Selecting a subgenre updates the URL through the History API rather than
 *    a router navigation, so changing the filter costs no server request at
 *    all — the whole point of the phase.
 *
 * `useSearchParams()` is deliberately not used: under static rendering it
 * forces the consuming subtree behind a Suspense boundary, which would strip
 * the genre's indexable content out of the prerendered HTML.
 *
 * Labels arrive prebuilt from the server because the public client bundle
 * intentionally excludes the `pages.*` messages (see [locale]/layout.tsx).
 * The set of possible headings is known server-side — the genre plus each of
 * its subgenres — so they are all resolved up front.
 */
type GenreSubgenreValue = {
  /** The genre this page is about. Needed to build links out of it. */
  genreSlug: string;
  subgenres: GenreSubgenre[];
  selected: GenreSubgenre | null;
  loading: boolean;
  select: (slug: string) => void;
  artists: ArtistSummary[];
  media: GenreMedia[];
  activeHistory: string | null;
  labels: GenreLabelSet;
  sharedLabels: Pick<GenreLabels, "loadError" | "sortAria" | "mediaSubtitle">;
};

export { ALL_SUBGENRES };

const GenreSubgenreContext = createContext<GenreSubgenreValue | null>(null);

export function useGenreSubgenre() {
  const value = useContext(GenreSubgenreContext);
  if (!value) throw new Error("useGenreSubgenre must be used within GenreSubgenreProvider");
  return value;
}

type Fetched = { slug: string; artists: ArtistSummary[]; media: GenreMedia[] };

export default function GenreSubgenreProvider({
  genreSlug,
  genreHistory,
  subgenres,
  canonicalArtists,
  canonicalMedia,
  locale,
  labels,
  children,
}: {
  genreSlug: string;
  genreHistory: string | null;
  subgenres: GenreSubgenre[];
  canonicalArtists: ArtistSummary[];
  canonicalMedia: GenreMedia[];
  locale: string;
  labels: GenreLabels;
  children: React.ReactNode;
}) {
  const [selectedSlug, setSelectedSlug] = useState<string | null>(null);
  const [fetched, setFetched] = useState<Fetched | null>(null);
  const [failedSlug, setFailedSlug] = useState<string | null>(null);

  const selected = useMemo(
    () => (selectedSlug ? subgenres.find((entry) => entry.slug === selectedSlug) ?? null : null),
    [selectedSlug, subgenres],
  );

  // Derived rather than stored, so the effect below never has to synchronise
  // state on its own — it only writes when a fetch actually resolves.
  const filtered = fetched && fetched.slug === selectedSlug ? fetched : null;
  const loading = selectedSlug !== null && !filtered && failedSlug !== selectedSlug;

  const writeUrl = useCallback((slug: string | null, replace: boolean) => {
    const url = new URL(window.location.href);
    if (slug) url.searchParams.set("subgenre", slug);
    else url.searchParams.delete("subgenre");
    const next = `${url.pathname}${url.search}`;
    // History API only: a router navigation here would request the route
    // payload again, which is exactly the server work this phase removes.
    if (replace) window.history.replaceState(null, "", next);
    else window.history.pushState(null, "", next);
  }, []);

  // Restore a shared or bookmarked filter after hydration, and drop a value
  // that matches no subgenre of this genre rather than showing an empty filter.
  // The URL can only be read once the client is running, so this genuinely
  // has to happen in an effect.
  useEffect(() => {
    const fromUrl = new URLSearchParams(window.location.search).get("subgenre");
    if (!fromUrl) return;
    // The URL is only readable after hydration, so restoring a shared filter link needs an effect.
    // eslint-disable-next-line react-hooks/set-state-in-effect
    if (subgenres.some((entry) => entry.slug === fromUrl)) setSelectedSlug(fromUrl);
    else writeUrl(null, true);
  }, [subgenres, writeUrl]);

  // Back/forward should move through filter states as it did when selection
  // was a router navigation.
  useEffect(() => {
    const onPopState = () => {
      const fromUrl = new URLSearchParams(window.location.search).get("subgenre");
      setSelectedSlug(fromUrl && subgenres.some((e) => e.slug === fromUrl) ? fromUrl : null);
    };
    window.addEventListener("popstate", onPopState);
    return () => window.removeEventListener("popstate", onPopState);
  }, [subgenres]);

  useEffect(() => {
    if (!selectedSlug || fetched?.slug === selectedSlug || failedSlug === selectedSlug) return;

    const controller = new AbortController();
    fetch(
      `/api/genres/subgenre-context?genre=${encodeURIComponent(genreSlug)}&subgenre=${encodeURIComponent(selectedSlug)}`,
      { signal: controller.signal },
    )
      .then((response) => (response.ok ? response.json() : null))
      .then((body) => {
        if (body?.ok) setFetched({ slug: selectedSlug, artists: body.artists ?? [], media: body.media ?? [] });
        // A failed lookup keeps the canonical lists rather than blanking the page.
        else setFailedSlug(selectedSlug);
      })
      .catch((error) => {
        if ((error as Error).name !== "AbortError") setFailedSlug(selectedSlug);
      });

    return () => controller.abort();
  }, [genreSlug, selectedSlug, fetched?.slug, failedSlug]);

  const select = useCallback(
    (slug: string) => {
      const next = slug === ALL_SUBGENRES ? null : slug;
      setSelectedSlug(next);
      writeUrl(next, false);
    },
    [writeUrl],
  );

  const value = useMemo<GenreSubgenreValue>(() => {
    const activeHistory = selected
      ? (locale === "es" ? selected.historyEs || selected.history : selected.history) ?? null
      : genreHistory;
    return {
      genreSlug,
      subgenres,
      selected,
      loading,
      select,
      artists: filtered?.artists ?? canonicalArtists,
      media: filtered?.media ?? canonicalMedia,
      activeHistory,
      labels: labels.byKey[selected?.slug ?? ALL_SUBGENRES] ?? labels.byKey[ALL_SUBGENRES],
      sharedLabels: {
        loadError: labels.loadError,
        sortAria: labels.sortAria,
        mediaSubtitle: labels.mediaSubtitle,
      },
    };
  }, [
    canonicalArtists,
    canonicalMedia,
    filtered,
    genreHistory,
    genreSlug,
    labels,
    loading,
    locale,
    select,
    selected,
    subgenres,
  ]);

  return <GenreSubgenreContext.Provider value={value}>{children}</GenreSubgenreContext.Provider>;
}
