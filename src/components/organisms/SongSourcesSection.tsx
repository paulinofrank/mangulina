// components/organisms/SongSourcesSection.tsx

type SongSource = {
  id: string | number;
  source_usage?: string | null;
  source?: {
    title?: string | null;
    source_type?: string | null;
    author?: string | null;
    publisher?: string | null;
    url?: string | null;
    publication_date?: string | null;
    notes?: string | null;
  } | null;
};

type SongSourcesSectionProps = {
  sources: SongSource[];
};

function formatDate(value: string | null | undefined) {
  if (!value) return null;

  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return value;

  return new Intl.DateTimeFormat("en", {
    year: "numeric",
    month: "short",
    day: "numeric",
  }).format(date);
}

function formatLabel(value: string | null | undefined) {
  if (!value) return null;
  return value
    .replace(/_/g, " ")
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

export default function SongSourcesSection({ sources }: SongSourcesSectionProps) {
  const visibleSources = sources.filter((item) => item.source?.title);
  if (!visibleSources.length) return null;

  return (
    <section className="h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-1.5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Sources
      </h2>
      <p className="mb-4 text-xs text-gray-400">
        References connected to this song profile.
      </p>

      <div className="space-y-3">
        {visibleSources.map((item) => {
          const source = item.source;
          if (!source?.title) return null;

          const meta = [
            formatLabel(source.source_type),
            source.author,
            source.publisher,
            formatDate(source.publication_date),
          ].filter(Boolean);

          return (
            <article
              key={item.id}
              className="rounded-lg border border-black/5 bg-gray-50 p-4"
            >
              <div className="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
                <div className="min-w-0">
                  <h3 className="text-sm font-semibold text-[#002D62]">
                    {source.title}
                  </h3>
                  {meta.length > 0 && (
                    <p className="mt-1 text-xs text-gray-500">
                      {meta.join(" · ")}
                    </p>
                  )}
                </div>

                {source.url && (
                  <a
                    href={source.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="shrink-0 text-xs font-semibold text-[#CE1126] underline-offset-2 hover:underline"
                  >
                    Open Source
                  </a>
                )}
              </div>

              {item.source_usage && (
                <p className="mt-3 text-sm leading-relaxed text-gray-700">
                  {item.source_usage}
                </p>
              )}

              {source.notes && (
                <p className="mt-2 text-xs leading-relaxed text-gray-500">
                  {source.notes}
                </p>
              )}
            </article>
          );
        })}
      </div>
    </section>
  );
}
