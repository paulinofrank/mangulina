import {readFile,writeFile} from 'node:fs/promises';import * as cheerio from 'cheerio';
const root='docs/audits/2026-10-02/corrections/',receipt=JSON.parse(await readFile(root+'aramis-correction-receipt.json')),snapshot=JSON.parse(await readFile('docs/audits/2026-10-02/catalog-snapshot.json'));
const candidates=receipt.recordings.map(x=>({path:'/es/songs/'+x.after.slug,artist:snapshot.artists.find(a=>a.id===x.after.artist_id).name}));
const urls=[...candidates,{path:'/es/releases/la-combinacion-perfecta-tony-seval',release:true},{path:'/releases/la-combinacion-perfecta-tony-seval',release:true}];
const results=await Promise.allSettled(urls.map(async entry=>{const url='https://www.mangulina.do'+entry.path,r=await fetch(url,{signal:AbortSignal.timeout(45000)});if(!r.ok)throw Error('HTTP '+r.status);const p=cheerio.load(await r.text()),h1=p('h1').text().trim(),title=p('title').text();
if(entry.artist&&!h1.includes(entry.artist))throw Error('Incorrect artist header '+url);
if(entry.release){for(const name of ['Aramis Camilo','El Zafiro','Tony Seval'])if(!title.includes(name))throw Error('Shared metadata missing '+name);const schemas=p('script[type="application/ld+json"]').map((i,e)=>JSON.parse(p(e).text())).get();if(!schemas.some(s=>s['@type']==='MusicAlbum'&&Array.isArray(s.byArtist)&&s.byArtist.length===3))throw Error('Shared schema missing');}
if(entry.artist&&!p('dt').text().toLowerCase().includes('intérprete principal'))throw Error('Incorrect visible performer translation');
return {url,httpStatus:r.status,h1,title,correctArtist:entry.artist??null,sharedRelease:entry.release??false};}));
const result={verifiedAt:new Date().toISOString(),deploymentId:'dpl_kLcYt2KJxgp4cJGH5LFCL9ZJFHGU',checks:results.filter(r=>r.status==='fulfilled').map(r=>r.value),failures:results.flatMap((r,i)=>r.status==='rejected'?[{url:urls[i].path,error:r.reason.message}]:[])};
await writeFile(root+'aramis-production-pages.json',JSON.stringify(result,null,2));console.log(JSON.stringify({verifiedPages:result.checks.length,failures:result.failures}));if(result.failures.length)process.exitCode=1;
