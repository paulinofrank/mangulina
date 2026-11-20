import fs from 'node:fs';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import dotenv from 'dotenv';
import { createClient } from '@supabase/supabase-js';
import { validateEditorialDocument } from '../../../src/lib/editorial/validate';
import { buildEditorialIntegrityReport } from '../../../src/lib/editorial/integrity';
import type { EditorialDocumentV1 } from '../../../src/types/editorialDocument';

dotenv.config({ quiet: true });

const base = 'docs/reports/editorial/';
const manifestFile = base + 'los-hijos-del-rey-profile-manifest.json';
const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL ?? process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { persistSession: false, autoRefreshToken: false } }
);

const check = (r: any) => {
  if (r.error) throw Error(r.error.message);
  return r.data;
};

const duplicate = () =>
  db
    .from('artists')
    .select('id,name,status')
    .or('slug.eq.los-hijos-del-rey,name.ilike.%hijos del rey%,spotify.eq.2tjPWNqjIhDad2esOUUD7b,mbid.eq.e826fa8b-8ff0-443f-bb41-6e6eb36370fe');

const targetIds = [
  '2bc36959-dcce-4e10-9ecf-2cd418eaa489', // Wilfrido Vargas
  'bc310977-31a9-41bb-9af2-7d3a0d7fabdd', // Fernando Villalona
  'faf3e4cb-808e-419c-87ff-5126eed85e73', // Raulín Rosendo
  'bc4db4c6-c96f-4eb7-af95-ac637785c5bf', // Bonny Cepeda
  'dc89c826-c298-48c8-aa05-50e77d85264a', // Los Kenton
  '052b710d-e91f-41c6-94ac-480100f95f5b', // July Mateo "Rasputín"
  'ba42e200-51b0-437b-99ac-1daf39ade337', // Rafael Solano
  'c2e192d4-f144-4f9a-8db4-b71f0cff391e', // Los Beduinos
  'fb2c703f-5362-47dd-ada0-7c6d5e106f3b', // Dioni Fernández y El Equipo
  'e005898c-4fcc-45da-b857-c6775e92fa52', // Johnny Pacheco
  '214e98cc-cac9-4473-9741-2a87481b0685', // Carlos Alfredo Fatule
  '0a36ec1b-2de1-4890-95f2-57d6b19a1d69', // Kaki Vargas
  '059a9e99-5d11-433e-97b9-9c35e57908f1'  // Sergio Vargas
];

function markdown(document: EditorialDocumentV1): string {
  return document.content
    .map((block) => {
      if (block.type === 'paragraph') {
        const contents = block.content ?? [];
        if (
          contents.length === 1 &&
          contents[0].type === 'text' &&
          contents[0].marks?.length === 1 &&
          contents[0].marks[0].type === 'bold'
        ) {
          return `**${contents[0].text}**`;
        }
        return contents
          .map((node) =>
            node.type === 'artistReference'
              ? node.attrs.displayText
              : node.type === 'text'
                ? node.text
                : ''
          )
          .join('');
      } else if (block.type === 'bulletList') {
        return block.content
          .map((item: any) => {
            const itemContents = item.content?.[0]?.content ?? [];
            const text = itemContents
              .map((node: any) =>
                node.type === 'artistReference'
                  ? node.attrs.displayText
                  : node.type === 'text'
                    ? node.text
                    : ''
              )
              .join('');
            return `- ${text}`;
          })
          .join('\n');
      }
      throw new Error(`Unexpected block type: ${block.type}`);
    })
    .join('\n\n');
}

async function run() {
  const mode = process.argv[2];

  if (mode === 'prepare') {
    assert.ok(!fs.existsSync(manifestFile), 'Preserve frozen manifest');
    assert.equal(check(await duplicate()).length, 0, 'Artist already exists');

    const targets = check(
      await db.from('artists').select('id,name,slug,status').in('id', targetIds)
    );
    assert.equal(targets.length, 13, `Expected 13 targets, got ${targets.length}`);
    assert.ok(targets.every((x: any) => x.status === 'published'), 'All targets must be published');

    const source = JSON.parse(
      fs.readFileSync(base + 'los-hijos-del-rey-profile-content.json', 'utf8')
    );

    const artistId = randomUUID();

    const parseInline = (text: string) => {
      const nodes: any[] = [];
      let pos = 0;
      for (const match of text.matchAll(/\[\[(.*?)\]\]/g)) {
        if (match.index! > pos) {
          nodes.push({ type: 'text', text: text.slice(pos, match.index) });
        }
        const name = match[1];
        const target = targets.find((x: any) => x.name === name);
        assert.ok(target, `Target artist not found: ${name}`);
        nodes.push({
          type: 'artistReference',
          attrs: {
            artistId: target.id,
            occurrenceId: randomUUID(),
            displayText: target.name
          }
        });
        pos = match.index! + match[0].length;
      }
      if (pos < text.length) {
        nodes.push({ type: 'text', text: text.slice(pos) });
      }
      return nodes;
    };

    const documents = Object.entries(source.bios).map(([locale, sections]: any) => {
      const contentNodes: any[] = [];
      for (const [heading, prose] of sections) {
        if (heading) {
          contentNodes.push({
            type: 'paragraph',
            content: [{ type: 'text', text: heading, marks: [{ type: 'bold' }] }]
          });
        }
        const paragraphs = prose.split('\n\n');
        for (const paragraphText of paragraphs) {
          if (paragraphText.startsWith('- ')) {
            const items = paragraphText.split('\n');
            const listItems: any[] = [];
            for (const item of items) {
              const itemText = item.replace(/^- /, '');
              const inlineNodes = parseInline(itemText);
              listItems.push({
                type: 'listItem',
                content: [{ type: 'paragraph', content: inlineNodes }]
              });
            }
            contentNodes.push({
              type: 'bulletList',
              content: listItems
            });
          } else {
            const inlineNodes = parseInline(paragraphText);
            contentNodes.push({
              type: 'paragraph',
              content: inlineNodes
            });
          }
        }
      }
      const document: EditorialDocumentV1 = { type: 'doc', content: contentNodes };
      const val = validateEditorialDocument(1, document);
      assert.equal(val.ok, true, `${locale} document validation failed: ${JSON.stringify(val.issues)}`);
      return { locale, document };
    });

    const esDoc = documents.find((d) => d.locale === 'es')!.document;
    const enDoc = documents.find((d) => d.locale === 'en')!.document;

    const artist = {
      id: artistId,
      ...source.artist,
      bio_es: markdown(esDoc),
      bio_en: markdown(enDoc)
    };

    const manifest = {
      date: '2026-11-01',
      authorization: 'Named new orchestra in ongoing editor request. New draft artist with published validated EN/ES biographies. No artist profile publication or discography import.',
      before: null,
      after: artist,
      documents,
      reference_targets: targets,
      field_evidence: {
        name: 'Historic orchestra name verified across Discogs, MusicBrainz, Spotify, and Dominican national press (Listín Diario, El Día, Hoy).',
        type: "group admitted value. Primary role 'orchestra'.",
        occupations: 'Empty array [] following hygiene rule (cannot repeat primary_role).',
        genre_tags: "primary_genre 'merengue', genres [] following hygiene rule (cannot repeat primary_genre). artist_tags ['secular', 'legend'] supported by iconic repertoire.",
        origin: "Formed in Santo Domingo, Distrito Nacional, August 1976. Origin is city per editorial guidance.",
        formation_year: '1976 (debuted August 1976 at Estadio Olímpico opening for Fania All Stars). Ended: true.',
        spotify: 'Verified artist ID 2tjPWNqjIhDad2esOUUD7b containing core albums (Sergio Vargas y Los Hijos del Rey [1986], Auténticos [1979], etc.).',
        mbid: 'Verified MusicBrainz group entity e826fa8b-8ff0-443f-bb41-6e6eb36370fe.'
      },
      backward_reference_audit: {
        matching_documents: 32,
        matching_artists: 15,
        audit_file: 'docs/reports/editorial/los-hijos-del-rey-pending-backlinks.json',
        status: 'Documented as pending review for authorized artist publication; draft status does not authorize changes to external published biographies or public exposure of draft targets.'
      },
      unresolved: [
        'Official photograph not provided; no image generated or uploaded.',
        'Discography import deferred to authorized dedicated discography task per AGENTS.md and Gate B.'
      ],
      exclusions: [
        'Artist profile publication (remains draft)',
        'Other artists or biography changes',
        'Discography and credit imports',
        'Image upload',
        'Deployment',
        'Supabase security policy changes',
        'Production public draft URL requests and manual cache refresh'
      ]
    };

    fs.writeFileSync(manifestFile, JSON.stringify(manifest, null, 2));
    console.log(
      JSON.stringify(
        {
          prepared: true,
          id: artist.id,
          documents: documents.length,
          esBlocks: esDoc.content.length,
          enBlocks: enDoc.content.length
        },
        null,
        2
      )
    );
  } else if (mode === 'execute') {
    assert.ok(fs.existsSync(manifestFile), 'Manifest file missing');
    const m = JSON.parse(fs.readFileSync(manifestFile, 'utf8'));
    assert.equal(check(await duplicate()).length, 0, 'Duplicate check failed on execute');

    // 1. Insert artist
    check(await db.from('artists').insert(m.after));
    console.log(`Inserted artist: ${m.after.name} (${m.after.id}) with status=${m.after.status}`);

    // 2. Upsert editorial documents
    for (const d of m.documents) {
      check(
        await db.rpc('upsert_editorial_document', {
          p_document_type: 'artist_biography',
          p_owner_artist_id: m.after.id,
          p_locale: d.locale,
          p_schema_version: 1,
          p_status: 'published',
          p_document: d.document,
          p_expected_revision: 0
        })
      );
      console.log(`Saved published biography (${d.locale}) for artist ${m.after.id}`);
    }
  } else if (mode === 'verify') {
    assert.ok(fs.existsSync(manifestFile), 'Manifest file missing');
    const m = JSON.parse(fs.readFileSync(manifestFile, 'utf8'));

    // 1. Verify artist row
    const artist = check(
      await db.from('artists').select('*').eq('id', m.after.id).single()
    );
    for (const [k, v] of Object.entries(m.after)) {
      assert.deepEqual(artist[k], v, `Field mismatch on ${k}`);
    }
    assert.equal(artist.status, 'draft', 'Artist must be draft');

    // 2. Verify editorial documents
    const documents = check(
      await db
        .from('editorial_documents')
        .select('*')
        .eq('owner_artist_id', artist.id)
        .order('locale')
    );
    assert.equal(documents.length, 2, 'Must have exactly 2 documents');

    for (const d of documents) {
      assert.equal(d.status, 'published', 'Document must be published');
      assert.equal(d.revision, 1, 'Document revision must be 1');
      assert.equal(validateEditorialDocument(1, d.document).ok, true);
      const expectedDoc = m.documents.find((x: any) => x.locale === d.locale).document;
      assert.deepEqual(d.document, expectedDoc);
    }

    // 3. Verify editorial entity references
    const relations = check(
      await db
        .from('editorial_entity_references')
        .select('*')
        .in('editorial_document_id', documents.map((d: any) => d.id))
    );
    assert.equal(relations.length, 64, `Expected 64 references across both docs, got ${relations.length}`);

    // 4. Build editorial integrity report
    const snapshot = {
      artists: [artist, ...m.reference_targets],
      documents,
      relations
    };
    const integrity = buildEditorialIntegrityReport(snapshot);
    assert.equal(integrity.counts.blocking, 0, `Blocking findings: ${JSON.stringify(integrity.findings)}`);
    assert.equal(integrity.counts.warning, 0, `Warning findings: ${JSON.stringify(integrity.findings)}`);

    // 5. Hygiene checks
    assert.ok(!artist.genres.includes(artist.primary_genre), 'genres must not include primary_genre');
    assert.ok(!artist.occupations.includes(artist.primary_role), 'occupations must not include primary_role');

    // 6. Write verification artifact
    fs.writeFileSync(
      base + 'los-hijos-del-rey-saved-verification.json',
      JSON.stringify({ snapshot: { artist, documents, relationsCount: relations.length }, integrity }, null, 2)
    );

    console.log(
      JSON.stringify(
        {
          verified: true,
          id: artist.id,
          name: artist.name,
          status: artist.status,
          documents: documents.map((d: any) => ({
            id: d.id,
            locale: d.locale,
            status: d.status,
            revision: d.revision
          })),
          relationsCount: relations.length,
          integrityCounts: integrity.counts
        },
        null,
        2
      )
    );
  } else {
    throw Error('Expected mode: prepare | execute | verify');
  }
}

run().catch((err) => {
  console.error(err);
  process.exit(1);
});
