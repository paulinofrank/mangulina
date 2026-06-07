// src/lib/supabase.ts
import { createBrowserClient } from "@supabase/auth-helpers-nextjs";
import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import { getSupabasePublicConfig } from "@/lib/supabaseConfig";

let cachedClient: SupabaseClient | null = null;

function resolveSupabaseConfig() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const isBrowser = typeof window !== "undefined";
  const keyToUse = isBrowser ? supabaseAnonKey : (supabaseServiceKey || supabaseAnonKey);

  return { supabaseUrl, keyToUse };
}

function createSupabaseClient() {
  if (cachedClient) return cachedClient;

  if (typeof window !== "undefined") {
    const { supabaseUrl, supabaseAnonKey } = getSupabasePublicConfig();
    cachedClient = createBrowserClient(supabaseUrl, supabaseAnonKey);
    return cachedClient;
  }

  const { supabaseUrl, keyToUse } = resolveSupabaseConfig();

  if (!supabaseUrl || !keyToUse) {
    throw new Error(
      "Missing Supabase configuration. Set NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY in the deployment environment.",
    );
  }

  cachedClient = createClient(supabaseUrl, keyToUse);
  return cachedClient;
}

export const supabase = new Proxy({} as SupabaseClient, {
  get(_target, property, receiver) {
    return Reflect.get(createSupabaseClient(), property, receiver);
  },
});

export function getSupabaseClient() {
  return supabase;
}
