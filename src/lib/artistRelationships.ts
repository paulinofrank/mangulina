import { getSupabaseClient } from "@/lib/supabase";

export type ArtistRelationshipType = "member_of" | "founder_of" | "leader_of";

export type ArtistRelationshipArtist = {
  id: string;
  name: string;
  slug: string | null;
  type?: string | null;
  status?: string | null;
};

export type ArtistRelationship = {
  id: string;
  source_artist_id: string;
  target_artist_id: string;
  relationship_type: ArtistRelationshipType;
  start_year: number | null;
  end_year: number | null;
  notes: string | null;
  source_artist?: ArtistRelationshipArtist | null;
  target_artist?: ArtistRelationshipArtist | null;
};

const RELATIONSHIP_SELECT = `
  id,
  source_artist_id,
  target_artist_id,
  relationship_type,
  start_year,
  end_year,
  notes,
  source_artist:source_artist_id(id, name, slug, type, status),
  target_artist:target_artist_id(id, name, slug, type, status)
`;

export const artistRelationshipTypeLabels: Record<ArtistRelationshipType, string> = {
  member_of: "Member",
  founder_of: "Founder",
  leader_of: "Leader",
};

export function isArtistRelationshipType(value: unknown): value is ArtistRelationshipType {
  return value === "member_of" || value === "founder_of" || value === "leader_of";
}

export function formatArtistRelationshipType(value: string | null | undefined) {
  return isArtistRelationshipType(value) ? artistRelationshipTypeLabels[value] : null;
}

export function formatArtistRelationshipDisplay(
  value: string | null | undefined,
  startYear: number | null | undefined,
  endYear: number | null | undefined
) {
  const label = formatArtistRelationshipType(value);
  if (!label) return null;

  const displayLabel = endYear ? `Former ${label}` : label;

  if (startYear && endYear) return `${displayLabel}, ${startYear}–${endYear}`;
  if (startYear) return `${displayLabel} since ${startYear}`;
  if (endYear) return `${displayLabel}, Until ${endYear}`;
  return displayLabel;
}

export function formatRelationshipYears(
  startYear: number | null | undefined,
  endYear: number | null | undefined
) {
  if (startYear && endYear) return `${startYear}–${endYear}`;
  if (startYear) return `Since ${startYear}`;
  if (endYear) return `Until ${endYear}`;
  return null;
}

function normalizeRelationship(row: unknown): ArtistRelationship {
  const relationship = row as ArtistRelationship & {
    source_artist?: ArtistRelationshipArtist | ArtistRelationshipArtist[] | null;
    target_artist?: ArtistRelationshipArtist | ArtistRelationshipArtist[] | null;
  };

  return {
    ...relationship,
    source_artist: Array.isArray(relationship.source_artist)
      ? relationship.source_artist[0] ?? null
      : relationship.source_artist ?? null,
    target_artist: Array.isArray(relationship.target_artist)
      ? relationship.target_artist[0] ?? null
      : relationship.target_artist ?? null,
  };
}

export async function getArtistRelationships(artistId: string) {
  const supabase = getSupabaseClient();

  const [outgoingResponse, incomingResponse] = await Promise.all([
    supabase
      .from("artist_relationships")
      .select(RELATIONSHIP_SELECT)
      .eq("source_artist_id", artistId)
      .order("start_year", { ascending: true, nullsFirst: false })
      .order("created_at", { ascending: true }),
    supabase
      .from("artist_relationships")
      .select(RELATIONSHIP_SELECT)
      .eq("target_artist_id", artistId)
      .order("start_year", { ascending: true, nullsFirst: false })
      .order("created_at", { ascending: true }),
  ]);

  if (outgoingResponse.error) {
    console.error("getArtistRelationships outgoing error:", outgoingResponse.error);
  }

  if (incomingResponse.error) {
    console.error("getArtistRelationships incoming error:", incomingResponse.error);
  }

  return {
    outgoing: (outgoingResponse.data ?? []).map(normalizeRelationship),
    incoming: (incomingResponse.data ?? []).map(normalizeRelationship),
  };
}
