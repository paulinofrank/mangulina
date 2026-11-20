import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';
dotenv.config({quiet:true});
assert.ok(process.env.REVALIDATION_TOKEN);
const response=await fetch('https://mangulina.do/api/revalidate',{method:'POST',headers:{'content-type':'application/json',authorization:'Bearer '+process.env.REVALIDATION_TOKEN},body:JSON.stringify({artists:['koki-acosta']})});
const refresh={status:response.status,body:await response.json()};assert.equal(refresh.status,200);assert.equal(refresh.body.ok,true);
const pages=[];
for(const locale of ['es','en']){
 const path='/'+locale+'/artists/koki-acosta';const r=await fetch('https://mangulina.do'+path);const html=(await r.text()).replace(/<script\b[^>]*>[\s\S]*?<\/script>/gi,'');
 const check={path,status:r.status,new_bio:html.includes('Shining Star')&&html.includes('Gijón')&&html.includes('Corre'),old_title_absent:!html.includes('Shine Star'),reference:html.includes('/'+locale+'/artists/guandulito')};pages.push(check);
 assert.equal(check.status,200);assert.ok(check.new_bio);assert.ok(check.old_title_absent);assert.ok(check.reference);
}
fs.writeFileSync('docs/reports/editorial/koki-acosta-update-live.json',JSON.stringify({refresh,pages},null,2));console.log(JSON.stringify({refresh,pages}));
