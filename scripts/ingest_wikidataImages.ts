import 'dotenv/config';
import fetch from 'node-fetch';
import { createClient } from '@supabase/supabase-js';
import { Buffer } from 'buffer';

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const WIKI_API = 'https://www.wikidata.org/w/api.php';
const BUCKET = 'artists-images';

// Descriptive User-Agent as required by Wikimedia
const WIKI_HEADERS = {
  'User-Agent': 'WikiMusicSync/1.2 (https://wikimusic.do; contact@wikimusic.do)'
};

async function run() {
  console.log('🖼️ Starting Image Sync for linked artists...');

  /**
   * 1. Target specifically:
   * - Artists WITH a wikidata_id
   * - Artists WITHOUT a valid image (NULL or the placeholder)
   */
  const { data: artists, error } = await supabase
    .from('artists')
    .select('id, name, wikidata_id, image_url')
    .not('wikidata_id', 'is', null)
    .or('image_url.is.null, image_url.eq.https://example.com/photo.jpg');

  if (error) {
    console.error('Supabase error:', error);
    return;
  }

  console.log(`Found ${artists?.length || 0} artists needing image updates.\n`);

  for (const artist of artists || []) {
    console.log(`🎤 Processing: ${artist.name} (${artist.wikidata_id})`);

    try {
      // 2. Fetch the filename (Property P18) from Wikidata
      const entityRes = await fetch(
        `${WIKI_API}?action=wbgetentities&ids=${artist.wikidata_id}&props=claims&format=json&origin=*`, 
        { headers: WIKI_HEADERS }
      );
      const entityData: any = await entityRes.json();
      
      const fileName = entityData.entities[artist.wikidata_id!]?.claims?.P18?.[0]?.mainsnak?.datavalue?.value;

      if (!fileName) {
        console.log(`  ℹ️ No image (P18) found on Wikidata.`);
        continue;
      }

      // 3. Download the image
      // width=1000 provides high quality for 4K designs while staying optimized
      const wikiUrl = `https://commons.wikimedia.org/wiki/Special:FilePath/${encodeURIComponent(fileName)}?width=1000`;
      console.log(`  > Downloading: ${fileName}`);
      
      const imageRes = await fetch(wikiUrl, { headers: WIKI_HEADERS });
      if (!imageRes.ok) throw new Error(`Wikimedia error: ${imageRes.statusText}`);

      const arrayBuffer = await imageRes.arrayBuffer();
      const buffer = Buffer.from(arrayBuffer);

      // 4. Upload to Supabase Storage
      const fileExt = fileName.split('.').pop()?.toLowerCase() || 'jpg';
      const storagePath = `${artist.id}/profile.${fileExt}`;

      const { error: uploadError } = await supabase.storage
        .from(BUCKET)
        .upload(storagePath, buffer, {
          contentType: imageRes.headers.get('content-type') || 'image/jpeg',
          upsert: true
        });

      if (uploadError) {
        console.error(`  ❌ Storage Error: ${uploadError.message}`);
        continue;
      }

      // 5. Update the Database Record
      const { data: pub } = supabase.storage.from(BUCKET).getPublicUrl(storagePath);
      
      const { error: updateError } = await supabase
        .from('artists')
        .update({ image_url: pub.publicUrl })
        .eq('id', artist.id);

      if (updateError) {
        console.error(`  ❌ DB Update Error: ${updateError.message}`);
      } else {
        console.log(`  ✅ Success! Image synced.`);
      }

    } catch (err: any) {
      console.error(`  ❌ Error processing ${artist.name}: ${err.message}`);
    }

    // Gentle delay to respect Wikimedia limits
    await new Promise(r => setTimeout(r, 500));
  }

  console.log('\n🎉 Image sync complete.');
}

run();