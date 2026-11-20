import fs from 'node:fs';
import { randomUUID } from 'node:crypto';
import assert from 'node:assert/strict';
import { validateEditorialDocument } from '../../../src/lib/editorial/validate';

const root = 'docs/reports/editorial/';
const content = JSON.parse(fs.readFileSync(root + 'ezequiel-ponciano-content-2026-11-06.json', 'utf8'));
const targets: Record<string,string> = {
  'Kabed': 'e6a27ceb-0e41-434e-b6aa-d1550c6d578b',
  'Amaury Hernández': 'acff8b0d-b889-48bc-96fe-7a92bb741da9',
  'Karen Ponciano': '3cfbc232-0dcb-470c-8aee-98e44be5b8ac',
  'Junior Ponciano': 'e897479f-94dd-47b5-af43-3a6dbfdac363',
  'Carolina Ponciano': '3258b734-bf0e-4be9-97ce-c6101d84e77e',
  'Barak': '5bdcbc0d-24de-451d-abdd-4e40ab13b3d4'
};
const existing: Record<string, {id:string,rev:Record<string,number>,doc:Record<string,string>}> = {
  'kabed': {id:targets.Kabed,rev:{en:2,es:2},doc:{en:'5b30b437-1181-4a27-a582-2b376337d76d',es:'c5dd6c68-bb67-4e8b-9355-adc3319d1891'}},
  'amaury-hernandez': {id:targets['Amaury Hernández'],rev:{en:1,es:1},doc:{en:'b2064d1d-a026-48c6-a061-0a7f79cbe2bd',es:'d074d777-daf3-4a66-ab91-02eb10ea10c0'}},
  'karen-ponciano': {id:targets['Karen Ponciano'],rev:{en:2,es:1},doc:{en:'30cd1f93-c779-4f09-b28a-191cf1355a22',es:'e0d906eb-6326-4c5f-bdb3-a46ab829fb38'}},
  'junior-ponciano': {id:targets['Junior Ponciano'],rev:{en:3,es:1},doc:{en:'376b27ba-da27-415f-87ad-125bb7915a3e',es:'6a5785ad-de10-4eaf-97c2-426f3ce56e55'}}
};

function nodes(prose:string) {
  const out:any[]=[];
  let pos=0;
  for(const hit of prose.matchAll(/\[\[([^\]]+)\]\]/g)) {
    if(hit.index>pos) out.push({type:'text',text:prose.slice(pos,hit.index)});
    const name=hit[1]; assert.ok(targets[name], `Missing target ${name}`);
    out.push({type:'artistReference',attrs:{artistId:targets[name],occurrenceId:randomUUID(),displayText:name}});
    pos=hit.index+hit[0].length;
  }
  if(pos<prose.length)out.push({type:'text',text:prose.slice(pos)});
  assert.ok(out.length>0);
  return out;
}

const documents:any[]=[];
for(const [slug,locales] of Object.entries(content) as any) {
  for(const [locale,sections] of Object.entries(locales) as any) {
    const blocks:any[]=[];
    for(const [heading,prose] of sections) {
      if(heading) blocks.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
      blocks.push({type:'paragraph',content:nodes(prose)});
    }
    const document={type:'doc',content:blocks};
    const v=validateEditorialDocument(1,document);
    assert.equal(v.ok,true,`${slug}/${locale} ${JSON.stringify(v)}`);
    const mirror=sections.map(([h,p]:[string|null,string])=>`${h?'**'+h+'**\n\n':''}${p.replace(/\[\[([^\]]+)\]\]/g,'$1')}`).join('\n\n');
    assert.ok(mirror.endsWith(sections[sections.length-1][1].replace(/\[\[([^\]]+)\]\]/g,'$1')));
    documents.push({slug,owner_artist_id:existing[slug]?.id??null,locale,expected_revision:existing[slug]?.rev[locale]??0,previous_document_id:existing[slug]?.doc[locale]??null,document,mirror});
  }
}
assert.equal(documents.length,10);
const artist={
  id:randomUUID(),name:'Ezequiel Ponciano',sort_name:'Ponciano, Ezequiel',slug:'ezequiel-ponciano',
  type:'solo_artist',status:'draft',first_name:'Ezequiel',last_name:'Ponciano',stage_name:'Ezequiel Ponciano',
  birth_place:'Santo Domingo',province:'Santo Domingo',gender:'male',
  primary_role:'musician',occupations:['bassist','musical_director','composer','producer','bandleader'],
  instruments:['bass'],primary_genre:'worship',genres:[],artist_tags:['christian'],
  instagram:'ezequielponciano',has_image:false
};
for(const d of documents)if(d.slug==='ezequiel-ponciano')d.owner_artist_id=artist.id;
assert.ok(!artist.occupations.includes(artist.primary_role));
assert.ok(!artist.genres.includes(artist.primary_genre));
const manifest={date:'2026-11-06',authorization:'User requested creation of Ezequiel Ponciano and updating all related biographies.',artist,documents,source_file:'ezequiel-ponciano-content-2026-11-06.json',note:'Biography references to the new artist remain plain text in published owners while Ezequiel status is draft. No discography import or artist publication.'};
fs.writeFileSync(root+'ezequiel-ponciano-change-manifest-2026-11-06.json',JSON.stringify(manifest,null,2));
console.log(JSON.stringify({artist_id:artist.id,documents:documents.map(d=>`${d.slug}/${d.locale}: ${d.expected_revision}`)}));
