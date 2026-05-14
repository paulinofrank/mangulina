import dotenv from "dotenv";
dotenv.config();

// =========================
// ENVIRONMENT VARIABLES
// =========================

export const SUPABASE_URL = process.env.SUPABASE_URL!;
export const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!;
export const MUSICBRAINZ_USER_AGENT =
  process.env.MUSICBRAINZ_USER_AGENT || "MangulinaIngest/1.0";

export const DELAY_MS = parseInt(process.env.DELAY_MS || "2000", 10);
export const TEST_MODE = process.env.TEST_MODE === "true";
export const TEST_LIMIT = parseInt(process.env.TEST_LIMIT || "10", 10);

export const COVER_ART_BUCKET = process.env.COVER_ART_BUCKET || "cover-art";

// =========================
// HELPERS
// =========================

export const sleep = (ms: number) =>
  new Promise((resolve) => setTimeout(resolve, ms));

export const log = (...args: any[]) =>
  console.log(new Date().toISOString(), ...args);

export const safeJson = (obj: any) => {
  try {
    return JSON.stringify(obj);
  } catch {
    return String(obj);
  }
};

// =========================
// DATE NORMALIZATION
// =========================
// MusicBrainz sometimes returns:
// "1989"
// "1989-05"
// "1989-05-12"
// PostgreSQL DATE requires YYYY-MM-DD

export function normalizeMBDate(dateStr: string | null): string | null {
  if (!dateStr) return null;

  // YYYY
  if (/^\d{4}$/.test(dateStr)) {
    return `${dateStr}-01-01`;
  }

  // YYYY-MM
  if (/^\d{4}-\d{2}$/.test(dateStr)) {
    return `${dateStr}-01`;
  }

  // YYYY-MM-DD (valid)
  if (/^\d{4}-\d{2}-\d{2}$/.test(dateStr)) {
    return dateStr;
  }

  // Anything else → null
  return null;
}
