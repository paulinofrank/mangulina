import SectionTitle from "@/components/atoms/SectionTitle";

export default function AboutPage() {
  const coreFeatures = [
    "Music metadata aggregation",
    "Recording-level data structuring",
    "Artist and release relationships",
    "API access for developers and researchers",
    "Integration with external music systems",
  ];

  return (
    <main className="mx-auto max-w-4xl px-6 py-20 sm:py-32">
      {/* Hero Header */}
      <header className="mb-16 border-b border-black/10 pb-10">
        <h1 className="mb-4 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          About Mangulina&trade;
        </h1>
        <p className="text-lg leading-relaxed text-gray-600 sm:text-xl">
          Mangulina is a music data platform focused on building a structured, 
          searchable, and scalable database for Dominican music.
        </p>
      </header>

      <div className="space-y-16">
        {/* Brand Identity Section */}
        <section className="prose prose-slate max-w-none">
          <SectionTitle>Brand & Identity</SectionTitle>
          <p className="mt-4 text-gray-700 leading-relaxed">
            Mangulina is not a representation of any specific musical genre or style. 
            The name is used as a brand identifier for a technology platform dedicated 
            to organizing and connecting music metadata across recordings, artists, and releases.
          </p>
        </section>

        {/* System Capabilities (Grid) */}
        <section>
          <SectionTitle>System Infrastructure</SectionTitle>
          <p className="mb-6 mt-2 text-sm text-gray-500 uppercase tracking-widest font-semibold">
            Designed to support:
          </p>
          <div className="grid gap-3 sm:grid-cols-2">
            {coreFeatures.map((feature) => (
              <div 
                key={feature} 
                className="flex items-center gap-3 rounded-xl border border-black/5 bg-white p-4 shadow-sm transition-all hover:border-[#8B0000]/20 hover:shadow-md"
              >
                <div className="h-2 w-2 rounded-full bg-[#8B0000]" />
                <span className="text-sm font-medium text-[#002D62]">{feature}</span>
              </div>
            ))}
          </div>
        </section>

        {/* Mission Statement (High Contrast) */}
        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
          <h2 className="mb-4 text-2xl font-bold">Our Mission</h2>
          <p className="text-lg leading-relaxed opacity-90 sm:text-xl">
            To create a reliable, open, and extensible infrastructure for Dominican music data,
            enabling developers, researchers, artists, and the general public to access structured musical information at scale.</p>
            <p className="text-lg leading-relaxed opacity-90 sm:text-xl">
              Mangulina is designed not only as a technical platform, but also as a cultural and educational resource for anyone
              interested in Dominican music— from casual listeners discovering new artists, to professionals building music applications and conducting research.</p>
            <p className="text-lg leading-relaxed opacity-90 sm:text-xl">
              Our goal is to make Dominican music more accessible, understandable, and connected across both digital systems and everyday listeners.</p>
        </section>

        {/* Clarification & Focus */}
        <div className="grid gap-8 sm:grid-cols-2">
          <section className="rounded-2xl border border-red-100 bg-red-50/30 p-6">
            <h3 className="mb-3 font-bold text-[#8B0000]">What Mangulina Is Not</h3>
            <p className="text-sm leading-relaxed text-gray-700">
              Mangulina is not a musical genre, style classification, or cultural categorization system. 
              Any reference to traditional Dominican music is strictly for contextual metadata 
              organization within the database.
            </p>
          </section>

          <section className="rounded-2xl border border-blue-100 bg-blue-50/30 p-6">
            <h3 className="mb-3 font-bold text-[#002D62]">Platform Focus</h3>
            <p className="text-sm leading-relaxed text-gray-700">
              Mangulina operates as a technology layer for music information, 
              not as a publisher, label, or genre authority.
            </p>
          </section>
        </div>
      </div>
    </main>
  );
}