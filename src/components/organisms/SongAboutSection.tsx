// components/organisms/SongAboutSection.tsx

type SongAboutSectionProps = {
  about?: string | null;
  inspiration?: string | null;
  culturalContext?: string | null;
  notes?: string | null;
};

const SUBSECTIONS = [
  { key: "about",           label: "About the Song"      },
  { key: "inspiration",     label: "Inspiration & Story" },
  { key: "culturalContext", label: "Cultural Context"     },
  { key: "notes",           label: "Notes"               },
] as const;

export default function SongAboutSection({
  about,
  inspiration,
  culturalContext,
  notes,
}: SongAboutSectionProps) {
  const values = { about, inspiration, culturalContext, notes };
  const visible = SUBSECTIONS.filter(({ key }) => values[key]?.trim());
  if (visible.length === 0) return null;

  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        About This Song
      </h2>

      <div className="space-y-5">
        {visible.map(({ key, label }) => (
          <div key={key}>
            {visible.length > 1 && (
              <h3 className="mb-2 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-400">
                {label}
              </h3>
            )}
            <p className="text-sm leading-relaxed text-gray-700 whitespace-pre-wrap">
              {values[key]}
            </p>
          </div>
        ))}
      </div>
    </section>
  );
}
