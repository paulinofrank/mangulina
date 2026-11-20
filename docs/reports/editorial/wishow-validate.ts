import fs from 'node:fs';
import assert from 'node:assert/strict';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
const docs=JSON.parse(fs.readFileSync('docs/reports/editorial/wishow-biographies.json','utf8'));
for(const d of docs) assert.equal(validateEditorialDocument(1,d.document).ok,true);
console.log('Both biography schemas valid');
