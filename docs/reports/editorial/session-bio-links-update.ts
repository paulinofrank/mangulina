import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
dotenv.config({quiet:true});
const b='docs/reports/editorial/';
const s=JSON.parse(fs.readFileSync(b+'session-bio-links-before.json','utf8'));
const file=b+'session-bio-links-change-manifest.json';
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
if(process.argv[2]==='prepare'){
 assert.ok(!fs.existsSync(file));
 const rules=[{owner:'Dhariana',mention:'Milton Peláez',target:'Milton Peláez'},{owner:'Solo Fernández',mention:'«Martox»',target:'Martox'},{owner:'Martox',mention:'NIKÓLA',target:'Nikóla'}];
 const changes:any[]=[];
 for(const d of s.documents){const owner=s.owners.find((o:any)=>o.id===d.owner_artist_id);const after=structuredClone(d.document);const mentions:any[]=[];
 for(const r of rules.filter(r=>r.owner===owner.name)){const target=s.artists.find((a:any)=>a.name===r.target);assert.equal(target.status,'published');for(const p of after.content){if(!p.content)continue;const nodes:any[]=[];for(const n of p.content){if(n.type!=='text'||n.marks?.some((m:any)=>m.type==='bold')||!n.text.includes(r.mention)){nodes.push(n);continue;}const parts=n.text.split(r.mention);for(let i=0;i<parts.length;i++){if(parts[i])nodes.push({...n,text:parts[i]});if(i<parts.length-1){nodes.push({type:'artistReference',attrs:{artistId:target.id,occurrenceId:randomUUID(),displayText:target.name}});mentions.push({before:r.mention,after:target.name,target_id:target.id,evidence:'Existing career context in this biography and matching published catalog identity; no new biographical claim.'});}}}p.content=nodes;}}
 if(mentions.length){assert.equal(validateEditorialDocument(1,after).ok,true);changes.push({owner:owner.name,owner_id:owner.id,slug:owner.slug,owner_status:owner.status,id:d.id,locale:d.locale,status:d.status,expected_revision:d.revision,before:d.document,after,mentions});}}
 assert.equal(changes.length,6);assert.equal(changes.flatMap(c=>c.mentions).length,6);
 const integrity=buildEditorialIntegrityReport({artists:s.artists,documents:s.documents,relations:s.relations});
 fs.writeFileSync(file,JSON.stringify({authorization:'User requested all session biographies be reviewed and pending links updated, 2026-10-24.',scope:s.owners.map((o:any)=>({id:o.id,name:o.name})),reviewed_documents:s.documents.map((d:any)=>({id:d.id,owner_id:d.owner_artist_id,locale:d.locale,revision:d.revision,status:d.status})),changes,before_integrity:integrity,exceptions:['Raffy Díaz EN Rokabanda and LeidyTr3 EN/ES El Fother section headings remain single bold text nodes under biography heading format; their prose already links those artists.','Ñico Lora in Rubali Valerio names a school, not an artist mention.','Rejected substring/alias false matches: Dominican/Dominic; Guananico/Raffy Díaz; Puerto Plata locality/artist; La Fiera 2.0 work/Raquel Arias; memory/MÓRIA; label/Abel; El catálogo/El Cata; De extremo a extremo/X3MO; Leslie Grace/Grupo Grace; billar/Billo Frómeta; ordinary mayo and renovación aliases.','Names without a matching catalog identity remain literal; no collaborator profiles created.']},null,2));
 console.log(JSON.stringify({reviewed:s.documents.length,changes:changes.map(({before,after,...rest})=>rest),before_integrity:integrity.counts,findings:integrity.findings}));
}else if(process.argv[2]==='execute'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));for(const c of m.changes){const d=check(await db.from('editorial_documents').select('*').eq('id',c.id).single());assert.equal(d.revision,c.expected_revision);assert.deepEqual(d.document,c.before);assert.equal(d.status,c.status);const targetIds=c.mentions.map((x:any)=>x.target_id);const targets=check(await db.from('artists').select('id,status,name').in('id',targetIds));assert.ok(targets.every((a:any)=>a.status==='published'));check(await db.rpc('upsert_editorial_document',{p_document_type:'artist_biography',p_owner_artist_id:c.owner_id,p_locale:c.locale,p_schema_version:1,p_status:c.status,p_document:c.after,p_expected_revision:c.expected_revision}));console.log('Saved '+c.owner+' '+c.locale);}
}else if(process.argv[2]==='verify'){
 const m=JSON.parse(fs.readFileSync(file,'utf8'));const documents=check(await db.from('editorial_documents').select('*').in('owner_artist_id',s.owners.map((o:any)=>o.id)).eq('document_type','artist_biography'));const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));const artists:any[]=[]; for(let offset=0;;offset+=1000){const rows=check(await db.from('artists').select('id,name,slug,status').range(offset,offset+999));artists.push(...rows);if(rows.length<1000)break;}
 assert.equal(documents.length,48);for(const d of documents){const c=m.changes.find((c:any)=>c.id===d.id);const old=s.documents.find((o:any)=>o.id===d.id);assert.equal(d.status,old.status);assert.equal(d.revision,old.revision+(c?1:0));assert.deepEqual(d.document,c?c.after:old.document);assert.equal(validateEditorialDocument(1,d.document).ok,true);}
 for(const owner of s.owners)assert.equal(artists.find((a:any)=>a.id===owner.id).status,owner.status);
 const integrity=buildEditorialIntegrityReport({artists,documents,relations});assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,m.before_integrity.counts.warning);assert.deepEqual(integrity.findings,m.before_integrity.findings);assert.equal(relations.length,s.relations.length+6);
 fs.writeFileSync(b+'session-bio-links-verification.json',JSON.stringify({date:'2026-10-24',documents,relations,integrity,verified_unchanged_documents:42,added_references:6,changed_owners:[...new Set(m.changes.map((c:any)=>c.owner))]},null,2));console.log(JSON.stringify({reviewed:48,updated:6,unchanged:42,references_before:s.relations.length,references_after:relations.length,integrity:integrity.counts}));
}else throw Error('prepare|execute|verify');

