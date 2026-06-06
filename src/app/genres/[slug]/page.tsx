import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import MainWrapper from "@/components/layout/MainWrapper";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import SongCard from "@/components/molecules/SongCard";
import GenreCarouselSection from "@/components/organisms/GenreCarouselSection";
import { getGenrePageData, getGenrePageSlugs, type GenreReleaseSummary } from "@/lib/genreApi";
import { genreDefinitions, getGenreDefinition } from "@/lib/genres";

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
    return {
      title: "Genre Not Found | Mangulina",
    };
  }

  return {
    title: `${data.genre.title} | Mangulina`,
    description: `Explore ${data.genre.title} artists, songs, albums, and Dominican music history in Mangulina.`,
  };
}

function ReleaseCard({ release }: { release: GenreReleaseSummary }) {
  return (
    <article className="shrink-0 w-36 sm:w-40">
      <div className="relative aspect-square overflow-hidden rounded-lg border border-black/5 bg-gray-100">
        {release.coverUrl ? (
          <img
            src={release.coverUrl}
            alt={release.title}
            className="absolute inset-0 h-full w-full object-cover"
            loading="lazy"
          />
        ) : (
          <div className="flex h-full w-full items-center justify-center px-3 text-center text-xs text-gray-400">
            No cover
          </div>
        )}
      </div>

      <div className="mt-2">
        <h4 className="line-clamp-2 text-sm font-normal text-[#002D62]">
          {release.title}
        </h4>
        <p className="mt-1 text-xs text-gray-500">
          {[release.releaseYear, release.label].filter(Boolean).join(" · ") || "Release"}
        </p>
      </div>
    </article>
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
      <div className="w-full px-5 py-10 sm:px-6 sm:py-12">
        <header className="mb-8 overflow-hidden rounded-lg border border-black/5 bg-white shadow-sm">
          <div className="grid gap-0 md:grid-cols-[1fr_280px]">
            <div className="p-6 sm:p-8">
              <span className="mb-4 inline-flex rounded-full bg-[#002D62]/10 px-3 py-1 text-xs font-normal uppercase tracking-wider text-[#002D62]">
                Dominican Music Database
              </span>
              <h1 className="text-4xl font-black uppercase tracking-tight text-[#002D62] sm:text-5xl">
                {genre.title}
              </h1>
              <p className="mt-2 text-sm font-normal uppercase tracking-wider text-[#CE1126]">
                {genre.subtitle}
              </p>
              <p className="mt-5 max-w-3xl text-base leading-relaxed text-gray-700 sm:text-lg">
                {genre.description}
              </p>
            </div>

            <div className={`flex min-h-48 items-center justify-center ${genre.color}`}>
              <Icon className="h-20 w-20 text-white/90" strokeWidth={1.4} />
            </div>
          </div>
        </header>

        <div className="space-y-8">
          {genre.history && (
            <SectionCard>
              <div className="section-inner">
                <div className="section-header">
                  <h2>History</h2>
                </div>
                <div className="max-w-5xl space-y-4 text-sm leading-relaxed text-gray-700 sm:text-base">
                  {genre.history.split("\n\n").map((paragraph) => (
                    <p key={paragraph}>{paragraph}</p>
                  ))}
                </div>
              </div>
            </SectionCard>
          )}

          {subgenres.length > 0 && (
            <SectionCard>
              <div className="section-inner">
                <div className="section-header">
                  <h2>Subgenres & Styles</h2>
                </div>
                <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
                  {subgenres.map((subgenre) => (
                    <article
                      key={subgenre.id}
                      className="rounded-lg border border-black/5 bg-white px-4 py-3"
                    >
                      <h3 className="text-sm font-semibold text-[#002D62]">
                        {subgenre.name}
                      </h3>
                      {subgenre.description && (
                        <p className="mt-1 text-sm leading-relaxed text-gray-600">
                          {subgenre.description}
                        </p>
                      )}
                    </article>
                  ))}
                </div>
              </div>
            </SectionCard>
          )}

          {mainArtists.length > 0 && (
            <GenreCarouselSection title={`Top ${genre.title} Artists`}>
              {mainArtists.map((artist) => (
                <div key={artist.id} className="shrink-0 w-[42%] sm:w-[26%] lg:w-[14%]">
                  <ArtistCard artist={artist} titleAs="h3" />
                </div>
              ))}
            </GenreCarouselSection>
          )}

          {connectedArtists.length > 0 && (
            <GenreCarouselSection title={`Artists Connected to ${genre.title}`}>
              {connectedArtists.map((artist) => (
                <div key={artist.id} className="shrink-0 w-[42%] sm:w-[26%] lg:w-[14%]">
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
                <div key={artist.id} className="shrink-0 w-[42%] sm:w-[26%] lg:w-[14%]">
                  <ArtistCard artist={artist} titleAs="h3" />
                </div>
              ))}
            </GenreCarouselSection>
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
