import fs from 'node:fs';
import assert from 'node:assert/strict';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';

dotenv.config({quiet: true});
const id = 'a7f7bc09-9356-41f0-9509-273b1724c452';
const file = 'docs/reports/editorial/la-gran-mawon-role-correction-manifest.json';
const db = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL ?? process.env.SUPABASE_URL!, process.env.SUPABASE_SERVICE_ROLE_KEY!, {auth: {persistSession: false, autoRefreshToken: false}});
const check = (r: any) => { if (r.error) throw Error(r.error.message); return r.data; };
const get = async () => check(await db.from('artists').select('id,name,slug,type,status,primary_role,occupations,updated_at').eq('id', id).single());

if (process.argv[2] === 'prepare') {
  assert.ok(!fs.existsSync(file), 'Preserve frozen role manifest');
  const before = await get();
  assert.equal(before.status, 'draft');
  assert.equal(before.type, 'group');
  assert.equal(before.primary_role, 'band');
  assert.deepEqual(before.occupations, []);
  const manifest = {date: '2026-10-30', artist_id: id, before, after: {primary_role: 'musician'}, reason: 'The admin group form renders band as no selected primary role; musician is an available option for a collective of musicians. Artist type remains group.', evidence_report: 'la-gran-mawon-research-2026-10-30.md'};
  fs.writeFileSync(file, JSON.stringify(manifest, null, 2));
  console.log(JSON.stringify({prepared: true, artist_id: id, before: before.primary_role, after: 'musician'}));
} else if (process.argv[2] === 'execute') {
  const m = JSON.parse(fs.readFileSync(file, 'utf8'));
  const before = await get();
  assert.equal(before.updated_at, m.before.updated_at);
  assert.equal(before.primary_role, 'band');
  const saved = check(await db.from('artists').update(m.after).eq('id', id).eq('updated_at', before.updated_at).select('id'));
  assert.equal(saved.length, 1);
  console.log('Primary role set to musician; group type and draft status preserved.');
} else if (process.argv[2] === 'verify') {
  const after = await get();
  assert.equal(after.type, 'group');
  assert.equal(after.status, 'draft');
  assert.equal(after.primary_role, 'musician');
  assert.ok(!after.occupations.includes(after.primary_role));
  fs.writeFileSync('docs/reports/editorial/la-gran-mawon-role-verification.json', JSON.stringify(after, null, 2));
  console.log(JSON.stringify({artist_id: id, type: after.type, status: after.status, primary_role: after.primary_role}));
} else throw Error('Expected prepare, execute or verify');
