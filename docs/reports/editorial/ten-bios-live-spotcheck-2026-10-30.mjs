const checks = [
  {url:'https://mangulina.do/es/artists/adriana-green',expected:['nacida en Santo Domingo','La Romana'],forbidden:['nacida en La Romana']},
  {url:'https://mangulina.do/en/artists/adalgisa-pantaleon',expected:['first solo CD','Al son del sol'],forbidden:['first album in 1985']},
  {url:'https://mangulina.do/es/artists/aguakate',expected:['Shino Aguakate','Pussy Cat'],forbidden:[]},
];
const results=[];
for(const check of checks){
  const response=await fetch(check.url,{signal:AbortSignal.timeout(25000)});
  const body=await response.text();
  results.push({url:check.url,status:response.status,expected:Object.fromEntries(check.expected.map(s=>[s,body.includes(s)])),forbidden:Object.fromEntries(check.forbidden.map(s=>[s,body.includes(s)]))});
}
console.log(JSON.stringify(results,null,2));
if(results.some(r=>r.status!==200||Object.values(r.expected).some(ok=>!ok)||Object.values(r.forbidden).some(found=>found)))process.exitCode=1;
