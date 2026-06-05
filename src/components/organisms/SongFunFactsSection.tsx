// components/organisms/SongFunFactsSection.tsx

type FunFact = {
  id: string | number;
  fact?: string | null;
  text?: string | null;
  source_url?: string | null;
};

type SongFunFactsSectionProps = {
  facts: FunFact[];
};

export default function SongFunFactsSection({ facts }: SongFunFactsSectionProps) {
  if (!facts.length) return null;

  return (
    <section className="h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Fun Facts
      </h2>

      <ol className="space-y-3">
        {facts.map((fact, i) => (
          <li
            key={fact.id}
            className="flex gap-4 rounded-lg border border-black/5 bg-gray-50 p-4"
          >
            <span
              aria-hidden
              className="shrink-0 text-lg font-black leading-none tabular-nums text-[#002D62]/20"
            >
              {String(i + 1).padStart(2, "0")}
            </span>
            <div className="min-w-0 flex-1">
              <p className="text-sm leading-relaxed text-gray-700">
                {fact.fact ?? fact.text}
              </p>
              {fact.source_url && (
                <a
                  href={fact.source_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="mt-2 inline-flex text-xs font-medium text-gray-400 underline-offset-2 hover:text-[#002D62] hover:underline"
                >
                  Source
                </a>
              )}
            </div>
          </li>
        ))}
      </ol>
    </section>
  );
}
