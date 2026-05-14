import 'dotenv/config';
import fetch from 'node-fetch';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(process.env.SUPABASE_URL!, process.env.SUPABASE_SERVICE_ROLE_KEY!);
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function fetchWikidata(mbid: string, name: string) {
  // Hybrid Query: Search by MBID OR (Name + Dominican Citizenship)
  const sparqlQuery = `
    SELECT ?item ?youtube
      (GROUP_CONCAT(DISTINCT ?occLabel; separator=", ") AS ?occupations)
      (GROUP_CONCAT(DISTINCT ?insLabel; separator=", ") AS ?instruments)
      (GROUP_CONCAT(DISTINCT ?genLabel; separator=", ") AS ?genres)
      (GROUP_CONCAT(DISTINCT ?awLabel; separator=", ") AS ?awards)
    WHERE {
      { ?item wdt:P434 "${mbid}". }
      UNION
      { 
        ?item wdt:P31 wd:Q5; 
              wdt:P27 wd:Q786; 
              rdfs:label "${name.replace(/"/g, '\\"')}"@es.
      }
      
      OPTIONAL { ?item wdt:P106 ?occ. ?occ rdfs:label ?occLabel. FILTER(LANG(?occLabel) IN ("es", "en")) }
      OPTIONAL { ?item wdt:P1303 ?ins. ?ins rdfs:label ?insLabel. FILTER(LANG(?insLabel) IN ("es", "en")) }
      OPTIONAL { ?item wdt:P136 ?gen. ?gen rdfs:label ?genLabel. FILTER(LANG(?genLabel) IN ("es", "en")) }
      OPTIONAL { ?item wdt:P166 ?aw. ?aw rdfs:label ?awLabel. FILTER(LANG(?awLabel) IN ("es", "en")) }
      OPTIONAL { ?item wdt:P1651 ?youtube. }
      
      SERVICE wikibase:label { bd:serviceParam wikibase:language "es,en". }
    } GROUP BY ?item ?youtube LIMIT 1
  `;

  const url = `https://query.wikidata.org/sparql?query=${encodeURIComponent(sparqlQuery)}&format=json`;
  
  try {
    const res = await fetch(url, { 
      headers: { 'User-Agent': 'WikiMusicDO/1.2 (paulinofrank@aol.com)', 'Accept': 'application/sparql-results+json' } 
    });

    if (!res.ok) return null;
    const data: any = await res.json();
    const b = data.results.bindings[0];
    
    if (!b) return null;

    const toArray = (val: string) => val ? val.split(', ').map(s => s.trim()) : [];

    return {
      wikidata_id: b.item.value.split('/').pop(),
      youtube: b.youtube?.value || null,
      occupations: toArray(b.occupations?.value),
      instruments: toArray(b.instruments?.value),
      genres: toArray(b.genres?.value),
      awards: toArray(b.awards?.value)
    };
  } catch (e) {
    return null;
  }
}

async function startRepair() {
  const { data: artists, error } = await supabase
    .from('artists')
    .select('id, name, mbid')
    .or('occupations.is.null, occupations.eq.{}');

  if (error || !artists) {
    console.error("Supabase connection error.");
    return;
  }

  console.log(`🚀 Starting repair for ${artists.length} artists...\n`);

  for (let i = 0; i < artists.length; i++) {
    const artist = artists[i];
    const data = await fetchWikidata(artist.mbid!, artist.name);

    if (data && (data.occupations.length > 0 || data.genres.length > 0)) {
      const { error: upError } = await supabase
        .from('artists')
        .update({
          wikidata_id: data.wikidata_id,
          youtube: data.youtube,
          occupations: data.occupations,
          instruments: data.instruments,
          genres: data.genres,
          awards: data.awards
        })
        .eq('id', artist.id);

      if (!upError) {
        console.log(`[${i + 1}/${artists.length}] ✅ ${artist.name.padEnd(25)} | Occ: [${data.occupations.join(', ')}] | Ins: [${data.instruments.join(', ')}]`);
      }
    } else {
      console.log(`[${i + 1}/${artists.length}] ❌ ${artist.name.padEnd(25)} | No structured data found.`);
    }
    
    await sleep(1200); // 1.2s delay for visibility and safety
  }
}

startRepair();