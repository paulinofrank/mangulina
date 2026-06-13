import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import MainWrapper from "@/components/layout/MainWrapper";
import AnalyticsPageView from "@/components/analytics/AnalyticsPageView";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import SongCard from "@/components/molecules/SongCard";
import GenreCarouselSection from "@/components/organisms/GenreCarouselSection";
import GenreSubgenreSongs from "@/components/genres/GenreSubgenreSongs";
import ReleaseCoverImage from "@/components/genres/ReleaseCoverImage";
import { getGenrePageData, getGenrePageSlugs, type GenreReleaseSummary } from "@/lib/genreApi";
import { genreDefinitions, getGenreDefinition } from "@/lib/genres";
import { createPageMetadata, genreSeoTitle } from "@/lib/seo";

type PageProps = {
  params: Promise<{ slug: string }>;
};

export const dynamic = "force-dynamic";

export async function generateStaticParams() {
  const dbSlugs = await getGenrePageSlugs();
  const slugs = Array.from(new Set([...genreDefinitions.map((genre) => genre.slug), ...dbSlugs]));

  return slugs.map((slug) => ({ slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const data = await getGenrePageData(slug);

  if (!data) {
    return createPageMetadata({
      title: "Genre Not Found",
      description: "This genre is not available in the Dominican Music Database.",
      path: `/genres/${slug}`,
      noIndex: true,
    });
  }

  return createPageMetadata({
    title: genreSeoTitle(data.genre),
    description: `Explore ${data.genre.title} artists, songs, albums and recordings in the Dominican Music Database.`,
    path: `/genres/${data.genre.slug}`,
  });
}

function ReleaseCard({ release }: { release: GenreReleaseSummary }) {
  const content = (
    <article className="group w-28 shrink-0 sm:w-32 lg:w-36">
      <div className="relative aspect-square overflow-hidden rounded-lg border border-black/5 bg-gray-100">
        {release.coverUrl ? (
          <ReleaseCoverImage
            src={release.coverUrl}
            alt={release.title}
          />
        ) : (
          <div className="flex h-full w-full items-center justify-center px-3 text-center text-xs text-gray-400">
            No cover
          </div>
        )}
      </div>

      <div className="mt-2">
        <h4 className="line-clamp-2 text-sm font-normal text-[#002D62] transition-colors group-hover:text-[#CE1126]">
          {release.title}
        </h4>
        <p className="mt-1 text-xs text-gray-500">
          {[release.releaseYear, release.label].filter(Boolean).join(" · ") || "Release"}
        </p>
      </div>
    </article>
  );

  if (!release.slug) return content;

  return (
    <Link
      href={`/releases/${release.slug}`}
      className="shrink-0 rounded-lg focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#002D62] focus-visible:ring-offset-2"
      aria-label={`View ${release.title}`}
    >
      {content}
    </Link>
  );
}

export default async function GenrePage({ params }: PageProps) {
  const { slug } = await params;
  const data = await getGenrePageData(slug);

  if (!data) return notFound();

  const { genre, subgenres, mainArtists, connectedArtists, popularSongs, importantReleases, recentlyAdded } = data;
  const Icon = genre.icon;
  const relatedGenres = genre.relatedGenres
    .map((relatedSlug) => getGenreDefinition(relatedSlug))
    .filter((relatedGenre): relatedGenre is NonNullable<typeof relatedGenre> => Boolean(relatedGenre));

  return (
    <MainWrapper>
      <AnalyticsPageView eventType="genre_view" entityId={genre.slug} />
      <div className="w-full px-5 pb-10 pt-5 sm:px-6 sm:pb-12 sm:pt-6">
        <header className="mb-8 overflow-hidden rounded-lg border border-black/5 bg-white shadow-sm">
          <div className="grid gap-0 md:grid-cols-[1fr_280px]">
            <div className="p-6 sm:p-8">
              <h1 className="text-4xl font-black uppercase tracking-tight text-[#002D62] sm:text-5xl">
                {genre.title}
              </h1>
              <p className="mt-2 text-sm font-normal uppercase tracking-wider text-[#CE1126]">
                {genre.subtitle}
              </p>
              <p className="mt-5 max-w-3xl text-base leading-relaxed text-gray-700 sm:text-lg">
                {genre.description}
              </p>
              {genre.history && (
                <a
                  href="#genre-history"
                  className="mt-4 inline-flex text-sm font-semibold text-[#8B0000] underline decoration-[#8B0000]/30 underline-offset-4 transition-colors hover:text-[#CE1126]"
                >
                  Learn more about {genre.title} history...
                </a>
              )}
            </div>

            <div className={`flex min-h-48 items-center justify-center ${genre.color}`}>
              <Icon className="h-20 w-20 text-white/90" strokeWidth={1.4} />
            </div>
          </div>
        </header>

        <div className="space-y-8">
          {subgenres.length > 0 && (
            <GenreSubgenreSongs genreId={genre.catalogId ?? 0} subgenres={subgenres} />
          )}

          {mainArtists.length > 0 && (
            <GenreCarouselSection title={`Top ${genre.title} Artists`}>
              {mainArtists.map((artist) => (
                <div key={artist.id} className="shrink-0 w-28 sm:w-32 lg:w-36">
                  <ArtistCard artist={artist} titleAs="h3" />
                </div>
              ))}
            </GenreCarouselSection>
          )}

          {connectedArtists.length > 0 && (
            <GenreCarouselSection title={`Artists Connected to ${genre.title}`}>
              {connectedArtists.map((artist) => (
                <div key={artist.id} className="shrink-0 w-28 sm:w-32 lg:w-36">
                  <ArtistCard artist={artist} titleAs="h3" />
                </div>
              ))}
            </GenreCarouselSection>
          )}

          {popularSongs.length > 0 && (
            <GenreCarouselSection title="Popular Songs" className="gap-4">
              {popularSongs.map((song) => (
                <SongCard
                  key={song.id}
                  id={song.id}
                  slug={song.slug}
                  title={song.title}
                  artistName={song.artistName}
                  coverUrl={song.coverUrl}
                  views={song.views}
                />
              ))}
            </GenreCarouselSection>
          )}

          {importantReleases.length > 0 && (
            <GenreCarouselSection title="Important Albums / Releases" className="gap-4">
              {importantReleases.map((release) => (
                <ReleaseCard key={release.id} release={release} />
              ))}
            </GenreCarouselSection>
          )}

          {recentlyAdded.length > 0 && (
            <GenreCarouselSection title="Recently Added">
              {recentlyAdded.map((artist) => (
                <div key={artist.id} className="shrink-0 w-28 sm:w-32 lg:w-36">
                  <ArtistCard artist={artist} titleAs="h3" />
                </div>
              ))}
            </GenreCarouselSection>
          )}

          {genre.history && (
            <div id="genre-history" className="scroll-mt-6">
              <SectionCard>
                <div className="section-inner">
                  <div className="section-header">
                    <h2>{genre.title} History</h2>
                  </div>
                  <div className="max-w-5xl space-y-4 text-sm leading-relaxed text-gray-700 sm:text-base">
                    {genre.history.split("\n\n").map((paragraph) => (
                      <p key={paragraph}>{paragraph}</p>
                    ))}
                  </div>
                </div>
              </SectionCard>
            </div>
          )}

          {relatedGenres.length > 0 && (
            <SectionCard>
              <div className="section-inner">
                <div className="section-header">
                  <h2>Related Genres & Styles</h2>
                </div>
                <div className="flex flex-wrap gap-3">
                  {relatedGenres.map((relatedGenre) => (
                    <Link
                      key={relatedGenre.slug}
                      href={relatedGenre.href}
                      className="rounded-full border border-black/10 bg-white px-4 py-2 text-sm text-[#002D62] transition-colors hover:border-[#CE1126]/40 hover:text-[#CE1126]"
                    >
                      {relatedGenre.title}
                    </Link>
                  ))}
                </div>
              </div>
            </SectionCard>
          )}
        </div>
      </div>
    </MainWrapper>
  );
}
