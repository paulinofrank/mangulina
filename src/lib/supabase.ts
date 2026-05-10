import { createClient } from "@supabase/supabase-js";

const url =
  process.env.NEXT_PUBLIC_SUPABASE_URL ||
  process.env.SUPABASE_URL;

const anon = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const service = process.env.SUPABASE_SERVICE_ROLE_KEY;

// Browser → use anon key
// Node scripts → use service role key
const key = typeof window === "undefined" ? service : anon;

if (!url || !key) {
  throw new Error("Missing Supabase environment variables");
}

// 1. Define the variable with 'let' so it CAN be reassigned
let supabaseInstance: ReturnType<typeof createClient> | null = null;

// 2. The function that manages the singleton logic
export function getSupabaseClient() {
  if (!supabaseInstance) {
    supabaseInstance = createClient(url as string, key as string);
  }
  return supabaseInstance;
}

// 3. Export the actual client instance for easy use in your Admin page
// We call it 'supabase' here so your imports look clean
export const supabase = getSupabaseClient();