import assert from 'node:assert/strict';
import fs from 'node:fs';
import { randomUUID } from 'node:crypto';
import { validateEditorialDocument } from '../../../src/lib/editorial/validate';

const base = 'docs/reports/editorial/';
const source = fs.readFileSync(`${base}johnny-tulanga-biographies-proposed-2026-11-10.md`, 'utf8');
const targets: Record<string, string> = {
  'orquesta-liberacion': '6e1b1d42-3fe5-4523-9999-479a7626fb9a',
  'wilfrido-vargas': '2bc36959-dcce-4e10-9ecf-2cd418eaa489',
  'los-hijos-del-rey': '3c82ee60-d565-405d-8423-7895d3706122',
  'fernando-villalona': 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd',
  'bonny-cepeda': 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf',
  'raulin-rosendo': 'faf3e4cb-808e-419c-87ff-5126eed85e73',
  'ramon-orlando': '02f23257-1cf6-4a4c-8df1-1f9aa630a2c3',
  'monchy-capricho': '97249298-9041-4d41-904c-2c788ac2963e',
  'henry-castro': '2c09c6dc-5de7-438d-8236-6bc085378377',
  'aramis-camilo': 'e5129444-0923-4e06-b77d-f82f14c02b7d',
};

function build(locale: 'es' | 'en') {
  const start = `## ${locale === 'es' ? 'Español' : 'English'}\n\n`;
  const end = locale === 'es' ? '\n## English\n' : '\n## END\n';
  const i = source.indexOf(start);
  assert.ok(i >= 0);
  const j = source.indexOf(end, i + start.length);
  const body = source.slice(i + start.length, j >= 0 ? j : undefined).trim();
  const content: any[] = [];
  for (const raw of body.split(/\r?\n\r?\n/)) {
    const paragraph = raw.trim();
    assert.ok(paragraph && !paragraph.includes('\n'), `Unexpected multiline paragraph: ${paragraph.slice(0, 40)}`);
    if (/^\*\*[^*]+\*\*$/.test(paragraph)) {
      content.push({ type: 'paragraph', content: [{ type: 'text', text: paragraph.slice(2, -2), marks: [{ type: 'bold' }] }] });
      continue;
    }
    const nodes: any[] = [];
    let previous = 0;
    for (const match of paragraph.matchAll(/\[([^\]]+)\]\(https:\/\/mangulina\.do\/(?:en|es)\/artists\/([a-z0-9-]+)\)/g)) {
      if (match.index > previous) nodes.push({ type: 'text', text: paragraph.slice(previous, match.index) });
      const id = targets[match[2]];
      assert.ok(id, `Unknown target ${match[2]}`);
      nodes.push({ type: 'artistReference', attrs: { occurrenceId: randomUUID(), artistId: id, displayText: match[1] } });
      previous = match.index + match[0].length;
    }
    if (previous < paragraph.length) nodes.push({ type: 'text', text: paragraph.slice(previous) });
    content.push({ type: 'paragraph', content: nodes });
  }
  const document = { type: 'doc', content };
  const validation = validateEditorialDocument(1, document);
  assert.equal(validation.ok, true, JSON.stringify(validation));
  const mirror = body.replace(/\[([^\]]+)\]\(https:\/\/mangulina\.do\/(?:en|es)\/artists\/[a-z0-9-]+\)/g, '$1');
  return { locale, document, mirror, references: content.flatMap((p: any) => (p.content ?? []).filter((n: any) => n.type === 'artistReference')).length };
}

const output = { owner_artist_id: '17b237d9-8aa3-4503-bb3e-f956cc900211', documents: [build('es'), build('en')] };
for (const entry of output.documents) assert.equal(entry.references, 11);
fs.writeFileSync(`${base}johnny-tulanga-prepared-2026-11-10.json`, JSON.stringify(output, null, 2));
console.log(output.documents.map(({locale, document, references}) => ({locale, blocks: document.content.length, references})));
