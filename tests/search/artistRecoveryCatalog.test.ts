import assert from "node:assert/strict";
import test from "node:test";
import { loadArtistRecoveryCatalog } from "../../src/lib/artistRecoveryCatalog";
import type { SearchResult } from "../../src/lib/searchTypes";
const row=(id:number):SearchResult=>({id:String(id),type:"artist",title:"Artist",slug:String(id),subtitle:null,year:null,cover_url:null});
test("recovery catalog fits a single shared fetch at current scale",async()=>{
 let calls=0;const rows=await loadArtistRecoveryCatalog(async()=>{calls++;return{total:773,rows:Array.from({length:773},(_,i)=>row(i))};});
 assert.equal(rows.length,773);assert.equal(calls,1);
});
test("recovery catalog spans Supabase response pages without dropping names",async()=>{
 const calls:number[][]=[];const rows=await loadArtistRecoveryCatalog(async(from,to)=>{calls.push([from,to]);return{total:2401,rows:Array.from({length:Math.min(to+1,2401)-from},(_,i)=>row(from+i))};});
 assert.equal(rows.length,2401);assert.deepEqual(calls,[[0,999],[1000,1999],[2000,2400]]);
});
test("recovery catalog errors and partial pages never become successful empty catalogs",async()=>{
 await assert.rejects(loadArtistRecoveryCatalog(async()=>{throw new Error("backend unavailable");}));
 await assert.rejects(loadArtistRecoveryCatalog(async()=>({total:null,rows:[]})));
 await assert.rejects(loadArtistRecoveryCatalog(async()=>({total:5001,rows:[]})));
 await assert.rejects(loadArtistRecoveryCatalog(async()=>({total:2,rows:[row(0)]})));
 await assert.rejects(loadArtistRecoveryCatalog(async()=>({total:2,rows:[row(0),row(0)]})));
});
