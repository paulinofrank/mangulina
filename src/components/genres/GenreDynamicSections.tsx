"use client";

import ArtistCard from "@/components/molecules/ArtistCard";
import BioText from "@/components/molecules/BioText";
import GenreCarouselSection from "@/components/organisms/GenreCarouselSection";
import ArtistInterviewsCarousel from "@/components/organisms/ArtistInterviewsCarousel";
import GenreSubgenreSongs from "@/components/genres/GenreSubgenreSongs";
import SectionCard from "@/components/layout/SectionCard";
import { useTranslations } from "next-intl";
import { useGenreSubgenre } from "@/components/genres/GenreSubgenreProvider";

/**
 * The regions of a genre page whose content depends on the selected subgenre:
 * connected artists, the songs list, genre media, and the history section.
 *
 * They render the canonical (unfiltered) values on first paint, so the
 * statically cached HTML carries the genre's full indexable content, and swap
 * to subgenre values on the client once one is selected. Headings come from
 * the provider, which received every possible variant from the server.
 */
export function GenreHistoryLink() {
  const { activeHistory, labels } = useGenreSubgenre();
  if (!activeHistory) return null;

  return (
    <a
      href="#genre-history"
      className="mt-4 inline-flex text-sm font-semibold text-[#8B0000] underline decoration-[#8B0000]/30 underline-offset-4 transition-colors hover:text-[#CE1126]"
    >
      {labels.learnMoreHistory}
    </a>
  );
}

export default function GenreDynamicSections({ genreCatalogId }: { genreCatalogId: number | null }) {
  const { artists, media, selected, activeHistory, labels, sharedLabels, genreSlug } =
    useGenreSubgenre();
  const nav = useTranslations("navigation");

  return (
    <>
      {/* The "see all" link goes to the genre, not to the selected subgenre:
          the directory matches subgenres by name rather than by slug, so
          passing one from here would be a filter that silently misses. "Every
          artist of this genre" stays true in both states. */}
      {artists.length > 0 && (
        <GenreCarouselSection
          title={labels.connectedArtists}
          linkHref={`/artists?genre=${encodeURIComponent(genreSlug)}`}
          linkLabel={nav("seeAll")}
        >
          {artists.map((artist, index) => (
            <div key={artist.id} className="shrink-0 w-28 sm:w-32 lg:w-36">
              <ArtistCard artist={artist} titleAs="h3" priorityImage={index === 0} />
            </div>
          ))}
        </GenreCarouselSection>
      )}

      {genreCatalogId && (
        <GenreSubgenreSongs
          key={selected?.slug ?? "all"}
          genreId={genreCatalogId}
          subgenre={selected}
          labels={{
            loadError: sharedLabels.loadError,
            heading: labels.songsHeading,
            sortAria: sharedLabels.sortAria,
            empty: labels.songsEmpty,
          }}
        />
      )}

      <ArtistInterviewsCarousel
        interviews={media}
        title={labels.mediaTitle}
        subtitle={sharedLabels.mediaSubtitle}
      />

      {activeHistory && (
        <div id="genre-history" className="scroll-mt-20 sm:scroll-mt-24">
          <SectionCard>
            <div className="section-inner">
              <div className="section-header mx-auto max-w-5xl">
                <h2>{labels.history}</h2>
              </div>
              <div className="mx-auto max-w-5xl">
                <BioText bio={activeHistory} />
              </div>
            </div>
          </SectionCard>
        </div>
      )}
    </>
  );
}
