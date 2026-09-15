BEGIN;

-- Corrige w359: pone en negrita el párrafo "Legacy"/"Legado" (bloque 5), que ya
-- existía sin la marca, en vez de haber tocado el título intermedio "Behind the catalogue".

UPDATE editorial_documents SET document = '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Nelson Estévez is a Dominican record executive and producer. With ","type":"text"},{"type":"artistReference","attrs":{"artistId":"84cdb60f-a0a4-4b2a-bac1-7c25474c8f3d","displayText":"Juan Hidalgo","occurrenceId":"7079735a-1e82-484f-9f3b-c7486f7d90f4"}},{"text":" he founded and has run J&N Records for more than forty years — the J and the N of the name are Juan and Nelson.","type":"text"}]},{"type":"paragraph","content":[{"text":"The label","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"J&N is the most internationally successful record company Dominican music has produced. It built its catalogue in merengue and bachata and carried both out of the country at a moment when neither had a route to a foreign audience except through a Dominican label willing to do the work.","type":"text"}]},{"type":"paragraph","content":[{"text":"The company operates out of Miami as JN Music Group and marked its fortieth year in 2021 with Latin Grammy nominations. Zacarías Ferreira, Monchy & Alexandra and Xantos all recorded for it, along with a long list of others.","type":"text"}]},{"type":"paragraph","content":[{"text":"Behind the catalogue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Legacy","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Estévez has spent four decades making those decisions, and a large part of what a Dominican audience can now hear from the eighties and nineties exists because J&N put it on tape.","type":"text"}]}]}'::jsonb, revision = revision + 1, updated_at = now()
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'nelson-estevez') AND document_type = 'artist_biography' AND locale = 'en';
UPDATE artists SET bio_en = 'Nelson Estévez is a Dominican record executive and producer. With Juan Hidalgo he founded and has run J&N Records for more than forty years — the J and the N of the name are Juan and Nelson.

**The label**

J&N is the most internationally successful record company Dominican music has produced. It built its catalogue in merengue and bachata and carried both out of the country at a moment when neither had a route to a foreign audience except through a Dominican label willing to do the work.

The company operates out of Miami as JN Music Group and marked its fortieth year in 2021 with Latin Grammy nominations. Zacarías Ferreira, Monchy & Alexandra and Xantos all recorded for it, along with a long list of others.

**Behind the catalogue**

**Legacy**

Estévez has spent four decades making those decisions, and a large part of what a Dominican audience can now hear from the eighties and nineties exists because J&N put it on tape.' WHERE slug = 'nelson-estevez';

UPDATE editorial_documents SET document = '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Nelson Estévez es un ejecutivo discográfico y productor dominicano. Con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"84cdb60f-a0a4-4b2a-bac1-7c25474c8f3d","displayText":"Juan Hidalgo","occurrenceId":"3eaa7604-827f-49bc-b57a-feb2e001af4d"}},{"text":" fundó y ha dirigido J&N Records por más de cuarenta años: la J y la N del nombre son Juan y Nelson.","type":"text"}]},{"type":"paragraph","content":[{"text":"El sello","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"J&N es la compañía discográfica de más éxito internacional que ha producido la música dominicana. Armó su catálogo en merengue y bachata y sacó a los dos del país en un momento en que ninguno tenía ruta hacia un público extranjero salvo por un sello dominicano dispuesto a hacer el trabajo.","type":"text"}]},{"type":"paragraph","content":[{"text":"La compañía opera desde Miami como JN Music Group y marcó sus cuarenta años en 2021 con nominaciones al Latin Grammy. Zacarías Ferreira, Monchy & Alexandra y Xantos grabaron para ella, junto a una lista larga de otros.","type":"text"}]},{"type":"paragraph","content":[{"text":"Detrás del catálogo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Legado","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Estévez lleva cuatro décadas tomando esas decisiones, y buena parte de lo que un público dominicano puede oír hoy de los ochenta y los noventa existe porque J&N lo puso en cinta.","type":"text"}]}]}'::jsonb, revision = revision + 1, updated_at = now()
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'nelson-estevez') AND document_type = 'artist_biography' AND locale = 'es';
UPDATE artists SET bio_es = 'Nelson Estévez es un ejecutivo discográfico y productor dominicano. Con Juan Hidalgo fundó y ha dirigido J&N Records por más de cuarenta años: la J y la N del nombre son Juan y Nelson.

**El sello**

J&N es la compañía discográfica de más éxito internacional que ha producido la música dominicana. Armó su catálogo en merengue y bachata y sacó a los dos del país en un momento en que ninguno tenía ruta hacia un público extranjero salvo por un sello dominicano dispuesto a hacer el trabajo.

La compañía opera desde Miami como JN Music Group y marcó sus cuarenta años en 2021 con nominaciones al Latin Grammy. Zacarías Ferreira, Monchy & Alexandra y Xantos grabaron para ella, junto a una lista larga de otros.

**Detrás del catálogo**

**Legado**

Estévez lleva cuatro décadas tomando esas decisiones, y buena parte de lo que un público dominicano puede oír hoy de los ochenta y los noventa existe porque J&N lo puso en cinta.' WHERE slug = 'nelson-estevez';

COMMIT;
