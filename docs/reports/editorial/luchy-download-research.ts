import fs from 'node:fs';
const b='docs/reports/editorial/';
const u=JSON.parse(fs.readFileSync(b+'luchy-cover-source-urls.json','utf8'));
const jobs=[['dueto-cover.jpg',u.dueto],['voz-piano-front.tif',u.voz_piano[0]],['voz-piano-rear.tif',u.voz_piano[1]],['matices-front.jpg','https://colecciones.agn.gob.do/gestion/descargadoc.php?tipo=guarda&file=00270267_0003.jpg']];
for(const [n,url]of jobs){const r=await fetch(url);if(!r.ok)throw Error(n+' HTTP '+r.status);fs.writeFileSync(b+'luchy-'+n,Buffer.from(await r.arrayBuffer()));console.log(n,r.status);}
