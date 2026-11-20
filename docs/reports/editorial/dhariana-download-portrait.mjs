import fs from 'node:fs/promises';
const url='https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhX1hE2qKO2YEjiPryGGyDgmovSHEA7jCFbmTf6xSFts35jWBFFGx_ao7GNNGeVEY7vpfGBF-TC3uCRB_M7iJZWC_qWNFwHaK1jE2T0zSoUGNwW1YdnR7H11v9eSeeochshhXRdzjy2uiGB/s1600/Dhariana2.jpg';
const r=await fetch(url);if(!r.ok)throw Error(String(r.status));
await fs.writeFile('docs/reports/editorial/dhariana-press-portrait.jpg',Buffer.from(await r.arrayBuffer()));
console.log('Press portrait downloaded for inspection; not uploaded.');
