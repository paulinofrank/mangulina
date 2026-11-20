import fs from 'node:fs/promises';
const url='https://eldia.com.do/wp-content/uploads/2021/11/14_E-3_1p01-e1637628985296.webp';
const r=await fetch(url);if(!r.ok)throw Error(String(r.status));const bytes=Buffer.from(await r.arrayBuffer());await fs.writeFile('docs/reports/editorial/raffy-diaz-press-portrait.webp',bytes);console.log(bytes.length);
