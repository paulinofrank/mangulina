import fs from 'node:fs';
import assert from 'node:assert/strict';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
const b='docs/reports/editorial/';
const m=JSON.parse(fs.readFileSync(b+'michan-leonardo-profile-manifest.json','utf8'));
const [s]=JSON.parse(fs.readFileSync(b+'michan-leonardo-saved.json','utf8'));
const planned=JSON.parse(fs.readFileSync(b+'michan-leonardo-biographies.json','utf8'));
for(const [k,v] of Object.entries(m.after))assert.deepEqual(s.artist[k],v,k);
assert.equal(s.documents.length,2);assert.equal(s.relations.length,4);
for(const d of s.documents){assert.equal(d.status,'published');assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,planned.find((p:any)=>p.locale===d.locale).document);}
const targets=Object.entries(m.references).map(([name,id])=>({id,name,slug:name,status:name==='Frantoni Santana'?'draft':'published'}));
const report=buildEditorialIntegrityReport({documents:s.documents,relations:s.relations,artists:[s.artist,...targets]});assert.equal(report.counts.blocking,0);assert.equal(report.counts.warning,2);
fs.writeFileSync(b+'michan-leonardo-verification.json',JSON.stringify({fieldsMatch:true,documentsMatch:true,report},null,2));console.log(JSON.stringify(report.counts));
