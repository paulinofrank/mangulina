// src/app/artists/[slug]/page.tsx

import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { getLocale, getTranslations } from "next-intl/server";
import AnalyticsPageView from "@/components/analytics/AnalyticsPageView";
import ArtistImage from "@/components/atoms/ArtistImage";
import MainWrapper from "@/components/layout/MainWrapper";
import ArtistAwardsSection from "@/components/organisms/ArtistAwardsSection";
import ArtistFactsCard from "@/components/organisms/ArtistFactsCard";
import ArtistDiscographyAccordion from "@/components/organisms/ArtistDiscographyAccordion";
import ArtistInterviewsCarousel from "@/components/organisms/ArtistInterviewsCarousel";
import BioText from "@/components/molecules/BioText";
import type { ArtistProfileData } from "@/lib/artistApi";
import JsonLd from "@/components/seo/JsonLd";
import {
  getArtistProfile,
  getArtistDiscographySummaries,
  getArtistMedia,
} from "@/lib/artistApi";
import { getArtistRelationships } from "@/lib/artistRelationships";
import { getArtistImageUrlIfAvailable } from "@/utils/getArtistImageUrl";
import ArtistWorksPortfolio from "@/components/organisms/ArtistWorksPortfolio";
import {
  artistSeoTitle,
  createPageMetadata,
} from "@/lib/seo";
import { absoluteUrl, breadcrumbSchema } from "@/lib/structuredData";

type PageProps = {
  params: Promise<{ slug: string; locale: string }>;
};

function firstNonEmpty(...values: Array<string | null | undefined>) {
  return values.find((value) => value?.trim()) ?? null;
}

function getLocalizedArtistBio(artist: ArtistProfileData, locale: string) {
  return locale === "es"
    ? firstNonEmpty(artist.bio_es, artist.bio_en)
    : firstNonEmpty(artist.bio_en);
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug, locale } = await params;
  const artist = await getArtistProfile(slug);

  if (!artist) {
    return createPageMetadata({
      title: "Artist Not Found",
      description: "This artist profile is not available in the Dominican Music Database.",
      path: `/artists/${slug}`,
      locale,
      noIndex: true,
    });
  }

  const description = `Explore the biography, songs, albums, awards and career of ${artist.name} in the Dominican Music Database.`;

  return createPageMetadata({
    title: artistSeoTitle(artist),
    description,
    path: `/artists/${artist.slug}`,
    image: getArtistImageUrlIfAvailable(artist),
    openGraphType: "profile",
    locale,
  });
}

export default async function ArtistProfile({ params }: PageProps) {
  const { slug } = await params;
  const artist = await getArtistProfile(slug);

  if (!artist) return notFound();

  const locale = await getLocale();
  const t = await getTranslations("artist");
  const tCommon = await getTranslations("common");
  const imageUrl = getArtistImageUrlIfAvailable(artist);
  const localizedBio = getLocalizedArtistBio(artist, locale);
  const hasBio = Boolean(localizedBio?.trim());
  const [discography, interviews, relationships] = await Promise.all([
    getArtistDiscographySummaries(artist.id),
    getArtistMedia(artist.id),
    getArtistRelationships(artist.id),
  ]);
  const isSoloArtist = artist.type === "solo_artist" || artist.type === "person";
  const sameAs = [artist.website, artist.youtube, artist.facebook, artist.instagram]
    .filter((value): value is string => Boolean(value && /^https?:\/\//i.test(value)));
  const alternateNames = [...(artist.aliases ?? []), ...(artist.pseudonyms ?? [])];
  const artistSchema = {
    "@context": "https://schema.org",
    "@type": isSoloArtist ? "Person" : "MusicGroup",
    name: artist.name,
    alternateName: alternateNames.length ? alternateNames : artist.stage_name ?? undefined,
    url: absoluteUrl(`/artists/${artist.slug}`),
    image: imageUrl ?? undefined,
    birthDate: isSoloArtist ? artist.date_of_birth ?? undefined : undefined,
    deathDate: isSoloArtist ? artist.date_of_death ?? undefined : undefined,
    birthPlace:
      isSoloArtist && (artist.birth_place || artist.province)
        ? {
            "@type": "Place",
            name: [artist.birth_place, artist.province].filter(Boolean).join(", "),
          }
        : undefined,
    genre: [artist.primary_genre, ...(artist.genres ?? [])].filter(Boolean),
    sameAs: sameAs.length ? sameAs : undefined,
  };

  return (
    <MainWrapper>
      <JsonLd
        data={[
          artistSchema,
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Artists", path: "/artists" },
            { name: artist.name, path: `/artists/${artist.slug}` },
          ]),
        ]}
      />
      <AnalyticsPageView eventType="artist_view" entityId={artist.id} />
      <div className="mx-auto w-full max-w-445 overflow-hidden px-4 py-10 sm:px-6 sm:py-12 2xl:px-10">
        <div className="grid min-w-0 items-start gap-8 lg:grid-cols-[300px_minmax(0,1fr)] lg:gap-10 2xl:grid-cols-[320px_minmax(0,1fr)]">
          <aside className="w-full min-w-0 space-y-6">
            <h1 className="text-center text-3xl font-black uppercase tracking-tight text-(--color-flagblue) min-[380px]:text-4xl sm:text-5xl lg:text-4xl">
              {artist.name}
            </h1>

            <div className="relative aspect-square w-full rounded-2xl shadow-lg">
              <div className="absolute inset-0 overflow-hidden rounded-2xl bg-gray-100">
                <ArtistImage
                  imageUrl={imageUrl}
                  name={artist.name}
                  priority
                  sizes="(max-width: 768px) calc(100vw - 40px), 300px"
                />
              </div>

              {artist.views != null && (
                <div className="absolute bottom-0 left-1/2 z-10 -translate-x-1/2 translate-y-1/2 rounded-full border border-black/5 bg-white px-3 py-1 text-[11px] font-normal uppercase tracking-wider text-[#8B0000]/80 shadow-sm">
                  {artist.views.toLocaleString()} {tCommon("views")}
                </div>
              )}
            </div>

            <ArtistFactsCard
              artist={artist}
              groupsAndProjects={relationships.membershipGroups}
              members={relationships.memberArtists}
            />

            <ArtistAwardsSection awards={artist.awards || []} />
          </aside>

          <main className="w-full min-w-0 space-y-6">
            <div className="grid min-w-0 items-start gap-6 xl:grid-cols-[minmax(0,0.62fr)_minmax(0,1.38fr)]">
              <div className="min-w-0 space-y-6">
                {hasBio && (
                  <section className="min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
                    <h3 className="mb-4 text-xs font-normal uppercase text-(--color-wikicrimson)">
                      {t("biography")}
                    </h3>

                    <BioText bio={localizedBio} />
                  </section>
                )}

                <ArtistInterviewsCarousel interviews={interviews} />
              </div>

              <div className="min-w-0 space-y-6">
                {discography.length > 0 && (
                  <ArtistDiscographyAccordion releases={discography} />
                )}

                <ArtistWorksPortfolio artistId={artist.id} />
              </div>
            </div>
          </main>
        </div>
      </div>
    </MainWrapper>
  );
}
