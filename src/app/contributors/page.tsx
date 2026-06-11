import type { Metadata } from "next";
import Link from "next/link";
import ContributorImage from "@/components/atoms/ContributorImage";
import { supabase } from "@/lib/supabase";
import type { Contributor } from "@/types/contributor";

export const metadata: Metadata = {
  title: "Contributors | Mangulina",
  description:
    "Meet the contributors helping preserve, document, and enrich Dominican music through Mangulina.",
  alternates: { canonical: "/contributors" },
};

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

export default async function ContributorsPage() {
  const { data: contributors, error } = await supabase
    .from("contributors")
    .select(
      "id, name, slug, role, bio, location, specialty, website, facebook, instagram, youtube, active, display_order, created_at"
    )
    .eq("active", true)
    .order("display_order", { ascending: true })
    .order("name", { ascending: true });

  if (error) {
    console.error("Error loading contributors:", error);
  }

  return (
    <main className="mx-auto max-w-5xl px-6 pt-20 pb-2 sm:pb-3">
      <header className="mb-6 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>Contributors</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          People Helping Preserve Dominican Music
        </h1>

        <p className="max-w-3xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          Mangulina is built through research, review, correction, and
          collaboration. This page recognizes the people helping document
          Dominican music, its artists, recordings, releases, credits, and
          cultural history.
        </p>
      </header>

      <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
        <SectionEyebrow>Current Contributors</SectionEyebrow>

        {!contributors || contributors.length === 0 ? (
          <p className="text-lg leading-relaxed text-gray-700">
            Contributors will appear here soon.
          </p>
        ) : (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {(contributors as Contributor[]).map((contributor) => (
              <article
                key={contributor.id}
                className="overflow-hidden rounded-3xl border border-black/10 bg-[#FAF9F6] shadow-sm transition hover:shadow-md"
              >
                <div className="aspect-square bg-white">
                  <ContributorImage
                    contributorId={contributor.id}
                    alt={contributor.name}
                    className="h-full w-full object-cover"
                  />
                </div>

                <div className="p-6">
                  <p className="mb-2 text-xs font-semibold uppercase tracking-widest text-[#8B0000]">
                    {contributor.role}
                  </p>

                  <h2 className="text-2xl font-bold text-[#002D62]">
                    {contributor.name}
                  </h2>

                  {contributor.location && (
                    <p className="mt-1 text-sm font-medium text-gray-500">
                      {contributor.location}
                    </p>
                  )}

                  {contributor.bio && (
                    <p className="mt-4 text-base leading-relaxed text-gray-700">
                      {contributor.bio}
                    </p>
                  )}

                  {contributor.specialty &&
                    contributor.specialty.length > 0 && (
                      <div className="mt-5 flex flex-wrap gap-2">
                        {contributor.specialty.map((item) => (
                          <span
                            key={item}
                            className="rounded-full border border-[#002D62]/10 bg-white px-3 py-1 text-xs font-semibold text-[#002D62]"
                          >
                            {item}
                          </span>
                        ))}
                      </div>
                    )}

                  <div className="mt-6 flex flex-wrap gap-3 text-sm font-semibold text-[#8B0000]">
                    {contributor.website && (
                      <a href={contributor.website} target="_blank">
                        Website
                      </a>
                    )}
                    {contributor.facebook && (
                      <a href={contributor.facebook} target="_blank">
                        Facebook
                      </a>
                    )}
                    {contributor.instagram && (
                      <a href={contributor.instagram} target="_blank">
                        Instagram
                      </a>
                    )}
                    {contributor.youtube && (
                      <a href={contributor.youtube} target="_blank">
                        YouTube
                      </a>
                    )}
                  </div>
                </div>
              </article>
            ))}
          </div>
        )}
      </section>

      <section className="mt-6 rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
        <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
          Community Effort
        </p>

        <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
          <p>
            Mangulina welcomes contributors, researchers, collectors, artists,
            musicians, historians, and music lovers who want to help preserve
            Dominican musical heritage.
          </p>

          <p>
            Contributors may help by reviewing artist profiles, correcting
            discographies, identifying credits, documenting regional history, or
            providing trusted references.
          </p>
        </div>
      </section>

      <section className="mt-6 rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/3 p-8 shadow-sm sm:p-10">
        <SectionEyebrow>Become a Contributor</SectionEyebrow>

        <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
          <p>
            If you have knowledge about Dominican music, artists, recordings,
            credits, regional styles, historical context, or rare releases,
            Mangulina would love to hear from you.
          </p>

          <p>
            Contributors help make Dominican music easier to discover, study,
            and preserve for future generations.
          </p>
        </div>

        <div className="mt-8">
          <Link
            href="/contact"
            className="inline-flex rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
          >
            Contact Mangulina
          </Link>
        </div>
      </section>
    </main>
  );
}
