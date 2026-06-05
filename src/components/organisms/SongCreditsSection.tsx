// components/organisms/SongCreditsSection.tsx
// Groups credits by role for a liner-notes style display.

export type CreditItem = {
  role: string;
  name: string;
};

type SongCreditsSectionProps = {
  credits: CreditItem[];
  labelName?: string;
  releaseInfo?: string;
};

// Role display order — common roles shown first, others follow alphabetically
const ROLE_ORDER = [
  "Lead Vocal", "Lead Vocals", "Vocals", "Vocalist",
  "Composer", "Songwriter", "Lyricist",
  "Producer", "Co-Producer", "Executive Producer",
  "Arranger",
  "Recording Engineer", "Engineer", "Mix Engineer", "Mastering Engineer",
  "Guitar", "Bass Guitar", "Bass", "Piano", "Keyboards", "Drums", "Percussion",
  "Trumpet", "Saxophone", "Violin", "Horn",
  "Chorus", "Backing Vocals", "Background Vocals",
  "Conductor",
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

export default function SongCreditsSection({
  credits,
  labelName,
  releaseInfo,
}: SongCreditsSectionProps) {
  const hasCredits = credits.length > 0;
  const hasExtra = Boolean(labelName || releaseInfo);
  if (!hasCredits && !hasExtra) return null;

  // Group by role
  const grouped = new Map<string, string[]>();
  for (const c of credits) {
    const role = c.role || "Credit";
    if (!grouped.has(role)) grouped.set(role, []);
    grouped.get(role)!.push(c.name);
  }
  const sortedRoles = sortRoles([...grouped.keys()]);

  return (
    <section className="h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Recording Credits
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
        <dl className="grid gap-y-3 sm:grid-cols-[160px_1fr]">
          {sortedRoles.map((role) => {
            const names = grouped.get(role) ?? [];
            return (
              <>
                <dt
                  key={`dt-${role}`}
                  className="text-[10px] font-semibold uppercase tracking-[0.14em] text-gray-400 sm:py-0.5"
                >
                  {role}
                </dt>
                <dd key={`dd-${role}`} className="text-sm text-gray-700 sm:py-0.5">
                  {names.join(", ")}
                </dd>
              </>
            );
          })}
        </dl>
      )}
    </section>
  );
}
