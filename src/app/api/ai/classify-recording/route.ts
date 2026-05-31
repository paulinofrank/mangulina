import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

type ClassifyRecordingBody = {
  recording_id?: unknown;
  genre_id?: unknown;
  subgenre_id?: unknown;
};

function isNonEmptyString(value: unknown): value is string {
  return typeof value === "string" && value.trim().length > 0;
}

function isIdValue(value: unknown): value is string | number {
  return (
    (typeof value === "string" && value.trim().length > 0) ||
    (typeof value === "number" && Number.isInteger(value))
  );
}

function normalizeIdValue(value: string | number) {
  return typeof value === "string" ? value.trim() : value;
}

export async function POST(req: Request) {
  let body: ClassifyRecordingBody;

  try {
    body = await req.json();
  } catch {
    return NextResponse.json(
      { ok: false, error: "Invalid JSON body" },
      { status: 400 }
    );
  }

  if (!isNonEmptyString(body.recording_id) || !isIdValue(body.genre_id)) {
    return NextResponse.json(
      { ok: false, error: "recording_id and genre_id are required" },
      { status: 400 }
    );
  }

  if (body.subgenre_id != null && !isIdValue(body.subgenre_id)) {
    return NextResponse.json(
      { ok: false, error: "subgenre_id must be a string or number when provided" },
      { status: 400 }
    );
  }

  const recordingId = body.recording_id.trim();
  const genreId = normalizeIdValue(body.genre_id);
  const subgenreId = isIdValue(body.subgenre_id)
    ? normalizeIdValue(body.subgenre_id)
    : null;

  const supabaseUrl = process.env.SUPABASE_URL ?? process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !serviceRoleKey) {
    return NextResponse.json(
      { ok: false, error: "Supabase service credentials are not configured" },
      { status: 500 }
    );
  }

  const supabase = createClient(
    supabaseUrl,
    serviceRoleKey
  );

  const { data, error } = await supabase.rpc("ai_update_recording_genre", {
    p_recording_id: recordingId,
    p_genre_id: genreId,
    p_subgenre_id: subgenreId,
  });

  if (error) {
    return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  }

  return NextResponse.json({ ok: true, data });
}
