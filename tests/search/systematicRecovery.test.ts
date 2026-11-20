import assert from "node:assert/strict";
import test from "node:test";
import artists from "./fixtures/published-artists.json";
import { rankCatalogResults, rankCatalogCandidate, QUESTION_WORDS } from "../../src/lib/searchMatching";
import { normalizeSearchText } from "../../src/lib/searchRanking";
import type { GlobalSearchResponse } from "../../src/lib/searchTypes";
const catalog = {artists, songs: [], releases: []} as GlobalSearchResponse;
const ids = ["bc2289d0-ae94-48b5-8eb9-7f0ae18b845a", "629a7daa-5ab3-4b77-825f-6795b8c4a566", "3f8bafec-e5ee-415d-8405-9551cceeeb9b", "5d8fb3d5-facf-4c54-b92c-518a7ec79d74", "5b271d53-9c3e-4cc3-88a4-b94126604198", "61781451-6220-4b5c-9074-9c1b6d2ec2ab", "4f331050-2568-42a4-a73b-7f9a731f1df4"];
function variants(word: string) {
  const rows = new Set<string>();
  for (let i=0; i<word.length; i++) {
    rows.add(word.slice(0,i)+word.slice(i+1));
    rows.add(word.slice(0,i)+"x"+word.slice(i));
    rows.add(word.slice(0,i)+(word[i]==="x"?"z":"x")+word.slice(i+1));
    if(i+1<word.length)rows.add(word.slice(0,i)+word[i+1]+word[i]+word.slice(i+2));
  }
  rows.delete(word); return [...rows].filter(q=>q.length>=4);
}
for(const id of ids) {
 const artist=artists.find(a=>a.id===id)!;
 for(const word of normalizeSearchText(artist.title).split(" ").filter(w=>w.length>=5)) {
  test(`systematic one-edit artist word recovery: ${artist.title} / ${word}`,()=>{
   for(const query of variants(word)) {
    const result=rankCatalogResults(catalog,query);
    assert.ok(result.artists.some(a=>a.id===id), `${query} must retain ${artist.title}`);
   }
  });
 }
}
test("two substitutions in a verified given name: myrian",()=>{
 const result=rankCatalogResults(catalog,"myrian");
 assert.equal(result.artists[0]?.id, ids[0]);
 assert.equal(result.search?.outcome,"recovered");
});
test("exact, aliases and ambiguity remain stronger than fuzzy guesses",()=>{
 const result=rankCatalogResults(catalog,"miriam");
 assert.equal(result.artists[0]?.id,ids[0]);
 const ambiguous=rankCatalogResults(catalog,"hernandes");
 assert.ok(ambiguous.artists.length>1);
 assert.equal(ambiguous.search?.suggestion,undefined);
});
test("full published catalog does not guess unrelated Yandel or Caminero",()=>{
 for(const query of ["yandel","caminero","qzxwvv","zzzzzzzz"]){assert.equal(rankCatalogResults(catalog,query).artists.length,0,query);}
 assert.ok(artists.every(a=>a.status==="published"));
});


test("systematic one-edit coverage across every published artist canonical name",()=>{
 let checked=0;
 for(const artist of artists){
  for(const word of normalizeSearchText(artist.title).split(" ").filter(w=>w.length>=5 && /^[a-z]+$/.test(w) && !QUESTION_WORDS.has(w))){
   for(const query of variants(word).filter(q=>!QUESTION_WORDS.has(q))){
    assert.ok(rankCatalogCandidate(artist,query), `${query} must retain verified ${artist.title}`);checked++;
   }
  }
 }
 assert.ok(checked>10000);
 console.log(`Verified ${checked} generated typo/name pairs across ${artists.length} published artists`);
});
test("canonical fuzzy name outranks the same name in another artist alias",()=>{
 const result=rankCatalogResults(catalog,"ayroide");
 assert.equal(result.artists[0]?.id,ids[1]);
 assert.equal(result.search?.suggestion?.id,ids[1]);
});
