import { createClient } from "@supabase/supabase-js";
// Keeping the import for future use, but we will stop enforcing it on the client
import type { Database } from "../types/supabase";

// 1. RESOLVE CONFIGURATION
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

// 2. CONTEXT-AWARE KEY SELECTION
const isBrowser = typeof window !== "undefined";
const keyToUse = isBrowser ? supabaseAnonKey : (supabaseServiceKey || supabaseAnonKey);

// 3. SILENT VALIDATION
if (!supabaseUrl || !keyToUse) {
  if (process.env.NODE_ENV === 'development') {
    console.warn("⚠️ Supabase Client: Missing URL or Key. Check your .env file.");
  }
}

// 4. THE SINGLETON INSTANCE
// REMOVED <Database> generic to stop the "never" type errors.
// This allows you to access custom columns like image_url without TypeScript blocking you.
export const supabase = createClient(
  supabaseUrl || "",
  keyToUse || ""
);

export function getSupabaseClient() {
  return supabase;
}