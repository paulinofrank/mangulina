import { NextResponse } from "next/server";
import { getCurrentUser } from "@/lib/auth";
import {
  canManageAdminAccess,
  getAdminAccessProfile,
  type AdminRole,
} from "@/lib/adminAccess";

const roleRank: Record<AdminRole, number> = {
  editor: 1,
  admin: 2,
  owner: 3,
};

export async function requireAdminApiRole(minimumRole: AdminRole = "editor") {
  const user = await getCurrentUser();
  const profile = await getAdminAccessProfile(user);

  if (!profile || roleRank[profile.role] < roleRank[minimumRole]) {
    return {
      user,
      profile,
      response: NextResponse.json(
        { ok: false, error: "Insufficient admin permissions." },
        { status: profile ? 403 : 401 },
      ),
    };
  }

  return { user, profile, response: null };
}

export async function requireAccessManagerApi() {
  const user = await getCurrentUser();

  if (!(await canManageAdminAccess(user))) {
    return {
      user,
      response: NextResponse.json(
        { ok: false, error: "Access management permission required." },
        { status: user ? 403 : 401 },
      ),
    };
  }

  return { user, response: null };
}
