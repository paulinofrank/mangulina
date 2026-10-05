import {readFile,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import * as cheerio from 'cheerio';
const urls=[
'https://www.qobuz.com/us-en/album/dos-generaciones-wilfrido-vargas-alinna-vargas/o6w1vzxq8eu7b',
'https://www.qobuz.com/fr-fr/album/los-30-de-kinito-kinito-mendez/segr4b1m10rza',
'https://www.qobuz.com/es-es/album/nueva-vida-miriam-y-las-chicas/xxn2o6996wzpc',
'https://www.qobuz.com/us-en/album/brindo-con-agua-aventura/b69t5knjxcxwa',
'https://www.miriamcruz.com/',
'https://juanluisguerra.com/historia/',
'https://www.youtube.com/watch?v=e5wN1g3SbMU',
'https://www.qobuz.com/nz-en/album/hasta-el-fin-monchy-alexandra/fgflok2q7pjlb',
'https://www.qobuz.com/us-en/album/grandes-exitos-alex-bueno/a05er0am73rca',
'https://music.apple.com/us/song/157780362',
'https://music.apple.com/us/album/el-pichirri-feat-kiko-el-crazy-cherry-scom-ito-gamy-single/1495066844',
'https://www.youtube.com/watch?v=yJkucryHDz4',
'https://www.youtube.com/watch?v=SeRYbpX6GCg',
'https://korvenbrox.com/',
'https://korvenbrox.bandcamp.com/',
'https://music.apple.com/us/album/estoy-atrapado-grunjeo-single/1812207695',
'https://music.apple.com/us/album/el-duro-soy-yo-en-reggaeton/1517925562',
'https://www.qobuz.com/se-en/album/grandes-exitos-de-alex-bueno-en-bachata-alex-bueno/ah3meo5yba9bb',
'https://music.apple.com/us/album/frente-a-frente-2023-remastered/1717613866',
'https://music.apple.com/us/album/the-mix/27044901',
'https://www.youtube.com/watch?v=ltn1fMQf1Mc',
'https://www.qobuz.com/ch-fr/album/frente-a-frente-dos-estrellas-en-uno-anthony-santos-raulin-rodriguez/snnnr88p0n21b',
'https://www.beatport.com/label/platano-records/168716/tracks?page=1&per_page=150',
'https://www.youtube.com/watch?v=TsaPY7tmvF4',
'https://www.youtube.com/watch?v=_mRrSu-Eu-s',
'https://www.youtube.com/watch?v=HtzQ_bfdLVc',
'https://www.youtube.com/watch?v=a-78bGQLN4U',
'https://music.apple.com/us/song/1717614018',
'https://www.youtube.com/watch?v=5pHbYSOu2JY',
'https://music.amazon.co.uk/albums/B07RWQ59CF',
'https://music.apple.com/us/song/1463836798',
'https://www.youtube.com/watch?v=f7vec7XBnLM',
'https://www.youtube.com/watch?v=S2p1haCVscw'];
const path='docs/audits/2026-10-02/corrections/remaining-official-sources.json';
const previous=JSON.parse(await readFile(path,'utf8').catch(()=>'{}'));
const pending=urls.filter(url=>!previous.sources?.some(s=>s.url===url));
const results=await Promise.allSettled(pending.map(async url=>{
 const r=await fetch(url,{signal:AbortSignal.timeout(45000)});if(!r.ok)throw Error('HTTP '+r.status);
 const body=await r.text(),p=cheerio.load(body);
 return {url,retrievedAt:new Date().toISOString(),htmlSha256:createHash('sha256').update(body).digest('hex'),title:p('h1').first().text().trim()||p('title').text(),tracks:p('.track').map((i,e)=>{const n=p(e);return {position:Number(n.find('.track__item--number span').first().text()),title:n.find('.track__item--name span').first().text().trim(),credits:n.find('.track__info').map((i,e)=>p(e).text().trim()).get(),duration:n.find('.track__item--duration').text().trim()};}).get(),...(url.includes('qobuz')?{}:{evidenceText:p('body').text().replace(/\s+/g,' ').slice(0,22000)})};
}));
const sources=[...(previous.sources??[]),...results.filter(x=>x.status==='fulfilled').map(x=>x.value)],failures=results.flatMap((x,i)=>x.status==='rejected'?[{url:pending[i],error:x.reason.message}]:[]);
await writeFile(path,JSON.stringify({sources,failures},null,2));
console.log(JSON.stringify({sources:sources.length,failures}));
