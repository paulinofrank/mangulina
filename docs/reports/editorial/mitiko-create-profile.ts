import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const manifestFile=base+'mitiko-profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(result:any)=>{if(result.error)throw Error(result.error.message);return result.data;};

async function duplicates(){
  const queries=await Promise.all([
    db.from('artists').select('id,name,status').eq('slug','mitiko'),
    db.from('artists').select('id,name,status').ilike('name','%mitiko%'),
    db.from('artists').select('id,name,status').ilike('name','%mítiko%'),
    db.from('artists').select('id,name,status').ilike('name','%mawon%'),
    db.from('artists').select('id,name,status').eq('first_name','José').eq('middle_name','Julio').eq('last_name','Bello').eq('second_last_name','Castillo'),
  ]);
  return [...new Map(queries.flatMap(q=>check(q)).map((a:any)=>[a.id,a])).values()];
}

const targetIds=[
  'b000b7d5-23f1-42a2-b089-f522a29a5d20',
  '350e5535-5229-4d49-903e-a5de047e7723',
  '3d4e3400-8661-46f7-ba48-54076a5d5087',
  '28a3745e-90d6-45cd-b8bd-798028f8deb8',
];

if(process.argv[2]==='prepare'){
  assert.ok(!fs.existsSync(manifestFile),'Preserve frozen manifest');
  assert.deepEqual(await duplicates(),[],'Duplicate artist candidate found');
  const targets=check(await db.from('artists').select('id,name,slug,status').in('id',targetIds));
  assert.equal(targets.length,4);
  assert.ok(targets.every((a:any)=>a.status==='published'));
  const source=JSON.parse(fs.readFileSync(base+'mitiko-profile-content.json','utf8'));
  const artist={id:randomUUID(),...source.artist};
  assert.equal(artist.status,'draft');
  assert.ok(!artist.genres.includes(artist.primary_genre));
  assert.ok(!artist.occupations.includes(artist.primary_role));
  const documents=Object.entries(source.bios).map(([locale,sections]:any)=>{
    const content:any[]=[];
    for(const [heading,prose] of sections){
      if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
      const nodes:any[]=[];
      let pos=0;
      for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){
        if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});
        const target=targets.find((a:any)=>a.name===hit[1]);
        assert.ok(target,`Missing published reference target: ${hit[1]}`);
        nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});
        pos=hit.index+hit[0].length;
      }
      if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});
      content.push({type:'paragraph',content:nodes});
    }
    const document={type:'doc',content};
    const validation=validateEditorialDocument(1,document);
    assert.equal(validation.ok,true,JSON.stringify(validation));
    return {locale,document};
  });
  assert.deepEqual(documents.map((x:any)=>x.locale).sort(),['en','es']);
  const manifest={
    date:'2026-10-28',
    authorization:'Editor explicitly requested creation of Mítiko ficha. Create one draft artist and published, validated Spanish and English biographies. No artist publication, discography import, shared-record or other-artist change.',
    before:null,
    after:artist,
    documents,
    reference_targets:targets,
    evidence_report:'mitiko-research-2026-10-28.md',
    field_evidence:'Field-level source decisions and unresolved data are in the evidence report.',
    backward_reference_audit:{
      pending_owner_id:'b000b7d5-23f1-42a2-b089-f522a29a5d20',
      pending_document_ids:['b721d349-ea2e-4f18-9652-e3b5148073d5','4cf3dbc5-912a-4507-8f22-40b43cff3552'],
      finding:'Two plain-text Mítiko mentions per published Los Sufridos biography; no changes authorized to those documents or safe link to a draft target.'
    },
    unresolved:['Only birth year and city are sourced; no month/day or province selected.','No current individual social handle or solo Spotify artist ID confirmed.','No licensed individual portrait supplied.','No discography or per-recording credit rows imported.'],
    exclusions:['Artist publication','Other artist biography changes','Artist relationship rows','Discography and music credit imports','Image upload','Deployment or security changes','Public draft URL request'],
  };
  fs.writeFileSync(manifestFile,JSON.stringify(manifest,null,2));
  console.log(JSON.stringify({prepared:true,id:artist.id,documents:documents.length,references:documents.reduce((n:number,d:any)=>n+JSON.stringify(d.document).match(/artistReference/g)!.length,0)}));
}else if(process.argv[2]==='execute'){
  const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
  assert.deepEqual(await duplicates(),[],'Duplicate artist candidate found');
  check(await db.from('artists').insert(manifest.after));
  for(const doc of manifest.documents){
    check(await db.rpc('upsert_editorial_document',{
      p_document_type:'artist_biography',p_owner_artist_id:manifest.after.id,p_locale:doc.locale,
      p_schema_version:1,p_status:'published',p_document:doc.document,p_expected_revision:0,
    }));
  }
  console.log('Draft artist and both published biographies saved.');
}else if(process.argv[2]==='verify'){
  const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
  const artist=check(await db.from('artists').select('*').eq('id',manifest.after.id).single());
  for(const [key,value] of Object.entries(manifest.after))assert.deepEqual(artist[key],value,key);
  const documents=check(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));
  assert.equal(documents.length,2);
  for(const doc of documents){
    assert.equal(doc.status,'published');assert.equal(doc.revision,1);
    assert.equal(validateEditorialDocument(1,doc.document).ok,true);
    assert.deepEqual(doc.document,manifest.documents.find((d:any)=>d.locale===doc.locale).document);
  }
  const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
  assert.equal(relations.length,12);
  const integrity=buildEditorialIntegrityReport({artists:[artist,...manifest.reference_targets],documents,relations});
  assert.equal(integrity.counts.blocking,0);
  assert.equal(integrity.counts.warning,0);
  assert.ok(!artist.genres.includes(artist.primary_genre));
  assert.ok(!artist.occupations.includes(artist.primary_role));
  const verification={artist,documents,relations,integrity};
  fs.writeFileSync(base+'mitiko-saved-verification.json',JSON.stringify(verification,null,2));
  console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),references:relations.length,integrity:integrity.counts}));
}else{
  throw Error('prepare|execute|verify');
}
