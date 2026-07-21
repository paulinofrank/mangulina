import { NextResponse } from "next/server";

import {
  isArtistRelationshipType,
  getArtistRelationships,
  type ArtistRelationshipType,
} from "@/lib/artistRelationships";
import { getSupabaseClient } from "@/lib/supabase";

type ArtistRelationshipPayload = {
  source_artist_id?: string;
  target_artist_id?: string;
  relationship_type?: ArtistRelationshipType;
  start_year?: number | null;
  end_year?: number | null;
  notes?: string | null;
};

function normalizeYear(value: unknown) {
  if (value == null || value === "") return null;
  const year = Number(value);
  return Number.isInteger(year) ? year : null;
}

function validatePayload(payload: ArtistRelationshipPayload | undefined) {
  if (!payload?.source_artist_id || !payload.target_artist_id) {
    return "Source artist and related artist are required.";
  }

  if (payload.source_artist_id === payload.target_artist_id) {
    return "An artist cannot be related to itself.";
  }

  if (!isArtistRelationshipType(payload.relationship_type)) {
    return "Relationship type must be Member, Founder, or Leader.";
  }

  return null;
}

type RelationshipArtist = {
  id: string;
  type: string | null;
};

function isIndividualArtistType(value: string | null | undefined) {
  return value === "solo_artist" || value === "person";
}

async function canonicalizeRelationshipPayload(
  supabase: ReturnType<typeof getSupabaseClient>,
  payload: Required<Pick<ArtistRelationshipPayload, "source_artist_id" | "target_artist_id" | "relationship_type">> &
    Pick<ArtistRelationshipPayload, "start_year" | "end_year" | "notes">
) {
  const { data, error } = await supabase
    .from("artists")
    .select("id,type")
    .in("id", [payload.source_artist_id, payload.target_artist_id]);

  if (error) {
    throw error;
  }

  const artistsById = new Map(
    ((data ?? []) as RelationshipArtist[]).map((artist) => [artist.id, artist])
  );
  const source = artistsById.get(payload.source_artist_id);
  const target = artistsById.get(payload.target_artist_id);
  const shouldSwap =
    source &&
    target &&
    !isIndividualArtistType(source.type) &&
    isIndividualArtistType(target.type);

  return shouldSwap
    ? {
        ...payload,
        source_artist_id: payload.target_artist_id,
        target_artist_id: payload.source_artist_id,
      }
    : payload;
}

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const artistId = searchParams.get("artistId");

  if (!artistId) {
    return NextResponse.json(
      { ok: false, error: "Artist id is required." },
      { status: 400 }
    );
  }

  const relationships = await getArtistRelationships(artistId);

  return NextResponse.json({ ok: true, ...relationships });
}

export async function POST(request: Request) {
  const { relationshipId, relationshipData } = await request.json();
  const payload = relationshipData as ArtistRelationshipPayload | undefined;
  const validationError = validatePayload(payload);

  if (validationError) {
    return NextResponse.json(
      { ok: false, error: validationError },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const validPayload = payload as ArtistRelationshipPayload & {
    source_artist_id: string;
    target_artist_id: string;
    relationship_type: ArtistRelationshipType;
  };
  const writePayload = await canonicalizeRelationshipPayload(supabase, {
    source_artist_id: validPayload.source_artist_id,
    target_artist_id: validPayload.target_artist_id,
    relationship_type: validPayload.relationship_type,
    start_year: normalizeYear(validPayload.start_year),
    end_year: normalizeYear(validPayload.end_year),
    notes: validPayload.notes?.trim() || null,
  });

  const existingResponse = await supabase
    .from("artist_relationships")
    .select("id")
    .eq("source_artist_id", writePayload.source_artist_id)
    .eq("target_artist_id", writePayload.target_artist_id)
    .eq("relationship_type", writePayload.relationship_type)
    .maybeSingle();

  if (existingResponse.error) {
    return NextResponse.json(
      { ok: false, error: existingResponse.error.message },
      { status: 500 }
    );
  }

  const existingId = existingResponse.data?.id ?? null;
  const idToUpdate = relationshipId || existingId;
  const response = idToUpdate
    ? await supabase
        .from("artist_relationships")
        .update(writePayload)
        .eq("id", idToUpdate)
        .select("id")
        .maybeSingle()
    : await supabase
        .from("artist_relationships")
        .insert(writePayload)
        .select("id")
        .maybeSingle();

  if (response.error) {
    return NextResponse.json(
      { ok: false, error: response.error.message },
      { status: 500 }
    );
  }

  if (!response.data?.id) {
    return NextResponse.json(
      { ok: false, error: "No artist relationship row was saved." },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true, id: response.data.id });
}

export async function DELETE(request: Request) {
  const { relationshipId, artistId } = await request.json();

  if (!relationshipId || !artistId) {
    return NextResponse.json(
      { ok: false, error: "Relationship id and artist id are required." },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const { error } = await supabase
    .from("artist_relationships")
    .delete()
    .eq("id", relationshipId)
    .eq("source_artist_id", artistId);

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true });
}
