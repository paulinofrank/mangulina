// src/app/artists/[slug]/page.tsx

import { notFound } from "next/navigation";
import Image from "next/image";
import MainWrapper from "@/components/layout/MainWrapper";
import ArtistAwardsSection from "@/components/organisms/ArtistAwardsSection";
import ArtistFactsCard from "@/components/organisms/ArtistFactsCard";
import ArtistDiscographyAccordion from "@/components/organisms/ArtistDiscographyAccordion";
import ArtistInterviewsCarousel from "@/components/organisms/ArtistInterviewsCarousel";
import BioText from "@/components/molecules/BioText";
import {
  getArtistProfile,
  getArtistDiscography,
  getArtistMedia,
} from "@/lib/artistApi";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

type PageProps = {
  params: Promise<{ slug: string }>;
};

export default async function ArtistProfile({ params }: PageProps) {
  const { slug } = await params;
  const artist = await getArtistProfile(slug);

  if (!artist) return notFound();

  const imageUrl = getArtistImageUrl(artist.id);
  const hasBio = Boolean(artist.bio?.trim());
  const [discography, interviews] = await Promise.all([
    getArtistDiscography(artist.id),
    getArtistMedia(artist.id),
  ]);

  return (
    <MainWrapper>
      <div className="mx-auto w-full max-w-[1780px] overflow-hidden px-4 py-10 sm:px-6 sm:py-12 2xl:px-10">
        <header className="mb-8 sm:mb-10">
          <h1 className="text-4xl sm:text-5xl font-black uppercase tracking-tight text-(--color-flagblue)">
            {artist.name}
          </h1>
        </header>

        <div className="grid min-w-0 items-start gap-8 lg:grid-cols-[300px_minmax(0,1fr)] lg:gap-10 2xl:grid-cols-[320px_minmax(0,1fr)]">
          <aside className="w-full min-w-0 space-y-6">
            <div className="relative aspect-square w-full overflow-hidden rounded-2xl bg-gray-100 shadow-lg">
              <Image
                src={imageUrl}
                alt={artist.name}
                fill
                className="object-cover"
                priority
                sizes="(max-width: 768px) calc(100vw - 40px), 300px"
              />
            </div>

            <ArtistFactsCard artist={artist} />

            <ArtistAwardsSection awards={artist.awards || []} />
          </aside>

          <main className="w-full min-w-0 space-y-6">
            <div className="grid min-w-0 items-start gap-6 xl:grid-cols-[minmax(0,0.62fr)_minmax(0,1.38fr)]">
              <div className="min-w-0 space-y-6">
                <section className="min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
                  <h3 className="mb-4 text-xs font-normal uppercase text-(--color-wikicrimson)">
                    Biography
                  </h3>

                  {hasBio ? (
                    <BioText bio={artist.bio} />
                  ) : (
                    <p className="text-sm leading-relaxed text-gray-700 sm:text-base">
                      No biography available for this artist.
                    </p>
                  )}
                </section>

                <ArtistInterviewsCarousel interviews={interviews} />
              </div>

              <div className="min-w-0">
                <ArtistDiscographyAccordion releases={discography} />
              </div>
            </div>
          </main>
        </div>
      </div>
    </MainWrapper>
  );
}
