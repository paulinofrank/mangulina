// components/organisms/SongSlangSection.tsx
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
    <section className="mb-8">
      <h2 className="mb-2 text-sm font-semibold uppercase tracking-wider text-[#002D62]">
        Slang & Expressions
      </h2>
      <div className="space-y-3 text-sm text-gray-800">
        {slang.map((item) => (
          <div key={item.id} className="rounded-lg border border-black/5 bg-gray-50 p-3">
            <p className="font-semibold text-[#002D62]">{item.term}</p>
            <p className="text-gray-700">{item.meaning}</p>
            {item.example && (
              <p className="mt-1 text-xs text-gray-500">
                Example: <span className="italic">{item.example}</span>
              </p>
            )}
          </div>
        ))}
      </div>
    </section>
  );
}
