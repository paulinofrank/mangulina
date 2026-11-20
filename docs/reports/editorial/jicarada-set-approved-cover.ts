import fs from 'node:fs';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import dotenv from 'dotenv';
import sharp from 'sharp';
import {createClient} from '@supabase/supabase-js';
dotenv.config({quiet:true});
const base='docs/reports/editorial/';
const id='a0dba3d6-e318-4217-bffc-66b710b1d9f3';
const source='C:/Users/fvpg/AppData/Local/Temp/codex-clipboard-c5d65543-50e3-4ef0-99eb-7ffcd489c721.png';
const saved=base+'jicarada-editor-approved-cover.png';
fs.copyFileSync(source,saved);
const hash=(b:Buffer)=>createHash('sha256').update(b).digest('hex');
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL??process.env.SUPABASE_URL!,process.env.SUPABASE_SERVICE_ROLE_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const check=(r:any)=>{if(r.error)throw Error(r.error.message);return r.data;};
const before=check(await db.from('releases').select('*').eq('id',id).single());
assert.equal(before.catalog_number,'JIC326CD');
const manifest:any={approval:'Editor explicitly requested using the attached image for the Jicarada album cover',release_id:id,before,source_file:saved,source_sha256:hash(fs.readFileSync(saved)),date:new Date().toISOString(),objects:[]};
fs.writeFileSync(base+'jicarada-cover-change.json',JSON.stringify(manifest,null,2));
for(const size of [150,300]){
 const path=`${size}px/${id}.webp`;
 const existing=check(await db.storage.from('cover-art').list(`${size}px`,{search:id}));
 if(existing.some((x:any)=>x.name===`${id}.webp`)){const old=check(await db.storage.from('cover-art').download(path));fs.writeFileSync(base+`jicarada-cover-before-${size}.webp`,Buffer.from(await old.arrayBuffer()));}
 const image=await sharp(saved).resize(size,size,{fit:'contain',background:'#ffffff'}).webp({quality:90}).toBuffer();
 check(await db.storage.from('cover-art').upload(path,image,{contentType:'image/webp',upsert:true,cacheControl:'3600'}));
 const url=db.storage.from('cover-art').getPublicUrl(path).data.publicUrl;
 const res=await fetch(url+'?verify='+Date.now());assert.equal(res.status,200);assert.equal(hash(Buffer.from(await res.arrayBuffer())),hash(image));
 manifest.objects.push({path,sha256:hash(image),url});
}
check(await db.from('releases').update({has_cover_image:true}).eq('id',id));
const after=check(await db.from('releases').select('*').eq('id',id).single());
for(const key of Object.keys(before))if(!['has_cover_image','updated_at'].includes(key))assert.deepEqual(after[key],before[key]);
assert.equal(after.has_cover_image,true);manifest.after=after;
if(process.env.REVALIDATION_TOKEN){const res=await fetch('https://mangulina.do/api/revalidate',{method:'POST',headers:{Authorization:`Bearer ${process.env.REVALIDATION_TOKEN}`,'Content-Type':'application/json'},body:JSON.stringify({artists:['orquesta-jicarada'],releases:[before.slug]})});manifest.cache={status:res.status,body:await res.text()};}
fs.writeFileSync(base+'jicarada-cover-change.json',JSON.stringify(manifest,null,2));
console.log('Approved image uploaded in both sizes; bytes verified; cover flag true; other release fields unchanged. Cache:',manifest.cache?.status);
