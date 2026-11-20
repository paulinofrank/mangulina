import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';

const dir='docs/reports/editorial/';
const before=JSON.parse(fs.readFileSync(dir+'ten-bios-before-2026-10-30.json','utf8'));
const adalgisa=JSON.parse(fs.readFileSync(dir+'adalgisa-rewrite-content-2026-10-30.json','utf8'));
const four=JSON.parse(fs.readFileSync(dir+'four-bio-rewrites-content-2026-10-30.json','utf8'));
const out=dir+'ten-bios-update-manifest-v2-2026-10-30.json';
assert.ok(!fs.existsSync(out),'Frozen manifest already exists');
assert.equal(before.artists.length,10);assert.equal(before.documents.length,20);
const refs:Record<string,string>={
  'Madiel Lara':'426d767e-4484-4fac-a9ba-215cbe23da4c',
  'Niko Eme':'d9b150f7-2399-40a9-adff-d9dd4c36732d',
  'Lil Naay':'c3307832-05e9-43ce-a575-56d463ffbbc1',
  'Mala Fe':'74b60ddd-3a3d-4983-8ff7-6fdf5f0513ed',
  'Juan Luis Guerra':'10034596-47cb-46ba-9e80-9ea319a2c0df',
  'Rafael Solano':'ba42e200-51b0-437b-99ac-1daf39ade337',
  'Jorge Taveras':'c958758c-a949-4bd9-963d-6d48bc750b60',
  'Frank Ceara':'aa733322-d3a4-4fe7-bf61-65f3425a8ed7',
};
function walk(v:any,fn:(n:any)=>void){if(Array.isArray(v)){for(const x of v)walk(x,fn);}else if(v&&typeof v==='object'){fn(v);for(const x of Object.values(v))walk(x,fn);}}
for(const d of before.documents)walk(d.document,n=>{if(n.type==='artistReference'){const name=n.attrs.displayText,id=n.attrs.artistId;if(refs[name]&&refs[name]!==id)throw Error(`Conflicting reference ${name}`);refs[name]=id;}});
function refCount(doc:any){let count=0;walk(doc,n=>{if(n.type==='artistReference')count++;});return count;}
function refIds(doc:any){const out:string[]=[];walk(doc,n=>{if(n.type==='artistReference')out.push(n.attrs.artistId);});return out;}
function existingQueue(value:any){const q=new Map<string,any[]>();walk(value,n=>{if(n.type==='artistReference'){const name=n.attrs.displayText;const bucket=q.get(name)??[];bucket.push(structuredClone(n));q.set(name,bucket);}});return q;}
function inline(template:string,queue:Map<string,any[]>){const nodes:any[]=[];let pos=0;for(const m of template.matchAll(/\[\[([^\]]+)\]\]/g)){if((m.index??0)>pos)nodes.push({type:'text',text:template.slice(pos,m.index)});const name=m[1];const id=refs[name];assert.ok(id,`Unknown reference target ${name}`);const old=queue.get(name)?.shift();nodes.push(old??{type:'artistReference',attrs:{artistId:id,occurrenceId:randomUUID(),displayText:name}});pos=(m.index??0)+m[0].length;}if(pos<template.length)nodes.push({type:'text',text:template.slice(pos)});assert.ok(nodes.length>0);return nodes;}
function paragraph(template:string,queue=new Map<string,any[]>()){return {type:'paragraph',content:inline(template,queue)};}
function heading(label:string){return {type:'paragraph',content:[{type:'text',text:label,marks:[{type:'bold'}]}]};}
function parseBiography(markdown:string,old:any){assert.equal(typeof markdown,'string');const chunks=markdown.trim().replace(/\r\n/g,'\n').split(/\n\s*\n/);const queue=existingQueue(old);const content:any[]=[];for(const raw of chunks){const s=raw.trim().replace(/\n/g,' ');const h=s.match(/^\*\*(.+)\*\*$/);if(h)content.push(heading(h[1]));else{assert.ok(!s.includes('**'),'No inline bold');content.push(paragraph(s,queue));}}assert.ok(content.length>=3);return {type:'doc',content};}
function plain(block:any){return (block.content??[]).map((n:any)=>n.type==='artistReference'?`[[${n.attrs.displayText}]]`:n.text??'').join('');}
function setParagraph(doc:any,index:number,template:string){const old=doc.content[index];assert.equal(old.type,'paragraph');doc.content[index]=paragraph(template,existingQueue(old));}
function replaceLiteral(doc:any,index:number,from:string,to:string,expected=1){const block=doc.content[index];assert.ok(block?.content,`No block ${index}`);let n=0;for(const node of block.content){if(node.type!=='text')continue;const hits=node.text.split(from).length-1;if(hits){node.text=node.text.replaceAll(from,to);n+=hits;}}assert.equal(n,expected,`Block ${index}: ${from} (${n} hits)`);}
function quote(doc:any,index:number,title:string){const block=doc.content[index];assert.ok(block?.content);const escaped=title.replace(/[.*+?^${}()|[\]\\]/g,'\\$&');const re=new RegExp(`(?<!«)${escaped}(?!»)`, 'g');let n=0;for(const node of block.content){if(node.type!=='text')continue;node.text=node.text.replace(re,()=>{n++;return `«${title}»`;});}assert.ok(n>=1,`Missing unquoted ${title} in block ${index}`);}
function addLegacy(doc:any,locale:'en'|'es',text:string){const label=locale==='en'?'Legacy':'Legado';assert.notEqual(plain(doc.content.at(-2)),label,`Already has ${label}`);doc.content.push(heading(label),paragraph(text));}
function mirror(doc:any){return doc.content.map((block:any)=>{assert.equal(block.type,'paragraph');const content=block.content??[];const isHeading=content.length===1&&content[0].type==='text'&&content[0].marks?.length===1&&content[0].marks[0].type==='bold';const value=content.map((node:any)=>{if(node.type==='artistReference')return node.attrs.displayText;assert.equal(node.type,'text');return node.text;}).join('');return isHeading?`**${value}**`:value;}).join('\n\n');}
function docFor(slug:string,locale:string){const a=before.artists.find((x:any)=>x.slug===slug);assert.ok(a,slug);const d=before.documents.find((x:any)=>x.owner_artist_id===a.id&&x.locale===locale);assert.ok(d,`${slug} ${locale}`);assert.equal(d.status,'published');return {a,d};}

const sources:Record<string,string[]>={
 '23thierno':['https://music.amazon.es/albums/B0DMBVML99'],
 'ada-betsabe':['https://music.apple.com/us/album/el-fin-se-acerca/6799277263','https://music.apple.com/us/album/uno-cinco-feat-ada-betsabe-arias-ftw/1730092622?i=1730092816','https://music.apple.com/us/album/lottery-single/1745457184','https://music.apple.com/us/artist/ada-betsabe/1025362156','https://zonavertical.com/ada-betsabe-biografia/'],
 'adonis-produciendo':['Catalog artist row Lil Naay c3307832-05e9-43ce-a575-56d463ffbbc1'],
 'agapito-pascual':['https://lapuertadigital.com/agapito-pascual-musico-del-merengue-tipico-que-modernizo-el-ritmo/'],
 'aguakate':['https://open.spotify.com/album/6o6WPv2bTxCno2RKWXu7jK','https://almomento.net/el-merenguero-raul-acosta-lanza-album-el-congreso-del-merengue/'],
};
const changes:any[]=[];
for(const slug of before.artists.map((a:any)=>a.slug))for(const locale of ['en','es'] as const){
  const {a,d}=docFor(slug,locale);let after:any;
  if(slug==='adalgisa-pantaleon'||slug in four){const entry=slug==='adalgisa-pantaleon'?adalgisa:four[slug];after=parseBiography(entry[locale],d.document);}
  else {after=structuredClone(d.document);
    if(slug==='23thierno'){
      replaceLiteral(after,2,'«With “U”»','«With "U"»');
      replaceLiteral(after,2,locale==='en'?'his most recent single, «Nena», is dated':'su sencillo más reciente, «Nena», lleva fecha',locale==='en'?'«Nena» is dated':'«Nena» lleva fecha');
    }
    if(slug==='ada-betsabe'){
      setParagraph(after,0,locale==='en'?'Ada Betsabé (born 29 January 1991 in Santo Domingo) is a Dominican Christian rapper, songwriter and producer whose recordings move between Spanish and English. She founded the label «Nuevopact Records» in 2015.':'Ada Betsabé (nacida el 29 de enero de 1991 en Santo Domingo) es una rapera, compositora y productora cristiana dominicana con grabaciones en español e inglés. En 2015 fundó el sello «Nuevopact Records».');
      replaceLiteral(after,3,locale==='en'?'Nuevopact Records and first recordings':'Nuevopact Records y primeras grabaciones',locale==='en'?'«Nuevopact Records» and first recordings':'«Nuevopact Records» y primeras grabaciones');
      setParagraph(after,4,locale==='en'?'In 2015, at twenty-four, she founded her own label, «Nuevopact Records». Her album «Freedom» followed in 2016.':'En 2015, a los veinticuatro años, fundó su propio sello, «Nuevopact Records». Su álbum «Freedom» llegó en 2016.');
      setParagraph(after,5,locale==='en'
        ?'«Mi Escudo», «Santo», «Alive», «Vengan» and the English-language «Sparrow» belong to her early recordings. The «Personal» EP followed in 2018 with «Emotional», «Corazón», «Tu Nombre», «God Body» and «Suficiente» with Sueezy. That year she also released «Trapstorno (Versión Femenina)», responding to [[Redimi2]]’s track from a woman’s perspective, and appeared on [[Madiel Lara]]’s «Uno Cinco» with Arias FTW.'
        :'«Mi Escudo», «Santo», «Alive», «Vengan» y «Sparrow», este último en inglés, figuran entre sus primeras grabaciones. En 2018 publicó el EP «Personal», con «Emotional», «Corazón», «Tu Nombre», «God Body» y «Suficiente» junto a Sueezy. Ese mismo año lanzó «Trapstorno (Versión Femenina)», respuesta al tema de [[Redimi2]] desde la perspectiva de una mujer, y participó en «Uno Cinco» de [[Madiel Lara]] junto a Arias FTW.');
      for(const title of ['Masterpiece','La Vía','4:13','Apunta','Alarma','¿Ahora Qué?','Solita'])quote(after,7,title);
      replaceLiteral(after,8,'El Fin Se Acerca', '«El Fin Se Acerca»');
      setParagraph(after,9,locale==='en'
        ?'«El Fin Se Acerca», a nine-track album released in September 2023, opens with «Inmortal (Intro)». Its songs include «Trono» with CH Gedeones, «Pecado» with [[Natan El Profeta]] and «¿Ahora Qué?». Other collaborations in her catalogue include «Intervención» with Tbabz, «No Se Va» with [[La Noe Aposento Alto]] and «Alguien Como Tú» alongside [[Lizzy Parra]] and [[Angel Brown]]. In 2025 she recorded «Súbele» with Rambo Cristiano; she continued releasing music in 2026.'
        :'En septiembre de 2023 publicó el álbum de nueve temas «El Fin Se Acerca», que abre con «Inmortal (Intro)». Incluye «Trono» con CH Gedeones, «Pecado» con [[Natan El Profeta]] y «¿Ahora Qué?». Entre otras colaboraciones figuran «Intervención» con Tbabz, «No Se Va» con [[La Noe Aposento Alto]] y «Alguien Como Tú» junto a [[Lizzy Parra]] y [[Angel Brown]]. En 2025 grabó «Súbele» con Rambo Cristiano; en 2026 continuó publicando música.');
      setParagraph(after,11,locale==='en'
        ?'She raps in Spanish and English, often inside the same song. «Sin Límites» was billed as a Spanglish Remix, and «Lottery», recorded with [[Niko Eme]] in 2018, as Spanglish Trap; «Cuenta – Blessings» was identified as a Spanglish Cover. English songs such as «Sparrow», «Alive» and «The Cure» coexist with «Mi Escudo», «Santo» and «De Rodillas». She describes her language as Spanglish.'
        :'Rapea en español y en inglés, a menudo dentro de una misma canción. «Sin Límites» se presentó como Spanglish Remix y «Lottery», grabada con [[Niko Eme]] en 2018, como Spanglish Trap; «Cuenta – Blessings» se identificó como Spanglish Cover. Temas en inglés como «Sparrow», «Alive» y «The Cure» conviven con «Mi Escudo», «Santo» y «De Rodillas». Ella describe su idioma de trabajo como spanglish.');
      replaceLiteral(after,13,'Real Vida TV','«Real Vida TV»');
      addLegacy(after,locale,locale==='en'?'Her albums «Freedom» (2016), «Masterpiece» (2020) and «El Fin Se Acerca» (2023) document a rap catalogue that moves between Spanish and English while keeping Christian themes at its centre.':'Sus álbumes «Freedom» (2016), «Masterpiece» (2020) y «El Fin Se Acerca» (2023) documentan un catálogo de rap entre el español y el inglés con una temática cristiana constante.');
    }
    if(slug==='adonis-produciendo'){
      const s=plain(after.content[4]);assert.ok(s.includes('Lil Naay'));setParagraph(after,4,s.replace('Lil Naay','[[Lil Naay]]'));
    }
    if(slug==='agapito-pascual'){
      setParagraph(after,0,locale==='en'?'Agapito Pascual (born 24 June 1962), also known as A lo Moderno, is a Dominican merengue típico accordionist, singer and composer. He played tambora before learning the accordion and founding his own conjunto in 1987.':'Agapito Pascual (nacido el 24 de junio de 1962), conocido como A lo Moderno, es un acordeonista, cantante y compositor dominicano de merengue típico. Tocó la tambora antes de aprender acordeón y formar su propio conjunto en 1987.');
      setParagraph(after,2,locale==='en'?'He was born in La Balsa de La Isabela, Puerto Plata. He began working in agriculture and shining shoes at seven, the age at which he also started to play tambora. Six of his siblings became musicians.':'Nació en La Balsa de La Isabela, Puerto Plata. A los siete años comenzó a trabajar en la agricultura y a limpiar zapatos; a esa edad también empezó a tocar la tambora. Seis de sus hermanos se dedicaron a la música.');
      setParagraph(after,4,locale==='en'?'In 1978 and 1979 he played tambora with the típico groups of [[Francisco Ulloa]], [[Rafaelito Román]] and Bartolo Alvarado, known as [[El Cieguito de Nagua]].':'En 1978 y 1979 tocó la tambora con los conjuntos típicos de [[Francisco Ulloa]], [[Rafaelito Román]] y Bartolo Alvarado, conocido como [[El Cieguito de Nagua]].');
      setParagraph(after,6,locale==='en'?'He later learned accordion and formed his own merengue típico conjunto in 1987. His sister [[Fidelina Pascual]], who also leads a conjunto, learned accordion from him.':'Después aprendió acordeón y formó su propio conjunto de merengue típico en 1987. Su hermana [[Fidelina Pascual]], también directora de conjunto, aprendió a tocar el acordeón con él.');
      replaceLiteral(after,7,'Mangú Records','«Mangú Records»');
      replaceLiteral(after,10,'Frente a Frente',locale==='en'?'A shared recording':'Un disco compartido');
      for(const title of ['El Café en Pilón','Muchachita Linda','El Mamón','La Mujer Moderna','El Paquetazo de Mujeres','La Hija de La Vecina'])quote(after,8,title);
      for(const entity of ['Mangú Records','Audio Enfi'])quote(after,8,entity);
      for(const title of ['La Vieja y Su Pipa','El Café en Pilón','La Mujer Moderna','La Pobre Adela','La Moderna Agarradera','Lejos de Mí','El Joven Moderno'])quote(after,9,title);
      replaceLiteral(after,9,locale==='en'?'The titles run to the comic and the everyday, which is where típico has always done its best work.':'Los títulos tiran a lo cómico y a lo cotidiano, que es donde el típico siempre ha hecho su mejor trabajo.',locale==='en'?'The titles draw on comic and everyday themes.':'Los títulos recurren a temas cómicos y cotidianos.');
      quote(after,11,'Frente a Frente: Dos Estrellas en Uno');quote(after,13,'El Palo Prendío');
      const s=plain(after.content[13]);assert.ok(s.includes('Fidelina'));setParagraph(after,13,s.replace(locale==='en'?'He and Fidelina still play together.':'Fidelina y él todavía tocan juntos.',locale==='en'?'He and [[Fidelina Pascual]] still play together.':'[[Fidelina Pascual]] y él todavía tocan juntos.'));
      addLegacy(after,locale,locale==='en'?'His path from tambora to the accordion led to a conjunto of his own in 1987. He settled in Miami in 2009 and has continued performing merengue típico there with his family.':'Su paso de la tambora al acordeón lo llevó a formar un conjunto propio en 1987. Se estableció en Miami en 2009 y ha seguido interpretando merengue típico allí junto a su familia.');
    }
    if(slug==='aguakate'){
      quote(after,2,'Peligro Records');
      const b4=plain(after.content[4]);const ending=locale==='en'?' A 2015 release of «Pussy Cat» credits Aguakate alongside [[Oro Sólido]] and Mala Fe.':' Una edición de 2015 de «Pussy Cat» acredita a Aguakate junto con [[Oro Sólido]] y Mala Fe.';
      assert.ok(b4.endsWith(ending));setParagraph(after,4,b4.slice(0,-ending.length).replace('Universal Latino','«Universal Latino»').replace('Mambo Records','«Mambo Records»'));
      const b6=plain(after.content[6]);const b6new=b6.replace('Shino Aguakate','[[Shino Aguakate]]').replace('M&M Enterprises','«M&M Enterprises»').replace(locale==='en'?'Puerto Rican Festival':'Festival Puertorriqueño',locale==='en'?'«Puerto Rican Festival»':'«Festival Puertorriqueño»').replace('La Mega 97.9','«La Mega 97.9»')+(locale==='en'?' In 2015 [[Shino Aguakate]] appeared with [[Oro Sólido]] and [[Mala Fe]] on «Pussy Cat».':' En 2015 [[Shino Aguakate]] participó con [[Oro Sólido]] y [[Mala Fe]] en «Pussy Cat».');
      setParagraph(after,6,b6new);
      const b10=plain(after.content[10]);setParagraph(after,10,b10.replace('Universal','«Universal Latino»').replace('Shino Aguakate','[[Shino Aguakate]]'));
    }
  }
  if(slug==='adriel-music')setParagraph(after,0,locale==='en'?'Adriel Music is a Dominican urban-music singer with documented singles released between 2021 and 2023.':'Adriel Music es un cantante dominicano de música urbana con sencillos documentados entre 2021 y 2023.');
  const validation=validateEditorialDocument(1,after);assert.equal(validation.ok,true,`${slug} ${locale} ${JSON.stringify(validation)}`);
  assert.notDeepEqual(after,d.document,`${slug} ${locale} unchanged`);
  changes.push({owner:a.name,owner_id:a.id,slug,document_id:d.id,locale,expected_revision:d.revision,status:d.status,before:d.document,after,reference_delta:refCount(after)-refCount(d.document),source_evidence:slug==='adalgisa-pantaleon'?adalgisa.sources:slug in four?four[slug].sources:sources[slug]});
}
assert.equal(changes.length,20);
const fieldChanges=[
  {slug:'23thierno',after:{birth_place:'San Cristóbal'},evidence:['Existing province field and sourced city spelling']},
  {slug:'adalgisa-pantaleon',after:{first_name:'Ramona',middle_name:'Adalgisa',last_name:'Pantaleón',second_last_name:'Fernández',genres:['bachata','bolero','son'],occupations:['actress','writer']},evidence:['https://listindiario.com/entretenimiento/musica/20260508/adalgisa-pantaleon-historia-55-anos-musica-muchacha-quiso-monja_904846.html','docs/EDITORIAL_BIOGRAPHY_FORMAT.md field hygiene']},
  {slug:'adriana-green',after:{birth_place:'Santo Domingo',province:'Santo Domingo'},evidence:['Editor firsthand clarification 2026-10-30 and province selection']},
  {slug:'adriano-ventura',after:{genres:['merengue'],occupations:['songwriter','bandleader','producer','musician']},evidence:['docs/EDITORIAL_BIOGRAPHY_FORMAT.md field hygiene']},
].map(c=>{const a=before.artists.find((x:any)=>x.slug===c.slug);assert.ok(a);const fields=Object.keys(c.after);const old=Object.fromEntries(fields.map(k=>[k,a[k]]));assert.ok(fields.some(k=>JSON.stringify(old[k])!==JSON.stringify((c.after as any)[k])));return {owner:a.name,owner_id:a.id,slug:c.slug,before:old,after:c.after,evidence:c.evidence};});
const mirrorChanges=changes.map(c=>{const a=before.artists.find((x:any)=>x.id===c.owner_id);assert.ok(a);const old=a[c.locale==='en'?'bio_en':'bio_es'];assert.equal(typeof old,'string');return {owner:c.owner,owner_id:c.owner_id,slug:c.slug,locale:c.locale,column:c.locale==='en'?'bio_en':'bio_es',before:old,after:mirror(c.after)};});
const manifest={date:'2026-10-30',authorization:'Editor: “Actualiza todo.” Specific clarification: Adriana born Santo Domingo, province Santo Domingo, lifelong La Romana residence/identity. Ten named artist biographies and verified same-artist field corrections only.',scope:before.artists.map((a:any)=>({id:a.id,name:a.name,slug:a.slug})),changes,mirrorChanges,fieldChanges,excluded:['No artist publication-state change','No discography/work/recording/release/track/credit change','No shared artist-relationship row change','No Supabase security/schema change','No app code/deployment change'],recovery:'Full before JSON and expected revisions are preserved per document; full before values are preserved for artist fields. Any authorized reversal must recheck current revisions and dependent references.'};
fs.writeFileSync(out,JSON.stringify(manifest,null,2));
console.log(JSON.stringify({prepared:true,documents:changes.length,mirrors:mirrorChanges.length,owners:[...new Set(changes.map(c=>c.owner))],referenceDelta:changes.reduce((n,c)=>n+c.reference_delta,0),fieldChanges:fieldChanges.map(c=>({owner:c.owner,before:c.before,after:c.after})),documentChanges:changes.map(c=>({owner:c.owner,locale:c.locale,id:c.document_id,revision:c.expected_revision,referenceDelta:c.reference_delta}))}));
