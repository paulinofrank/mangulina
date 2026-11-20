import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';
dotenv.config({quiet:true});
assert.ok(process.env.REVALIDATION_TOKEN);
const response=await fetch('https://mangulina.do/api/revalidate',{method:'POST',headers:{'content-type':'application/json',authorization:'Bearer '+process.env.REVALIDATION_TOKEN},body:JSON.stringify({artists:['joaquin-balaguer']})});
const refresh={status:response.status,body:await response.json()};assert.equal(refresh.status,200);assert.equal(refresh.body.ok,true);
const pages=[];
for(const locale of ['es','en']){
 const path='/'+locale+'/artists/joaquin-balaguer';const r=await fetch('https://mangulina.do'+path);
 const html=(await r.text()).replace(/<script\b[^>]*>[\s\S]*?<\/script>/gi,'');
 const check={path,status:r.status,new_bio:html.includes('DB-1020')&&html.includes('Melancolía otoñal')&&html.includes('Gina D’Alessandro'),old_claim_absent:!html.includes('every platform')&&!html.includes('todas las plataformas'),pedro_reference:html.includes('/'+locale+'/artists/pedro-samuel-rodriguez'),lope_reference:html.includes('/'+locale+'/artists/lope-balaguer')};
 pages.push(check);assert.equal(r.status,200);assert.ok(check.new_bio);assert.ok(check.old_claim_absent);assert.ok(check.pedro_reference);assert.ok(check.lope_reference);
}
fs.writeFileSync('docs/reports/editorial/joaquin-balaguer-bio-live.json',JSON.stringify({refresh,pages},null,2));console.log(JSON.stringify({refresh,pages}));
