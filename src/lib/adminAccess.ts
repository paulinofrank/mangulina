import { createHash, randomBytes } from "crypto";
import { createClient } from "@supabase/supabase-js";
import type { User } from "@supabase/supabase-js";
import { getAdminEmailAllowlist } from "@/lib/auth";
import { getSupabasePublicConfig } from "@/lib/supabaseConfig";

export type AdminRole = "owner" | "admin" | "editor";

export type AdminMember = {
  id: string;
  user_id: string | null;
  email: string;
  role: AdminRole;
  status: "active" | "disabled";
  created_at: string;
};

export type AdminAccessProfile = {
  email: string;
  role: AdminRole;
  source: "bootstrap" | "member";
};

export type AdminInvite = {
  id: string;
  email: string;
  role: AdminRole;
  expires_at: string;
  accepted_at: string | null;
  created_at: string;
};

export function getSupabaseServiceClient() {
  const { supabaseUrl } = getSupabasePublicConfig();
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!serviceRoleKey) {
    throw new Error("Missing SUPABASE_SERVICE_ROLE_KEY for admin operations.");
  }

  return createClient(supabaseUrl, serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });
}

export function normalizeAdminEmail(email: unknown) {
  return typeof email === "string" ? email.trim().toLowerCase() : "";
}

export function normalizeAdminRole(role: unknown): AdminRole {
  return role === "owner" || role === "admin" || role === "editor"
    ? role
    : "editor";
}

export function createInviteToken() {
  return randomBytes(32).toString("base64url");
}

export function hashInviteToken(token: string) {
  return createHash("sha256").update(token).digest("hex");
}

export function isBootstrapAdminEmail(email: string | undefined) {
  const normalizedEmail = normalizeAdminEmail(email);
  const allowlist = getAdminEmailAllowlist();

  return Boolean(
    normalizedEmail &&
      allowlist.length > 0 &&
      allowlist.includes(normalizedEmail),
  );
}

export async function getAdminMemberByEmail(email: string) {
  const normalizedEmail = normalizeAdminEmail(email);
  if (!normalizedEmail) return null;

  const supabase = getSupabaseServiceClient();
  const { data, error } = await supabase
    .from("admin_members")
    .select("id,user_id,email,role,status,created_at")
    .ilike("email", normalizedEmail)
    .eq("status", "active")
    .maybeSingle();

  if (error) return null;
  return data as AdminMember | null;
}

export async function hasAdminAccess(user: User | null) {
  return Boolean(await getAdminAccessProfile(user));
}

export async function canManageAdminAccess(user: User | null) {
  const profile = await getAdminAccessProfile(user);
  return profile?.role === "owner" || profile?.role === "admin";
}

export async function getAdminAccessProfile(
  user: User | null,
): Promise<AdminAccessProfile | null> {
  if (!user?.email) return null;

  const email = normalizeAdminEmail(user.email);

  if (isBootstrapAdminEmail(email)) {
    return {
      email,
      role: "owner",
      source: "bootstrap",
    };
  }

  const member = await getAdminMemberByEmail(email);
  if (!member) return null;

  return {
    email: member.email,
    role: member.role,
    source: "member",
  };
}

export async function ensureAdminMemberForBootstrapUser(user: User) {
  if (!isBootstrapAdminEmail(user.email)) return null;

  const email = normalizeAdminEmail(user.email);
  const supabase = getSupabaseServiceClient();
  const { data, error } = await supabase
    .from("admin_members")
    .upsert(
      {
        user_id: user.id,
        email,
        role: "owner",
        status: "active",
        updated_at: new Date().toISOString(),
      },
      { onConflict: "user_id" },
    )
    .select("id,user_id,email,role,status,created_at")
    .maybeSingle();

  if (error) return null;
  return data as AdminMember | null;
}
