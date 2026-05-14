import fetch from "node-fetch";
import { SupabaseClient } from "@supabase/supabase-js";

export async function fetchCoverArtMetadata(mbid: string) {
  const url = `https://coverartarchive.org/release/${mbid}`;
  const res = await fetch(url, {
    headers: { "User-Agent": "MangulinaIngest/1.0" }
  });

  if (!res.ok) {
    throw new Error(`CAA metadata fetch failed: ${res.status}`);
  }

  return res.json();
}

export async function downloadImage(url: string): Promise<Buffer> {
  const res = await fetch(url, {
    headers: { "User-Agent": "MangulinaIngest/1.0" }
  });

  if (!res.ok) {
    throw new Error(`Image download failed: ${res.status}`);
  }

  const buffer = await res.arrayBuffer();
  return Buffer.from(buffer);
}

export async function uploadToStorage(
  supabase: SupabaseClient,
  bucket: string,
  path: string,
  buffer: Buffer,
  contentType = "image/jpeg"
) {
  const { data, error } = await supabase.storage
    .from(bucket)
    .upload(path, buffer, {
      contentType,
      upsert: true
    });

  if (error) throw error;
  return data;
}
