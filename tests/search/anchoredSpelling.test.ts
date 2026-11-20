import assert from "node:assert/strict";
import test from "node:test";
import artists from "./fixtures/published-artists.json";
import { rankCatalogResults, rankCatalogCandidate, searchTokens, QUESTION_WORDS } from "../../src/lib/searchMatching";
import { normalizeSearchText } from "../../src/lib/searchRanking";
import type { GlobalSearchResponse, SearchResult } from "../../src/lib/searchTypes";
const catalog={artists,songs:[],releases:[]} as GlobalSearchResponse;
const eddyId="ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e";
for(const query of ["eddie herrera","herrera eddie","EDDIE HERRERA","  eddie   herrera  ","quien es eddie herrera"]){
 test(`anchored artist spelling: ${query}`,()=>{
  const result=rankCatalogResults(catalog,query);
  assert.equal(result.artists[0]?.id,eddyId);
  assert.equal(result.search?.suggestion?.text,"Eddy Herrera");
  assert.equal(result.search?.outcome,"recovered");
 });
}
test("exact Eddie and Eddy names remain first without an invented correction",()=>{
 assert.equal(rankCatalogResults(catalog,"eddie").artists[0]?.id,"50e3c4f1-6640-4b9e-b8df-106e2469c2a0");
 const exact=rankCatalogResults(catalog,"eddy herrera");assert.equal(exact.artists[0]?.id,eddyId);assert.equal(exact.search?.suggestion,undefined);
});
test("a surname alone or prefix does not license excessive spelling guesses",()=>{
 const eddy=artists.find(a=>a.id===eddyId)!;
 for(const query of ["zzzzz herrera","eddie herr","xx herrera","eddie unrelated"]){assert.equal(rankCatalogCandidate(eddy,query),null,query);}
 assert.equal(rankCatalogResults(catalog,"yandel").artists.length,0);
 assert.equal(rankCatalogResults(catalog,"caminero").artists.length,0);
});
test("wider anchored recovery is specific to artists, not unrelated title guesses",()=>{
 const song={...artists.find(a=>a.id===eddyId)!,type:"song" as const} as SearchResult;
 assert.equal(rankCatalogCandidate(song,"eddie herrera"),null);
});
test("generated full-name recovery covers two substitutions next to an exact word",()=>{
 let pairs=0;
 for(const artist of artists){
  const words=normalizeSearchText(artist.title).split(" ");
  for(let i=0;i<words.length;i++){
   const word=words[i];if(word.length<5||QUESTION_WORDS.has(word)||!words.some((w,j)=>j!==i&&w.length>=4&&!QUESTION_WORDS.has(w)))continue;
   const replacement=word[0]+(word[1]==="x"?"z":"x")+(word[2]==="x"?"z":"x")+word.slice(3);
   const query=words.map((w,j)=>j===i?replacement:w).join(" ");
   // Two errors must remain within the existing aggregate 25% evidence budget.
   if(2/searchTokens(query).join("").length>0.25)continue;
   assert.ok(rankCatalogCandidate(artist,query),`${query} -> ${artist.title}`);pairs++;
  }
 }
 assert.ok(pairs>100);console.log(`Verified ${pairs} additional anchored full-name typo pairs`);
});
