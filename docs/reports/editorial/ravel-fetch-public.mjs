import fs from 'node:fs/promises';
const base='docs/reports/editorial/';
for (const id of ['1196846231','1807231614','1808309604','1794652512','1803896536']) {
 const url=`https://itunes.apple.com/lookup?id=${id}&entity=${id==='1196846231'?'album':'song'}&limit=200&country=us`;
 try {const r=await fetch(url); if(!r.ok)throw Error(String(r.status));const data=await r.json();await fs.writeFile(`${base}ravel-apple-${id}.json`,JSON.stringify({source_url:url,retrieved_at:new Date().toISOString(),...data},null,2));console.log(id,JSON.stringify(data.results.map(x=>({type:x.wrapperType,title:x.collectionName||x.trackName,id:x.collectionId,tracks:x.trackCount}))));} catch(e){console.log(id,String(e));}
}
