import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

export const recordingContextValues = [
  "secular",
  "christian",
  "soundtrack",
  "children",
  "patriotic",
] as const;

const uuidPattern =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

export function jsonError(error: string, status = 400) {
  return NextResponse.json({ ok: false, error }, { status });
}

export function nullableString(value: unknown) {
  if (typeof value !== "string") return null;
  const trimmed = value.trim();
  return trimmed ? trimmed : null;
}

export function nullableUuid(value: unknown, label: string) {
  const normalized = nullableString(value);
  if (!normalized) return { value: null, error: null };
  if (!uuidPattern.test(normalized)) {
    return { value: null, error: `${label} must be a valid UUID.` };
  }
  return { value: normalized, error: null };
}

export function nullableInteger(value: unknown, label: string, minimum?: number) {
  if (value === null || value === undefined || value === "") return { value: null, error: null };
  const numberValue = Number(value);
  if (!Number.isInteger(numberValue)) {
    return { value: null, error: `${label} must be an integer.` };
  }
  if (minimum !== undefined && numberValue < minimum) {
    return { value: null, error: `${label} must be ${minimum} or greater.` };
  }
  return { value: numberValue, error: null };
}

export function nullableBigintId(value: unknown, label: string) {
  return nullableInteger(value, label, 1);
}

export function nullableJson(value: unknown, label: string) {
  if (value === null || value === undefined || value === "") return { value: null, error: null };
  if (typeof value === "object") return { value, error: null };
  if (typeof value !== "string") return { value: null, error: `${label} must be valid JSON.` };

  try {
    return { value: JSON.parse(value), error: null };
  } catch {
    return { value: null, error: `${label} must be valid JSON.` };
  }
}

export function slugify(value: string) {
  return value
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/&/g, " and ")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .replace(/-{2,}/g, "-");
}

export function getYearFromDate(value: unknown) {
  if (typeof value !== "string") return null;
  const year = value.slice(0, 4);
  return /^\d{4}$/.test(year) ? Number(year) : null;
}

export async function getArtistNames(ids: Array<string | null | undefined>) {
  const uniqueIds = [...new Set(ids.filter((id): id is string => Boolean(id)))];
  const artistMap = new Map<string, string>();
  if (uniqueIds.length === 0) return artistMap;

  const { data } = await getSupabaseClient()
    .from("artists")
    .select("id,name")
    .in("id", uniqueIds);

  for (const artist of (data ?? []) as Array<{ id: string; name: string }>) {
    artistMap.set(artist.id, artist.name);
  }

  return artistMap;
}

export async function getReleaseTitles(ids: Array<string | null | undefined>) {
  const uniqueIds = [...new Set(ids.filter((id): id is string => Boolean(id)))];
  const releaseMap = new Map<string, string>();
  if (uniqueIds.length === 0) return releaseMap;

  const { data } = await getSupabaseClient()
    .from("releases")
    .select("id,title")
    .in("id", uniqueIds);

  for (const release of (data ?? []) as Array<{ id: string; title: string }>) {
    releaseMap.set(release.id, release.title);
  }

  return releaseMap;
}

export async function countRows(table: string, column: string, value: string) {
  const { count, error } = await getSupabaseClient()
    .from(table)
    .select("id", { count: "exact", head: true })
    .eq(column, value);

  if (error) throw error;
  return count ?? 0;
}

