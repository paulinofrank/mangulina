import fs from 'node:fs';
import { randomUUID } from 'node:crypto';
import assert from 'node:assert/strict';
import { validateEditorialDocument } from '../../../src/lib/editorial/validate';

const directory = 'docs/reports/editorial/';
const source = JSON.parse(fs.readFileSync(directory + 'grupo-hope-content-2026-11-07.json', 'utf8')) as Record<string, [string | null, string][]>;
const targets: Record<string, string> = {
  'Junior Ponciano': 'e897479f-94dd-47b5-af43-3a6dbfdac363',
  'Misael J': '86d543cd-3eab-42d0-98c8-438bf8d5792c',
  'Carolina Ponciano': '3258b734-bf0e-4be9-97ce-c6101d84e77e',
  'Averly Morillo': '548bc0df-b19a-43af-b5a4-798b8a401780',
  'Jordan Mateo': '1a4f1c39-f32a-4b98-af5d-a6969885eab9',
  'Karen Ponciano': '3cfbc232-0dcb-470c-8aee-98e44be5b8ac'
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
  id: randomUUID(), name: 'Grupo Hope', sort_name: 'Grupo Hope', slug: 'grupo-hope',
  type: 'group', status: 'draft', stage_name: 'Grupo Hope', aliases: ['Hope W Music'],
  primary_role: 'singer', occupations: [], primary_genre: 'worship', genres: [],
  artist_tags: ['christian'], facebook: 'GrupoHopew', instagram: 'grupohopew',
  youtube: '@GrupoHopew', spotify: '0EmliyVpOhBPUadxwy5n2u', has_image: false
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
  scope: 'Create one draft Grupo Hope artist with published EN/ES biographies; add a founder_of relationship from Junior Ponciano. No discography or other biography edits.',
  artist,
  documents,
  relationship: { source_artist_id: targets['Junior Ponciano'], target_artist_id: artist.id, relationship_type: 'founder_of', start_year: null, end_year: null, notes: 'Grupo Hope official YouTube channel description identifies Junior Ponciano as the creator of Hope W Music; no foundation year stated.' },
  field_evidence: {
    name: 'https://www.youtube.com/@GrupoHopew and https://www.facebook.com/GrupoHopew',
    alias_and_spotify_identity: 'The official Grupo Hope YouTube description explicitly calls the project Hope W Music; Spotify artist 0EmliyVpOhBPUadxwy5n2u contains Rodeado, Kadosh and Te Mostrare Mi Gloria.',
    instagram: 'https://www.instagram.com/grupohopew/ linked from the official YouTube channel',
    christian_worship: 'Official YouTube description, repertoire and https://www.diariolibre.com/revista/musica/2022/06/10/grupo-cristiano-hope-estrena-nueva-cancion/1880969',
    origin_and_formation_year: 'Group formation city and exact year not established; left null.',
    image: 'No rights-confirmed portrait or logo uploaded; has_image=false.'
  },
  sources: [
    'https://www.youtube.com/@GrupoHopew',
    'https://www.facebook.com/GrupoHopew',
    'https://www.instagram.com/grupohopew/',
    'https://open.spotify.com/artist/0EmliyVpOhBPUadxwy5n2u',
    'https://music.apple.com/us/album/esp%C3%ADritu-santo-live/1591114171?i=1591114173',
    'https://music.apple.com/us/album/dios-de-gloria-live/1591114266?i=1591114267',
    'https://music.apple.com/us/song/1628975442',
    'https://music.apple.com/us/album/kadosh-feat-averly-morillo-single/1700621106',
    'https://music.apple.com/us/album/alfa-omega-ep/1774969309',
    'https://music.apple.com/us/artist/hope-w-music/1489337779',
    'https://www.qobuz.com/us-en/album/te-mostrare-mi-gloria-hope-w-music-amp-carolina-ponciano-amp-karen-ponciano-ministry/uvzmsj2gyjmip'
  ],
  limits: 'The 2018 Hope Worship report is not treated as proof of formal identity or founding year. Carolina, Misael J and other singers are guests, not fixed members. Do not link published biographies to a draft artist or open its public URL as a preview.'
};
fs.writeFileSync(directory + 'grupo-hope-change-manifest-2026-11-07.json', JSON.stringify(manifest, null, 2));
console.log(JSON.stringify({ artist_id: artist.id, documents: documents.map(d => d.locale), validated: true }));
