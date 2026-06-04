// components/organisms/SongSlangSection.tsx
// Cultural vocabulary boxes — unique to Mangulina.

type SlangItem = {
  id: string | number;
  term: string;
  meaning: string;
  example?: string | null;
};

type SongSlangSectionProps = {
  slang: SlangItem[];
};

export default function SongSlangSection({ slang }: SongSlangSectionProps) {
  if (!slang.length) return null;

  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-1.5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Dominican Slang & Expressions
      </h2>
      <p className="mb-4 text-xs text-gray-400">
        Cultural vocabulary used or referenced in this song.
      </p>

      <div className="space-y-3">
        {slang.map((item) => (
          <div
            key={item.id}
            className="rounded-lg border border-[#002D62]/10 bg-[#002D62]/3 p-4"
          >
            <p className="text-sm font-bold text-[#002D62]">
              {item.term}
            </p>
            <p className="mt-1 text-sm leading-relaxed text-gray-700">
              {item.meaning}
            </p>
            {item.example && (
              <p className="mt-2 text-xs text-gray-500">
                <span className="font-medium uppercase tracking-wide">Example: </span>
                <span className="italic">{item.example}</span>
              </p>
            )}
          </div>
        ))}
      </div>
    </section>
  );
}
