import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet: true});
const base = 'docs/reports/editorial/';
const id = 'a7f7bc09-9356-41f0-9509-273b1724c452';
const file = base + 'la-gran-mawon-profile-manifest.json';
const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL ?? process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  {auth: {persistSession: false, autoRefreshToken: false}},
);
const check = (result: any) => {
  if (result.error) throw Error(result.error.message);
  return result.data;
};
const artist = async () => check(await db.from('artists').select('*').eq('id', id).single());
const documents = async () => check(await db.from('editorial_documents').select('*').eq('owner_artist_id', id));
const releaseIds = async () => check(await db.from('releases').select('id').eq('release_artist_id', id)).map((r: any) => r.id).sort();
const targets = async () => check(await db.from('artists').select('id,name,slug,status').in('id', [
  '648cd724-dccf-4174-8d13-18b9cfd0ce1e', // Mítiko
  'ec8ba439-3772-49ff-a218-05f5dc615763', // Vakeró
  '8e29188a-215b-4c6c-b34a-45b381765e46', // Xiomara Fortuna
  'a3a0551d-7f39-42f3-b30b-05a9d3c83ab2', // Yasser Tejeda
]));

if (process.argv[2] === 'prepare') {
  assert.ok(!fs.existsSync(file), 'Preserve frozen manifest');
  const before = await artist();
  assert.equal(before.status, 'draft');
  assert.equal(before.slug, 'la-gran-mawon');
  assert.equal(before.type, 'group');
  assert.equal((await documents()).length, 0);
  const beforeReleases = await releaseIds();
  assert.equal(beforeReleases.length, 7, 'Release scope changed; inspect before proceeding');
  const referenceTargets = await targets();
  assert.equal(referenceTargets.length, 4);
  assert.ok(referenceTargets.every((t: any) => t.status === 'published'));
  const source = JSON.parse(fs.readFileSync(base + 'la-gran-mawon-profile-content.json', 'utf8'));
  assert.ok(!source.artist.genres.includes(source.artist.primary_genre));
  assert.ok(!source.artist.occupations.includes(before.primary_role));
  assert.match(source.artist.spotify, /^[A-Za-z0-9]{22}$/);
  assert.match(source.artist.youtube, /^@/);

  const built = Object.entries(source.bios).map(([locale, sections]: any) => {
    const content: any[] = [];
    for (const [heading, prose] of sections) {
      if (heading) content.push({type: 'paragraph', content: [{type: 'text', text: heading, marks: [{type: 'bold'}]}]});
      const nodes: any[] = [];
      let pos = 0;
      for (const match of prose.matchAll(/\[\[(.*?)\]\]/g)) {
        if (match.index > pos) nodes.push({type: 'text', text: prose.slice(pos, match.index)});
        const target = referenceTargets.find((t: any) => t.name === match[1]);
        assert.ok(target, `Missing published reference target: ${match[1]}`);
        nodes.push({type: 'artistReference', attrs: {artistId: target.id, occurrenceId: randomUUID(), displayText: target.name}});
        pos = match.index + match[0].length;
      }
      if (pos < prose.length) nodes.push({type: 'text', text: prose.slice(pos)});
      content.push({type: 'paragraph', content: nodes});
    }
    const document = {type: 'doc', content};
    const validation = validateEditorialDocument(1, document);
    assert.equal(validation.ok, true, JSON.stringify(validation));
    const mirror = sections.map(([heading, prose]: [string | null, string]) =>
      `${heading ? `**${heading}**\n\n` : ''}${prose.replace(/\[\[(.*?)\]\]/g, '$1')}`,
    ).join('\n\n');
    return {locale, document, mirror};
  });
  assert.deepEqual(built.map((d: any) => d.locale).sort(), ['en', 'es']);
  const after = {
    ...source.artist,
    bio_en: built.find((d: any) => d.locale === 'en').mirror,
    bio_es: built.find((d: any) => d.locale === 'es').mirror,
  };
  const changes = Object.entries(after).map(([field, value]) => ({field, before: before[field], after: value}));
  const manifest = {
    date: '2026-10-30',
    authorization: 'Complete named existing draft artist and publish its validated EN/ES biography documents; keep artist draft. No discography, media, other-artist, publication, deployment or security writes.',
    artist_id: id,
    before,
    changes,
    after,
    documents: built.map(({locale, document}: any) => ({locale, document})),
    reference_targets: referenceTargets,
    before_release_ids: beforeReleases,
    evidence_report: 'la-gran-mawon-research-2026-10-30.md',
    backward_reference_pending: [
      'b721d349-ea2e-4f18-9652-e3b5148073d5',
      '4cf3dbc5-912a-4507-8f22-40b43cff3552',
      'b20736f2-e6a3-4a4c-94df-c88e31f65b32',
      '12433f83-6c84-4b1f-859b-31ade027b65c',
    ],
  };
  fs.writeFileSync(file, JSON.stringify(manifest, null, 2));
  console.log(JSON.stringify({prepared: true, artist_id: id, changed_fields: changes.map(c => c.field), documents: built.length, reference_nodes: built.reduce((n: number, d: any) => n + d.document.content.flatMap((p: any) => p.content).filter((x: any) => x.type === 'artistReference').length, 0)}));
} else if (process.argv[2] === 'execute') {
  const m = JSON.parse(fs.readFileSync(file, 'utf8'));
  const before = await artist();
  assert.equal(before.status, 'draft');
  assert.equal(before.updated_at, m.before.updated_at, 'Artist changed after manifest preparation');
  assert.equal((await documents()).length, 0, 'Biography document already exists');
  assert.deepEqual(await releaseIds(), m.before_release_ids);
  const saved = check(await db.from('artists').update(m.after).eq('id', id).eq('updated_at', m.before.updated_at).select('id'));
  assert.equal(saved.length, 1, 'Artist update did not affect exactly one row');
  for (const d of m.documents) {
    check(await db.rpc('upsert_editorial_document', {
      p_document_type: 'artist_biography', p_owner_artist_id: id, p_locale: d.locale,
      p_schema_version: 1, p_status: 'published', p_document: d.document, p_expected_revision: 0,
    }));
  }
  console.log('Draft artist completed; Spanish and English biographies published.');
} else if (process.argv[2] === 'verify') {
  const m = JSON.parse(fs.readFileSync(file, 'utf8'));
  const current = await artist();
  assert.equal(current.status, 'draft');
  for (const [field, value] of Object.entries(m.after)) assert.deepEqual(current[field], value, field);
  assert.deepEqual(await releaseIds(), m.before_release_ids, 'Primary release IDs changed');
  const docs = await documents();
  assert.equal(docs.length, 2);
  for (const doc of docs) {
    assert.equal(doc.status, 'published');
    assert.equal(doc.revision, 1);
    assert.equal(validateEditorialDocument(1, doc.document).ok, true);
    assert.deepEqual(doc.document, m.documents.find((x: any) => x.locale === doc.locale).document);
  }
  const relations = check(await db.from('editorial_entity_references').select('*').in('editorial_document_id', docs.map((d: any) => d.id)));
  assert.equal(relations.length, 8);
  const integrity = buildEditorialIntegrityReport({artists: [current, ...m.reference_targets], documents: docs, relations});
  assert.equal(integrity.counts.blocking, 0);
  assert.equal(integrity.counts.warning, 0);
  assert.ok(!current.genres.includes(current.primary_genre));
  assert.ok(!current.occupations.includes(current.primary_role));
  const verification = {artist: current, documents: docs, relations, release_ids: await releaseIds(), integrity};
  fs.writeFileSync(base + 'la-gran-mawon-saved-verification.json', JSON.stringify(verification, null, 2));
  console.log(JSON.stringify({artist_id: id, status: current.status, documents: docs.map((d: any) => ({id: d.id, locale: d.locale, status: d.status, revision: d.revision})), references: relations.length, release_count: verification.release_ids.length, integrity: integrity.counts}));
} else {
  throw Error('Expected prepare, execute or verify');
}
