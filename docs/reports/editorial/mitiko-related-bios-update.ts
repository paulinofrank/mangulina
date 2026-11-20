import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const beforeFile=base+'mitiko-related-bios-before.json';
const manifestFile=base+'mitiko-related-bios-manifest.json';
const verificationFile=base+'mitiko-related-bios-verification.json';
const ids={
  'Los Sufridos':'b000b7d5-23f1-42a2-b089-f522a29a5d20',
  'Mítiko':'648cd724-dccf-4174-8d13-18b9cfd0ce1e',
  'Cromo X':'350e5535-5229-4d49-903e-a5de047e7723',
  'T.Y.S':'3d4e3400-8661-46f7-ba48-54076a5d5087',
  'Antony Santos':'28a3745e-90d6-45cd-b8bd-798028f8deb8',
  'Eklectico':'b8699416-10d2-4c84-a43a-2a035387126f',
  'Tokischa':'3e1718be-c12d-42f5-85e7-2156d9574940',
};
type Name=keyof typeof ids;
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(result:any)=>{if(result.error)throw Error(result.error.message);return result.data;};
const walk=(v:any,fn:(node:any)=>void)=>{if(Array.isArray(v)){for(const x of v)walk(x,fn);}else if(v&&typeof v==='object'){fn(v);for(const x of Object.values(v))walk(x,fn);}};
const refs=(document:any)=>{const out:string[]=[];walk(document,(n:any)=>{if(n.type==='artistReference'&&n.attrs?.artistId)out.push(n.attrs.artistId);});return out;};
const textOf=(block:any)=>block.content?.map((n:any)=>n.type==='artistReference'?n.attrs.displayText:n.text??'').join('')??'';
const heading=(label:string)=>({type:'paragraph',content:[{type:'text',text:label,marks:[{type:'bold'}]}]});
function paragraph(prose:string){
  const nodes:any[]=[];let pos=0;
  for(const hit of prose.matchAll(/\[\[(.*?)\]\]/g)){
    if(hit.index>pos)nodes.push({type:'text',text:prose.slice(pos,hit.index)});
    const name=hit[1] as Name;assert.ok(name in ids,`Unknown target ${name}`);
    nodes.push({type:'artistReference',attrs:{artistId:ids[name],occurrenceId:randomUUID(),displayText:name}});
    pos=hit.index+hit[0].length;
  }
  if(pos<prose.length)nodes.push({type:'text',text:prose.slice(pos)});
  return {type:'paragraph',content:nodes};
}
function splitTextMention(block:any,mention:string,target:Name){
  const nodes:any[]=[];let count=0;
  for(const node of block.content??[]){
    if(node.type!=='text'||!node.text?.includes(mention)){nodes.push(node);continue;}
    const parts=node.text.split(mention);
    for(let i=0;i<parts.length;i++){
      if(parts[i])nodes.push({...node,text:parts[i]});
      if(i<parts.length-1){nodes.push({type:'artistReference',attrs:{artistId:ids[target],occurrenceId:randomUUID(),displayText:target}});count++;}
    }
  }
  block.content=nodes;return count;
}
function appendSentence(block:any,prose:string){
  assert.equal(block.type,'paragraph');
  const p=paragraph(prose);
  const last=block.content.at(-1);assert.ok(last);
  if(last.type==='text')last.text+=' ';
  else block.content.push({type:'text',text:' '});
  block.content.push(...p.content);
}

if(process.argv[2]==='snapshot'){
  assert.ok(!fs.existsSync(beforeFile),'Preserve baseline');
  const owners=check(await db.from('artists').select('id,name,slug,status,updated_at').in('id',Object.values(ids)));
  assert.equal(owners.length,Object.keys(ids).length);
  assert.ok(owners.every((a:any)=>a.status==='published'));
  const documents=check(await db.from('editorial_documents').select('*').in('owner_artist_id',Object.values(ids)).eq('document_type','artist_biography'));
  assert.equal(documents.length,14);
  const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
  const targetIds=[...new Set(documents.flatMap((d:any)=>refs(d.document)))];
  const targets=check(await db.from('artists').select('id,name,slug,status').in('id',targetIds));
  assert.equal(targets.length,targetIds.length);
  const snapshot={date:'2026-10-28',owners,documents,relations,targets};
  fs.writeFileSync(beforeFile,JSON.stringify(snapshot,null,2));
  console.log(JSON.stringify({owners:owners.map((x:any)=>({name:x.name,status:x.status})),documents:documents.map((d:any)=>({id:d.id,owner:owners.find((x:any)=>x.id===d.owner_artist_id).name,locale:d.locale,revision:d.revision,status:d.status,blocks:d.document.content.length})),relations:relations.length}));
}else if(process.argv[2]==='prepare'){
  assert.ok(!fs.existsSync(manifestFile),'Preserve frozen manifest');
  const before=JSON.parse(fs.readFileSync(beforeFile,'utf8'));
  const doc=(name:Name,locale:string)=>{const d=before.documents.find((x:any)=>x.owner_artist_id===ids[name]&&x.locale===locale);assert.ok(d);return d;};
  const changes:any[]=[];
  const add=(name:Name,locale:string,after:any,reason:string,sources:string[])=>{
    const original=doc(name,locale);
    const validation=validateEditorialDocument(1,after);assert.equal(validation.ok,true,JSON.stringify(validation));
    assert.notDeepEqual(after,original.document);
    changes.push({owner:name,owner_id:ids[name],slug:before.owners.find((x:any)=>x.id===ids[name]).slug,document_id:original.id,locale,status:original.status,expected_revision:original.revision,before:original.document,after,reason,sources,reference_delta:refs(after).length-refs(original.document).length});
  };
  for(const locale of ['en','es']){
    // Conversion only: do not replace the literal personal-name songwriting credit.
    {
      const original=doc('Los Sufridos',locale);const after=structuredClone(original.document);
      const count=after.content.reduce((n:number,block:any)=>n+splitTextMention(block,'Mítiko','Mítiko'),0);
      assert.equal(count,2,`Los Sufridos ${locale}: expected two mentions`);
      add('Los Sufridos',locale,after,'Link the two established cofounder mentions to the now-published Mítiko identity; preserve José Julio Bello as literal credited name.',['https://ccesd.aecid.es/w/seis-d%C3%A9cadas-de-amargue-origen-y-evoluci%C3%B3n-de-la-bachata-1','https://www.diariolibre.com/revista/musica/2024/08/28/bachata-urbana-con-anthony-santos/2833017']);
    }
    {
      const original=doc('Cromo X',locale);const after=structuredClone(original.document);
      const prose=locale==='es'
        ? 'En 2023 formó [[Los Sufridos]] junto a [[T.Y.S]] y [[Mítiko]]. El colectivo llevó sus trayectorias de producción a la bachata urbana; en 2024 publicó «Lleno Contigo» con [[Antony Santos]], tema cuya letra acredita a Cromo X bajo su nombre personal, Martín Rodríguez.'
        : 'In 2023 he formed [[Los Sufridos]] with [[T.Y.S]] and [[Mítiko]]. The collective brought their production backgrounds to urban bachata; in 2024 it released «Lleno Contigo» with [[Antony Santos]], a song whose lyrics credit Cromo X under his personal name, Martín Rodríguez.';
      after.content.push(heading('Los Sufridos'),paragraph(prose));
      add('Cromo X',locale,after,'Document his cofounding role and a sourced 2024 songwriting credit.',['https://www.diariolibre.com/revista/musica/2024/08/28/bachata-urbana-con-anthony-santos/2833017']);
    }
    {
      const original=doc('T.Y.S',locale);const after=structuredClone(original.document);
      const prose=locale==='es'
        ? 'En 2023 formó [[Los Sufridos]] con [[Cromo X]] y [[Mítiko]], un proyecto centrado en la bachata urbana. En 2024 el grupo publicó «Lleno Contigo» con [[Antony Santos]]; la letra acredita a T.Y.S bajo su nombre personal, Steven Domínguez.'
        : 'In 2023 he formed [[Los Sufridos]] with [[Cromo X]] and [[Mítiko]], a project centred on urban bachata. The group’s «Lleno Contigo» with [[Antony Santos]] appeared in 2024; its lyrics credit T.Y.S under his personal name, Steven Domínguez.';
      assert.ok(textOf(after.content[6]).includes(locale==='es'?'Hache, N.I.T.O y Big O':'Hache, N.I.T.O and Big O'));
      after.content.splice(7,0,heading('Los Sufridos'),paragraph(prose));
      add('T.Y.S',locale,after,'Document his cofounding role and a sourced 2024 songwriting credit.',['https://www.diariolibre.com/revista/musica/2024/08/28/bachata-urbana-con-anthony-santos/2833017']);
    }
    {
      const original=doc('Antony Santos',locale);const after=structuredClone(original.document);
      assert.ok(textOf(after.content[16]).length>100);
      appendSentence(after.content[16],locale==='es'?'En agosto de 2024 publicó «Lleno Contigo» con [[Los Sufridos]].':'In August 2024 he released «Lleno Contigo» with [[Los Sufridos]].');
      add('Antony Santos',locale,after,'Add his verified 2024 collaboration with the collective.',['https://music.apple.com/us/album/lleno-contigo-single/1759898182']);
    }
    {
      const original=doc('Eklectico',locale);const after=structuredClone(original.document);
      const originalPrefix=locale==='es'?'Me Persiguen, Kacha2 y Préndela vienen del mismo tramo, y Como Ali lo juntó con ':'Me Persiguen, Kacha2 and Prendela come from the same stretch, and Como Ali paired him with ';
      const replacement=locale==='es'?'«Me Persiguen» y «Kacha2» vienen de ese tramo. En diciembre de 2023 publicó «Prendela» con [[Los Sufridos]]. «Como Ali» lo juntó con ':'«Me Persiguen» and «Kacha2» belong to that period. In December 2023 he released «Prendela» with [[Los Sufridos]]. «Como Ali» paired him with ';
      const block=after.content[3];assert.equal(block.content[0]?.text,originalPrefix);
      block.content.splice(0,1,...paragraph(replacement).content);
      add('Eklectico',locale,after,'Replace a dated title mention with the verified joint release and canonical song title.',['https://open.spotify.com/intl-es/track/6dDAv38b7W8AeaJ2QAjQb3']);
    }
    {
      const original=doc('Tokischa',locale);const after=structuredClone(original.document);
      // The official video names her in its cast, not as a recording artist.
      const prose=locale==='es'?'El videoclip de «Duro De Verdad pt.2» (2024), de [[Los Sufridos]] y Bad Gyal, también contó con su participación.':'The 2024 video for [[Los Sufridos]] and Bad Gyal’s «Duro De Verdad pt.2» also features her.';
      const insertion=after.content.findIndex((block:any)=>textOf(block).includes('Bad Gyal'));
      assert.ok(insertion>=0,`Tokischa ${locale}: expected Bad Gyal context`);
      appendSentence(after.content[insertion],prose);
      add('Tokischa',locale,after,'Add a verified music-video cast appearance, explicitly not a recording collaboration.',['https://www.youtube.com/watch?v=e74C11fdjak']);
    }
  }
  assert.equal(changes.length,12);
  assert.equal(changes.reduce((n,c)=>n+c.reference_delta,0),26);
  const manifest={date:'2026-10-28',authorization:'Editor requested updates to fichas mentioning Mítiko and fichas of catalog artists named in Los Sufridos biographies. Existing published biographies only; no artist status or unrelated catalog changes.',scope:Object.keys(ids),changes,non_catalog_names:['La Gran Mawon','Bad Gyal','Rels B','N.I.T.O'],excluded:['No artist publication or status change','No artist relationship rows','No discography or credit edits','No new profiles','No code/schema/security/deployment change'],recovery:'Each change stores the full before document and expected revision. The editorial RPC is revision guarded; a later authorized reversal can upsert the prior document against the saved post-write revision.'};
  fs.writeFileSync(manifestFile,JSON.stringify(manifest,null,2));
  console.log(JSON.stringify({prepared:true,owners:[...new Set(changes.map(c=>c.owner))],documents:changes.length,addedReferences:changes.reduce((n,c)=>n+c.reference_delta,0),changes:changes.map(c=>({owner:c.owner,locale:c.locale,document_id:c.document_id,expected_revision:c.expected_revision,reference_delta:c.reference_delta}))}));
}else if(process.argv[2]==='execute'){
  const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
  const targetIds=[...new Set(manifest.changes.flatMap((c:any)=>refs(c.after)))];
  const targets=check(await db.from('artists').select('id,status').in('id',targetIds));
  assert.equal(targets.length,targetIds.length);
  assert.ok(targets.every((a:any)=>a.status==='published'));
  for(const change of manifest.changes){
    const current=check(await db.from('editorial_documents').select('*').eq('id',change.document_id).single());
    if(current.revision===change.expected_revision+1&&current.status===change.status&&isDeepStrictEqual(current.document,change.after)){
      console.log(`Already saved ${change.owner} ${change.locale}`);
      continue;
    }
    assert.equal(current.revision,change.expected_revision);
    assert.equal(current.status,change.status);
    assert.deepEqual(current.document,change.before);
    check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:change.owner_id,p_locale:change.locale,p_schema_version:1,p_status:change.status,p_document:change.after,p_expected_revision:change.expected_revision}));
    console.log(`Saved ${change.owner} ${change.locale}`);
  }
}else if(process.argv[2]==='verify'){
  const before=JSON.parse(fs.readFileSync(beforeFile,'utf8'));
  const manifest=JSON.parse(fs.readFileSync(manifestFile,'utf8'));
  const documents=check(await db.from('editorial_documents').select('*').in('owner_artist_id',Object.values(ids)).eq('document_type','artist_biography'));
  assert.equal(documents.length,14);
  for(const doc of documents){
    const original=before.documents.find((x:any)=>x.id===doc.id);assert.ok(original);
    const change=manifest.changes.find((x:any)=>x.document_id===doc.id);
    assert.equal(doc.status,original.status);
    assert.equal(doc.revision,original.revision+(change?1:0));
    assert.deepEqual(doc.document,change?change.after:original.document);
    assert.equal(validateEditorialDocument(1,doc.document).ok,true);
  }
  const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
  const targetIds=[...new Set(documents.flatMap((d:any)=>refs(d.document)))];
  const targets=check(await db.from('artists').select('id,name,slug,status').in('id',targetIds));
  assert.equal(targets.length,targetIds.length);
  const owners=check(await db.from('artists').select('id,name,slug,status').in('id',Object.values(ids)));
  assert.ok(owners.every((o:any)=>o.status==='published'));
  const artists=[...new Map([...owners,...targets].map((a:any)=>[a.id,a])).values()];
  const integrity=buildEditorialIntegrityReport({artists,documents,relations});
  assert.equal(integrity.counts.blocking,0);
  assert.equal(integrity.counts.warning,0);
  assert.equal(relations.length,before.relations.length+26);
  fs.writeFileSync(verificationFile,JSON.stringify({date:'2026-10-28',owners,documents,relations,integrity,oldRelationCount:before.relations.length,newRelationCount:relations.length},null,2));
  console.log(JSON.stringify({updated:manifest.changes.length,owners:[...new Set(manifest.changes.map((c:any)=>c.owner))],references_before:before.relations.length,references_after:relations.length,integrity:integrity.counts,documents:documents.map((d:any)=>({id:d.id,owner:owners.find((a:any)=>a.id===d.owner_artist_id)?.name,locale:d.locale,status:d.status,revision:d.revision}))}));
}else throw Error('snapshot|prepare|execute|verify');
