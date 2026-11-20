import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {collectEditorialReferences} from '../../../src/lib/editorial/references';

// Local preparation only. This script contains no network or database writes.
const dir='docs/reports/editorial/';
const read=(file:string)=>JSON.parse(fs.readFileSync(dir+file,'utf8'));
const base=read('440-biographies-before-2026-11-03.json');
const extra=read('440-related-biographies-before-2026-11-04.json');
const drafts=read('440-biography-drafts-2026-11-04.json');
const patches=read('440-biography-patches-2026-11-04.json');
const artists=[...base.artists,...extra.artists];
const documents=[...base.documents,...extra.documents];
const catalog=new Map<string,any>();
for(const a of [...artists,...read('440-biography-reference-targets-2026-11-04.json')])catalog.set(a.name,a);
function walk(n:any,fn:(n:any)=>void){if(!n||typeof n!=='object')return;fn(n);for(const child of n.content??[])walk(child,fn);}
for(const d of documents)walk(d.document,n=>{if(n.type==='artistReference'&&!catalog.has(n.attrs.displayText))catalog.set(n.attrs.displayText,{id:n.attrs.artistId,name:n.attrs.displayText,status:'existing_unverified'});});
function template(n:any):string{if(n.type==='text')return n.text;if(n.type==='artistReference')return `[[${n.attrs.displayText}]]`;return (n.content??[]).map(template).join('');}
function queue(doc:any){const q=new Map<string,any[]>();walk(doc,n=>{if(n.type==='artistReference'){const arr=q.get(n.attrs.displayText)??[];arr.push(structuredClone(n));q.set(n.attrs.displayText,arr);}});return q;}
function inline(s:string,q:Map<string,any[]>){const nodes:any[]=[];let pos=0;for(const m of s.matchAll(/\[\[([^\]]+)\]\]/g)){const at=m.index!;if(at>pos)nodes.push({type:'text',text:s.slice(pos,at)});const a=catalog.get(m[1]);assert.ok(a,`Unknown artist ${m[1]}`);const existing=q.get(m[1])?.shift();nodes.push(existing??{type:'artistReference',attrs:{occurrenceId:randomUUID(),artistId:a.id,displayText:a.name}});pos=at+m[0].length;}if(pos<s.length)nodes.push({type:'text',text:s.slice(pos)});assert.ok(nodes.length);return nodes;}
function paragraph(s:string,q=new Map<string,any[]>()){const h=s.match(/^\*\*(.+)\*\*$/);return h?{type:'paragraph',content:[{type:'text',text:h[1],marks:[{type:'bold'}]}]}:{type:'paragraph',content:inline(s,q)};}
function parse(s:string,old:any){const q=queue(old);return {type:'doc',content:s.trim().split(/\n\s*\n/).map(x=>paragraph(x.replace(/\n/g,' '),q))};}
function mirror(n:any):string{if(n.type==='text')return n.marks?.some((m:any)=>m.type==='bold')?`**${n.text}**`:n.text;if(n.type==='artistReference')return n.attrs.displayText;if(n.type==='hardBreak')return '  \n';if(n.type==='bulletList')return n.content.map((x:any)=>'- '+mirror(x)).join('  \n');return (n.content??[]).map(mirror).join(n.type==='doc'?'\n\n':'');}
function replaceKnownMention(node:any,name:string){walk(node,n=>{if(n.type!=='paragraph')return;const s=template(n);if(s.includes(name)&&!s.includes(`[[${name}]]`))n.content=inline(s.replaceAll(name,`[[${name}]]`),queue(n));});}
const changes:any[]=[];
for(const d of documents){
  const a=artists.find((a:any)=>a.id===d.owner_artist_id);const slug=a.slug,locale=d.locale;
  if(!drafts[slug]&&!['adalgisa-pantaleon','juan-luis-guerra','maridalia-hernandez','frank-ceara','fefita-la-grande','claudio-cohen','hector-anibal'].includes(slug))continue;
  let after=structuredClone(d.document);
  if(drafts[slug])after=parse(drafts[slug][locale],d.document);
  for(const p of patches.filter((p:any)=>p.slug===slug&&p.locale===locale)){
    if(p.insertBeforeLegacy){const idx=after.content.findIndex((n:any)=>['Legacy','Legado'].includes(template(n)));assert.ok(idx>0);after.content.splice(idx,0,paragraph(p.insertBeforeLegacy));}
    else{assert.ok(after.content[p.index]);after.content[p.index]=paragraph(p.text,queue(after.content[p.index]));}
  }
  if(slug==='adalgisa-pantaleon'){
    for(const n of after.content){if(template(n).includes('«4.40»'))n.content=inline(template(n).replaceAll('«4.40»','[[Grupo 440]]'),queue(n));}
  }
  if(slug==='juan-luis-guerra'){
    const titles=['Ojalá que llueva café','Bachata Rosa','Areíto','Fogárate','Fogáraté','Ni es lo mismo ni es igual','Para Ti','Mi Jesús'];
    walk(after,n=>{if(n.type!=='text')return;for(const title of titles){const escaped=title.replace(/[.*+?^${}()|[\]\\]/g,'\\$&');n.text=n.text.replace(new RegExp(`(?<![«“])${escaped}(?![»”])`,'g'),`«${title}»`);}n.text=n.text.replaceAll('“Mi Jesús”','«Mi Jesús»').replaceAll('Fogárate','Fogaraté').replaceAll('Fogáraté','Fogaraté').replaceAll('the Beatles','«The Beatles»');});
  }
  if(slug==='frank-ceara'){
    const theatre=after.content.find((n:any)=>template(n).includes('«Los Miserables»'));
    assert.ok(theatre,'Locate existing musical-theatre paragraph');
    theatre.content=inline(template(theatre)+(locale==='en'?' In 2022 he portrayed Rafael Trujillo in the musical «Mariposas de acero».':' En 2022 interpretó a Rafael Trujillo en el musical «Mariposas de acero».'),queue(theatre));
    const idx=after.content.findIndex((n:any)=>['Legacy','Legado'].includes(template(n)));assert.ok(idx>0);
    after.content.splice(idx,0,paragraph(locale==='en'?'In 2026 he presented «Íntimo» with [[Adalgisa Pantaleón]], sharing songs and stories in a small-format show at the National Theatre’s Juan Lockward bar. The programme continued with further performances in Santo Domingo and Santiago, accompanied by Emil Pimentel on piano and musical direction and Eudy David on percussion.':'En 2026 presentó «Íntimo» junto a [[Adalgisa Pantaleón]], un espectáculo de canciones y anécdotas en pequeño formato en el bar Juan Lockward del Teatro Nacional. La propuesta continuó con nuevas funciones en Santo Domingo y Santiago, con Emil Pimentel al piano y en la dirección musical, y Eudy David en la percusión.'));
  }
  if(slug==='fefita-la-grande'){
    let changed=0;walk(after,n=>{if(n.type==='text'&&n.text.includes('2019')){n.text=n.text.replace('2019','2017');changed++;}if(n.type==='text')n.text=n.text.replace(/(?<!«)La Pimienta Es la Que Pica(?!»)/g,'«La pimienta es la que pica»');});assert.equal(changed,1);
  }
  if(slug==='claudio-cohen')replaceKnownMention(after,'Maridalia Hernández');
  if(slug==='hector-anibal'){
    const lead=after.content[0];let changed=0;walk(lead,n=>{if(n.type==='text'){const from=locale==='es'?', integrante de la agrupación de ':', a member of ';if(n.text.includes(from)){n.text=n.text.replace(from,locale==='es'?', conocida por su prolongada trayectoria con ':', known for her long association with ');changed++;}}});assert.equal(changed,1,'Héctor lead wording changed; inspect before continuing');
  }
  const validation=validateEditorialDocument(1,after);assert.ok(validation.ok,JSON.stringify(validation));
  const references=collectEditorialReferences(1,after);
  walk(after,n=>{if(n.type==='artistReference')assert.equal(catalog.get(n.attrs.displayText)?.id,n.attrs.artistId);});
  assert.equal(template(after.content[0]).length>0,true);
  changes.push({owner_id:a.id,name:a.name,slug,document_id:d.id,locale,expected_revision:d.revision,status_before:d.status,status_after:d.status,before:d.document,after,mirror_before:a['bio_'+locale]??null,mirror_after:mirror(after),references_after:references});
}
const manifest={state:'PROPOSED — NOT APPLIED',prepared_at:new Date().toISOString(),scope:'Biography documents and synchronized reference relations/compatibility mirrors only',changes};
fs.writeFileSync(dir+'440-biography-change-manifest-2026-11-04.json',JSON.stringify(manifest,null,2));
fs.writeFileSync(dir+'440-biographies-proposed-2026-11-04.md',changes.map(c=>`# ${c.name} — ${c.locale.toUpperCase()}\n\nDocument ${c.document_id}; expected revision ${c.expected_revision}; status ${c.status_before}.\n\n${c.mirror_after}`).join('\n\n---\n\n'));
console.log(JSON.stringify(changes.map(c=>({name:c.name,locale:c.locale,revision:c.expected_revision,references:c.references_after.length})),null,2));
