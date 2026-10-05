import {readFileSync,writeFileSync} from 'node:fs';
const root='docs/audits/2026-10-02/',d=JSON.parse(readFileSync(root+'catalog-snapshot.json'));
const scans=JSON.parse(readFileSync(root+'corrections/additional-package-evidence.json'));
const fiesta=scans.find(s=>s.package==='fiesta-latina'),encuentro=JSON.parse(readFileSync(root+'corrections/package-evidence.json')).find(s=>s.types.includes('Back'));
const artist=name=>{const a=d.artists.find(a=>a.name===name);if(!a)throw Error(name);return a;};
const track=(releaseId,position)=>{const t=d.tracks.find(t=>t.release_id===releaseId&&t.track_number===position);if(!t)throw Error('Missing placement');return d.recordings.find(r=>r.id===t.recording_id);};
const plan={sources:[{key:'fiesta',...fiesta,title:'2 grandes voces de la fiesta latina — original CD back',organization:'Mock & Roll / Sony BMG Norte',type:'original_release_packaging'},{key:'iaso',url:'https://iasorecords.bandcamp.com/album/me-decid',title:'Me decidí — label track and featured artist credits',organization:'iASO Records',type:'record_label',retrievedAt:new Date().toISOString()},{key:'encuentro',...encuentro,title:'Encuentro — original CD back',organization:'Banco Popular de Puerto Rico',type:'original_release_packaging'}],recordings:[],releaseCredits:[]};
function add(r,source,position,credits,changes={}){plan.recordings.push({recordingId:r.id,expectedArtistId:r.artist_id,expectedTitle:r.title,source,position,credits:credits.map(([name,role,external=false])=>({name,role,...external?{externalName:name}:{artistId:artist(name).id}})),...changes});}
const fiestaId='ec2c5415-c598-4b7a-9f2c-234f9e6b5784';
for(const position of [2,4,6,8,10,12,14,16]){const r=track(fiestaId,position);if(!r.metadata?.['artist-credit']?.some(c=>c.artist?.name==='Proyecto Uno'))throw Error('Imported identity mismatch '+r.title);add(r,'fiesta',position,[['Proyecto Uno','lead_performer']],{artistId:artist('Proyecto Uno').id});}
add(track(fiestaId,3),'fiesta',3,[['Ilegales','lead_performer'],['Johnny Ventura','lead_performer']]);
plan.releaseCredits.push({releaseId:fiestaId,artistId:artist('Proyecto Uno').id,name:'Proyecto Uno',source:'fiesta'});
const sorianoId='261580ae-dbb2-49c4-b658-f48e029df2f7';
for(const [position,names]of [[2,['Fernando Soriano']],[3,['Andre Veloz']],[4,['Fernando Soriano']],[7,['Andre Veloz']],[9,['Fernando Soriano']],[10,['Griselda Soriano']],[11,['Fernando Soriano','Griselda Soriano']],[13,['Griselda Soriano']]])add(track(sorianoId,position),'iaso',position,names.map(n=>[n,'featured_performer']),position===11?{title:'Yolanda'}:{});
add(track(sorianoId,8),'iaso',8,[],{title:'Váyase en paz'});
add(track('9377dfe3-7011-47d7-964d-98b628918559',17),'encuentro',17,[['Rubén Blades','lead_performer',true],['Draco Rosa','lead_performer',true]]);
writeFileSync(root+'corrections/additional-recording-plan.json',JSON.stringify(plan,null,2));
console.log(JSON.stringify({recordings:plan.recordings.length,ownerChanges:8,creditAdditions:plan.recordings.reduce((n,r)=>n+r.credits.length,0),titleCorrections:2,sharedReleaseCredits:1}));
