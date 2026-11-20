import fs from 'node:fs';
import assert from 'node:assert/strict';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
import {editorialDocumentToPlainText} from '../../../src/lib/editorial/plainText';
const base='docs/reports/editorial/';
const saved=JSON.parse(fs.readFileSync(base+'jicarada-saved-snapshot.json','utf8'));
const report=buildEditorialIntegrityReport(saved);
assert.equal(report.counts.blocking,0);
assert.equal(report.counts.warning,0);
assert.equal(saved.documents.length,2);
assert.equal(saved.relations.length,2);
assert.equal(saved.artists.find((a:any)=>a.id==='0da11a3b-6611-4438-9c1c-4c8bfe67fc36').status,'draft');
for(const d of saved.documents){assert.equal(d.status,'published'); const t=editorialDocumentToPlainText(d.document); assert.ok(t.includes('JIC326CD')); assert.ok(t.includes('Ronny Moramis'));}
fs.writeFileSync(base+'jicarada-integrity-report.json',JSON.stringify(report,null,2));
console.log(JSON.stringify(report));
