// components/organisms/SongHeader.tsx
type SongHeaderProps = {
  title: string;
  artist: string;
  year?: number | null;
  views?: number | null;
};

export default function SongHeader({ title, artist, year, views }: SongHeaderProps) {
  return (
    <header className="mb-6">
      <h1 className="text-2xl font-semibold text-[#002D62]">{title}</h1>
      <p className="mt-1 text-sm text-gray-600">
        {artist}
        {year ? <span className="text-gray-400"> · {year}</span> : null}
      </p>
      {views != null && (
        <p className="mt-1 text-xs text-gray-500">
          {views.toLocaleString()} views
        </p>
      )}
    </header>
  );
}
