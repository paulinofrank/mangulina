import fs from 'node:fs';
import { randomUUID } from 'node:crypto';
import assert from 'node:assert/strict';
import { validateEditorialDocument } from '../../../src/lib/editorial/validate';

const directory = 'docs/reports/editorial/';
const source = JSON.parse(fs.readFileSync(directory + 'grupo-hope-evolution-content-2026-11-07.json', 'utf8')) as Record<string, [string | null, string][]>;
const targets: Record<string, string> = {
  'Junior Ponciano': 'e897479f-94dd-47b5-af43-3a6dbfdac363',
  'Misael J': '86d543cd-3eab-42d0-98c8-438bf8d5792c',
  'Carolina Ponciano': '3258b734-bf0e-4be9-97ce-c6101d84e77e',
  'Karol Michelle': 'de2cd2a0-bf2f-497c-a747-82266c8fa32e',
  'Averly Morillo': '548bc0df-b19a-43af-b5a4-798b8a401780',
  'Jordan Mateo': '1a4f1c39-f32a-4b98-af5d-a6969885eab9',
  'Karen Ponciano': '3cfbc232-0dcb-470c-8aee-98e44be5b8ac'
};
function nodes(prose: string) {
  const result: any[] = [];
  let position = 0;
  for (const match of prose.matchAll(/\[\[([^\]]+)\]\]/g)) {
    if (match.index > position) result.push({ type: 'text', text: prose.slice(position, match.index) });
    const name = match[1];
    assert.ok(targets[name], `Unknown artist reference: ${name}`);
    result.push({ type: 'artistReference', attrs: { artistId: targets[name], occurrenceId: randomUUID(), displayText: name } });
    position = match.index + match[0].length;
  }
  if (position < prose.length) result.push({ type: 'text', text: prose.slice(position) });
  return result;
}

const documents = ['en', 'es'].map(locale => {
  const sections = source[locale];
  assert.ok(sections?.length && sections[0][0] === null && sections.at(-1)?.[0] === (locale === 'es' ? 'Legado' : 'Legacy'));
  const blocks: any[] = [];
  for (const [heading, prose] of sections) {
    if (heading) blocks.push({ type: 'paragraph', content: [{ type: 'text', text: heading, marks: [{ type: 'bold' }] }] });
    blocks.push({ type: 'paragraph', content: nodes(prose) });
  }
  const document = { type: 'doc', content: blocks };
  const validation = validateEditorialDocument(1, document);
  assert.equal(validation.ok, true, JSON.stringify(validation));
  const mirror = sections.map(([heading, prose]) => `${heading ? '**' + heading + '**\n\n' : ''}${prose.replace(/\[\[([^\]]+)\]\]/g, '$1')}`).join('\n\n');
  return { locale, expected_revision: 1, new_revision: 2, document, mirror };
});
const manifest = {
  date: '2026-11-07',
  owner_artist_id: '04788dac-8c1b-40ec-8c3e-c6a375838f20',
  artist_status_before_and_after: 'draft',
  document_status_before_and_after: 'published',
  scope: 'Replace only Grupo Hope EN/ES biographies and their compatibility mirrors. Preserve artist fields, relationships and music data.',
  documents,
  source_report: 'docs/reports/editorial/grupo-hope-evolution-research-2026-11-07.md'
};
fs.writeFileSync(directory + 'grupo-hope-evolution-manifest-2026-11-07.json', JSON.stringify(manifest, null, 2));
console.log(JSON.stringify({ owner_artist_id: manifest.owner_artist_id, locales: documents.map(d => d.locale), blocks: documents.map(d => d.document.content.length), references: documents.map(d => d.document.content.flatMap((b: any) => b.content || []).filter((n: any) => n.type === 'artistReference').length), validated: true }));
