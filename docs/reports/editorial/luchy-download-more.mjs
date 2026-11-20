import fs from 'node:fs';
const b='docs/reports/editorial/';const u=JSON.parse(fs.readFileSync(b+'luchy-additional-download-urls.json','utf8'));for(const[n,url]of Object.entries(u)){const r=await fetch(url);if(r.ok){fs.writeFileSync(b+'luchy-'+n+'.jpg',Buffer.from(await r.arrayBuffer()));console.log(n,'OK');}else console.log(n,r.status);}
