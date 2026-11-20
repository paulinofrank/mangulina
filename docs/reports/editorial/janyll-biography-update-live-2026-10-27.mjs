import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';

dotenv.config({quiet:true});
assert.ok(process.env.REVALIDATION_TOKEN,'Targeted refresh credential unavailable');
const url='https://mangulina.do';
const response=await fetch(url+'/api/revalidate',{method:'POST',headers:{'content-type':'application/json',authorization:'Bearer '+process.env.REVALIDATION_TOKEN},body:JSON.stringify({artists:['janyll-la-interprete']})});
const body=await response.json();
const result={refresh:{status:response.status,body},pages:[]};
assert.equal(response.status,200);assert.equal(body.ok,true);assert.deepEqual(body.revalidated,{artists:1,songs:0,releases:0,allArtists:false});
for(const locale of ['es','en']){
 const path=`/${locale}/artists/janyll-la-interprete`;
 const page=await fetch(url+path);
 const html=await page.text();
 const visible=html.replace(/<script\b[^>]*>[\s\S]*?<\/script>/gi,'');
 const check={path,status:page.status,stage_name:visible.includes('Piti Franqui'),merengue_album:visible.includes('Pantera Agresiva'),prior_album:visible.includes('Máquina de placer'),linked_arranger:visible.includes(`/${locale}/artists/ramon-orlando`),cache:page.headers.get('x-vercel-cache')};
 result.pages.push(check);
}
fs.writeFileSync('docs/reports/editorial/janyll-biography-update-live-2026-10-27.json',JSON.stringify(result,null,2));
for(const page of result.pages){assert.equal(page.status,200,JSON.stringify(page));assert.ok(page.stage_name&&page.merengue_album&&page.prior_album&&page.linked_arranger,JSON.stringify(page));}
console.log(JSON.stringify(result));
