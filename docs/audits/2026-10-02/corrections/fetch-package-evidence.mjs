import {writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
const url='https://coverartarchive.org/release/b2292ff5-f723-4d66-9b9b-a4e959b95aa7';
const response=await fetch(url,{signal:AbortSignal.timeout(30000)});if(!response.ok)throw Error('Archive '+response.status);
const data=await response.json();
const sources=[];
for(const item of data.images){
 const r=await fetch(item.image,{signal:AbortSignal.timeout(30000)});if(!r.ok)throw Error('Scan '+r.status);
 const bytes=Buffer.from(await r.arrayBuffer());const file='docs/audits/2026-10-02/corrections/encuentro-'+(item.back?'back':'front')+'.jpg';
 await writeFile(file,bytes);sources.push({url:item.image,archiveUrl:url,file,types:item.types,retrievedAt:new Date().toISOString(),sha256:createHash('sha256').update(bytes).digest('hex')});
}
await writeFile('docs/audits/2026-10-02/corrections/package-evidence.json',JSON.stringify(sources,null,2));console.log(JSON.stringify(sources));
