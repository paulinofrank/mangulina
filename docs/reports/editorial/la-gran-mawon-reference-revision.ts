import fs from 'node:fs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {editorialDocumentToPlainText} from '../../../src/lib/editorial/plainText';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';

dotenv.config({quiet: true});
const base = 'docs/reports/editorial/';
const id = 'a7f7bc09-9356-41f0-9509-273b1724c452';
const file = base + 'la-gran-mawon-reference-revision-manifest.json';
const db = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL ?? process.env.SUPABASE_URL!, process.env.SUPABASE_SERVICE_ROLE_KEY!, {auth: {persistSession: false, autoRefreshToken: false}});
const check = (r: any) => { if (r.error) throw Error(r.error.message); return r.data; };
const docs = async () => check(await db.from('editorial_documents').select('*').eq('owner_artist_id', id));
const owner = async () => check(await db.from('artists').select('*').eq('id', id).single());

if (process.argv[2] === 'prepare') {
  assert.ok(!fs.existsSync(file), 'Preserve frozen revision manifest');
  const beforeArtist = await owner();
  assert.equal(beforeArtist.status, 'draft');
  const beforeDocs = await docs();
  assert.equal(beforeDocs.length, 2);
  assert.ok(beforeDocs.every((d: any) => d.status === 'published' && d.revision === 1));
  const source = JSON.parse(fs.readFileSync(base + 'la-gran-mawon-profile-content.json', 'utf8'));
  const target = check(await db.from('artists').select('id,name,slug,status').eq('id', '648cd724-dccf-4174-8d13-18b9cfd0ce1e').single());
  assert.equal(target.name, 'Mítiko');
  assert.equal(target.status, 'published');
  const afterDocs = Object.entries(source.bios).map(([locale, sections]: any) => {
    const content: any[] = [];
    for (const [heading, prose] of sections) {
      if (heading) content.push({type: 'paragraph', content: [{type: 'text', text: heading, marks: [{type: 'bold'}]}]});
      const nodes: any[] = [];
      let pos = 0;
      for (const match of prose.matchAll(/\[\[(.*?)\]\]/g)) {
        if (match.index > pos) nodes.push({type: 'text', text: prose.slice(pos, match.index)});
        const t = match[1] === 'Mítiko' ? target : null;
        const prior = JSON.parse(fs.readFileSync(base + 'la-gran-mawon-profile-manifest.json', 'utf8'));
        const other = prior.reference_targets.find((x: any) => x.name === match[1]);
        const reference = t ?? other;
        assert.ok(reference && reference.status === 'published', match[1]);
        nodes.push({type: 'artistReference', attrs: {artistId: reference.id, occurrenceId: randomUUID(), displayText: reference.name}});
        pos = match.index + match[0].length;
      }
      if (pos < prose.length) nodes.push({type: 'text', text: prose.slice(pos)});
      content.push({type: 'paragraph', content: nodes});
    }
    const document = {type: 'doc', content};
    assert.equal(validateEditorialDocument(1, document).ok, true);
    const before = beforeDocs.find((d: any) => d.locale === locale);
    assert.ok(before);
    assert.equal(editorialDocumentToPlainText(before.document), editorialDocumentToPlainText(document), 'Only link markup may change');
    return {locale, id: before.id, before_revision: before.revision, document};
  });
  fs.writeFileSync(file, JSON.stringify({date: '2026-10-30', reason: 'Link the two additional Mítiko mentions in each published biography; wording unchanged.', artist_id: id, before_artist_updated_at: beforeArtist.updated_at, before_documents: beforeDocs.map((d: any) => ({id: d.id, locale: d.locale, revision: d.revision, updated_at: d.updated_at})), after_documents: afterDocs}, null, 2));
  console.log(JSON.stringify({prepared: true, revisions: afterDocs.map((d: any) => ({locale: d.locale, from: d.before_revision, to: 2})), total_references: afterDocs.reduce((n: number, d: any) => n + d.document.content.flatMap((p: any) => p.content).filter((x: any) => x.type === 'artistReference').length, 0)}));
} else if (process.argv[2] === 'execute') {
  const m = JSON.parse(fs.readFileSync(file, 'utf8'));
  assert.equal((await owner()).status, 'draft');
  const current = await docs();
  for (const d of m.after_documents) {
    const prior = current.find((x: any) => x.locale === d.locale);
    assert.equal(prior.id, d.id);
    assert.equal(prior.revision, d.before_revision);
  }
  for (const d of m.after_documents) check(await db.rpc('upsert_editorial_document', {p_document_type: 'artist_biography', p_owner_artist_id: id, p_locale: d.locale, p_schema_version: 1, p_status: 'published', p_document: d.document, p_expected_revision: d.before_revision}));
  console.log('Both reference revisions published.');
} else if (process.argv[2] === 'verify') {
  const m = JSON.parse(fs.readFileSync(file, 'utf8'));
  const artist = await owner();
  assert.equal(artist.status, 'draft');
  const current = await docs();
  assert.equal(current.length, 2);
  for (const d of current) {
    assert.equal(d.status, 'published');
    assert.equal(d.revision, 2);
    assert.deepEqual(d.document, m.after_documents.find((x: any) => x.locale === d.locale).document);
  }
  const relations = check(await db.from('editorial_entity_references').select('*').in('editorial_document_id', current.map((d: any) => d.id)));
  assert.equal(relations.length, 12);
  const targets = JSON.parse(fs.readFileSync(base + 'la-gran-mawon-profile-manifest.json', 'utf8')).reference_targets;
  const integrity = buildEditorialIntegrityReport({artists: [artist, ...targets], documents: current, relations});
  assert.equal(integrity.counts.blocking, 0);
  assert.equal(integrity.counts.warning, 0);
  fs.writeFileSync(base + 'la-gran-mawon-final-verification.json', JSON.stringify({artist, documents: current, relations, integrity}, null, 2));
  console.log(JSON.stringify({artist_id: id, status: artist.status, documents: current.map((d: any) => ({id: d.id, locale: d.locale, status: d.status, revision: d.revision})), references: relations.length, integrity: integrity.counts}));
} else throw Error('Expected prepare, execute or verify');
