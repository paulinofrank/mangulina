import { NextResponse } from "next/server";
import { getAdminEmailAllowlist } from "@/lib/auth";
import {
  getSupabaseServiceClient,
  hashInviteToken,
  normalizeAdminEmail,
  normalizeAdminRole,
} from "@/lib/adminAccess";

function normalizeEmail(value: unknown) {
  return normalizeAdminEmail(value);
}

function normalizePassword(value: unknown) {
  return typeof value === "string" ? value : "";
}

async function findAuthUserIdByEmail(
  supabaseAdmin: ReturnType<typeof getSupabaseServiceClient>,
  email: string,
) {
  const { data, error } = await supabaseAdmin.auth.admin.listUsers({
    page: 1,
    perPage: 1000,
  });

  if (error) return null;

  return (
    data.users.find(
      (user) => normalizeEmail(user.email) === email,
    )?.id ?? null
  );
}

export async function POST(request: Request) {
  let body: { email?: unknown; password?: unknown; inviteToken?: unknown };

  try {
    body = await request.json();
  } catch {
    return NextResponse.json(
      { ok: false, error: "Invalid signup request." },
      { status: 400 },
    );
  }

  const email = normalizeEmail(body.email);
  const password = normalizePassword(body.password);
  const inviteToken =
    typeof body.inviteToken === "string" ? body.inviteToken.trim() : "";

  if (!email || !password) {
    return NextResponse.json(
      { ok: false, error: "Email and password are required." },
      { status: 400 },
    );
  }

  if (password.length < 8) {
    return NextResponse.json(
      { ok: false, error: "Password must be at least 8 characters." },
      { status: 400 },
    );
  }

  const allowlist = getAdminEmailAllowlist();
  let supabaseAdmin: ReturnType<typeof getSupabaseServiceClient> | null = null;
  let invitedBy: string | null = null;
  let role = "owner";
  let inviteId: string | null = null;

  if (inviteToken) {
    supabaseAdmin = getSupabaseServiceClient();
    const { data: invite, error: inviteError } = await supabaseAdmin
      .from("admin_invites")
      .select("id,email,role,expires_at,accepted_at,created_by")
      .eq("token_hash", hashInviteToken(inviteToken))
      .maybeSingle();

    if (inviteError || !invite) {
      return NextResponse.json(
        { ok: false, error: "Invite link is invalid." },
        { status: 403 },
      );
    }

    if (invite.accepted_at) {
      return NextResponse.json(
        { ok: false, error: "Invite link has already been used." },
        { status: 403 },
      );
    }

    if (new Date(invite.expires_at).getTime() <= Date.now()) {
      return NextResponse.json(
        { ok: false, error: "Invite link has expired." },
        { status: 403 },
      );
    }

    if (normalizeEmail(invite.email) !== email) {
      return NextResponse.json(
        { ok: false, error: "Invite link was issued for a different email." },
        { status: 403 },
      );
    }

    role = normalizeAdminRole(invite.role);
    invitedBy = invite.created_by ?? null;
    inviteId = invite.id;
  } else if (allowlist.includes(email)) {
    role = "owner";
  } else {
    return NextResponse.json(
      { ok: false, error: "Signup requires an admin invite link." },
      { status: 403 },
    );
  }

  supabaseAdmin = supabaseAdmin ?? getSupabaseServiceClient();
  const { data, error } = await supabaseAdmin.auth.admin.createUser({
    email,
    password,
    email_confirm: true,
    user_metadata: {
      admin_role: role,
    },
  });

  let userId = data.user?.id ?? null;
  let accountAlreadyExisted = false;

  if (error) {
    userId = await findAuthUserIdByEmail(supabaseAdmin, email);
    accountAlreadyExisted = Boolean(userId);
  }

  if (error && !userId) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 400 },
    );
  }

  if (!userId) {
    return NextResponse.json(
      { ok: false, error: "No auth user was created." },
      { status: 500 },
    );
  }

  if (accountAlreadyExisted) {
    const { error: updateError } = await supabaseAdmin.auth.admin.updateUserById(
      userId,
      {
        password,
        email_confirm: true,
        user_metadata: {
          admin_role: role,
        },
      },
    );

    if (updateError) {
      return NextResponse.json(
        { ok: false, error: updateError.message },
        { status: 400 },
      );
    }
  }

  const { error: memberError } = await supabaseAdmin.from("admin_members").upsert(
    {
      user_id: userId,
      email,
      role,
      status: "active",
      invited_by: invitedBy,
      updated_at: new Date().toISOString(),
    },
    { onConflict: "user_id" },
  );

  if (memberError) {
    return NextResponse.json(
      { ok: false, error: memberError.message },
      { status: 500 },
    );
  }

  if (inviteId) {
    await supabaseAdmin
      .from("admin_invites")
      .update({ accepted_at: new Date().toISOString() })
      .eq("id", inviteId);
  }

  return NextResponse.json({
    ok: true,
    message: accountAlreadyExisted
      ? "Account already exists. Password updated; you can sign in now."
      : "Account created. You can sign in now.",
  });
}
