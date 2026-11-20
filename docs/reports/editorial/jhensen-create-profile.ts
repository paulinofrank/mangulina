import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet:true});
const base='docs/reports/editorial/jhensen-';
const file=base+'profile-manifest.json';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const get=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const duplicate=()=>db.from('artists').select('id,name,status').or('slug.eq.jhensen,name.ilike.%Jhensen%,and(first_name.eq.Félix,last_name.eq.Caraballo),spotify.eq.329jhhEpDL1oM7hHcsl1Wr,facebook.eq.JhensenCantautor');
const paragraphText=(node:any):string=>[node.text??'',node.attrs?.displayText??'',...(node.content??[]).map(paragraphText)].join('');

if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file),'Preserve prepared manifest');
 assert.equal(get(await duplicate()).length,0);
 const source=JSON.parse(fs.readFileSync(base+'profile-content.json','utf8'));
 const targetNames=[...new Set(Object.values(source.bios).flat().flatMap((section:any)=>[...section[1].matchAll(/\[\[(.*?)\]\]/g)].map((m:any)=>m[1])))];
 const targets=get(await db.from('artists').select('id,name,slug,status').in('name',targetNames));
 assert.equal(targets.length,targetNames.length);assert.ok(targets.every((a:any)=>a.status==='published'));
 const artist={id:randomUUID(),...source.artist};
 const documents=Object.entries(source.bios).map(([locale,sections]:any)=>{
  const content:any[]=[];
  for(const [heading,prose] of sections){
   if(heading)content.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
   const nodes:any[]=[];let pos=0;
   for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){
    if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});
    const target=targets.find((a:any)=>a.name===hit[1]);assert.ok(target);
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
 const [backlinks,legacy]=await Promise.all([
  db.from('editorial_documents').select('id,owner_artist_id,locale,revision,status,document').or('document->>content.ilike.%Jhensen%,document->>content.ilike.%Caraballo Leonidas%'),
  db.from('artists').select('id,name,slug,bio_en,bio_es').or('bio_en.ilike.%Jhensen%,bio_es.ilike.%Jhensen%')
 ]);
 const pending=get(backlinks).filter((d:any)=>/\bJhensen\b|Caraballo Leonidas/i.test(JSON.stringify(d.document))).map((d:any)=>({id:d.id,owner_artist_id:d.owner_artist_id,locale:d.locale,revision:d.revision,status:d.status,contexts:d.document.content.map(paragraphText).filter((s:string)=>/\bJhensen\b|Caraballo Leonidas/i.test(s))}));
 const legacyMatches=get(legacy).map((a:any)=>({id:a.id,name:a.name,slug:a.slug}));
 const manifest={date:'2026-11-11',authorization:'Editor supplied Jhensen EN/ES profile sheet in ongoing new-profile workflow. Create draft artist and validated published EN/ES biography documents.',scope:'Only Jhensen profile and biographies. No artist publication, shared artist changes, music imports or deployment.',before:null,after:artist,documents,reference_targets:targets,backward_reference_audit:{pending,legacyMatches},field_evidence:{identity:'Artist-controlled ReverbNation biography and Facebook JhensenCantautor state Félix Caraballo Leonidas; distinct from Hansel.',birth:'ReverbNation states born Bayagüana; Facebook About states September 30 but no year. Bayagüana is in Monte Plata. Date and birth_year remain null.',upbringing:'ReverbNation biography states raised in La Otra Banda, Higüey; Facebook About lists Higüey as city of origin, distinct from birth place.',career:'Artist-controlled ReverbNation biography supplies the 1967 move, albums and 2014 bachata single. Spotify main profile independently displays the 1981, 1984 and 1999 albums.',songwriting:'Artist-controlled ReverbNation account says Frank Reyes recorded Pienso en ti; Amazon Music lists Jhensen’s 1999 album with the song and Apple Music lists Frank Reyes’s recording. No work credit imported.',genre_role_tag:'Self-description and recorded catalog support singer/songwriter, ballads with later bachata, voice and secular repertoire.',facebook:'ReverbNation links facebook.com/JhensenCantautor; page displays the complete personal name.',spotify:'Spotify artist 329jhhEpDL1oM7hHcsl1Wr displays Jhensen and the three identified albums; separate collaboration-only ID not merged.'},sources:['https://www.reverbnation.com/jhensen','https://www.facebook.com/JhensenCantautor/about','https://open.spotify.com/artist/329jhhEpDL1oM7hHcsl1Wr','https://music.amazon.com.au/albums/B01EPF75QW','https://music.apple.com/us/song/255086137'],unresolved:['Birth year unknown; September 30 cannot populate date_of_birth or generated birthday calendar.','No verified official Instagram, YouTube or TikTok handle.','No portrait supplied or uploaded.','The precise edition/date of some nondigitized records and composition credits require a separate discography review.'],exclusions:['No artist publication','No discography/credit import','No other artist or shared-record change','No security/schema/application change','No deployment, public draft URL request or manual cache refresh']};
 assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(file,JSON.stringify(manifest,null,2));
 console.log(JSON.stringify({prepared:true,id:artist.id,documents:documents.length,references:targetNames,pending_backlinks:pending.length,legacy_matches:legacyMatches.length}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));
 assert.equal(get(await duplicate()).length,0);
 get(await db.from('artists').insert(m.after));
 for(const d of m.documents)get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:m.after.id,p_locale:d.locale,p_schema_version:1,p_status:'published',p_document:d.document,p_expected_revision:0}));
 console.log('Saved Jhensen draft profile and published EN/ES biographies.');
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));
 const artist=get(await db.from('artists').select('*').eq('id',m.after.id).single());
 for(const [k,v] of Object.entries(m.after))assert.deepEqual(artist[k],v,k);
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artist.id));assert.equal(documents.length,2);
 for(const d of documents){assert.equal(d.status,'published');assert.equal(d.revision,1);assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,m.documents.find((x:any)=>x.locale===d.locale).document);}
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
 const integrity=buildEditorialIntegrityReport({artists:[artist,...m.reference_targets],documents,relations});
 assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 assert.ok(!artist.genres.includes(artist.primary_genre));assert.ok(!artist.occupations.includes(artist.primary_role));
 fs.writeFileSync(base+'saved-verification.json',JSON.stringify({artist,documents,relations,integrity},null,2));
 console.log(JSON.stringify({id:artist.id,status:artist.status,documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision})),references:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');
