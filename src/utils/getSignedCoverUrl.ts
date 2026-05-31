import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY! // server-side only
);

export async function getSignedCoverUrl(releaseId: string) {
  const filePath = `${releaseId}.webp`;

  const { data, error } = await supabase.storage
    .from("cover-art")
    .createSignedUrl(filePath, 60 * 60); // 1 hour

  if (error || !data?.signedUrl) {
    return null;
  }

  return data.signedUrl;
}
