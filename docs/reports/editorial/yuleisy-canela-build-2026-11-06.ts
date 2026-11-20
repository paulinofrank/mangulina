import fs from 'node:fs';
import { randomUUID } from 'node:crypto';
import assert from 'node:assert/strict';
import { validateEditorialDocument } from '../../../src/lib/editorial/validate';

const dir = 'docs/reports/editorial/';
const source = JSON.parse(fs.readFileSync(dir + 'yuleisy-canela-content-2026-11-06.json', 'utf8')) as Record<string,[string|null,string][]>;
const targets:Record<string,string> = {
  Kabed:'e6a27ceb-0e41-434e-b6aa-d1550c6d578b',
  'Ezequiel Ponciano':'ef2dd5d6-6893-4e2b-ad13-ac8aa10c37de',
  'Amaury Hernández':'acff8b0d-b889-48bc-96fe-7a92bb741da9',
  'Karen Ponciano':'3cfbc232-0dcb-470c-8aee-98e44be5b8ac',
  'Junior Ponciano':'e897479f-94dd-47b5-af43-3a6dbfdac363'
};
function nodes(prose:string){
  const result:any[]=[];
  let pos=0;
  for(const hit of prose.matchAll(/\[\[([^\]]+)\]\]/g)){
    if(hit.index>pos)result.push({type:'text',text:prose.slice(pos,hit.index)});
    const name=hit[1];assert.ok(targets[name]);
    result.push({type:'artistReference',attrs:{artistId:targets[name],occurrenceId:randomUUID(),displayText:name}});
    pos=hit.index+hit[0].length;
  }
  if(pos<prose.length)result.push({type:'text',text:prose.slice(pos)});
  return result;
}
const artist={
  id:randomUUID(),name:'Yuleisy Canela',sort_name:'Canela, Yuleisy',slug:'yuleisy-canela',
  type:'solo_artist',status:'draft',first_name:'Yuleisy',last_name:'Canela',stage_name:'Yuleisy Canela',
  gender:'female',primary_role:'singer',occupations:['composer','producer'],
  primary_genre:'worship',genres:[],artist_tags:['christian'],instruments:['voice'],
  instagram:'yuleisycanela',facebook:'yuleisy.canela',has_image:false
};
const documents=[];
for(const locale of ['en','es']){
  const sections=source[locale];
  const blocks:any[]=[];
  for(const [heading,prose] of sections){
    if(heading)blocks.push({type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]});
    blocks.push({type:'paragraph',content:nodes(prose)});
  }
  const document={type:'doc',content:blocks};
  const validation=validateEditorialDocument(1,document);
  assert.equal(validation.ok,true,JSON.stringify(validation));
  const mirror=sections.map(([h,p])=>`${h?'**'+h+'**\n\n':''}${p.replace(/\[\[([^\]]+)\]\]/g,'$1')}`).join('\n\n');
  documents.push({owner_artist_id:artist.id,locale,expected_revision:0,document,mirror});
}
assert.ok(!artist.occupations.includes(artist.primary_role));
assert.ok(!artist.genres.includes(artist.primary_genre));
const manifest={date:'2026-11-06',authorization:'User supplied Yuleisy Canela official social profiles for artist profile creation.',artist,documents,
  field_evidence:{instagram:'https://www.instagram.com/yuleisycanela/',facebook:'https://www.facebook.com/yuleisy.canela',gender:'Official Instagram self-description: wife and mom',primary_role:'https://www.youtube.com/watch?v=ADrqVcjix8I and podcast host description',christian:'https://kabedmusicweb.com/nosotros/',birthday_partial:'Facebook About shows 9 September; year undisclosed. date_of_birth left null.',birth_place:'Unconfirmed; left null.',spotify:'Personal artist identity unverified; left null.'},
  sources:['https://www.mundodecristo.net/2016/05/kabed-presenta-su-primer-sencillo.html','https://kabedmusicweb.com/nosotros/','https://www.multitracks.com/songs/KABED/Intimo/Intimo-%28Live%29/overview/','https://www.secuencias.com/songs/KABED/Rey-De-Gloria-%28Live%29/Rey-De-Gloria-%28Live%29/overview/','https://evidenciasdigital.com/2024/03/22/kabed-junto-a-abner-himely-y-mary-pagan-nos-cantan-caeran/','https://music.apple.com/us/song/1887446900','https://www.podcasts-online.org/de/la-libreta-de-lola-el-podcast-1494123625'],
  pending:'Backward references in published biographies of Kabed, Ezequiel Ponciano, Amaury Hernández, Karen Ponciano and Junior Ponciano; not altered while Yuleisy is draft. No discography or relationship writes.'};
fs.writeFileSync(dir+'yuleisy-canela-change-manifest-2026-11-06.json',JSON.stringify(manifest,null,2));
console.log(JSON.stringify({artist_id:artist.id,documents:documents.map(d=>d.locale),validated:true}));
