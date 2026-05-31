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
      <div className="max-w-5xl mx-auto px-6 py-12">
        <header className="mb-10">
          <h1 className="text-4xl sm:text-5xl font-black uppercase tracking-tight text-(--color-flagblue)">
            {artist.name}
          </h1>
        </header>

        <div className="grid md:grid-cols-[300px_1fr] gap-10">
          <aside className="space-y-6">
            <div className="relative w-75 h-75 overflow-hidden rounded-2xl bg-gray-100 shadow-lg">
              <Image
                src={imageUrl}
                alt={artist.name}
                fill
                className="object-cover"
                priority
              />
            </div>

            <ArtistFactsCard artist={artist} />

            <ArtistAwardsSection awards={artist.awards || []} />
          </aside>

          <main className="space-y-6">
            <section className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
              <h3 className="text-xs font-bold text-(--color-wikicrimson) uppercase mb-4">
                Biography
              </h3>

              {bioParagraphs.length > 0 ? (
                <div className="space-y-4 text-gray-700 leading-relaxed">
                  {bioParagraphs.map((paragraph, index) => (
                    <p key={index}>{paragraph}</p>
                  ))}
                </div>
              ) : (
                <p className="text-gray-700 leading-relaxed">
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