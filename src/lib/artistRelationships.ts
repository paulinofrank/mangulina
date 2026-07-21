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

export type ArtistMembershipRelationshipType = "member_of" | "former_member_of";

export type ArtistMembership = {
  id: string;
  relatedArtistId: string;
  relatedArtistName: string;
  relatedArtistSlug: string | null;
  artistType: string | null;
  relationshipType: ArtistMembershipRelationshipType;
  startYear: number | null;
  endYear: number | null;
  isFormer: boolean;
};

export type NormalizedArtistRelationships = {
  outgoing: ArtistRelationship[];
  incoming: ArtistRelationship[];
  membershipGroups: ArtistMembership[];
  memberArtists: ArtistMembership[];
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

const spanishArtistRelationshipTypeLabels: Record<ArtistRelationshipType, string> = {
  member_of: "Miembro",
  founder_of: "Fundador",
  leader_of: "Líder",
};

const spanishFormerArtistRelationshipTypeLabels: Record<ArtistRelationshipType, string> = {
  member_of: "Ex-Miembro",
  founder_of: "Ex-Fundador",
  leader_of: "Ex-Líder",
};

export function isArtistRelationshipType(value: unknown): value is ArtistRelationshipType {
  return value === "member_of" || value === "founder_of" || value === "leader_of";
}

export function formatArtistRelationshipType(
  value: string | null | undefined,
  locale = "en"
) {
  if (!isArtistRelationshipType(value)) return null;

  return locale === "es"
    ? spanishArtistRelationshipTypeLabels[value]
    : artistRelationshipTypeLabels[value];
}

export function formatArtistRelationshipDisplay(
  value: string | null | undefined,
  startYear: number | null | undefined,
  endYear: number | null | undefined,
  locale = "en"
) {
  const label = formatArtistRelationshipType(value, locale);
  if (!label) return null;

  const displayLabel =
    endYear && locale === "es" && isArtistRelationshipType(value)
      ? spanishFormerArtistRelationshipTypeLabels[value]
      : endYear
        ? `Former ${label}`
        : label;

  if (startYear && endYear) return `${displayLabel}, ${startYear}–${endYear}`;
  if (locale === "es" && startYear) return `${displayLabel} desde ${startYear}`;
  if (locale === "es" && endYear) return `${displayLabel}, hasta ${endYear}`;
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

function normalizeMembership({
  relationship,
  artist,
}: {
  relationship: ArtistRelationship;
  artist: ArtistRelationshipArtist | null | undefined;
}): ArtistMembership | null {
  if (relationship.relationship_type !== "member_of" || !artist?.id) {
    return null;
  }

  const isFormer = Boolean(relationship.end_year);

  return {
    id: relationship.id,
    relatedArtistId: artist.id,
    relatedArtistName: artist.name,
    relatedArtistSlug: artist.slug ?? null,
    artistType: artist.type ?? null,
    relationshipType: isFormer ? "former_member_of" : "member_of",
    startYear: relationship.start_year,
    endYear: relationship.end_year,
    isFormer,
  };
}

function dedupeMemberships(relationships: ArtistMembership[]) {
  const seen = new Set<string>();

  return relationships.filter((relationship) => {
    const key = [
      relationship.relatedArtistId,
      relationship.relationshipType,
      relationship.startYear ?? "",
      relationship.endYear ?? "",
    ].join(":");

    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

export async function getArtistRelationships(
  artistId: string
): Promise<NormalizedArtistRelationships> {
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

  const outgoing = (outgoingResponse.data ?? []).map(normalizeRelationship);
  const incoming = (incomingResponse.data ?? []).map(normalizeRelationship);

  const membershipGroups = dedupeMemberships(
    outgoing
      .map((relationship) =>
        normalizeMembership({
          relationship,
          artist: relationship.target_artist,
        })
      )
      .filter((relationship): relationship is ArtistMembership => Boolean(relationship))
  );

  const memberArtists = dedupeMemberships(
    incoming
      .map((relationship) =>
        normalizeMembership({
          relationship,
          artist: relationship.source_artist,
        })
      )
      .filter((relationship): relationship is ArtistMembership => Boolean(relationship))
  );

  return {
    outgoing,
    incoming,
    membershipGroups,
    memberArtists,
  };
}
