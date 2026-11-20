import fs from 'node:fs';
import assert from 'node:assert/strict';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
import {buildEditorialIntegrityReport} from '../../../src/lib/editorial/integrity';
const base='C:/Mangulina/docs/reports/editorial/';
const manifest=JSON.parse(fs.readFileSync(base+'nicol-pena-profile-manifest.json','utf8'));
const [saved]=JSON.parse(fs.readFileSync(base+'nicol-pena-saved.json','utf8'));
for(const [key,value] of Object.entries(manifest.after)) assert.deepEqual(saved.artist[key],value,key);
assert.equal(saved.documents.length,2);
for(const d of saved.documents){assert.equal(d.status,'draft');assert.equal(d.revision,1);assert.equal(validateEditorialDocument(1,d.document).ok,true);const pairs=manifest.biographies[d.locale];const content=pairs.flatMap(([heading,text]:string[])=>[...(heading?[{type:'paragraph',content:[{type:'text',text:heading,marks:[{type:'bold'}]}]}]:[]),{type:'paragraph',content:[{type:'text',text}]}]);assert.deepEqual(d.document,{type:'doc',content});}
const report=buildEditorialIntegrityReport({documents:saved.documents,relations:[],artists:[saved.artist]});
assert.equal(report.counts.blocking,0);
fs.writeFileSync(base+'nicol-pena-verification.json',JSON.stringify({fieldsMatch:true,biographiesMatch:true,report},null,2));
console.log(JSON.stringify(report.counts));
