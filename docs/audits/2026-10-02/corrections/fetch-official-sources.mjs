import {writeFile} from 'node:fs/promises';
import * as cheerio from 'cheerio';
import {createHash} from 'node:crypto';
const urls=[
'https://www.qobuz.com/ie-en/album/dos-x-uno-eddy-herrera-los-toros-band/d5m5ax01dyxna',
'https://www.qobuz.com/es-es/album/dos-x-uno-junior-jorge-luis-vargas/mufz3ew3u2sla',
'https://www.qobuz.com/us-en/album/bachata-fest-vol-1-frank-reyes-raulin-rodriguez-zacarias-ferreira/pwy1xz94q4qca',
'https://www.qobuz.com/ie-en/album/bachata-fest-vol-2-yoskar-sarante-joe-veras-alex-bueno/t0ugopvb3j3ub',
'https://www.qobuz.com/us-en/album/dobletazo-luis-vargas-teodoro-reyes/c7xf99nonmcpc',
'https://www.qobuz.com/us-en/album/dos-x-uno-alex-bueno-zacarias-ferreira/o734sl0q7e6hc',
'https://www.qobuz.com/es-es/album/2-grandes-de-la-bachata-vol4-frank-reyes-luis-vargas/0739645048022',
'https://www.qobuz.com/es-es/album/dos-x-uno-frank-reyes-raulin-rodriguez/hoiryk3ec85sb',
'https://www.qobuz.com/ar-es/album/4x4-en-salsa-vol-1-varios-artistas/rq3bbgb91vfka',
'https://www.qobuz.com/gb-en/album/sergio-vargas-y-alex-bueno-sergio-vargas-alex-bueno/c0stvf47mdmta',
'https://www.qobuz.com/se-en/album/vagabundo-robi-draco-rosa/0037628192923',
'https://www.qobuz.com/es-es/album/vagabundo-22-draco-rosa/c0rxk1ng4wuyc',
'https://www.qobuz.com/jp-ja/album/como-me-acuerdo-robi-draco-rosa/xzc1ydonaud9b',
'https://www.qobuz.com/fi-en/album/libertad-del-alma-robi-rosa/qu7jmk96yx7ab',
'https://www.qobuz.com/au-en/album/asi-soy-charlie-cruz/0685738267163',
'https://www.qobuz.com/us-en/album/calipso-clasicos-y-originales-alfrid-valdez-el-rey-del-steel-band/goptnvv89paam',
'https://www.qobuz.com/us-en/album/amor-y-control-ruben-blades/mtmwzwdbdtwyb',
'https://www.qobuz.com/br-pt/album/gracias-a-la-vida-voces-unidas-por-chile-beto-cuevas-juanes-alejandro-sanz-juan-luis-guerra-laura-pausini-fher-de-mana-shakira-michael-buble-miguel-bose/0825646816439',
'https://www.qobuz.com/us-en/album/siembra-ruben-blades-willie-colon/ub6j1forrtscc',
'https://www.qobuz.com/se-en/album/esto-es-vida-draco-rosa-juan-luis-guerra/u97cx6via0yva',
'https://www.qobuz.com/ca-en/album/vida-draco-rosa/0886443579927',
'https://www.qobuz.com/es-es/album/maestra-vida-primera-parte-ruben-blades/bgz5w1720z6nc',
'https://www.qobuz.com/es-es/album/amar-es-combatir-mana/0825646366163',
'https://www.qobuz.com/fr-fr/album/todos-vuelven-live-vol-2-live-ruben-blades-seis-del-solar/vkdimchd8k6sb',
'https://www.qobuz.com/fr-fr/album/frio-robi-rosa/d80eqkhn03k8a',
'https://www.qobuz.com/es-es/album/buscando-america-ruben-blades/0075596035262',
'https://www.qobuz.com/es-es/album/bohemio-y-poeta-ruben-blades/kcy2yel4fszdb'
];
const sources=[];
for(let offset=0;offset<urls.length;offset+=3){const batch=await Promise.allSettled(urls.slice(offset,offset+3).map(async url=>{const response=await fetch(url,{signal:AbortSignal.timeout(30000)});if(!response.ok)throw Error('HTTP '+response.status);const html=await response.text();const $=cheerio.load(html);const tracks=$('.track').map((i,e)=>{const node=$(e);const credits=node.find('.track__info').map((i,e)=>$(e).text().trim()).get();return {position:Number(node.find('.track__item--number span').first().text()),title:node.find('.track__item--name span').first().text().trim(),artist:node.find('.track__item--artist span').first().text().trim(),credits,duration:node.find('.track__item--duration').text().trim()}}).get();if(!tracks.length)throw Error('No tracks');return {url,retrievedAt:new Date().toISOString(),htmlSha256:createHash('sha256').update(html).digest('hex'),title:$('h1').first().text().trim(),tracks};}));batch.forEach((result,i)=>{if(result.status==='fulfilled'){sources.push(result.value);console.log(result.value.title,result.value.tracks.length)}else console.log('FAILED',urls[offset+i],result.reason.message)})}
await writeFile('docs/audits/2026-10-02/corrections/official-release-credits.json',JSON.stringify(sources,null,2));
