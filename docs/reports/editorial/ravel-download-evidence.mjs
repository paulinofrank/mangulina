import fs from 'node:fs/promises';
import {createHash} from 'node:crypto';
const b='docs/reports/editorial/';await fs.mkdir(b+'ravel-covers',{recursive:true});
const albums=JSON.parse(await fs.readFile(b+'ravel-allmusic-evidence.json','utf8'));
const vinyl=JSON.parse(await fs.readFile(b+'ravel-con-sentimiento-ebay.json','utf8'));
const images=[...albums.flatMap((a,i)=>a.covers.filter(x=>!x.src.includes('no_image')).slice(0,1).map(x=>({title:a.title,url:x.src,file:`album-${i}.jpg`}))),...vinyl.images.filter(x=>x.src.includes('s-l1600')).map((x,i)=>({title:x.alt,url:x.src,file:`con-sentimiento-${i}.webp`})),{title:'Como Tu Lo Querias — digital LF Productions edition',url:'https://m.media-amazon.com/images/I/51d7DPUgPoL._UX358_FMwebp_QL85_.jpg',file:'como-digital.jpg'}];
for(const x of images){try{const r=await fetch(x.url);if(!r.ok)throw Error(String(r.status));const v=Buffer.from(await r.arrayBuffer());await fs.writeFile(b+'ravel-covers/'+x.file,v);x.sha256=createHash('sha256').update(v).digest('hex');x.bytes=v.length;console.log(x.file,v.length);}catch(e){x.error=String(e);}}
await fs.writeFile(b+'ravel-covers/manifest.json',JSON.stringify(images,null,2));
