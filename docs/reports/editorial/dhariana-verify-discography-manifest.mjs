import fs from 'node:fs';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
const b='docs/reports/editorial/';const m=JSON.parse(fs.readFileSync(b+'dhariana-discography-manifest.json','utf8'));
assert.equal(m.proposed_releases.length,6);const tracks=m.proposed_releases.flatMap(r=>r.tracks);assert.equal(tracks.length,22);
const ids=m.proposed_releases.flatMap(r=>[r.proposed_id,...r.tracks.flatMap(t=>[t.proposed_track_id,t.proposed_recording_id])]);assert.equal(new Set(ids).size,ids.length);
for(const r of m.proposed_releases){assert.equal(r.before,null);assert.equal(r.artist_id,m.artist.id);assert.equal(createHash('sha256').update(fs.readFileSync(b+r.cover.file)).digest('hex'),r.cover.sha256);r.tracks.forEach((t,i)=>{assert.equal(t.position,i+1);assert.equal(t.artist_id,m.artist.id);assert.ok(t.credits_literal);});}
assert.equal(m.held[0].tracks.length,19);assert.equal(m.proposed_releases[0].tracks[4].title,'Cuando');assert.equal(m.counts.canonical_contributor_credits,0);
console.log(JSON.stringify({releases:6,recordings:22,tracks:22,covers_sha256_verified:6,unique_proposed_ids:ids.length,held_exitos_tracks:19,db_writes:0}));
