import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet:true});
const dir='docs/reports/editorial/';
const report=dir+'janyll-biography-review-2026-10-27.md';
const manifestPath=dir+'janyll-biography-update-manifest-2026-10-27.json';
const verificationPath=dir+'janyll-biography-update-verification-2026-10-27.json';
const artistId='aa45d980-e99c-4036-9375-f005ed357d55';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const get=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const targetNames=['Ramón Orlando','Víctor Waill','Enrique Féliz','Mártires de León','Edilio Paredes'];

function extract(markdown:string,locale:'es'|'en'){
 const start=locale==='es'?'## Proposed Spanish biography':'## Proposed English biography';
 const end=locale==='es'?'## Proposed English biography':'## Evidence and limits';
 const content=markdown.split(start)[1]?.split(end)[0]?.trim();
 assert.ok(content,`Missing ${locale} proposal`);
 return content.split(/\r?\n\s*\r?\n/).map(x=>x.trim()).filter(Boolean);
}
function build(markdown:string,locale:'es'|'en',old:any,targets:any[]){
 const oldRefs=new Map<string,any>();
 for(const block of old.document.content)for(const node of block.content??[])if(node.type==='artistReference')oldRefs.set(node.attrs.displayText,node.attrs);
 assert.equal(oldRefs.size,5);
 const blocks:any[]=[];const used=new Set<string>();
 for(const paragraph of extract(markdown,locale)){
  const heading=paragraph.match(/^\*\*(.+)\*\*$/);
  if(heading){blocks.push({type:'paragraph',content:[{type:'text',text:heading[1],marks:[{type:'bold'}]}]});continue;}
  const nodes:any[]=[];let position=0;
  for(const hit of paragraph.matchAll(/\[\[(.*?)\]\]/g)){
   if(hit.index!>position)nodes.push({type:'text',text:paragraph.slice(position,hit.index)});
   const target=targets.find(x=>x.name===hit[1]);assert.ok(target,`Unknown artist ${hit[1]}`);
   assert.equal(target.status,'published');
   const previous=oldRefs.get(target.name);assert.ok(previous,`Missing prior occurrence ${target.name}`);
   assert.ok(!used.has(target.name),`Duplicate mention ${target.name}`);used.add(target.name);
   nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:previous.occurrenceId,displayText:target.name}});
   position=hit.index!+hit[0].length;
  }
  if(position<paragraph.length)nodes.push({type:'text',text:paragraph.slice(position)});
  blocks.push({type:'paragraph',content:nodes});
 }
 assert.equal(used.size,5);
 const document={type:'doc',content:blocks};
 const validation=validateEditorialDocument(1,document);assert.equal(validation.ok,true,JSON.stringify(validation.issues));
 return document;
}

const mode=process.argv[2];
if(mode==='prepare'){
 assert.ok(!fs.existsSync(manifestPath),'Frozen manifest already exists');
 const artist=get(await db.from('artists').select('id,name,slug,status,date_of_birth,birth_place,province,bio_en,bio_es,updated_at').eq('id',artistId).single());
 assert.equal(artist.status,'published');assert.equal(artist.name,'Janyll La Intérprete');
 const before=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artistId).eq('document_type','artist_biography'));
 assert.equal(before.length,2);assert.ok(before.every((d:any)=>d.status==='published'&&d.revision===1));
 const targets=get(await db.from('artists').select('id,name,slug,status').in('name',targetNames));
 assert.equal(targets.length,5);assert.ok(targets.every((x:any)=>x.status==='published'));
 const markdown=fs.readFileSync(report,'utf8');
 const documents=before.map((d:any)=>({id:d.id,locale:d.locale,expected_revision:d.revision,before:d.document,after:build(markdown,d.locale,d,targets)}));
 fs.writeFileSync(manifestPath,JSON.stringify({date:'2026-10-27',authorization:'Editor explicitly approved updating both published Janyll biographies to revision 2; no artist field, discography or other-artist changes.',artist_before:artist,documents,targets,evidence_report:report},null,2));
 console.log(JSON.stringify({prepared:true,artist_id:artistId,documents:documents.map((x:any)=>({locale:x.locale,revision:x.expected_revision+1,paragraphs:x.after.content.length}))}));
}else if(mode==='execute'){
 const m=JSON.parse(fs.readFileSync(manifestPath,'utf8'));
 const artist=get(await db.from('artists').select('id,name,slug,status,date_of_birth,birth_place,province,bio_en,bio_es,updated_at').eq('id',artistId).single());
 assert.deepEqual(artist,m.artist_before,'Artist changed since review; stop');
 for(const c of m.documents){const d=get(await db.from('editorial_documents').select('id,status,revision,document').eq('id',c.id).single());assert.equal(d.status,'published');assert.equal(d.revision,c.expected_revision);assert.deepEqual(d.document,c.before);}
 for(const c of m.documents){const saved=get(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:artistId,p_locale:c.locale,p_schema_version:1,p_status:'published',p_document:c.after,p_expected_revision:c.expected_revision}));console.log(JSON.stringify({saved_locale:c.locale,result:saved}));}
}else if(mode==='verify'){
 const m=JSON.parse(fs.readFileSync(manifestPath,'utf8'));
 const artist=get(await db.from('artists').select('*').eq('id',artistId).single());assert.equal(artist.status,'published');
 for(const key of ['name','slug','date_of_birth','birth_place','province','bio_en','bio_es'])assert.deepEqual(artist[key],m.artist_before[key]);
 const documents=get(await db.from('editorial_documents').select('*').eq('owner_artist_id',artistId).eq('document_type','artist_biography'));
 assert.equal(documents.length,2);
 for(const d of documents){const c=m.documents.find((x:any)=>x.locale===d.locale);assert.ok(c);assert.equal(d.id,c.id);assert.equal(d.status,'published');assert.equal(d.revision,c.expected_revision+1);assert.deepEqual(d.document,c.after);assert.equal(validateEditorialDocument(1,d.document).ok,true);}
 const relations=get(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((x:any)=>x.id)));
 assert.equal(relations.length,10);
 const integrity=buildEditorialIntegrityReport({artists:[artist,...m.targets],documents,relations});
 assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);
 fs.writeFileSync(verificationPath,JSON.stringify({artist:{id:artist.id,name:artist.name,slug:artist.slug,status:artist.status,date_of_birth:artist.date_of_birth,birth_place:artist.birth_place,province:artist.province},documents:documents.map((d:any)=>({id:d.id,locale:d.locale,status:d.status,revision:d.revision,document:d.document})),relations,integrity},null,2));
 console.log(JSON.stringify({verified:true,documents:documents.map((d:any)=>({locale:d.locale,status:d.status,revision:d.revision})),relations:relations.length,integrity:integrity.counts}));
}else throw Error('Use prepare|execute|verify');
