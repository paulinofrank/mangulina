import fs from 'node:fs/promises';
const b='docs/reports/editorial/';
const sources=JSON.parse(await fs.readFile(b+'dhariana-vinyl-image-sources.json','utf8'));
const unique=[...new Set(sources.map(x=>x.src))];
for(let i=0;i<unique.length;i++){const r=await fetch(unique[i]);if(!r.ok)throw Error(String(r.status));await fs.writeFile(b+`dhariana-covers/ven-a-amarme-${i}.jpg`,Buffer.from(await r.arrayBuffer()));}
const ex=JSON.parse(await fs.readFile(b+'dhariana-exitos-spotify.json','utf8'));const r=await fetch(ex.images[0].src);if(!r.ok)throw Error(String(r.status));await fs.writeFile(b+'dhariana-covers/exitos.jpg',Buffer.from(await r.arrayBuffer()));
const url='https://itunes.apple.com/lookup?id=1599235699&entity=song&country=us';const a=await fetch(url);const data=await a.json();await fs.writeFile(b+'dhariana-apple-1599235699.json',JSON.stringify({url,data},null,2));console.log(JSON.stringify({images:unique.length+1,exitosApple:data.resultCount}));
