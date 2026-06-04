// components/organisms/SongLyricsSection.tsx

type SongLyricsSectionProps = {
  lyrics: string;
  notice?: string;
};

export default function SongLyricsSection({ lyrics, notice }: SongLyricsSectionProps) {
  if (!lyrics) return null;

  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Lyrics
      </h2>
      {notice && (
        <p className="mb-3 text-[10px] text-gray-400 uppercase tracking-wide">{notice}</p>
      )}
      <pre className="whitespace-pre-wrap font-sans text-sm leading-7 text-gray-700">
        {lyrics}
      </pre>
    </section>
  );
}
