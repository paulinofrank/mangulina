import fs from 'node:fs';
import assert from 'node:assert/strict';
import { validateEditorialDocument } from '../../../src/lib/editorial/validate';
import { buildEditorialIntegrityReport } from '../../../src/lib/editorial/integrity';
const base = 'C:/Mangulina/docs/reports/editorial/';
const manifest = JSON.parse(fs.readFileSync(base + 'rubali-valerio-profile-manifest.json', 'utf8'));
const [saved] = JSON.parse(fs.readFileSync(base + 'rubali-valerio-saved.json', 'utf8'));
for (const [field, value] of Object.entries(manifest.after.artist_fields)) assert.deepEqual(saved.artist[field], value, field);
assert.equal(saved.documents.length, 2);
for (const expected of manifest.after.editorial_documents) {
  const actual = saved.documents.find((d: {locale: string}) => d.locale === expected.locale);
  assert.deepEqual(actual.document, expected.document);
  assert.equal(actual.status, 'draft');
  assert.equal(actual.revision, 1);
  assert.equal(validateEditorialDocument(actual.schema_version, actual.document).ok, true);
}
const report = buildEditorialIntegrityReport({ documents: saved.documents, relations: [], artists: [saved.artist] });
assert.equal(report.counts.blocking, 0);
fs.writeFileSync(base + 'rubali-valerio-verification.json', JSON.stringify({fieldsMatchManifest: true, documentsMatchManifest: true, report}, null, 2));
console.log(JSON.stringify(report.counts));
