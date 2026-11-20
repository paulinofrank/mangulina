import fs from 'node:fs';
import assert from 'node:assert/strict';
const targets=[{path:'/es/artists/solo-fernandez',link:'/es/artists/martox'},{path:'/en/artists/martox',link:'/en/artists/nikola'},{path:'/es/artists/dhariana',link:'/es/artists/milton-pelaez'}];
const results=[];
for(const t of targets){const r=await fetch('https://mangulina.do'+t.path);const html=await r.text();const links=[...html.matchAll(/<a\b[^>]*href="([^"]+)"[^>]*>([\s\S]*?)<\/a>/g)].filter(x=>x[1]===t.link);results.push({...t,status:r.status,matching_anchors:links.map(x=>x[0]),cache:r.headers.get('x-vercel-cache')});}
fs.writeFileSync('docs/reports/editorial/session-bio-links-live.json',JSON.stringify(results,null,2));
for(const r of results){assert.equal(r.status,200);assert.ok(r.matching_anchors.length>0,JSON.stringify(r));}console.log(JSON.stringify(results));
