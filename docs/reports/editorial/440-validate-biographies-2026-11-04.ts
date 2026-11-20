import fs from 'node:fs';
import assert from 'node:assert/strict';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
const dir='docs/reports/editorial/';
const manifest=JSON.parse(fs.readFileSync(dir+'440-biography-change-manifest-2026-11-04.json','utf8'));
const targets=JSON.parse(fs.readFileSync(dir+'440-validation-targets-2026-11-04.json','utf8'));
const names=new Map(targets.map((a:any)=>[a.id,a.name]));
function walk(n:any,fn:(n:any)=>void){fn(n);for(const c of n.content??[])walk(c,fn);}
function text(n:any):string{return n.type==='text'?n.text:n.type==='artistReference'?n.attrs.displayText:(n.content??[]).map(text).join('');}
const docs:any[]=[],relations:any[]=[],checks:any[]=[];
for(const c of manifest.changes){
  assert.equal(c.status_before,'published');assert.equal(c.status_after,c.status_before);
  assert.ok(validateEditorialDocument(1,c.after).ok);
  walk(c.after,n=>{if(n.type==='artistReference')assert.equal(n.attrs.displayText,names.get(n.attrs.artistId));});
  const major=['adalgisa-pantaleon','juan-luis-guerra','maridalia-hernandez','mariela-mercado','marco-hernandez','roger-zayas-bazan','grupo-440'].includes(c.slug);
  if(major){assert.equal(c.after.content[0].type,'paragraph');assert.ok(!c.after.content[0].content.some((n:any)=>n.marks?.length));assert.equal(text(c.after.content.at(-2)),c.locale==='en'?'Legacy':'Legado');walk(c.after,n=>{assert.notEqual(n.type,'heading');if(n.type==='paragraph'){const bold=n.content?.filter((x:any)=>x.marks?.some((m:any)=>m.type==='bold'))??[];assert.ok(!bold.length||(n.content.length===1&&bold.length===1));}});}
  docs.push({id:c.document_id,document_type:'artist_biography',owner_artist_id:c.owner_id,locale:c.locale,schema_version:1,status:c.status_after,document:c.after});
  for(const r of c.references_after)relations.push({editorial_document_id:c.document_id,occurrence_id:r.occurrenceId,entity_type:'artist',target_artist_id:r.targetArtistId});
  checks.push({name:c.name,locale:c.locale,document_id:c.document_id,expected_revision:c.expected_revision,next_revision:c.expected_revision+1,blocks:c.after.content.length,references:c.references_after.length,format:major?'checked full revised biography':'preserved existing layout; targeted change only'});
}
assert.equal(manifest.changes.length,22);
assert.equal(new Set(manifest.changes.map((c:any)=>c.owner_id)).size,11);
const ownerArtists=manifest.changes.map((c:any)=>({id:c.owner_id,name:c.name,slug:c.slug,status:c.status_before}));
const allArtists=[...new Map([...targets,...ownerArtists].map((a:any)=>[a.id,a])).values()] as any[];
const report=buildEditorialIntegrityReport({documents:docs,relations,artists:allArtists});
assert.equal(report.counts.blocking,0);assert.equal(report.counts.warning,0);assert.equal(report.counts.informational,0);
const out={state:'LOCAL PROPOSAL VALIDATION ONLY — NOT PERSISTED',checks,integrity:report,publication:'No database writes or cache refreshes performed.'};
fs.writeFileSync(dir+'440-proposal-validation-2026-11-04.json',JSON.stringify(out,null,2));
console.log(JSON.stringify({documents:docs.length,owners:11,referenceOccurrences:relations.length,targets:targets.length,integrity:report.counts},null,2));
