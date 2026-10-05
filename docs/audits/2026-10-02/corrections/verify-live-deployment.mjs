import {writeFile} from 'node:fs/promises';
import * as cheerio from 'cheerio';
const paths=['/es','/en','/es/artists/juan-luis-guerra','/es/artists/alinna-vargas','/es/songs/de-moca-a-paris-juan-luis-guerra-4-40'];
const results=await Promise.allSettled(paths.map(async path=>{
 const url='https://www.mangulina.do'+path,r=await fetch(url,{signal:AbortSignal.timeout(60000)}),html=await r.text(),$=cheerio.load(html);
 return {url,httpStatus:r.status,finalUrl:r.url,title:$('title').text(),hasServerError:/Application error:|Internal Server Error/.test(html),scriptAssets:$('script[src]').map((i,e)=>$(e).attr('src')).get()};
}));
const checks=results.map((r,i)=>r.status==='fulfilled'?r.value:{path:paths[i],error:r.reason.message});
const report={checkedAt:new Date().toISOString(),deploymentId:'dpl_4kjePwdcD8KrERQWJpvGEMBYgRwt',productionUrl:'https://mangulina.do',checks};
await writeFile('docs/audits/2026-10-02/corrections/deployment-verification.json',JSON.stringify(report,null,2));
console.log(JSON.stringify(checks.map(({url,httpStatus,title,hasServerError,error})=>({url,httpStatus,title,hasServerError,error}))));
if(checks.some(c=>c.error||c.httpStatus!==200||c.hasServerError))process.exitCode=1;
