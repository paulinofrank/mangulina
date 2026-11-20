const checks = [
  {url:'https://mangulina.do/es/artists/ramon-orlando',markers:['Ramón Orlando Valoy García','Distrito Nacional','El piano y']},
  {url:'https://mangulina.do/artists/ramon-orlando',markers:['Ramón Orlando Valoy García','Distrito Nacional','Piano and']},
  {url:'https://mangulina.do/es/artists/cuco-valoy',markers:['Cuco preparó','Los Virtuosos','Ramón Orlando']},
];
const results=[];
for(const c of checks){
  const r=await fetch(c.url);
  const html=await r.text();
  const result={url:c.url,status:r.status,cache:r.headers.get('x-vercel-cache'),markers:Object.fromEntries(c.markers.map(m=>[m,html.includes(m)]))};
  results.push(result);
  if(r.status!==200||Object.values(result.markers).some(x=>!x))process.exitCode=1;
}
console.log(JSON.stringify(results,null,2));
