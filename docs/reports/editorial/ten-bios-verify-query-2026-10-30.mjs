import fs from 'node:fs';
import assert from 'node:assert/strict';

const manifest = JSON.parse(fs.readFileSync(new URL('./ten-bios-update-manifest-v2-2026-10-30.json', import.meta.url), 'utf8'));
const first = Number(process.argv[2]);
const last = Number(process.argv[3]);
assert.ok(Number.isInteger(first) && Number.isInteger(last) && first >= 0 && first <= last && last < manifest.scope.length);
const q = value => `'${String(value).replaceAll("'", "''")}'`;
const uuid = value => `${q(value)}::uuid`;
const jsonb = value => `${q(JSON.stringify(value))}::jsonb`;
const typed = (key, value) => {
  if (value == null) return 'NULL';
  if (key === 'genres') return `ARRAY[${value.map(q).join(',')}]::text[]`;
  if (key === 'occupations') return jsonb(value);
  return q(value);
};
const refs = doc => {
  const found = [];
  const walk = value => {
    if (Array.isArray(value)) return value.forEach(walk);
    if (value && typeof value === 'object') {
      if (value.type === 'artistReference') found.push(`artist:${value.attrs.occurrenceId}:${value.attrs.artistId}`);
      Object.values(value).forEach(walk);
    }
  };
  walk(doc);
  return found;
};
const queries = [];
for (let i = first; i <= last; i++) {
  const artist = manifest.scope[i];
  const docs = manifest.changes.filter(c => c.owner_id === artist.id);
  const mirrors = manifest.mirrorChanges.filter(c => c.owner_id === artist.id);
  const fields = manifest.fieldChanges.find(c => c.owner_id === artist.id);
  const fieldChecks = fields ? Object.entries(fields.after).map(([key, value]) => `a.${key} IS NOT DISTINCT FROM ${typed(key, value)}`) : ['true'];
  const mirrorChecks = mirrors.map(c => `a.${c.column} IS NOT DISTINCT FROM ${q(c.after)}`);
  const docChecks = docs.map(c => `EXISTS (SELECT 1 FROM public.editorial_documents d WHERE d.id = ${uuid(c.document_id)} AND d.owner_artist_id = a.id AND d.locale = ${q(c.locale)} AND d.status = 'published' AND d.revision = ${c.expected_revision+1} AND d.document = ${jsonb(c.after)})`);
  const expectedRefs = docs.flatMap(c => refs(c.after)).sort();
  const actualRefs = `(SELECT ARRAY(SELECT r.entity_type || ':' || r.occurrence_id::text || ':' || r.target_artist_id::text FROM public.editorial_entity_references r JOIN public.editorial_documents d ON d.id = r.editorial_document_id WHERE d.owner_artist_id = a.id AND d.document_type = 'artist_biography' ORDER BY 1))`;
  const expectedArray = `ARRAY[${expectedRefs.map(q).join(',')}]::text[]`;
  queries.push(`SELECT a.slug, (a.status = 'published' AND ${fieldChecks.join(' AND ')}) AS fields_ok, (${mirrorChecks.join(' AND ')}) AS mirrors_ok, ((SELECT count(*) FROM public.editorial_documents d WHERE d.owner_artist_id = a.id AND d.document_type = 'artist_biography') = 2 AND ${docChecks.join(' AND ')}) AS documents_ok, (${actualRefs} = ${expectedArray}) AS references_ok, ${expectedRefs.length} AS expected_references, (SELECT count(*) FROM public.editorial_entity_references r JOIN public.editorial_documents d ON d.id = r.editorial_document_id WHERE d.owner_artist_id = a.id AND d.document_type = 'artist_biography') AS actual_references FROM public.artists a WHERE a.id = ${uuid(artist.id)}`);
}
process.stdout.write(queries.join('\nUNION ALL\n') + ';');
