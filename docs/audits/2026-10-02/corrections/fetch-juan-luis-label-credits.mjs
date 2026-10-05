import {readFile,writeFile} from 'node:fs/promises';
import * as cheerio from 'cheerio';
import {createHash} from 'node:crypto';
const root='docs/audits/2026-10-02/corrections/';
const indexUrl='https://www.qobuz.com/us-en/interpreter/juan-luis-guerra/44327';
const response=await fetch(indexUrl,{signal:AbortSignal.timeout(30000)});if(!response.ok)throw Error('Index '+response.status);
const html=await response.text(),$=cheerio.load(html);
const urls=[...new Set($('a[href*="/album/"]').map((i,e)=>new URL($(e).attr('href'),indexUrl).href).get())];
urls.push('https://www.qobuz.com/es-es/album/capitan-avispa-original-motion-picture-soundtrack-juan-luis-guerra-440/h9mzuut1cjy1b');
urls.push('https://www.qobuz.com/us-en/album/literal-juan-luis-guerra-440/vxd50t9m391ac','https://www.qobuz.com/es-es/album/todo-tiene-su-hora-juan-luis-guerra-440/0060254703757','https://www.qobuz.com/us-en/album/areito-juan-luis-guerra-440/i0unam58p2jma','https://www.qobuz.com/es-es/album/ni-es-lo-mismo-ni-es-igual-juan-luis-guerra-440/k288wtop0g9rb','https://www.qobuz.com/us-en/album/la-llave-de-mi-corazon-juan-luis-guerra-440/0094638839255');
const previous=JSON.parse(await readFile(root+'juan-luis-label-credits.json','utf8').catch(()=>'{}'));
urls.push('https://www.qobuz.com/es-es/album/prive-juan-luis-guerra-440/wo32u7jgdj08a');
urls.push('https://www.qobuz.com/es-es/album/para-ti-juan-luis-guerra-440/u8f4aodo95gya','https://www.qobuz.com/es-es/album/coleccion-cristiana-juan-luis-guerra-440/a05dnokyj3gla','https://www.qobuz.com/fr-fr/album/asondeguerra-tour-juan-luis-guerra-440/5099901505252');
const sources=previous.sources??[],failures=[];
const pending=urls.filter(url=>!sources.some(s=>s.url===url));
console.log('Release pages',pending.length);
for(let offset=0;offset<pending.length;offset+=4){
 const results=await Promise.allSettled(pending.slice(offset,offset+4).map(async url=>{
  const r=await fetch(url,{signal:AbortSignal.timeout(30000)});if(!r.ok)throw Error('HTTP '+r.status);
  const body=await r.text(),p=cheerio.load(body);
  const tracks=p('.track').map((i,e)=>{const n=p(e);return {position:Number(n.find('.track__item--number span').first().text()),title:n.find('.track__item--name span').first().text().trim(),artist:n.find('.track__item--artist span').first().text().trim(),credits:n.find('.track__info').map((i,e)=>p(e).text().trim()).get(),duration:n.find('.track__item--duration').text().trim()};}).get();
  if(!tracks.length)throw Error('No track credits');return {url,retrievedAt:new Date().toISOString(),htmlSha256:createHash('sha256').update(body).digest('hex'),title:p('h1').first().text().trim(),tracks};
 }));results.forEach((r,i)=>{if(r.status==='fulfilled')sources.push(r.value);else failures.push({url:pending[offset+i],error:r.reason.message});});
 console.log('Reviewed',Math.min(offset+4,pending.length),'of',pending.length);
}
await writeFile(root+'juan-luis-label-credits.json',JSON.stringify({indexUrl,retrievedAt:new Date().toISOString(),sources,failures},null,2));
console.log(JSON.stringify({sources:sources.length,failures:failures.length}));
