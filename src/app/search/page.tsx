import type { Metadata } from "next";
import SearchAnalytics from "@/components/analytics/SearchAnalytics";
import MainWrapper from "@/components/layout/MainWrapper";
import SearchContent from "./SearchContent";
import { globalSearch } from "@/lib/searchApi";
import { createPageMetadata } from "@/lib/seo";

export const metadata: Metadata = createPageMetadata({
  title: "Search Dominican Music",
  description:
    "Search Dominican artists, songs, releases, genres, and music history in Mangulina, the Dominican Music Database.",
  path: "/search",
});

type SearchPageProps = {
  searchParams: Promise<{ q?: string }>;
};

export default async function SearchPage({ searchParams }: SearchPageProps) {
  const { q = "" } = await searchParams;
  const query = q.trim();

  const results = query
    ? await globalSearch(query)
    : { artists: [], songs: [], releases: [] };

  const total =
    results.artists.length + results.songs.length + results.releases.length;

  return (
    <MainWrapper>
      {query && <SearchAnalytics query={query} resultsCount={total} />}
      <SearchContent
        query={query}
        total={total}
        results={results}
      />
    </MainWrapper>
  );
}
