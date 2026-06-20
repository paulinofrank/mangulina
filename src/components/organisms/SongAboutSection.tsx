// components/organisms/SongAboutSection.tsx
import { useTranslations } from "next-intl";

type SongAboutSectionProps = {
  about?: string | null;
  inspiration?: string | null;
  historicalContext?: string | null;
  culturalSignificance?: string | null;
  culturalContext?: string | null;
  notes?: string | null;
};

const SUBSECTIONS = [
  { key: "about",                labelKey: "aboutTheSong"        },
  { key: "inspiration",          labelKey: "inspirationAndStory"   },
  { key: "historicalContext",    labelKey: "historicalContext"    },
  { key: "culturalSignificance", labelKey: "culturalSignificance" },
  { key: "culturalContext",      labelKey: "culturalContext"      },
  { key: "notes",                labelKey: "notes"                 },
] as const;

export default function SongAboutSection({
  about,
  inspiration,
  historicalContext,
  culturalSignificance,
  culturalContext,
  notes,
}: SongAboutSectionProps) {
  const t = useTranslations("songAbout");
  const tSong = useTranslations("song");
  const values = {
    about,
    inspiration,
    historicalContext,
    culturalSignificance,
    culturalContext,
    notes,
  };
  const visible = SUBSECTIONS.filter(({ key }) => values[key]?.trim());
  if (visible.length === 0) return null;

  return (
    <section className="h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        {tSong("about")}
      </h2>

      <div className="space-y-5">
        {visible.map(({ key, labelKey }) => (
          <div key={key}>
            {visible.length > 1 && (
              <h3 className="mb-2 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-400">
                {t(labelKey)}
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
