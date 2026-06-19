import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";

import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import SectionCard from "@/components/layout/SectionCard";
import JsonLd from "@/components/seo/JsonLd";
import ReleaseGrid from "@/components/releases/ReleaseGrid";
import ReleaseListingControls from "@/components/releases/ReleaseListingControls";
import {
  getReleaseDecade,
  getReleaseDecadeCounts,
  getReleaseSummaries,
  getReleaseTypeDefinition,
  getReleaseTypeCounts,
  normalizeReleasePage,
  normalizeReleaseSort,
  type ReleaseDecadeDefinition,
  type ReleaseTypeDefinition,
} from "@/lib/releaseApi";
import { createPageMetadata } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

type ListingSearchParams = Promise<{
  sort?: string | string[];
  page?: string | string[];
  decade?: string | string[];
}>;

type ReleaseListingPageProps = {
  searchParams: ListingSearchParams;
};

function firstParam(value: string | string[] | undefined) {
  return Array.isArray(value) ? value[0] : value;
}

function buildPageHref(path: string, params: Record<string, string | number | null | undefined>) {
  const search = new URLSearchParams();

  for (const [key, value] of Object.entries(params)) {
    if (value == null || value === "" || value === 1) continue;
    search.set(key, String(value));
  }

  const query = search.toString();
  return query ? `${path}?${query}` : path;
}

function ListingPagination({
  path,
  page,
  totalPages,
  sort,
  decade,
}: {
  path: string;
  page: number;
  totalPages: number;
  sort: string;
  decade?: string;
}) {
  if (totalPages <= 1) return null;

  return (
    <nav className="mt-8 flex flex-wrap items-center justify-center gap-2" aria-label="Release pagination">
      <Link
        href={buildPageHref(path, { sort, decade, page: page - 1 })}
        aria-disabled={page <= 1}
        className={`rounded-lg border border-black/10 bg-white px-4 py-2 text-sm text-[#002D62] transition hover:border-[#CE1126]/40 hover:text-[#CE1126] ${
          page <= 1 ? "pointer-events-none opacity-40" : ""
        }`}
      >
        Previous
      </Link>
      <span className="px-3 text-sm text-gray-500">
        Page {page.toLocaleString()} of {totalPages.toLocaleString()}
      </span>
      <Link
        href={buildPageHref(path, { sort, decade, page: page + 1 })}
        aria-disabled={page >= totalPages}
        className={`rounded-lg border border-black/10 bg-white px-4 py-2 text-sm text-[#002D62] transition hover:border-[#CE1126]/40 hover:text-[#CE1126] ${
          page >= totalPages ? "pointer-events-none opacity-40" : ""
        }`}
      >
        Next
      </Link>
    </nav>
  );
}

function ListingHeader({
  title,
  description,
}: {
  title: string;
  description: string;
}) {
  return (
    <header className="rounded-xl border border-black/5 bg-white/70 p-6 shadow-sm sm:p-8">
      <p className="text-xs font-semibold uppercase tracking-[0.22em] text-[#CE1126]">
        Releases
      </p>
      <h1 className="mt-3 text-4xl font-black uppercase tracking-tight text-[#002D62] sm:text-5xl">
        {title}
      </h1>
      <p className="mt-4 max-w-3xl text-base leading-relaxed text-gray-700 sm:text-lg">
        {description}
      </p>
    </header>
  );
}

async function ReleaseListingPage({
  title,
  description,
  path,
  eventType,
  type,
  decade,
  searchParams,
}: {
  title: string;
  description: string;
  path: string;
  eventType:
    | "release_type_view"
    | "release_decade_view"
    | "release_most_viewed_view"
    | "release_recent_view";
  type?: ReleaseTypeDefinition;
  decade?: ReleaseDecadeDefinition;
  searchParams: ListingSearchParams;
}) {
  const params = await searchParams;
  const requestedSort = firstParam(params.sort);
  const sort = eventType === "release_recent_view" && !requestedSort
    ? "recent"
    : normalizeReleaseSort(params.sort);
  const page = normalizeReleasePage(params.page);
  const selectedDecade = firstParam(params.decade);
  const decadeCounts = type ? await getReleaseDecadeCounts() : [];
  const decadeFilter = type && selectedDecade ? getReleaseDecade(selectedDecade) : null;
  const listing = await getReleaseSummaries({
    type,
    decade: decade ?? decadeFilter ?? undefined,
    sort,
    page,
  });

  if (listing.total === 0) notFound();

  const totalPages = Math.max(1, Math.ceil(listing.total / listing.pageSize));

  return (
    <MainWrapper>
      <JsonLd
        data={[
          collectionPageSchema({ name: title, description, path }),
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Releases", path: "/releases" },
            { name: title, path },
          ]),
        ]}
      />
      <PageSection className="mt-4">
        <div className="mx-auto max-w-6xl space-y-5">
          <ListingHeader title={title} description={description} />

          <SectionCard>
            <div className="section-inner">
              <ReleaseListingControls
                sort={sort}
                decade={selectedDecade}
                decades={decadeCounts}
              />
              <p className="mb-5 text-sm text-gray-500">
                Showing {listing.releases.length.toLocaleString()} of {listing.total.toLocaleString()} releases
              </p>
              <ReleaseGrid releases={listing.releases} />
              <ListingPagination
                path={path}
                page={page}
                totalPages={totalPages}
                sort={sort}
                decade={selectedDecade}
              />
            </div>
          </SectionCard>
        </div>
      </PageSection>
    </MainWrapper>
  );
}

export function metadataForReleaseType(slug: string): Metadata {
  const type = getReleaseTypeDefinition(slug);
  if (!type) return {};

  return createPageMetadata({
    title: type.title,
    description: type.description,
    path: `/releases/${type.slug}`,
  });
}

export function metadataForReleaseDecade(slug: string): Metadata {
  const decade = getReleaseDecade(slug);
  if (!decade) return {};

  return createPageMetadata({
    title: `Dominican Releases of the ${decade.label} | Mangulina`,
    description: `Explore Dominican albums, singles, EPs, compilations, live recordings, and other releases from the ${decade.label}.`,
    path: `/releases/${decade.slug}`,
  });
}

export async function ReleaseTypePage({
  slug,
  searchParams,
}: {
  slug: string;
  searchParams: ListingSearchParams;
}) {
  const type = getReleaseTypeDefinition(slug);
  if (!type) notFound();

  return (
    <ReleaseListingPage
      title={type.h1}
      description={type.description}
      path={`/releases/${type.slug}`}
      eventType="release_type_view"
      type={type}
      searchParams={searchParams}
    />
  );
}

export async function ReleaseDecadePage({
  slug,
  searchParams,
}: {
  slug: string;
  searchParams: ListingSearchParams;
}) {
  const decade = getReleaseDecade(slug);
  if (!decade) notFound();

  return (
    <ReleaseListingPage
      title={`Dominican Releases of the ${decade.label}`}
      description={`Explore Dominican releases from the ${decade.label}, including albums, singles, EPs, compilations, live recordings, and more.`}
      path={`/releases/${decade.slug}`}
      eventType="release_decade_view"
      decade={decade}
      searchParams={searchParams}
    />
  );
}

export async function MostViewedReleasesPage({ searchParams }: ReleaseListingPageProps) {
  return (
    <ReleaseListingPage
      title="Most Viewed Dominican Releases"
      description="Browse the Dominican releases receiving the most attention from Mangulina visitors."
      path="/releases/most-viewed"
      eventType="release_most_viewed_view"
      searchParams={searchParams}
    />
  );
}

export async function RecentReleasesPage({ searchParams }: ReleaseListingPageProps) {
  return (
    <ReleaseListingPage
      title="Recent Dominican Releases"
      description="Browse recently released Dominican albums, singles, EPs, compilations, live recordings, and more."
      path="/releases/recent"
      eventType="release_recent_view"
      searchParams={searchParams}
    />
  );
}
