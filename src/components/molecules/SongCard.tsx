"use client";

import Link from "next/link";

type SongCardProps = {
  id: string | number;
  title: string;
  artistName: string;
  coverUrl: string;
  views?: number | null;
};

export default function SongCard({
  id,
  title,
  artistName,
  coverUrl,
  views,
}: SongCardProps) {
  return (
    <Link href={`/songs/${id}`} className="shrink-0 w-32 group">
      <div className="relative aspect-square overflow-hidden rounded-lg bg-gray-100 border border-black/5 transition-transform duration-350 ease-out group-hover:scale-[1.02]">
        <img
          src={coverUrl}
          alt={title}
          className="absolute inset-0 w-full h-full object-cover"
          loading="lazy"
          onError={(e) => {
            e.currentTarget.src = "/images/placeholder-song.jpg";
          }}
        />
      </div>

      <div className="mt-2">
        <h4 className="truncate text-sm font-normal text-[#002D62] group-hover:text-[#CE1126] transition-colors duration-200">
          {title}
        </h4>

        <p className="truncate text-xs text-gray-500">
          {artistName}
        </p>

        {views != null && (
          <p className="text-[11px] text-gray-500 leading-tight">
            {views.toLocaleString()} views
          </p>
        )}
      </div>
    </Link>
  );
}
