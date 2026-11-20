import fs from 'node:fs';
import assert from 'node:assert/strict';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
const base='docs/reports/editorial/';
const m=JSON.parse(fs.readFileSync(base+'nelly-swing-profile-manifest.json','utf8'));
const [s]=JSON.parse(fs.readFileSync(base+'nelly-swing-saved.json','utf8'));
const docs=JSON.parse(fs.readFileSync(base+'nelly-swing-biographies.json','utf8'));
for(const [k,v] of Object.entries(m.after))assert.deepEqual(s.artist[k],v,k);
assert.equal(s.documents.length,2);assert.equal(s.relations.length,8);
for(const d of s.documents){assert.equal(d.status,'published');assert.equal(validateEditorialDocument(1,d.document).ok,true);assert.deepEqual(d.document,docs.find((x:any)=>x.locale===d.locale).document);}
const names=m.references;const targets=Object.entries(names).map(([name,id])=>({id,name,slug:name,status:'published'}));
const report=buildEditorialIntegrityReport({documents:s.documents,relations:s.relations,artists:[s.artist,...targets]});assert.equal(report.counts.blocking,0);
fs.writeFileSync(base+'nelly-swing-verification.json',JSON.stringify({fieldsMatch:true,biographiesMatch:true,report},null,2));console.log(JSON.stringify(report.counts));
