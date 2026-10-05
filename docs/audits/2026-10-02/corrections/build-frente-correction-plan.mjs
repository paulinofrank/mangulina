import {readFileSync,writeFileSync} from 'node:fs';
const root='docs/audits/2026-10-02/',dir=root+'corrections/',d=JSON.parse(readFileSync(root+'catalog-snapshot.json'));
const sources=JSON.parse(readFileSync(dir+'remaining-official-sources.json')).sources;
const a=d.artists.find(a=>a.name==='Antony Santos');
const literal=sources.find(s=>s.url.includes('snnnr88p0n21b'));
const remasterUrls={1:'https://music.apple.com/us/song/1717614018',3:'https://www.youtube.com/watch?v=a-78bGQLN4U',5:'https://www.youtube.com/watch?v=5pHbYSOu2JY',7:'https://www.youtube.com/watch?v=_mRrSu-Eu-s',9:'https://www.youtube.com/watch?v=HtzQ_bfdLVc'};
const plan={sources:[{key:'original',...literal,organization:'Platano Records',type:'record_label',note:'Use literal Anthony Santos MainArtist credits; Qobuz artist display mapping incorrectly says Romeo Santos. Independently corroborated by official Virgin Music uploads.'}],recordings:[],releaseCredits:[]};
for(const [pos,url]of Object.entries(remasterUrls)){const s=sources.find(s=>s.url===url);if(!s)throw Error(url);plan.sources.push({key:'remaster-'+pos,...s,organization:'Platano Records / Virgin Music Group',type:'record_label'});}
for(const [releaseId,edition]of [['f052d481-c5f7-4107-ace9-6f82ba368321','original'],['7d716fb9-1c46-4e27-8509-c0f247c33f2c','remaster']]){
 for(const position of [1,3,5,7,9]){
  const t=d.tracks.find(t=>t.release_id===releaseId&&t.track_number===position),r=d.recordings.find(r=>r.id===t.recording_id);
  if(!literal.tracks.find(t=>t.position===position).credits.join(' ').includes('Anthony Santos, MainArtist'))throw Error('Literal track credit missing');
  if(!r.metadata?.['artist-credit']?.some(c=>c.artist?.name==='Antony Santos'))throw Error('Recording identity mismatch');
  plan.recordings.push({recordingId:r.id,expectedArtistId:r.artist_id,expectedTitle:r.title,artistId:a.id,source:edition==='original'?'original':'remaster-'+position,position,credits:[{artistId:a.id,name:'Anthony Santos',role:'lead_performer'}]});
 }
 if(!d.release_artists.some(r=>r.release_id===releaseId&&r.artist_id===a.id))plan.releaseCredits.push({releaseId,artistId:a.id,name:'Anthony Santos',source:edition==='original'?'original':'remaster-1'});
}
writeFileSync(dir+'frente-plan.json',JSON.stringify(plan,null,2));
console.log(JSON.stringify({ownerChanges:plan.recordings.length,credits:10,sharedReleases:plan.releaseCredits.length}));
