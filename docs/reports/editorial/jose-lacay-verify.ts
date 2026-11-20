import fs from 'node:fs';
import assert from 'node:assert/strict';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
const base='docs/reports/editorial/';
const saved=JSON.parse(fs.readFileSync(base+'jose-lacay-saved-snapshot.json','utf8'));
// Only Lacay's documents are in scope; reference targets supply identity/status,
// not their legacy biographies (which would require their own full document audit).
const scoped={...saved,artists:saved.artists.map((a:any)=>a.slug==='jose-lacay'?a:{id:a.id,name:a.name,slug:a.slug,status:a.status})};
const report=buildEditorialIntegrityReport(scoped);
assert.equal(report.counts.blocking,0);assert.equal(report.counts.warning,0);
assert.equal(saved.documents.length,2);assert.equal(saved.relations.length,4);
for(const d of saved.documents) assert.equal(d.status,'published');
const a=saved.artists.find((a:any)=>a.slug==='jose-lacay');
assert.equal(a.status,'draft');assert.equal(a.date_of_birth,'1947-03-19');assert.equal(a.date_of_death,'2016-11-14');assert.equal(a.has_image,true);
assert.ok(!a.genres.includes(a.primary_genre));assert.ok(!(a.occupations??[]).includes(a.primary_role));
assert.equal(a.birth_place,'Santo Domingo');assert.equal(a.province,'Distrito Nacional');assert.equal(a.spotify,'3e2m8rnUL2tQVVus6u2k5L');
fs.writeFileSync(base+'jose-lacay-integrity-report.json',JSON.stringify(report,null,2));
console.log(JSON.stringify(report));
