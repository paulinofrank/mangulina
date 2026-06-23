// components/organisms/SongHeader.tsx
import { useTranslations } from "next-intl";
type SongHeaderProps = {
  title: string;
  artist: string;
  year?: number | null;
  views?: number | null;
  genre?: string | null;
  subgenre?: string | null;
};

function formatLabel(value: string | null | undefined) {
  if (!value) return null;

  return value
    .replace(/[-_]/g, " ")
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

export default function SongHeader({
  title,
  artist,
  year,
  views,
  genre,
  subgenre,
}: SongHeaderProps) {
  const t = useTranslations("common");
  const genreText = [formatLabel(genre), formatLabel(subgenre)].filter(Boolean).join(" / ");

  return (
    <header className="mb-6">
      <h1 className="text-2xl font-semibold text-[#002D62]">{title}</h1>
      <p className="mt-1 text-sm text-gray-600">
        {artist}
        {year ? <span className="text-gray-400"> · {year}</span> : null}
      </p>
      {views != null && (
        <p className="mt-1 text-xs text-gray-500">
          {views.toLocaleString()} {t("views")}
        </p>
      )}
      {genreText && (
        <p className="mt-2 text-xs font-medium uppercase tracking-wider text-[#CE1126]">
          {genreText}
        </p>
      )}
    </header>
  );
}
