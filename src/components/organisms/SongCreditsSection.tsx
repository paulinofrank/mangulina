// components/organisms/SongCreditsSection.tsx
// Groups credits by role for a liner-notes style display.
import Link from "next/link";

export type CreditItem = {
  role: string;
  name: string;
  slug?: string | null;
};

type SongCreditsSectionProps = {
  credits: CreditItem[];
  labelName?: string;
  releaseInfo?: string;
};

const ROLE_LABELS: Record<string, string> = {
  performer: "Performed by",
  vocalist: "Vocals",
  vocal: "Vocals",
  vocals: "Vocals",
  singer: "Vocals",
  composer: "Composed by",
  songwriter: "Written by",
  writer: "Written by",
  lyricist: "Lyrics by",
  lyrics: "Lyrics by",
  arranger: "Arranged by",
  producer: "Produced by",
  "co-producer": "Co-produced by",
  "executive producer": "Executive producer",
  conductor: "Conducted by",
  "musical director": "Musical director",
  "recording engineer": "Recording engineer",
  engineer: "Engineer",
  "mix engineer": "Mix engineer",
  "mastering engineer": "Mastering engineer",
  guitar: "Guitar",
  piano: "Piano",
  bass: "Bass",
  "bass guitar": "Bass guitar",
  drums: "Drums",
  percussion: "Percussion",
  trumpet: "Trumpet",
  saxophone: "Saxophone",
  violin: "Violin",
  chorus: "Chorus",
  "backing vocals": "Backing vocals",
  "background vocals": "Background vocals",
};

const ROLE_ORDER = [
  "Performed by",
  "Vocals",
  "Written by",
  "Composed by",
  "Lyrics by",
  "Arranged by",
  "Produced by",
  "Co-produced by",
  "Executive producer",
  "Musical director",
  "Conducted by",
  "Recording engineer",
  "Engineer",
  "Mix engineer",
  "Mastering engineer",
];

function sortRoles(roles: string[]): string[] {
  return roles.sort((a, b) => {
    const ia = ROLE_ORDER.findIndex((r) => r.toLowerCase() === a.toLowerCase());
    const ib = ROLE_ORDER.findIndex((r) => r.toLowerCase() === b.toLowerCase());
    if (ia !== -1 && ib !== -1) return ia - ib;
    if (ia !== -1) return -1;
    if (ib !== -1) return 1;
    return a.localeCompare(b);
  });
}

function titleCase(value: string) {
  return value
    .replace(/[_-]+/g, " ")
    .trim()
    .replace(/\s+/g, " ")
    .replace(/\b\w/g, (letter) => letter.toUpperCase());
}

function normalizeRole(role: string) {
  const normalized = role.trim().toLowerCase();
  return ROLE_LABELS[normalized] ?? titleCase(role);
}

export default function SongCreditsSection({
  credits,
  labelName,
  releaseInfo,
}: SongCreditsSectionProps) {
  const hasCredits = credits.length > 0;
  const hasExtra = Boolean(labelName || releaseInfo);
  if (!hasCredits && !hasExtra) return null;

  const grouped = new Map<string, CreditItem[]>();
  for (const c of credits) {
    const role = normalizeRole(c.role || "Credit");
    if (!grouped.has(role)) grouped.set(role, []);
    const names = grouped.get(role)!;
    if (!names.some((item) => item.name === c.name && item.slug === c.slug)) {
      names.push(c);
    }
  }
  const sortedRoles = sortRoles([...grouped.keys()]);

  return (
    <section className="h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Song Credits
      </h2>

      {/* Label / Release info */}
      {hasExtra && (
        <div className="mb-5 flex flex-wrap gap-x-6 gap-y-2 border-b border-gray-50 pb-5 text-sm">
          {labelName && (
            <div>
              <span className="mr-1.5 text-[10px] font-semibold uppercase tracking-[0.14em] text-gray-400">Label</span>
              <span className="text-gray-700">{labelName}</span>
            </div>
          )}
          {releaseInfo && (
            <div>
              <span className="mr-1.5 text-[10px] font-semibold uppercase tracking-[0.14em] text-gray-400">Release</span>
              <span className="text-gray-700">{releaseInfo}</span>
            </div>
          )}
        </div>
      )}

      {/* Credit rows */}
      {sortedRoles.length > 0 && (
        <dl className="grid gap-y-3 sm:grid-cols-[140px_1fr]">
          {sortedRoles.map((role) => {
            const names = grouped.get(role) ?? [];
            return (
              <div key={role} className="contents">
                <dt
                  className="text-[10px] font-semibold uppercase tracking-[0.14em] text-gray-400 sm:py-0.5"
                >
                  {role}
                </dt>
                <dd className="text-sm text-gray-700 sm:py-0.5">
                  <span className="flex flex-wrap gap-x-1.5 gap-y-1">
                    {names.map((credit, index) => (
                      <span key={`${role}-${credit.name}-${credit.slug ?? index}`}>
                        {credit.slug ? (
                          <Link
                            href={`/artists/${credit.slug}`}
                            className="font-medium text-[#002D62] transition hover:text-[#CE1126]"
                          >
                            {credit.name}
                          </Link>
                        ) : (
                          <span>{credit.name}</span>
                        )}
                        {index < names.length - 1 && <span>,</span>}
                      </span>
                    ))}
                  </span>
                </dd>
              </div>
            );
          })}
        </dl>
      )}
    </section>
  );
}
