"use client";

import Link from "next/link";
import { useTranslations } from "next-intl";

import {
  formatArtistRelationshipDisplay,
  type ArtistRelationship,
} from "@/lib/artistRelationships";

type ArtistRelationshipsSectionProps = {
  title: "Groups & Projects" | "Members";
  relationships: ArtistRelationship[];
  direction: "outgoing" | "incoming";
};

export default function ArtistRelationshipsSection({
  title,
  relationships,
  direction,
}: ArtistRelationshipsSectionProps) {
  const t = useTranslations();
  if (!relationships.length) return null;

  return (
    <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
      <h3 className="mb-4 text-xs font-normal uppercase text-(--color-wikicrimson)">
        {title}
      </h3>

      <div className="grid gap-2">
        {relationships.map((relationship) => {
          const artist =
            direction === "outgoing"
              ? relationship.target_artist
              : relationship.source_artist;
          const details = formatArtistRelationshipDisplay(
            relationship.relationship_type,
            relationship.start_year,
            relationship.end_year
          );
          const content = (
            <>
              <span className="truncate text-sm font-medium text-(--color-flagblue)">
                {artist?.name ?? t("fallback.unknownArtist")}
              </span>
              {details && (
                <span className="shrink-0 text-xs text-gray-500">
                  {details}
                </span>
              )}
            </>
          );

          return artist?.slug ? (
            <Link
              key={relationship.id}
              href={`/artists/${artist.slug}`}
              className="flex items-center justify-between gap-3 rounded-lg border border-gray-100 bg-gray-50 px-3 py-2 transition hover:border-(--color-flagblue)/25 hover:bg-(--color-flagblue)/5"
            >
              {content}
            </Link>
          ) : (
            <div
              key={relationship.id}
              className="flex items-center justify-between gap-3 rounded-lg border border-gray-100 bg-gray-50 px-3 py-2"
            >
              {content}
            </div>
          );
        })}
      </div>
    </section>
  );
}
