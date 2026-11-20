const fs = require('node:fs');
const assert = require('node:assert/strict');
globalThis.AsyncLocalStorage = require('node:async_hooks').AsyncLocalStorage;
const {workAsyncStorage} = require('next/dist/server/app-render/work-async-storage.external.js');
const {revalidatePath} = require('next/dist/server/web/spec-extension/revalidate.js');
const {getImplicitTags} = require('next/dist/server/lib/implicit-tags.js');
(async()=>{
 const results=[];
 for(const slug of ['onguito-wa','rhina-ramirez']){
  const path=`/es/artists/${slug}`;
  const implicit=await getImplicitTags('/[locale]/artists/[slug]/page',path,null);
  function emitted(type){const store={incrementalCache:{},route:'/api/revalidate',page:'/api/revalidate/route'};workAsyncStorage.run(store,()=>revalidatePath(path,type));return store.pendingRevalidatedTags.map(x=>x.tag);}
  const current=emitted('page');const proposed=emitted();
  assert.equal(current.some(t=>implicit.tags.includes(t)),false);
  assert.equal(proposed.some(t=>implicit.tags.includes(t)),true);
  results.push({slug,routeTags:implicit.tags,current,proposed,currentMatches:false,proposedMatches:true});
 }
 fs.writeFileSync('docs/reports/editorial/onguito-rhina-revalidation-repro.json',JSON.stringify(results,null,2));console.log(JSON.stringify(results));
})();
