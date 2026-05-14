import { createClient } from "@supabase/supabase-js";
import * as dotenv from "dotenv";

// 1. Manually load envs to be safe
dotenv.config();

const url = process.env.SUPABASE_URL || process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !key) {
  throw new Error("Missing env variables. Run with: npx ts-node -r dotenv/config ...");
}

// 2. Create a COMPLETELY UNTYPED client
// By not passing <Database>, Supabase defaults to allowing any string for table names.
const supabase = createClient(url, key);

async function ingestWikidata() {
  console.log("🚀 Starting Wikidata ingestion (Untyped Mode)...");

  // Use 'as any' on the results so we can access .name, .id, etc.
  const { data: artists, error: fetchError } = await supabase
    .from('artists')
    .select('*');

  if (fetchError || !artists) {
    console.error("❌ Error fetching artists:", fetchError);
    return;
  }

  for (const artist of (artists as any[])) {
    try {
      const updateData = {
        birth_year: 1950, 
        death_year: null, 
        origin_region: "Santo Domingo",
        image_url: "https://example.com/photo.jpg",
      };

      // 3. Simple update
      const { error: updateError } = await supabase
        .from('artists')
        .update(updateData)
        .eq("id", artist.id);

      if (updateError) throw updateError;

      const wikidataData = {
        artist_id: artist.id,
        wikidata_id: "Q12345", 
        raw_json: { info: "data" },
        updated_at: new Date().toISOString(),
      };

      // 4. Simple insert
      const { error: rawError } = await supabase
        .from('wikidata_raw')
        .insert(wikidataData);

      if (rawError) throw rawError;

      console.log(`✅ Updated ${artist.name}`);
    } catch (err) {
      console.error(`❌ Error processing ${artist.name}:`, err);
    }
  }
}

ingestWikidata();