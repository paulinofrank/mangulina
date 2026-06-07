import { createServerClient } from "@supabase/auth-helpers-nextjs";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { getSupabasePublicConfig } from "@/lib/supabaseConfig";

export function isAdminEmail(email: string | undefined) {
  const allowlist = getAdminEmailAllowlist();

  if (allowlist.length === 0) return Boolean(email);
  return Boolean(email && allowlist.includes(email.toLowerCase()));
}

export function getAdminEmailAllowlist() {
  return (
    process.env.MANGULINA_ADMIN_EMAILS ||
    process.env.ADMIN_EMAILS ||
    process.env.NEXT_PUBLIC_ADMIN_EMAILS ||
    ""
  )
    .split(",")
    .map((item) => item.trim().toLowerCase())
    .filter(Boolean);
}

export async function createServerSupabaseAuthClient() {
  const cookieStore = await cookies();
  const { supabaseUrl, supabaseAnonKey } = getSupabasePublicConfig();

  return createServerClient(supabaseUrl, supabaseAnonKey, {
    cookies: {
      getAll() {
        return cookieStore.getAll();
      },
      setAll(cookiesToSet) {
        try {
          cookiesToSet.forEach(({ name, value, options }) => {
            cookieStore.set(name, value, options);
          });
        } catch {
          // Server components cannot always set cookies. Middleware refreshes
          // sessions before protected pages and route handlers run.
        }
      },
    },
  });
}

export async function getCurrentUser() {
  const supabase = await createServerSupabaseAuthClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  return user;
}

export async function requireAdminUser() {
  const user = await getCurrentUser();

  if (!isAdminEmail(user?.email)) {
    redirect("/admin/login");
  }

  return user;
}
