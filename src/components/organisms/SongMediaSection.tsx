// components/organisms/SongMediaSection.tsx

type SongMedia = {
  id: string | number;
  media_type: string;
  title: string;
  url: string;
  platform?: string | null;
  external_id?: string | null;
  is_official?: boolean | null;
  is_primary?: boolean | null;
  notes?: string | null;
  display_order?: number | null;
  source?: {
    title?: string | null;
    url?: string | null;
  } | null;
};

type SongMediaSectionProps = {
  media: SongMedia[];
};

function formatLabel(value: string | null | undefined) {
  if (!value) return null;
  return value
    .replace(/_/g, " ")
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

export default function SongMediaSection({ media }: SongMediaSectionProps) {
  if (!media.length) return null;

  return (
    <section className="h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-1.5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Media
      </h2>
      <p className="mb-4 text-xs text-gray-400">
        Videos, performances, interviews, and other media connected to this recording.
      </p>

      <div className="space-y-3">
        {media.map((item) => {
          const mediaType = formatLabel(item.media_type) ?? "Media";
          const platform = formatLabel(item.platform);

          return (
            <article
              key={item.id}
              className="rounded-lg border border-black/5 bg-gray-50 p-4"
            >
              <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
                <div className="min-w-0">
                  <div className="flex flex-wrap items-center gap-2">
                    <span className="rounded-full bg-[#002D62]/8 px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.14em] text-[#002D62]">
                      {mediaType}
                    </span>
                    {item.is_official && (
                      <span className="rounded-full bg-[#CE1126]/8 px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.14em] text-[#CE1126]">
                        Official
                      </span>
                    )}
                    {item.is_primary && (
                      <span className="rounded-full bg-gray-200 px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.14em] text-gray-600">
                        Primary
                      </span>
                    )}
                  </div>

                  <h3 className="mt-2 text-sm font-semibold text-[#002D62]">
                    {item.title}
                  </h3>

                  {platform && (
                    <p className="mt-1 text-xs text-gray-500">
                      {platform}
                    </p>
                  )}
                </div>

                <a
                  href={item.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="shrink-0 text-xs font-semibold text-[#CE1126] underline-offset-2 hover:underline"
                >
                  Open Media
                </a>
              </div>

              {item.notes && (
                <p className="mt-3 text-sm leading-relaxed text-gray-700">
                  {item.notes}
                </p>
              )}

              {item.source?.title && (
                <p className="mt-2 text-xs text-gray-500">
                  Source:{" "}
                  {item.source.url ? (
                    <a
                      href={item.source.url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="font-medium underline-offset-2 hover:text-[#002D62] hover:underline"
                    >
                      {item.source.title}
                    </a>
                  ) : (
                    item.source.title
                  )}
                </p>
              )}
            </article>
          );
        })}
      </div>
    </section>
  );
}
