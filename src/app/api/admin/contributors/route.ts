import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";

type ContributorPayload = {
  name: string;
  slug: string;
  role: string;
  bio: string | null;
  location: string | null;
  specialty: string[];
  website: string | null;
  facebook: string | null;
  instagram: string | null;
  youtube: string | null;
  active: boolean;
  display_order: number;
};

type ContributorRequest = {
  contributorId?: string | null;
  contributorData?: ContributorPayload;
};

const selectFields =
  "id, name, slug, role, bio, location, specialty, website, facebook, instagram, youtube, active, display_order, created_at";

function isContributorPayload(value: unknown): value is ContributorPayload {
  if (!value || typeof value !== "object") return false;

  const payload = value as Record<string, unknown>;
  return (
    typeof payload.name === "string" &&
    typeof payload.slug === "string" &&
    typeof payload.role === "string" &&
    Array.isArray(payload.specialty) &&
    payload.specialty.every((item) => typeof item === "string") &&
    typeof payload.active === "boolean" &&
    typeof payload.display_order === "number" &&
    Number.isFinite(payload.display_order)
  );
}

function errorMessage(message: string) {
  if (message.toLowerCase().includes("duplicate key") && message.includes("slug")) {
    return "That slug is already used by another contributor.";
  }

  return message;
}

export async function GET() {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { data, error } = await getSupabaseClient()
    .from("contributors")
    .select(selectFields)
    .order("display_order", { ascending: true })
    .order("name", { ascending: true });

  if (error) {
    return NextResponse.json(
      { ok: false, error: errorMessage(error.message), contributors: [] },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, contributors: data ?? [] });
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const body = (await request.json()) as ContributorRequest;

  if (!isContributorPayload(body.contributorData)) {
    return NextResponse.json(
      { ok: false, error: "Contributor data is invalid." },
      { status: 400 },
    );
  }

  const contributorData = body.contributorData;
  if (!contributorData.name.trim() || !contributorData.slug.trim() || !contributorData.role.trim()) {
    return NextResponse.json(
      { ok: false, error: "Name, slug, and role are required." },
      { status: 400 },
    );
  }

  const payload = {
    ...contributorData,
    name: contributorData.name.trim(),
    slug: contributorData.slug.trim(),
    role: contributorData.role.trim(),
  };
  const supabase = getSupabaseClient();
  const response = body.contributorId
    ? await supabase
        .from("contributors")
        .update(payload)
        .eq("id", body.contributorId)
        .select(selectFields)
        .maybeSingle()
    : await supabase.from("contributors").insert(payload).select(selectFields).maybeSingle();

  if (response.error) {
    return NextResponse.json(
      { ok: false, error: errorMessage(response.error.message) },
      { status: response.error.code === "23505" ? 409 : 500 },
    );
  }

  if (!response.data) {
    return NextResponse.json(
      { ok: false, error: "No contributor row was saved." },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, contributor: response.data });
}

export async function PATCH(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const body = (await request.json()) as { contributorId?: string; active?: boolean };
  if (!body.contributorId || typeof body.active !== "boolean") {
    return NextResponse.json(
      { ok: false, error: "Contributor id and active status are required." },
      { status: 400 },
    );
  }

  const { data, error } = await getSupabaseClient()
    .from("contributors")
    .update({ active: body.active })
    .eq("id", body.contributorId)
    .select(selectFields)
    .maybeSingle();

  if (error) {
    return NextResponse.json(
      { ok: false, error: errorMessage(error.message) },
      { status: 500 },
    );
  }

  if (!data) {
    return NextResponse.json(
      { ok: false, error: "Contributor was not found." },
      { status: 404 },
    );
  }

  return NextResponse.json({ ok: true, contributor: data });
}
