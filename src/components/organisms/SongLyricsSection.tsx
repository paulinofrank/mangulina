// components/organisms/SongLyricsSection.tsx
type SongLyricsSectionProps = {
  lyrics: string;
  notice?: string;
};

export default function SongLyricsSection({ lyrics, notice }: SongLyricsSectionProps) {
  if (!lyrics) return null;

  return (
    <section className="mb-8">
      <h2 className="mb-2 text-sm font-semibold uppercase tracking-wider text-[#002D62]">
        Lyrics
      </h2>
      {notice && (
        <p className="mb-2 text-xs text-gray-500">
          {notice}
        </p>
      )}
      <pre className="whitespace-pre-wrap rounded-lg bg-gray-50 p-3 text-sm text-gray-800 border border-black/5">
        {lyrics}
      </pre>
    </section>
  );
}
