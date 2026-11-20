import fs from 'node:fs';
import assert from 'node:assert/strict';

const manifest = JSON.parse(fs.readFileSync(new URL('./ten-bios-update-manifest-v2-2026-10-30.json', import.meta.url), 'utf8'));
const index = Number(process.argv[2]);
assert.ok(Number.isInteger(index) && index >= 0 && index < manifest.scope.length, 'Artist index 0–9 required');
const artist = manifest.scope[index];
const changes = manifest.changes.filter(c => c.owner_id === artist.id);
const mirrors = manifest.mirrorChanges.filter(c => c.owner_id === artist.id);
const field = manifest.fieldChanges.find(c => c.owner_id === artist.id);
assert.deepEqual(changes.map(c => c.locale).sort(), ['en', 'es']);
assert.deepEqual(mirrors.map(c => c.locale).sort(), ['en', 'es']);
const q = value => `'${String(value).replaceAll("'", "''")}'`;
const jsonb = value => `${q(JSON.stringify(value))}::jsonb`;
const uuid = value => `${q(value)}::uuid`;
const textArray = value => `ARRAY[${value.map(q).join(',')}]::text[]`;
const typed = (key, value) => {
  if (value == null) return 'NULL';
  if (key === 'genres') return textArray(value);
  if (key === 'occupations') return jsonb(value);
  return q(value);
};
const checks = [`id = ${uuid(artist.id)}`, `slug = ${q(artist.slug)}`, `status = 'published'`];
for (const mirror of mirrors) checks.push(`${mirror.column} IS NOT DISTINCT FROM ${q(mirror.before)}`);
if (field) for (const [key, value] of Object.entries(field.before)) checks.push(`${key} IS NOT DISTINCT FROM ${typed(key, value)}`);
const sets = mirrors.map(mirror => `${mirror.column} = ${q(mirror.after)}`);
if (field) for (const [key, value] of Object.entries(field.after)) sets.push(`${key} = ${typed(key, value)}`);

let sql = `DO $editorial_pass$\nBEGIN\n`;
sql += `  IF NOT EXISTS (SELECT 1 FROM public.artists WHERE ${checks.join(' AND ')} FOR UPDATE) THEN\n`;
sql += `    RAISE EXCEPTION 'Stale artist or mirror precondition: ${artist.slug}';\n  END IF;\n`;
for (const change of changes) {
  sql += `  IF NOT EXISTS (SELECT 1 FROM public.editorial_documents WHERE id = ${uuid(change.document_id)} AND owner_artist_id = ${uuid(artist.id)} AND locale = ${q(change.locale)} AND status = 'published' AND revision = ${change.expected_revision} AND document = ${jsonb(change.before)} FOR UPDATE) THEN\n`;
  sql += `    RAISE EXCEPTION 'Stale biography precondition: ${artist.slug} ${change.locale}';\n  END IF;\n`;
}
sql += `  UPDATE public.artists SET ${sets.join(', ')} WHERE id = ${uuid(artist.id)};\n`;
for (const change of changes) {
  sql += `  PERFORM id FROM public.upsert_editorial_document('artist_biography', ${uuid(artist.id)}, ${q(change.locale)}, 1, 'published', ${jsonb(change.after)}, ${change.expected_revision});\n`;
}
sql += `END $editorial_pass$;\n`;
sql += `SELECT a.slug, a.status, (SELECT jsonb_agg(jsonb_build_object('locale', d.locale, 'revision', d.revision, 'status', d.status) ORDER BY d.locale) FROM public.editorial_documents d WHERE d.owner_artist_id = a.id AND d.document_type = 'artist_biography') AS documents, (SELECT count(*) FROM public.editorial_entity_references r JOIN public.editorial_documents d ON d.id = r.editorial_document_id WHERE d.owner_artist_id = a.id AND d.document_type = 'artist_biography') AS reference_count FROM public.artists a WHERE a.id = ${uuid(artist.id)};`;
process.stdout.write(sql);
