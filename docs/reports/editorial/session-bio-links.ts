import fs from 'node:fs';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const artists:any[]=[];
for(let offset=0;;offset+=1000){const rows=check(await db.from('artists').select('id,name,slug,status,aliases,stage_name').range(offset,offset+999));artists.push(...rows);if(rows.length<1000)break;}
const owners=fs.readdirSync(base).filter(f=>f.endsWith('-profile-manifest.json')).map(f=>{const m=JSON.parse(fs.readFileSync(base+f,'utf8'));const a=m.after?.artist_fields??m.after??m.artist;const found=artists.filter(x=>x.id===(m.artist_id??m.created_artist_id??a?.id)||x.slug===a?.slug||x.name===a?.name);if(found.length!==1)throw Error(f+': '+JSON.stringify(found));return{file:f,...found[0]};});
const documents=check(await db.from('editorial_documents').select('*').in('owner_artist_id',owners.map(x=>x.id)).eq('document_type','artist_biography'));
const relations=check(await db.from('editorial_entity_references').select('*').in('editorial_document_id',documents.map((d:any)=>d.id)));
fs.writeFileSync(base+'session-bio-links-before.json',JSON.stringify({owners,artists,documents,relations},null,2));
const norm=(s:string)=>s.normalize('NFD').replace(/\p{Diacritic}/gu,'').toLowerCase();
const candidates:any[]=[];
for(const d of documents){const walk=(n:any)=>{if(n.type==='text'){for(const a of artists){if(a.id===d.owner_artist_id)continue;const names=[a.name,a.stage_name,...(Array.isArray(a.aliases)?a.aliases:[])].filter((v:any)=>typeof v==='string'&&v.length>=4);for(const name of [...new Set(names)] as string[]){const p=norm(n.text).indexOf(norm(name));if(p>=0){candidates.push({owner:owners.find(x=>x.id===d.owner_artist_id)?.name,doc:d.id,locale:d.locale,target:a.name,targetId:a.id,status:a.status,match:name,text:n.text});break;}}}}for(const c of n.content??[])walk(c);};walk(d.document);}
fs.writeFileSync(base+'session-bio-links-candidates.json',JSON.stringify(candidates,null,2));
console.log(JSON.stringify({owners:owners.map(x=>({name:x.name,status:x.status})),documents:documents.length,catalog:artists.length,candidates},null,2));

