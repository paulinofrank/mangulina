BEGIN;

-- Ficha de Juan Bautista Alfonseca.
--
-- La biografía de relleno omitía su carrera militar (coronel, veterano de la Guerra de
-- Independencia), su autoría de la música del primer himno nacional dominicano, y el hecho
-- de que ninguna de sus partituras sobrevivió -solo un fragmento de "Juana Quilina" se
-- conserva, preservado por Flérida de Nolasco-. second_last_name añadido (Baris).

UPDATE artists SET second_last_name = 'Baris' WHERE slug = 'juan-bautista-alfonseca';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Colonel Juan Bautista Alfonseca Baris, born in Santo Domingo on 23 June 1810 and died there on 9 August 1875, was a Dominican soldier and musician regarded as merengue’s earliest precursor and remembered as «El Padre de la Música Dominicana»."}]},{"type":"paragraph","content":[{"type":"text","text":"Soldier and bandmaster","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He fought in the Dominican War of Independence and rose to colonel in the national army, where he directed official military bands. He also served as maestro de capilla at the Santo Domingo Cathedral, composing at least two Masses and a Miserere."}]},{"type":"paragraph","content":[{"type":"text","text":"The first anthem","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After the First Dominican Republic was proclaimed on 27 February 1844, Alfonseca wrote the music for «Canción Dominicana», the country’s first national anthem, set to words by Félix María del Monte. It was never officially adopted, but it was performed publicly at patriotic commemorations for years afterward."}]},{"type":"paragraph","content":[{"type":"text","text":"A vanished catalogue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He is credited as the first musician to set merengue to staff notation, folding Dominican folk elements into European dance forms like the danza and contradanza — the foundation later composers such as his own great-great-grandson "},{"type":"artistReference","attrs":{"occurrenceId":"bee377e2-269b-4564-8d08-7bd92780fc92","artistId":"360bec27-421a-466f-8604-3598aa46a7a4","displayText":"Luis Alberti"}},{"type":"text","text":" would build on. None of Alfonseca’s own scores survived his death; the sole surviving trace of nineteenth-century Dominican merengue is a fragment of his «Juana Quilina», preserved by the musicologist Flérida de Nolasco."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2005 the Dominican government declared 26 November the Día Nacional del Merengue, formal recognition of a genre whose roots trace back to a colonel who wrote its first surviving notes and lost nearly everything else he composed."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-bautista-alfonseca'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-bautista-alfonseca' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bee377e2-269b-4564-8d08-7bd92780fc92', 'artist', '360bec27-421a-466f-8604-3598aa46a7a4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista-alfonseca' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Colonel Juan Bautista Alfonseca Baris, born in Santo Domingo on 23 June 1810 and died there on 9 August 1875, was a Dominican soldier and musician regarded as merengue’s earliest precursor and remembered as «El Padre de la Música Dominicana».

**Soldier and bandmaster**

He fought in the Dominican War of Independence and rose to colonel in the national army, where he directed official military bands. He also served as maestro de capilla at the Santo Domingo Cathedral, composing at least two Masses and a Miserere.

**The first anthem**

After the First Dominican Republic was proclaimed on 27 February 1844, Alfonseca wrote the music for «Canción Dominicana», the country’s first national anthem, set to words by Félix María del Monte. It was never officially adopted, but it was performed publicly at patriotic commemorations for years afterward.

**A vanished catalogue**

He is credited as the first musician to set merengue to staff notation, folding Dominican folk elements into European dance forms like the danza and contradanza — the foundation later composers such as his own great-great-grandson Luis Alberti would build on. None of Alfonseca’s own scores survived his death; the sole surviving trace of nineteenth-century Dominican merengue is a fragment of his «Juana Quilina», preserved by the musicologist Flérida de Nolasco.

**Legacy**

In 2005 the Dominican government declared 26 November the Día Nacional del Merengue, formal recognition of a genre whose roots trace back to a colonel who wrote its first surviving notes and lost nearly everything else he composed.' WHERE slug = 'juan-bautista-alfonseca';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El coronel Juan Bautista Alfonseca Baris, nacido en Santo Domingo el 23 de junio de 1810 y fallecido en la misma ciudad el 9 de agosto de 1875, fue militar y músico dominicano considerado el precursor primigenio del merengue y recordado como «El Padre de la Música Dominicana»."}]},{"type":"paragraph","content":[{"type":"text","text":"Militar y director de banda","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Combatió en la Guerra de Independencia Dominicana y alcanzó el grado de coronel en el ejército nacional, donde dirigió bandas militares oficiales. También sirvió como maestro de capilla en la Catedral de Santo Domingo, componiendo al menos dos misas y un miserere."}]},{"type":"paragraph","content":[{"type":"text","text":"El primer himno","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras la proclamación de la Primera República Dominicana el 27 de febrero de 1844, Alfonseca escribió la música de «Canción Dominicana», el primer himno nacional del país, con letra de Félix María del Monte. Nunca fue adoptado oficialmente, pero se interpretó en público durante años en conmemoraciones patrióticas."}]},{"type":"paragraph","content":[{"type":"text","text":"Un catálogo desaparecido","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se le atribuye ser el primer músico en llevar el merengue al pentagrama, incorporando elementos folclóricos dominicanos a formas de danza europeas como la danza y la contradanza —la base sobre la que compondría después su propio tataranieto, "},{"type":"artistReference","attrs":{"occurrenceId":"f97de6c8-5ae0-4094-8215-1de3f2859ba4","artistId":"360bec27-421a-466f-8604-3598aa46a7a4","displayText":"Luis Alberti"}},{"type":"text","text":"—. Ninguna partitura propia de Alfonseca sobrevivió a su muerte; el único rastro que queda del merengue dominicano del siglo XIX es un fragmento de su «Juana Quilina», preservado por la musicóloga Flérida de Nolasco."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2005 el gobierno dominicano declaró el 26 de noviembre como Día Nacional del Merengue, reconocimiento formal de un género cuyas raíces se remontan a un coronel que escribió sus primeras notas conocidas y perdió casi todo lo demás que compuso."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-bautista-alfonseca'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-bautista-alfonseca' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f97de6c8-5ae0-4094-8215-1de3f2859ba4', 'artist', '360bec27-421a-466f-8604-3598aa46a7a4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-bautista-alfonseca' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'El coronel Juan Bautista Alfonseca Baris, nacido en Santo Domingo el 23 de junio de 1810 y fallecido en la misma ciudad el 9 de agosto de 1875, fue militar y músico dominicano considerado el precursor primigenio del merengue y recordado como «El Padre de la Música Dominicana».

**Militar y director de banda**

Combatió en la Guerra de Independencia Dominicana y alcanzó el grado de coronel en el ejército nacional, donde dirigió bandas militares oficiales. También sirvió como maestro de capilla en la Catedral de Santo Domingo, componiendo al menos dos misas y un miserere.

**El primer himno**

Tras la proclamación de la Primera República Dominicana el 27 de febrero de 1844, Alfonseca escribió la música de «Canción Dominicana», el primer himno nacional del país, con letra de Félix María del Monte. Nunca fue adoptado oficialmente, pero se interpretó en público durante años en conmemoraciones patrióticas.

**Un catálogo desaparecido**

Se le atribuye ser el primer músico en llevar el merengue al pentagrama, incorporando elementos folclóricos dominicanos a formas de danza europeas como la danza y la contradanza —la base sobre la que compondría después su propio tataranieto, Luis Alberti—. Ninguna partitura propia de Alfonseca sobrevivió a su muerte; el único rastro que queda del merengue dominicano del siglo XIX es un fragmento de su «Juana Quilina», preservado por la musicóloga Flérida de Nolasco.

**Legado**

En 2005 el gobierno dominicano declaró el 26 de noviembre como Día Nacional del Merengue, reconocimiento formal de un género cuyas raíces se remontan a un coronel que escribió sus primeras notas conocidas y perdió casi todo lo demás que compuso.' WHERE slug = 'juan-bautista-alfonseca';

COMMIT;
