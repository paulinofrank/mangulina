// src/app/artists/[slug]/page.tsx

import { notFound } from "next/navigation";
import Image from "next/image";
import MainWrapper from "@/components/layout/MainWrapper";
import ArtistAwardsSection from "@/components/organisms/ArtistAwardsSection";
import ArtistFactsCard from "@/components/organisms/ArtistFactsCard";
import ArtistDiscographyAccordion from "@/components/organisms/ArtistDiscographyAccordion";
import { getArtistProfile, getArtistDiscography } from "@/lib/artistApi";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

type PageProps = {
  params: Promise<{ slug: string }>;
};

function getBioParagraphs(bio: string | null) {
  if (!bio) return [];

  return bio
    .replace(/\r\n/g, "\n")
    .split(/\n\s*\n/)
    .map((paragraph) => paragraph.trim())
    .filter(Boolean);
}

export default async function ArtistProfile({ params }: PageProps) {
  const { slug } = await params;
  const artist = await getArtistProfile(slug);

  if (!artist) return notFound();

  const imageUrl = getArtistImageUrl(artist.id);
  const bioParagraphs = getBioParagraphs(artist.bio);
  const discography = await getArtistDiscography(artist.id);

  return (
    <MainWrapper>
      <div className="mx-auto max-w-5xl px-5 py-10 sm:px-6 sm:py-12">
        <header className="mb-8 sm:mb-10">
          <h1 className="text-4xl sm:text-5xl font-black uppercase tracking-tight text-(--color-flagblue)">
            {artist.name}
          </h1>
        </header>

        <div className="grid gap-8 md:grid-cols-[300px_1fr] md:gap-10">
          <aside className="w-full space-y-6">
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

          <main className="w-full space-y-6">
            <section className="rounded-xl border border-gray-100 bg-white p-6 shadow-sm">
              <h3 className="mb-4 text-xs font-normal uppercase text-(--color-wikicrimson)">
                Biography
              </h3>

              {bioParagraphs.length > 0 ? (
                <div className="space-y-4 text-sm leading-relaxed text-gray-700 sm:text-base">
                  {bioParagraphs.map((paragraph, index) => (
                    <p key={index}>{paragraph}</p>
                  ))}
                </div>
              ) : (
                <p className="text-sm leading-relaxed text-gray-700 sm:text-base">
                  No biography available for this artist.
                </p>
              )}
            </section>

            <ArtistDiscographyAccordion releases={discography} />
          </main>
        </div>
      </div>
    </MainWrapper>
  );
}