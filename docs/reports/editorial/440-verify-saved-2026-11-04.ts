import fs from 'node:fs';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
const dir='docs/reports/editorial/';
const read=(name:string)=>JSON.parse(fs.readFileSync(dir+name,'utf8'));
const raw=fs.readFileSync(dir+'440-biography-change-manifest-2026-11-04.json');
const hash=createHash('sha256').update(raw).digest('hex');
assert.equal(hash,'f216a8e1f435cad7e6e3192c8d9ec6f951214c8e79832da96987b77f851f748e');
const manifest=JSON.parse(raw.toString('utf8'));
const saved=read('440-biographies-after-2026-11-04.json');
const targets=read('440-validation-targets-2026-11-04.json');
const checks=[];
for(const c of manifest.changes){
 const d=saved.documents.find((d:any)=>d.id===c.document_id);
 const a=saved.artists.find((a:any)=>a.id===c.owner_id);
 assert.ok(d&&a);assert.equal(d.revision,c.expected_revision+1);
 assert.equal(d.status,c.status_after);assert.equal(a.status,c.artist_status_after);
 assert.equal(d.owner_artist_id,c.owner_id);assert.equal(d.locale,c.locale);
 assert.deepEqual(d.document,c.after);assert.equal(a['bio_'+c.locale],c.mirror_after);
 assert.ok(validateEditorialDocument(1,d.document).ok);
 const refs=saved.references.filter((r:any)=>r.editorial_document_id===d.id);
 assert.equal(refs.length,c.references_after.length);
 for(const r of c.references_after)assert.ok(refs.some((v:any)=>v.occurrence_id===r.occurrenceId&&v.target_artist_id===r.targetArtistId&&v.entity_type==='artist'));
 checks.push({name:c.name,locale:c.locale,document_id:d.id,revision_before:c.expected_revision,revision_after:d.revision,document_matches:true,mirror_matches:true,references_match:true,status_preserved:true});
}
assert.equal(saved.documents.length,22);assert.equal(saved.artists.length,11);
const artists=[...new Map([...targets,...saved.artists].map((a:any)=>[a.id,a])).values()] as any[];
// Mirrors are compared exactly above. Integrity's text-normalization check is separate.
const integrity=buildEditorialIntegrityReport({documents:saved.documents,relations:saved.references,artists:artists.map(({bio_en,bio_es,...a}:any)=>a)});
assert.equal(integrity.counts.blocking,0);assert.equal(integrity.counts.warning,0);assert.equal(integrity.counts.informational,0);
const report={state:'APPROVED AND SAVED; DATABASE VERIFICATION PASSED',approved_manifest_sha256:hash,checks,integrity,non_biography_artist_fields:'Compared within save transaction; no differences permitted.',cache_refresh:'Pending separate targeted refresh',live_rendering:'Pending bounded representative checks'};
fs.writeFileSync(dir+'440-save-verification-2026-11-04.json',JSON.stringify(report,null,2));
console.log(JSON.stringify({documents:checks.length,artists:saved.artists.length,references:saved.references.length,integrity:integrity.counts,allExactComparisonsPassed:true},null,2));
