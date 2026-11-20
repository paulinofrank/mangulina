const fs=require('node:fs');const crypto=require('node:crypto');const cp=require('node:child_process');const path=require('node:path');const assert=require('node:assert/strict');
const revision='30d79c2d011e433b79cf924d2d6407d774f6a0c9';const root='C:/Mangulina/release-snapshots/artist-cache-fix-20261023';
const changed=[];const tree=cp.execFileSync('git',['ls-tree','-rz',revision],{encoding:'utf8',maxBuffer:10000000}).split('\0').filter(Boolean);
let normalizedLineEndings=0;
const blobHash=bytes=>crypto.createHash('sha1').update(`blob ${bytes.length}\0`).update(bytes).digest('hex');
for(const row of tree){const [entry,name]=row.split('\t');const expected=entry.split(' ')[2];const bytes=fs.readFileSync(path.join(root,name));if(blobHash(bytes)===expected)continue;const normalized=bytes.includes(0)?bytes:Buffer.from(bytes.toString('utf8').replace(/\r\n/g,'\n'));if(blobHash(normalized)===expected){normalizedLineEndings++;continue;}changed.push(name);}
assert.deepEqual(changed.sort(),['src/lib/revalidateArtistProfile.ts','tests/performance/publicCatalogCaching.test.ts']);
const manifest={baseRevision:revision,trackedFilesCompared:tree.length,normalizedLineEndings,changedTrackedFiles:changed,newTest:'tests/performance/artistNegativeCache.test.ts',deployedSourceFiles:['src/lib/revalidateArtistProfile.ts'],helperSha256:crypto.createHash('sha256').update(fs.readFileSync(path.join(root,'src/lib/revalidateArtistProfile.ts'))).digest('hex'),deployment:'dpl_DvUxdmNfkQ8ordac1Br6JnevhFYS',url:'https://mangulina-99j32iuo8-frankprojects.vercel.app',testsExcludedFromUpload:true};
fs.writeFileSync('docs/reports/editorial/artist-cache-release-snapshot.json',JSON.stringify(manifest,null,2));console.log(JSON.stringify(manifest));
