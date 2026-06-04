// components/organisms/SongRecordingDetails.tsx
// Clean encyclopedia-style facts table for a recording.

const COUNTRY_NAMES: Record<string, string> = {
  DO: "Dominican Republic",
  US: "United States",
  MX: "Mexico",
  PR: "Puerto Rico",
  CO: "Colombia",
  VE: "Venezuela",
  ES: "Spain",
  CU: "Cuba",
  AR: "Argentina",
  BR: "Brazil",
  PA: "Panama",
  PE: "Peru",
  GT: "Guatemala",
  HN: "Honduras",
  SV: "El Salvador",
  NI: "Nicaragua",
  CR: "Costa Rica",
  EC: "Ecuador",
  BO: "Bolivia",
  PY: "Paraguay",
  UY: "Uruguay",
  XW: "Worldwide",
  GB: "United Kingdom",
  DE: "Germany",
  FR: "France",
  IT: "Italy",
  JP: "Japan",
};

const LANGUAGE_NAMES: Record<string, string> = {
  spa: "Spanish",
  eng: "English",
  por: "Portuguese",
  fra: "French",
  deu: "German",
  ita: "Italian",
  "zxx": "No linguistic content",
  mul: "Multiple languages",
};

type SongRecordingDetailsProps = {
  recordingYear?: number | null;
  releaseYear?: number | null;
  label?: string | null;
  country?: string | null;         // ISO 3166-1 alpha-2 code
  isrcs?: string[] | null;
  mbid?: string | null;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  releaseMetadata?: Record<string, any> | null;
};

function getLanguage(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  releaseMetadata: Record<string, any> | null | undefined,
): string | null {
  const code = releaseMetadata?.["text-representation"]?.language as string | undefined;
  if (!code) return null;
  return LANGUAGE_NAMES[code.toLowerCase()] ?? code.toUpperCase();
}

type Row = { label: string; value: string };

export default function SongRecordingDetails({
  recordingYear,
  releaseYear,
  label,
  country,
  isrcs,
  mbid,
  releaseMetadata,
}: SongRecordingDetailsProps) {
  const rows: Row[] = [];

  if (recordingYear && recordingYear !== releaseYear)
                       rows.push({ label: "Recorded",     value: String(recordingYear) });
  if (label)           rows.push({ label: "Label",        value: label });

  const countryName = country ? (COUNTRY_NAMES[country] ?? country) : null;
  if (countryName)     rows.push({ label: "Country",      value: countryName });

  const language = getLanguage(releaseMetadata);
  if (language)        rows.push({ label: "Language",     value: language });

  const isrcList = (isrcs ?? []).filter(Boolean);
  if (isrcList.length > 0)
                       rows.push({ label: "ISRC",         value: isrcList.join(" · ") });

  if (mbid)            rows.push({
    label: "MusicBrainz ID",
    value: mbid,
  });

  if (rows.length === 0) return null;

  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Recording Details
      </h2>

      <dl className="divide-y divide-gray-50">
        {rows.map(({ label: rowLabel, value }) => (
          <div
            key={rowLabel}
            className="flex items-start justify-between gap-4 py-2.5 text-sm first:pt-0 last:pb-0"
          >
            <dt className="w-32 shrink-0 text-xs font-medium uppercase tracking-[0.12em] text-gray-400">
              {rowLabel}
            </dt>
            <dd className="text-right text-gray-700 break-all">
              {rowLabel === "MusicBrainz ID" ? (
                <a
                  href={`https://musicbrainz.org/recording/${value}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="font-mono text-xs text-[#002D62] underline-offset-2 hover:underline"
                >
                  {value}
                </a>
              ) : (
                value
              )}
            </dd>
          </div>
        ))}
      </dl>
    </section>
  );
}
