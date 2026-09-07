// src/app/artists/[slug]/page.tsx

import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { Suspense } from "react";
import { getTranslations, setRequestLocale } from "next-intl/server";
import AnalyticsPageView from "@/components/analytics/AnalyticsPageView";
import ArtistImage from "@/components/atoms/ArtistImage";
import MainWrapper from "@/components/layout/MainWrapper";
import ArtistAwardsSection from "@/components/organisms/ArtistAwardsSection";
import ArtistFactsCard from "@/components/organisms/ArtistFactsCard";
import ArtistDiscographyAccordion from "@/components/organisms/ArtistDiscographyAccordion";
import ArtistInterviewsCarousel from "@/components/organisms/ArtistInterviewsCarousel";
import BioText from "@/components/molecules/BioText";
import EditorialDocumentRenderer from "@/components/editorial/EditorialDocumentRenderer";
import JsonLd from "@/components/seo/JsonLd";
import {
  getArtistProfile,
  getArtistDiscographySummaries,
  getArtistMedia,
} from "@/lib/artistApi";
import { getArtistRelationships } from "@/lib/artistRelationships";
import { getArtistFamilyRelationships } from "@/lib/artistFamilyRelationships";
import { getPublishedEditorialDocument } from "@/lib/editorial/publicData";
import {
  editorialDocumentHasVisibleText,
  getLegacyArtistBiography,
  selectCutoverArtistBiography,
} from "@/lib/editorial/biographyFallback";
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

// Fallback-only TTL: editorial changes revalidate this page on demand
// (revalidateArtistProfilePaths), so the clock exists purely as a safety net.
//
// Held at 31 days, and the split from /songs and /releases is deliberate.
//
// An ISR write unit is 8 KB and a profile rebuild writes roughly 34 KB, so a
// full pass over the ~41,700 cacheable profile URLs costs about 174K write
// units against a 200K monthly allowance. Paying that four times a month for a
// 7-day clock, on rows nobody edited, was most of the bill.
//
// Artists are only ~1,286 of those URLs and are the rows under constant
// editorial work, so a month-long backstop costs little and still catches a
// revalidation that was missed. Songs and releases are the other ~40,400 and
// are essentially never edited after creation, so they carry a year.
//
// Historical note, because this route has misbehaved before: at 2592000 it
// served s-maxage=600 in a production build while /songs and /releases
// honoured that same value. Bisection never found the cause — the export, the
// artists layout, the Suspense boundary, the works portfolio cache,
// PUBLIC_CATALOG_REVALIDATE_SECONDS, the sibling birthdays TTL and stale
// build caches were each ruled out. At 604800 it honoured the declared value,
// verified by response header on fresh cache misses in both locales.
//
// 2678400 is 31 days rather than the round 2592000 precisely to stay off the
// value that misbehaved. That is a guess about a cause nobody established.
//
// THAT VERIFICATION IS NO LONGER POSSIBLE THE WAY IT IS DESCRIBED ABOVE, and
// the next reader should not go hunting for a header that is gone. Checked on
// production after deploying 63a54e8: none of the three profile routes serves
// s-maxage at all any more. What they serve is
//
//   Cache-Control: public, max-age=0, must-revalidate
//   X-Nextjs-Prerender: 1
//   X-Vercel-Cache: HIT | MISS      Age: <seconds>
//
// Vercel now keeps the ISR entry behind x-vercel-cache instead of announcing
// its lifetime to the client, so the declared revalidate cannot be read back
// off the response. Beware of X-Nextjs-Stale-Time: 300, which looks like the
// answer and is not — that is the client router cache, whose static default is
// 300 regardless of this export.
//
// What can still be checked is that ISR is on at all (X-Nextjs-Prerender: 1)
// and that entries survive (X-Vercel-Cache: HIT with a rising Age). Whether the
// declared value took effect now shows up only in the ISR write volume on the
// usage dashboard over the following days: a clock this long should drop the
// catalogue's clock-driven writes from roughly 747K a month to roughly 19K.
// If they do not fall, suspect this value before suspecting the traffic.
export const revalidate = 2678400; // 31 days -- see ARTIST_PROFILE_REVALIDATE_SECONDS

export function generateStaticParams() {
  return [];
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

  const isSpanish = locale === "es";
  const description = isSpanish
    ? `Explora la biografía, canciones, álbumes, premios y trayectoria de ${artist.name} en la Base de Datos de Música Dominicana.`
    : `Explore the biography, songs, albums, awards and career of ${artist.name} in the Dominican Music Database.`;

  return createPageMetadata({
    title: artistSeoTitle(artist, locale),
    description,
    path: `/artists/${artist.slug}`,
    image: getArtistImageUrlIfAvailable(artist),
    openGraphType: "profile",
    locale,
  });
}

export default async function ArtistProfile({ params }: PageProps) {
  const { slug, locale: routeLocale } = await params;
  setRequestLocale(routeLocale);
  const artist = await getArtistProfile(slug);

  if (!artist) return notFound();

  const locale = routeLocale;
  const t = await getTranslations("artist");
  const tCommon = await getTranslations("common");
  const imageUrl = getArtistImageUrlIfAvailable(artist);
  const editorialLocale = locale === "es" ? "es" : "en";
  const localizedBio = getLegacyArtistBiography(editorialLocale, artist.bio_en, artist.bio_es);
  const [discography, interviews, relationships, familyRelationships, structuredBiography, englishStructuredBiography] = await Promise.all([
    getArtistDiscographySummaries(artist.id),
    getArtistMedia(artist.id),
    getArtistRelationships(artist.id),
    getArtistFamilyRelationships(artist.id),
    getPublishedEditorialDocument({
      documentType: "artist_biography",
      ownerArtistId: artist.id,
      locale: editorialLocale,
    }),
    editorialLocale === "es" ? getPublishedEditorialDocument({
      documentType: "artist_biography",
      ownerArtistId: artist.id,
      locale: "en",
    }) : Promise.resolve(null),
  ]);
  if (structuredBiography && !structuredBiography.ok) {
    console.error("Artist structured biography integrity failure.", {
      artistId: artist.id,
      locale,
      issueCodes: structuredBiography.issues.map((issue) => issue.code),
    });
  }
  const biography = selectCutoverArtistBiography(structuredBiography, englishStructuredBiography, localizedBio);
  const hasBio = editorialDocumentHasVisibleText(biography);
  const isSoloArtist = artist.type === "solo_artist" || artist.type === "person";
  const sameAs = [artist.website, artist.youtube, artist.facebook, artist.instagram]
    .filter((value): value is string => Boolean(value && /^https?:\/\//i.test(value)));
  const alternateNames = [...(artist.aliases ?? []), ...(artist.pseudonyms ?? [])];
  const artistSchema = {
    "@context": "https://schema.org",
    "@type": isSoloArtist ? "Person" : "MusicGroup",
    name: artist.name,
    alternateName: alternateNames.length ? alternateNames : artist.stage_name ?? undefined,
    url: absoluteUrl(`/artists/${artist.slug}`, routeLocale),
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
          ], routeLocale),
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
              shareUrl={absoluteUrl(`/artists/${artist.slug}`, locale)}
              memberships={relationships.memberships}
              foundedProjects={relationships.foundedProjects}
              ledProjects={relationships.ledProjects}
              members={relationships.members}
              founders={relationships.founders}
              leaders={relationships.leaders}
              familyRelationships={familyRelationships}
            />

            <ArtistAwardsSection awards={artist.awards || []} />
          </aside>

          <div className="w-full min-w-0 space-y-6">
            <div className="grid min-w-0 items-start gap-6 xl:grid-cols-[minmax(420px,1fr)_minmax(380px,520px)]">
              <div className="min-w-0 space-y-6">
                {hasBio && (
                  <section className="min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
                    <h3 className="mb-4 text-xs font-normal uppercase text-(--color-wikicrimson)">
                      {t("biography")}
                    </h3>

                    {biography.kind === "structured" ? (
                      <EditorialDocumentRenderer resolvedDocument={biography.document} />
                    ) : biography.kind === "legacy" ? (
                      <BioText bio={biography.text} />
                    ) : null}
                  </section>
                )}

                <ArtistInterviewsCarousel interviews={interviews} />
              </div>

              <div className="min-w-0 space-y-6">
                {discography.length > 0 && (
                  <ArtistDiscographyAccordion releases={discography} />
                )}

                <Suspense
                  fallback={
                    <div
                      className="h-48 animate-pulse rounded-xl border border-gray-100 bg-white shadow-sm"
                      aria-hidden="true"
                    />
                  }
                >
                  <ArtistWorksPortfolio artistId={artist.id} />
                </Suspense>
              </div>
            </div>
          </div>
        </div>
      </div>
    </MainWrapper>
  );
}
