// components/organisms/SongCreditsSection.tsx
export type CreditItem = {
  role: string;
  name: string;
};

type SongCreditsSectionProps = {
  credits: CreditItem[];
  labelName?: string;
  releaseInfo?: string;
};


export default function SongCreditsSection({
  credits,
  labelName,
  releaseInfo,
}: SongCreditsSectionProps) {
  if (!credits.length && !labelName && !releaseInfo) return null;

  return (
    <section className="mb-8">
      <h2 className="mb-2 text-sm font-semibold uppercase tracking-wider text-[#002D62]">
        Credits
      </h2>
      <div className="space-y-1 text-sm text-gray-700">
        {labelName && <p><span className="font-medium">Label:</span> {labelName}</p>}
        {releaseInfo && <p><span className="font-medium">Release:</span> {releaseInfo}</p>}
        {credits.map((c, idx) => (
          <p key={idx}>
            <span className="font-medium">{c.role}:</span> {c.name}
          </p>
        ))}
      </div>
    </section>
  );
}
