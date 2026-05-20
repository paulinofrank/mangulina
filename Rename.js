import 'dotenv/config';
import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

async function listAllFiles() {
  const all = [];
  let offset = 0;
  const limit = 1000;

  while (true) {
    const { data, error } = await supabase.storage
      .from("cover-art")
      .list("", { limit, offset });

    if (error) {
      console.error("List error:", error);
      break;
    }

    if (!data || data.length === 0) break;

    all.push(...data);
    offset += limit;
  }

  return all;
}

async function renameAllMbidFiles() {
  const files = await listAllFiles();
  console.log(`Found ${files.length} files in bucket.`);

  for (const file of files) {
    const base = file.name.replace(".jpg", "");

    // Look up release by MBID
    const { data: release } = await supabase
      .from("releases")
      .select("id, mbid")
      .eq("mbid", base)
      .single();

    if (!release) continue;

    const oldPath = `${release.mbid}.jpg`;
    const newPath = `${release.id}.jpg`;

    console.log(`Renaming ${oldPath} → ${newPath}`);

    const { error: copyError } = await supabase.storage
      .from("cover-art")
      .copy(oldPath, newPath);

    if (copyError) {
      console.log(`❌ Failed to copy ${oldPath}: ${copyError.message}`);
      continue;
    }

    const { error: removeError } = await supabase.storage
      .from("cover-art")
      .remove([oldPath]);

    if (removeError) {
      console.log(`⚠️ Copied but could not delete ${oldPath}`);
    } else {
      console.log(`✅ Renamed ${oldPath} → ${newPath}`);
    }
  }
}

renameAllMbidFiles();
