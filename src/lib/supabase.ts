import { createClient } from "@supabase/supabase-js";
import type { Database } from "../types/supabase";

// 1. RESOLVE CONFIGURATION
// We check both the browser-safe and the server-only variables for maximum flexibility.
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

// 2. CONTEXT-AWARE KEY SELECTION
// Scripts and Server routes need the Service Key. The Browser MUST use the Anon Key.
const isBrowser = typeof window !== "undefined";
const keyToUse = isBrowser ? supabaseAnonKey : (supabaseServiceKey || supabaseAnonKey);

// 3. SILENT VALIDATION
if (!supabaseUrl || !keyToUse) {
  // Only logs during development to avoid cluttering production
  if (process.env.NODE_ENV === 'development') {
    console.warn("⚠️ Supabase Client: Missing URL or Key. Check your .env file.");
  }
}

// 4. THE SINGLETON INSTANCE
// Exporting both the instance and a getter for different coding styles.
export const supabase = createClient<Database>(
  supabaseUrl || "",
  keyToUse || ""
);

export function getSupabaseClient() {
  return supabase;
}