// supabase/functions/copy-cover-art/index.ts
import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async () => {
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  );

  const sourceBucket = "cover-art";
  const targetBucket = "cover-art-originals";

  console.log("Listing files in source bucket…");

  const { data: files, error: listError } = await supabase.storage
    .from(sourceBucket)
    .list("", { limit: 10000, recursive: true });

  if (listError) {
    console.error("Error listing files:", listError);
    return new Response("Failed to list files", { status: 500 });
  }

  console.log(`Found ${files.length} files to copy`);

  for (const file of files) {
    const filePath = file.name;

    console.log(`Copying ${filePath}`);

    const { error: copyError } = await supabase.storage
      .from(sourceBucket)
      .copy(filePath, `${targetBucket}/${filePath}`);

    if (copyError) {
      console.error(`❌ Failed to copy ${filePath}:`, copyError);
    } else {
      console.log(`✔ Copied ${filePath}`);
    }
  }

  return new Response("Copy complete", { status: 200 });
});
