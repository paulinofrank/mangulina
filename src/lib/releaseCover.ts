export type ReleaseCoverSize = 150 | 300;

const DEFAULT_SUPABASE_URL = "https://srulenjahemkuxtkfmzt.supabase.co";

export function getPublicReleaseCoverUrl(
  releaseId: string,
  size: ReleaseCoverSize = 300,
) {
  const supabaseUrl =
    process.env.NEXT_PUBLIC_SUPABASE_URL ??
    process.env.SUPABASE_URL ??
    DEFAULT_SUPABASE_URL;

  return `${supabaseUrl}/storage/v1/object/public/cover-art/${size}px/${releaseId}.webp`;
}
