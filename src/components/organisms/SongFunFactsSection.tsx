type FunFact = {
  id: string | number;
  text: string;
};

type SongFunFactsSectionProps = {
  facts: FunFact[];
};

export default function SongFunFactsSection({ facts }: SongFunFactsSectionProps) {
  if (!facts.length) return null;

  return (
    <section className="mb-8">
      <h2 className="mb-2 text-sm font-semibold uppercase tracking-wider text-[#002D62]">
        Fun Facts
      </h2>
      <ul className="list-disc space-y-1 pl-5 text-sm text-gray-800">
        {facts.map((fact) => (
          <li key={fact.id}>{fact.text}</li>
        ))}
      </ul>
    </section>
  );
}
