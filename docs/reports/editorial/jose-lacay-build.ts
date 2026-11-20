import fs from 'node:fs';
import {randomUUID} from 'node:crypto';
import assert from 'node:assert/strict';
import {validateEditorialDocument} from '../../../src/lib/editorial/validate';
const base='docs/reports/editorial/';
const input=JSON.parse(fs.readFileSync(base+'jose-lacay-biography-input.json','utf8'));
const esc=(s:string)=>s.replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;');
const docs=Object.entries(input.bios).map(([locale,pairs]:any)=>{
 const content:any[]=[];let html='';
 for(const [h,t] of pairs){if(h){content.push({type:'paragraph',content:[{type:'text',text:h,marks:[{type:'bold'}]}]});html+='<p><strong>'+esc(h)+'</strong></p>';}
 const nodes:any[]=[];let body='';let pos=0;
 for(const m of t.matchAll(/\[\[(.*?)\]\]/g)){const prefix=t.slice(pos,m.index);if(prefix){nodes.push({type:'text',text:prefix});body+=esc(prefix);}const attrs={occurrenceId:randomUUID(),artistId:input.refs[m[1]],displayText:m[1]};assert.ok(attrs.artistId);nodes.push({type:'artistReference',attrs});body+='<span data-editorial-node="artist-reference" occurrenceId="'+attrs.occurrenceId+'" artistId="'+attrs.artistId+'" displayText="'+esc(attrs.displayText)+'">'+esc(attrs.displayText)+'</span>';pos=m.index+m[0].length;}
 if(pos<t.length){nodes.push({type:'text',text:t.slice(pos)});body+=esc(t.slice(pos));}content.push({type:'paragraph',content:nodes});html+='<p>'+body+'</p>';}
 const document={type:'doc',content};assert.equal(validateEditorialDocument(1,document).ok,true);fs.writeFileSync(base+'jose-lacay-'+locale+'.html',html);return {locale,document};});
fs.writeFileSync(base+'jose-lacay-biographies.json',JSON.stringify(docs,null,2));
const manifest=JSON.parse(fs.readFileSync(base+'jose-lacay-profile-manifest.json','utf8'));manifest.biographies=input.bios;manifest.references=input.refs;fs.writeFileSync(base+'jose-lacay-profile-manifest.json',JSON.stringify(manifest,null,2));
console.log('Two structured biographies validated; four artist references prepared.');

