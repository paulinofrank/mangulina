import { createClient } from "@supabase/supabase-js";

function getStorageClient() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY
    || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
    || process.env.SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) return null;

  return createClient(supabaseUrl, supabaseKey);
}

export async function getSignedCoverUrl(releaseId: string) {
  const supabase = getStorageClient();
  if (!supabase) return null;

  const filePath = `${releaseId}.webp`;

  const { data, error } = await supabase.storage
    .from("cover-art")
    .createSignedUrl(filePath, 60 * 60); // 1 hour

  if (error || !data?.signedUrl) {
    return null;
  }

  return data.signedUrl;
}
