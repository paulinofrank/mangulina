import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';
dotenv.config({quiet:true});
assert.ok(process.env.REVALIDATION_TOKEN,'Targeted refresh credential unavailable');
let refreshResult;
if(process.argv.includes('--verify-only'))refreshResult={previous_call:'One targeted refresh already succeeded (HTTP 200, ok true); not repeated.'};
else {const refresh=await fetch('https://mangulina.do/api/revalidate',{method:'POST',headers:{'content-type':'application/json',authorization:'Bearer '+process.env.REVALIDATION_TOKEN},body:JSON.stringify({artists:['carlos-silver']})});refreshResult={status:refresh.status,body:await refresh.json()};assert.equal(refresh.status,200);assert.equal(refreshResult.body.ok,true);}
const result={refresh:refreshResult,pages:[]};
for(const locale of ['es','en']){
 const path='/'+locale+'/artists/carlos-silver';const r=await fetch('https://mangulina.do'+path);const html=await r.text();const rendered=html.replace(/<script\b[^>]*>[\s\S]*?<\/script>/gi,'');const check={path,status:r.status,new_bio:rendered.includes('PROPEEP')&&rendered.includes('Vientos de Bohemia'),removed_claim_absent:!rendered.includes('El Camaleón'),elvis_link:rendered.includes('/'+locale+'/artists/elvis-cabrera'),cache:r.headers.get('x-vercel-cache')};result.pages.push(check);
 assert.equal(check.status,200);assert.ok(check.new_bio);assert.ok(check.removed_claim_absent);assert.ok(check.elvis_link);
}
fs.writeFileSync('docs/reports/editorial/carlos-silver-update-live.json',JSON.stringify(result,null,2));console.log(JSON.stringify(result));
