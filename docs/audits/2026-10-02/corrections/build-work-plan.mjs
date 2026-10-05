import {readFileSync,writeFileSync} from 'node:fs';
const root='docs/audits/2026-10-02/',d=JSON.parse(readFileSync(root+'catalog-snapshot.json'));
const sources=JSON.parse(readFileSync(root+'corrections/official-release-credits.json'));
const norm=s=>s.normalize('NFD').replace(/\p{Diacritic}/gu,'').toLowerCase().replace(/[^a-z0-9]/g,'');
const additional=process.argv.includes('--additional');
const selections=additional ? [['Bendita tu luz',22,7],['Patria',23,6],['Mamá',24,5],['Padre Antonio y su monaguillo Andrés',25,6,'El Padre Antonio (Y El Monaguillo Andres LP Version)'],['Sin tu cariño',26,2]] : [['Blanca mujer',10,8],['Vagabundo',10,4],['Penélope',10,5],['Cruzando puertas',13,11],['Amor y control',16,7],['Pedro Navaja',18,9],['Gracias a la vida',17,1],['Si no te hubieras ido',14,2],['Woman del Callao',15,6],['Esto es vida',20,1],['El nacimiento de Ramiro',21,7]];
const aliases={'Robi Draco Rosa':'Draco Rosa','Draco Cornelius Rosa':'Draco Rosa','R. Rosa':'Draco Rosa','Ruben Blades':'Rubén Blades','Jose Manuel Navarro':'José Manuel Navarro Sempere','Luis Gomez Escolar':'Luis Gómez Escolar','Marco Antonio Solis':'Marco Antonio Solís','Sergio Vallin':'Sergio Vallín'};
const changes=[];
for(const [title,index,position,sourceTitle]of selections){
 const work=d.works.find(w=>norm(w.preferred_title)===norm(title));if(!work)throw Error('No Work '+title);
 const source=sources[index],track=source.tracks.find(t=>t.position===position);if(!track||!norm(track.title).startsWith(norm(sourceTitle??title)))throw Error('Source mismatch '+title+' '+track?.title);
 const authors=track.credits[0].split(/\s+-\s+/).flatMap(part=>{const [creditedAs,...roles]=part.split(',').map(v=>v.trim());const name=aliases[creditedAs]??creditedAs;return ['composer','lyricist','songwriter'].filter(role=>roles.some(r=>r===({composer:'Composer',lyricist:'Lyricist',songwriter:'Writer'})[role]||(r==='ComposerLyricist'&&role!=='songwriter'))).map(role=>({name,creditedAs,role}));});
 if(!authors.length)throw Error('No authors '+title);
 const previous=d.work_credits.filter(c=>c.work_id===work.id&&c.artist_id==='10034596-47cb-46ba-9e80-9ea319a2c0df');
 if(previous.length!==2)throw Error('Unexpected existing credits '+title);
 changes.push({workId:work.id,title:work.preferred_title,previous:previous.map(c=>additional?{...c,verification_status:'unverified'}:c),authors,sourceUrl:source.url,sourceTrack:track});
}
writeFileSync(root+'corrections/'+(additional?'additional-work-plan.json':'work-plan.json'),JSON.stringify({changes},null,2));
console.log(JSON.stringify(changes.map(c=>({title:c.title,authors:c.authors}))));
