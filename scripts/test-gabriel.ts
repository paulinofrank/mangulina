import fetch from 'node-fetch';

/**
 * RAW API TEST - GABRIEL PAGÁN
 * This script verifies exactly what MusicBrainz sends in the 'relations' array.
 */
async function debugGabrielSocials() {
  const GABRIEL_MBID = '04395b45-d205-4a2a-b952-f8d2f33928ad';
  const url = `https://musicbrainz.org/ws/2/artist/${GABRIEL_MBID}?fmt=json&inc=url-rels`;

  console.log(`📡 Fetching raw relations for Gabriel Pagán...`);
  console.log(`🔗 URL: ${url}\n`);

  try {
    const res = await fetch(url, {
      headers: { 
        'User-Agent': 'WikiMusicDO/Debug (https://wikimusic.do; fvpg@hotmail.com)' 
      }
    });

    if (!res.ok) {
      console.error(`❌ API Error: ${res.status} ${res.statusText}`);
      return;
    }

    const data: any = await res.json();
    
    if (!data.relations || data.relations.length === 0) {
      console.log("⚠️ No relations found in the API response.");
      return;
    }

    console.log(`✅ Success! Found ${data.relations.length} total relationships.\n`);
    console.log("--- RAW RELATIONSHIP LIST ---");
    
    data.relations.forEach((rel: any, index: number) => {
      const type = rel.type;
      const resource = rel.url?.resource;
      
      console.log(`[${index + 1}] Type: "${type}"`);
      console.log(`    Resource: ${resource}`);
      console.log('------------------------------');
    });

    // Targeted Check
    const hasSocials = data.relations.some((r: any) => r.type === 'social networking');
    if (!hasSocials) {
      console.log("\n🛑 OBSERVATION: The 'social networking' type is MISSING from the JSON.");
    }

  } catch (error: any) {
    console.error(`❌ Script Error: ${error.message}`);
  }
}

// Fixed the function call name here
debugGabrielSocials();