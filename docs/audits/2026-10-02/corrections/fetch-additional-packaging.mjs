import {readFile,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
const root='docs/audits/2026-10-02/corrections/';
const packages=[['fiesta-latina','a4f66633-e31d-4269-a9bc-c48b2d07143b'],['hasta-el-fin','670e06e5-9531-4f16-8b03-a1bc4229fa51'],['fogarate','ccde26e9-37c2-49d2-b033-241ef65aaf92'],['areito','6fcc2841-fc98-4c7d-a285-23cd8429bd18']];
const sources=JSON.parse(await readFile(root+'additional-package-evidence.json','utf8').catch(()=>'[]'));
for(const [name,id] of packages){
 if(sources.some(s=>s.package===name))continue;
 const url='https://coverartarchive.org/release/'+id;
 const response=await fetch(url,{signal:AbortSignal.timeout(30000)});
 if(!response.ok)throw Error('Archive '+response.status);
 const data=await response.json();
 for(const [index,item] of data.images.entries()){
  if(item.front&&!item.back)continue;
  const r=await fetch(item.image,{signal:AbortSignal.timeout(30000)});if(!r.ok)throw Error('Scan '+r.status);
  const bytes=Buffer.from(await r.arrayBuffer()),file=root+name+'-'+index+'.jpg';
  await writeFile(file,bytes);sources.push({package:name,url:item.image,archiveUrl:url,file,types:item.types,retrievedAt:new Date().toISOString(),sha256:createHash('sha256').update(bytes).digest('hex')});
 }
}
await writeFile(root+'additional-package-evidence.json',JSON.stringify(sources,null,2));
console.log(JSON.stringify(sources));
