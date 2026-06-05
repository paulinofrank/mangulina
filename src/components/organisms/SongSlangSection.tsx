// components/organisms/SongSlangSection.tsx
// Cultural vocabulary boxes — unique to Mangulina.

type SlangItem = {
  id: string | number;
  term?: string | null;
  meaning?: string | null;
  example?: string | null;
  meaning_in_song?: string | null;
  cultural_note?: string | null;
  lyric_excerpt?: string | null;
  source_url?: string | null;
  expression?: {
    term?: string | null;
    definition?: string | null;
    example?: string | null;
    notes?: string | null;
  } | null;
};

type SongSlangSectionProps = {
  slang: SlangItem[];
};

export default function SongSlangSection({ slang }: SongSlangSectionProps) {
  if (!slang.length) return null;

  return (
    <section className="h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-1.5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Dominican Slang & Expressions
      </h2>
      <p className="mb-4 text-xs text-gray-400">
        Cultural vocabulary used or referenced in this song.
      </p>

      <div className="space-y-3">
        {slang.map((item) => {
          const term = item.expression?.term ?? item.term ?? "Expression";
          const meaning = item.meaning_in_song ?? item.meaning ?? item.expression?.definition;
          const example = item.lyric_excerpt ?? item.example ?? item.expression?.example;
          const culturalNote = item.cultural_note ?? item.expression?.notes;
          return (
            <div
              key={item.id}
              className="rounded-lg border border-[#002D62]/10 bg-[#002D62]/3 p-4"
            >
              <p className="text-sm font-bold text-[#002D62]">
                {term}
              </p>
              {meaning && (
                <p className="mt-1 text-sm leading-relaxed text-gray-700">
                  {meaning}
                </p>
              )}
              {culturalNote && (
                <p className="mt-2 text-xs leading-relaxed text-gray-500">
                  {culturalNote}
                </p>
              )}
              {example && (
                <p className="mt-2 text-xs text-gray-500">
                  <span className="font-medium uppercase tracking-wide">Example: </span>
                  <span className="italic">{example}</span>
                </p>
              )}
              {item.source_url && (
                <a
                  href={item.source_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="mt-3 inline-flex text-xs font-medium text-gray-400 underline-offset-2 hover:text-[#002D62] hover:underline"
                >
                  Source
                </a>
              )}
            </div>
          );
        })}
      </div>
    </section>
  );
}
