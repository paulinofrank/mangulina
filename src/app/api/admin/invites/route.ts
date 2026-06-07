import { NextResponse } from "next/server";
import {
  createInviteToken,
  getSupabaseServiceClient,
  hashInviteToken,
  normalizeAdminEmail,
  normalizeAdminRole,
} from "@/lib/adminAccess";
import { requireAccessManagerApi } from "@/lib/adminApiAuth";

function getOrigin(request: Request) {
  return new URL(request.url).origin;
}

export async function GET() {
  const { response } = await requireAccessManagerApi();

  if (response) return response;

  const supabase = getSupabaseServiceClient();
  const [{ data: invites, error: invitesError }, { data: members, error: membersError }] =
    await Promise.all([
      supabase
        .from("admin_invites")
        .select("id,email,role,expires_at,accepted_at,created_at")
        .order("created_at", { ascending: false })
        .limit(50),
      supabase
        .from("admin_members")
        .select("id,user_id,email,role,status,created_at")
        .order("created_at", { ascending: false })
        .limit(50),
    ]);

  if (invitesError || membersError) {
    return NextResponse.json(
      {
        ok: false,
        error: invitesError?.message || membersError?.message || "Unable to load admin access.",
      },
      { status: 500 },
    );
  }

  return NextResponse.json({
    ok: true,
    invites: invites ?? [],
    members: members ?? [],
  });
}

export async function POST(request: Request) {
  const { user, response } = await requireAccessManagerApi();

  if (response) return response;

  let body: { email?: unknown; role?: unknown };

  try {
    body = await request.json();
  } catch {
    return NextResponse.json(
      { ok: false, error: "Invalid invite request." },
      { status: 400 },
    );
  }

  const email = normalizeAdminEmail(body.email);
  const role = normalizeAdminRole(body.role);

  if (!email) {
    return NextResponse.json(
      { ok: false, error: "Invite email is required." },
      { status: 400 },
    );
  }

  const token = createInviteToken();
  const supabase = getSupabaseServiceClient();
  const { data, error } = await supabase
    .from("admin_invites")
    .insert({
      email,
      role,
      token_hash: hashInviteToken(token),
      created_by: user?.id ?? null,
    })
    .select("id,email,role,expires_at,accepted_at,created_at")
    .maybeSingle();

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 },
    );
  }

  const inviteUrl = `${getOrigin(request)}/admin/sign-up?invite=${encodeURIComponent(token)}`;
  const { error: emailError } = await supabase.auth.admin.inviteUserByEmail(
    email,
    {
      redirectTo: inviteUrl,
      data: {
        admin_role: role,
      },
    },
  );

  return NextResponse.json({
    ok: true,
    invite: data,
    inviteUrl,
    emailSent: !emailError,
    emailError: emailError?.message,
  });
}

export async function DELETE(request: Request) {
  const { response } = await requireAccessManagerApi();

  if (response) return response;

  let body: { inviteId?: unknown };

  try {
    body = await request.json();
  } catch {
    return NextResponse.json(
      { ok: false, error: "Invalid revoke request." },
      { status: 400 },
    );
  }

  const inviteId = typeof body.inviteId === "string" ? body.inviteId : "";

  if (!inviteId) {
    return NextResponse.json(
      { ok: false, error: "Invite id is required." },
      { status: 400 },
    );
  }

  const supabase = getSupabaseServiceClient();
  const { data, error } = await supabase
    .from("admin_invites")
    .delete()
    .eq("id", inviteId)
    .is("accepted_at", null)
    .select("id")
    .maybeSingle();

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 },
    );
  }

  if (!data?.id) {
    return NextResponse.json(
      { ok: false, error: "Invite was already accepted or does not exist." },
      { status: 409 },
    );
  }

  return NextResponse.json({ ok: true, id: data.id });
}
