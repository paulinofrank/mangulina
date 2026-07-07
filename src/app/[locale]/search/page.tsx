import type { Metadata } from "next";
import SearchAnalytics from "@/components/analytics/SearchAnalytics";
import MainWrapper from "@/components/layout/MainWrapper";
import SearchContent from "./SearchContent";
import { MIN_SEARCH_QUERY_LENGTH, globalSearch } from "@/lib/searchApi";
import { createPageMetadata, type SeoLocale } from "@/lib/seo";

const SEARCH_METADATA: Record<SeoLocale, { title: string; description: string }> = {
  en: {
    title: "Search Dominican Music",
    description:
      "Search Dominican artists, songs, releases, genres, and music history in Mangulina, the Dominican Music Database.",
  },
  es: {
    title: "Buscar Música Dominicana",
    description:
      "Busca artistas, canciones, álbumes, géneros e historia de la música dominicana en Mangulina, la Base de Datos de Música Dominicana.",
  },
};

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale: routeLocale } = await params;
  const locale: SeoLocale = routeLocale === "es" ? "es" : "en";
  const { title, description } = SEARCH_METADATA[locale];

  return createPageMetadata({
    title,
    description,
    path: "/search",
    locale,
  });
}

type SearchPageProps = {
  searchParams: Promise<{ q?: string }>;
};

export default async function SearchPage({ searchParams }: SearchPageProps) {
  const { q = "" } = await searchParams;
  const query = q.trim();
  const shouldSearch = query.length >= MIN_SEARCH_QUERY_LENGTH;

  const results = shouldSearch
    ? await globalSearch(query)
    : { artists: [], songs: [], releases: [] };

  const total =
    results.artists.length + results.songs.length + results.releases.length;

  return (
    <MainWrapper>
      {shouldSearch && <SearchAnalytics query={query} resultsCount={total} />}
      <SearchContent
        query={query}
        total={total}
        results={results}
      />
    </MainWrapper>
  );
}
