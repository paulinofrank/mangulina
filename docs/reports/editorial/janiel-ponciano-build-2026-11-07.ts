import fs from 'node:fs';
import { randomUUID } from 'node:crypto';
import assert from 'node:assert/strict';
import { validateEditorialDocument } from '../../../src/lib/editorial/validate';

const directory = 'docs/reports/editorial/';
const source = JSON.parse(fs.readFileSync(directory + 'janiel-ponciano-content-2026-11-07.json', 'utf8')) as Record<string, [string | null, string][]>;
const targets: Record<string, string> = {
  Barak: '5bdcbc0d-24de-451d-abdd-4e40ab13b3d4',
  Kabed: 'e6a27ceb-0e41-434e-b6aa-d1550c6d578b',
  'Grupo Hope': '04788dac-8c1b-40ec-8c3e-c6a375838f20',
  'Averly Morillo': '548bc0df-b19a-43af-b5a4-798b8a401780',
  'Junior Ponciano': 'e897479f-94dd-47b5-af43-3a6dbfdac363',
  'Yuleisy Canela': '15ebe282-0d3d-47ed-8aaa-6c901dee5478',
  'Ezequiel Ponciano': 'ef2dd5d6-6893-4e2b-ad13-ac8aa10c37de'
};

function nodes(prose: string) {
  const result: any[] = [];
  let pos = 0;
  for (const match of prose.matchAll(/\[\[([^\]]+)\]\]/g)) {
    if (match.index > pos) result.push({ type: 'text', text: prose.slice(pos, match.index) });
    const name = match[1];
    assert.ok(targets[name], `Unknown artist reference: ${name}`);
    result.push({ type: 'artistReference', attrs: { artistId: targets[name], occurrenceId: randomUUID(), displayText: name } });
    pos = match.index + match[0].length;
  }
  if (pos < prose.length) result.push({ type: 'text', text: prose.slice(pos) });
  return result;
}

const artist = {
  id: randomUUID(), name: 'Janiel Ponciano', sort_name: 'Ponciano, Janiel', slug: 'janiel-ponciano',
  type: 'solo_artist', status: 'draft', stage_name: 'Janiel Ponciano',
  aliases: ['Janiel Fernando Ponciano Lebrón'], first_name: 'Janiel', middle_name: 'Fernando',
  last_name: 'Ponciano', second_last_name: 'Lebrón', gender: 'male',
  primary_role: 'musician', occupations: ['bassist', 'singer', 'songwriter', 'producer'],
  instruments: ['bass', 'voice'], primary_genre: 'worship', genres: [], artist_tags: ['christian'],
  facebook: 'janiel.poncianolebron', instagram: 'janielponciano',
  date_of_birth: null, birth_place: null, province: null, spotify: null, has_image: false
};

const documents = [];
for (const locale of ['en', 'es']) {
  const sections = source[locale];
  const blocks: any[] = [];
  for (const [heading, prose] of sections) {
    if (heading) blocks.push({ type: 'paragraph', content: [{ type: 'text', text: heading, marks: [{ type: 'bold' }] }] });
    blocks.push({ type: 'paragraph', content: nodes(prose) });
  }
  const document = { type: 'doc', content: blocks };
  const validation = validateEditorialDocument(1, document);
  assert.equal(validation.ok, true, JSON.stringify(validation));
  const mirror = sections.map(([heading, prose]) => `${heading ? '**' + heading + '**\n\n' : ''}${prose.replace(/\[\[([^\]]+)\]\]/g, '$1')}`).join('\n\n');
  documents.push({ owner_artist_id: artist.id, locale, expected_revision: 0, document, mirror });
}

assert.ok(!artist.occupations.includes(artist.primary_role));
assert.ok(!artist.genres.includes(artist.primary_genre));
const manifest = {
  date: '2026-11-07',
  scope: 'Create Janiel Ponciano as one draft artist with published English and Spanish biographies. No release, discography, public profile publication, family relationship, member_of relationship or other artist biography changes.',
  artist,
  documents,
  field_evidence: {
    full_name: 'ONAPI 2017 and SAYCO 2023 list Janiel Fernando Ponciano Lebrón / PONCIANO LEBRON JANIEL FERNANDO.',
    birthday: 'Santiago Ponciano Facebook posts on 2014-08-30, 2015-08-30 and 2022-08-30 explicitly call Janiel his son and wish him happy birthday. Year unknown, so date_of_birth remains null.',
    birth_city: 'No direct evidence of birthplace; Santo Domingo church and Dominican nationality do not establish birth city.',
    roles_and_genre: 'Barak-supplied MultiTracks bio; 2026 Bondadoso Dios songwriting and production credits; Christian worship repertoire.',
    social_identity: 'Barak official channel lists Instagram @janielponciano; Facebook page Janiel Ponciano Lebron identifies him as Barak member.',
    spotify: 'No personal artist ID established; Barak and co-writer credits do not imply a solo artist page.',
    image: 'No verified reusable portrait uploaded.'
  },
  corrections_to_submitted_sheet: [
    'Uso Honorable was released 2026-04-10 in Shazam; seven writers, not three.',
    'Llena Este Lugar has Janiel as a writer, but Secuencias lists Ezequiel too; no exclusive authorship claim.',
    'Barak founding year and Janiel join year are not asserted without direct evidence.',
    'No birth city or birth year inferred from Barak location or birthday posts.'
  ],
  sources: [
    'https://www.onapi.gov.do/transparencia/index.php/institucional/publicaciones/3515-historico-de-publicaciones-de-registro/3517-historico-de-publicaciones-de-registro-2000-2019/407-2015-2019-pu/953-2019-pu?download=6110%3Apublicacion-15-de-marzo-2019',
    'https://www.sayco.org/_files/ugd/733ded_d5db21634f7f41cbb913be11dd707a63.pdf',
    'https://www.facebook.com/photo/?fbid=740417362726652',
    'https://www.facebook.com/photo/?fbid=618552699679253',
    'https://www.facebook.com/janiel.poncianolebron',
    'https://www.instagram.com/janielponciano/',
    'https://www.multitracks.com.br/artists/barak/biography/',
    'https://www.diariolibre.com/revista/musica/2025/04/12/barak-se-presenta-tras-tragedia-en-discoteca-jet-set/3071674',
    'https://www.latingrammy.com/en/artists/barak-33057/',
    'https://www.grammy.com/news/2023-latin-grammys-complete-winners-nominees-nominations-list/',
    'https://www.secuencias.com/songs/KABED/Favor-And-Gracia/Llena-Este-Lugar/overview/',
    'https://www.youtube.com/watch?v=9hlJDW88NA8',
    'https://www.youtube.com/watch?v=Lt7fd0yqOG0',
    'https://www.shazam.com/song/1853885115/uso-honorable',
    'https://radionotas.com/2026/10/07/barak-habla-en-su-nuevo-album-de-un-bondadoso-dios/'
  ]
};
fs.writeFileSync(directory + 'janiel-ponciano-change-manifest-2026-11-07.json', JSON.stringify(manifest, null, 2));
console.log(JSON.stringify({ artist_id: artist.id, document_locales: documents.map(d => d.locale), validated: true }));
