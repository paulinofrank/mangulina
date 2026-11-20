import { readFileSync, writeFileSync } from 'node:fs';
import { randomUUID } from 'node:crypto';

const base = 'docs/reports/editorial/';
const source = readFileSync(base + 'ramon-orlando-biographies-proposed-2026-11-06.md', 'utf8').replace(/\r\n/g,'\n');
const es = source.split('## Español\n')[1]?.split('\n## English\n')[0];
const en = source.split('## English\n')[1]?.split('\n## Save checklist\n')[0];
if (!es || !en) throw new Error('Missing bilingual proposal');

const ids = {
  'Cuco Valoy': 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d',
  'Henry García': 'fb068903-a085-4a3f-b846-0be0b3e28934',
  'Fernando Villalona': 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd',
  'Sandy Reyes': '49f8aae7-e066-4b01-a836-126082163c52',
  'Manuel Tejada': '4d3a653c-688e-47c1-8cec-b8cf85a4abac',
  'Alex Bueno': '6c3e0d74-23b7-4d80-969f-9d5319ee5127',
  'Peter Cruz': 'bb114227-a160-4f45-960e-b6c1710fbeef',
  'Juan Luis Guerra': '10034596-47cb-46ba-9e80-9ea319a2c0df',
  'José Antonio Molina': 'df68a7c8-c284-4d97-a4fd-b02264396148',
  'Milly Quezada': '070e7449-814e-4ea6-a009-7a091b7e4878',
  'Johnny Ventura': '3f8bafec-e5ee-415d-8405-9551cceeeb9b',
};
const names = Object.keys(ids).sort((a,b) => b.length-a.length);

function referenceParts(line) {
  const out = [];
  let remaining = line;
  while (remaining) {
    let best = null;
    for (const name of names) {
      const at = remaining.indexOf(name);
      if (at >= 0 && (!best || at < best.at || (at === best.at && name.length > best.name.length))) best = { name, at };
    }
    if (!best) { out.push({type:'text',text:remaining}); break; }
    if (best.at) out.push({type:'text',text:remaining.slice(0,best.at)});
    out.push({type:'artistReference',attrs:{artistId:ids[best.name],displayText:best.name,occurrenceId:randomUUID()}});
    remaining = remaining.slice(best.at+best.name.length);
  }
  return out;
}
function makeBio(part) {
  const lines = part.trim().split(/\r?\n\s*\r?\n/).map(x=>x.trim()).filter(Boolean);
  const content = lines.map(line => {
    const h = /^\*\*(.+)\*\*$/.exec(line);
    return {type:'paragraph',content:h?[{type:'text',text:h[1],marks:[{type:'bold'}]}]:referenceParts(line)};
  });
  const plain = lines.map(x=>x.replace(/^\*\*(.+)\*\*$/,'$1')).join('\n\n');
  return {document:{type:'doc',content},plain,referenceCount:content.flatMap(x=>x.content).filter(x=>x.type==='artistReference').length};
}
const ramon = {es:makeBio(es),en:makeBio(en)};
for (const [locale,bio] of Object.entries(ramon)) {
  if (bio.referenceCount < 10) throw new Error(`${locale}: too few artist references`);
  if (bio.document.content.at(-2)?.content?.[0]?.text !== (locale==='es'?'Legado':'Legacy')) throw new Error(`${locale}: missing final heading`);
  if (bio.plain.includes('1959') || bio.plain.includes('1960')) throw new Error(`${locale}: disputed birth year printed`);
}

const cucoText = {
  es: 'Cuco preparó «Los Virtuosos» junto a su hijo [Ramón Orlando], a quien había encaminado al piano desde niño. Ensayaron durante años antes de las primeras presentaciones profesionales de 1975. Cuco definía la dirección y aportaba repertorio e ideas para las canciones; Ramón escribía arreglos, tocaba el piano y asumía la dirección musical. La agrupación adoptó después el nombre de «La Tribu».',
  en: 'Cuco prepared «Los Virtuosos» with his son [Ramón Orlando], whom he had steered toward piano as a child. They rehearsed for years before their first professional performances in 1975. Cuco set the direction and brought repertoire and song ideas; Ramón wrote arrangements, played piano and served as musical director. The ensemble later adopted the name «La Tribu».',
};
const cucoOld = {
  es: 'En 1975 formó Los Virtuosos. Había encaminado a su hijo Ramón Orlando hacia el piano desde los siete años; el joven se incorporó como pianista, arreglista y director musical. Cuco aportaba el repertorio y las ideas de las canciones, y su hijo desarrollaba sus arreglos para la orquesta.',
  en: 'In 1975 he formed Los Virtuosos. He had steered his son Ramón Orlando towards piano from the age of seven; the young musician joined as pianist, arranger and musical director. Cuco brought repertoire and song ideas, while his son developed the arrangements for the orchestra.',
};
function makeCucoParagraph(locale) {
  const [before,after] = cucoText[locale].split('[Ramón Orlando]');
  if (!after) throw new Error('Missing Cuco reference marker');
  return {type:'paragraph',content:[{type:'text',text:before},{type:'artistReference',attrs:{artistId:'02f23257-1cf6-4a4c-8df1-1f9aa630a2c3',displayText:'Ramón Orlando',occurrenceId:locale==='es'?'1490e55b-b5ee-44a5-b797-b59a29bbc98a':'ae91eff4-59ef-45b6-b083-563331a0f962'}},{type:'text',text:after}]};
}
const q = value => `'${String(value).replaceAll("'","''")}'`;
const doc = x => `${q(JSON.stringify(x))}::jsonb`;
const statements = [
  'BEGIN;',
  `UPDATE artists SET birth_place='Santo Domingo',province='Distrito Nacional',second_last_name='García',bio_es=${q(ramon.es.plain)},bio_en=${q(ramon.en.plain)} WHERE id='02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' AND status='published' AND birth_place='Manoguayabo' AND province='Santo Domingo' AND second_last_name IS NULL;`,
  `SELECT * FROM public.upsert_editorial_document('artist_biography','02f23257-1cf6-4a4c-8df1-1f9aa630a2c3','es',1,'published',${doc(ramon.es.document)},5);`,
  `SELECT * FROM public.upsert_editorial_document('artist_biography','02f23257-1cf6-4a4c-8df1-1f9aa630a2c3','en',1,'published',${doc(ramon.en.document)},6);`,
];
for (const locale of ['es','en']) {
  const id = locale==='es'?'3f978fc5-e7ec-4ecd-9e99-d168b7edec17':'a741e62b-e30d-4e43-8110-04690e816bd1';
  const revision = locale==='es'?5:6;
  statements.push(`SELECT * FROM public.upsert_editorial_document('artist_biography','c11c2dda-ffa1-4f09-9d24-00dc4473bc8d','${locale}',1,'published',jsonb_set((SELECT document FROM editorial_documents WHERE id='${id}' AND revision=${revision} AND status='published' AND document->'content'->7->'content'->0->>'text' LIKE ${q(locale==='es'?'En 1975 formó Los Virtuosos.%':'In 1975 he formed Los Virtuosos.%')}),'{content,7}',${doc(makeCucoParagraph(locale))}),${revision});`);
}
statements.push(`UPDATE artists SET bio_es=replace(bio_es,${q(cucoOld.es)},${q(cucoText.es.replace('[Ramón Orlando]','Ramón Orlando'))}),bio_en=replace(bio_en,${q(cucoOld.en)},${q(cucoText.en.replace('[Ramón Orlando]','Ramón Orlando'))}) WHERE id='c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' AND status='published' AND position(${q(cucoOld.es)} in bio_es)>0 AND position(${q(cucoOld.en)} in bio_en)>0;`);
statements.push(`DO $verify$ BEGIN IF NOT (
  (SELECT count(*)=1 FROM artists WHERE id='02f23257-1cf6-4a4c-8df1-1f9aa630a2c3' AND birth_place='Santo Domingo' AND province='Distrito Nacional' AND second_last_name='García' AND status='published' AND bio_es LIKE 'Ramón Orlando Valoy García,%' AND bio_en LIKE 'Ramón Orlando Valoy García,%')
  AND (SELECT count(*)=1 FROM artists WHERE id='c11c2dda-ffa1-4f09-9d24-00dc4473bc8d' AND status='published' AND bio_es LIKE '%Cuco preparó «Los Virtuosos» junto a su hijo Ramón Orlando%' AND bio_en LIKE '%Cuco prepared «Los Virtuosos» with his son Ramón Orlando%')
  AND (SELECT count(*)=4 FROM editorial_documents WHERE (id='560a9787-972f-476f-9543-785c6c5f4d06' AND revision=6 AND status='published') OR (id='ae4945d7-8056-4879-8eb1-4cfd84f2717e' AND revision=7 AND status='published') OR (id='3f978fc5-e7ec-4ecd-9e99-d168b7edec17' AND revision=6 AND status='published') OR (id='a741e62b-e30d-4e43-8110-04690e816bd1' AND revision=7 AND status='published'))
  ) THEN RAISE EXCEPTION 'Approved editorial save verification failed'; END IF; END $verify$;`);
statements.push('COMMIT;');
const sqlPath = base+'ramon-orlando-cuco-approved-save-2026-11-06.sql';
writeFileSync(sqlPath,statements.join('\n')+'\n','utf8');
writeFileSync(base+'ramon-orlando-approved-document-summary-2026-11-06.json',JSON.stringify({ramon:{es:{blocks:ramon.es.document.content.length,references:ramon.es.referenceCount,chars:ramon.es.plain.length},en:{blocks:ramon.en.document.content.length,references:ramon.en.referenceCount,chars:ramon.en.plain.length}},cuco:{es:'one paragraph, existing reference preserved',en:'one paragraph, existing reference preserved'}},null,2),'utf8');
console.log(`Prepared ${sqlPath}; Ramón references ES/EN: ${ramon.es.referenceCount}/${ramon.en.referenceCount}`);
