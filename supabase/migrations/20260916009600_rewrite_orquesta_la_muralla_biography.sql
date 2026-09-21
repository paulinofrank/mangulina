BEGIN;

-- Orquesta La Muralla: orquesta dominicana de merengue de los años noventa cuya figura fue el cantante Pablo Martínez; la ficha solo tenía una frase vacía. Fuentes: discografía de MusicBrainz (Construyendo 1993, A ritmo de merengue 1995, Nuestro 1er aniversario 1995; 'Dominican merengue group'), La Fórmula Radio (10 jun. 2025, trayectoria de Pablo Martínez por Dioni Fernández y El Equipo, La Muralla, La Gran Manzana y Parada Joven), un video de la canción «Que bonito» de La Muralla con Pablo Martínez, publicaciones de páginas de merengue en Facebook (figura principal, impacto en los noventa). Ficha mínima: sin fundación, integrantes ni entrevistas. Ojo: hay otra orquesta 'La Muralla' de salsa (Venezuela/Colombia, años setenta, sello Tico); no se mezcla. Nota: hay una discrepancia de fechas: 'Nuestro 1er aniversario' (1995) sugiere fundación en 1994, y 'Construyendo' es de 1993 en MusicBrainz. Sin birth_year. Enlazada: Pablo Martínez.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Orquesta La Muralla was a Dominican merengue orchestra of the 1990s, associated with the singer "},{"type":"artistReference","attrs":{"occurrenceId":"9cce31c4-b32b-42bb-b1e2-d20363cbe7e0","artistId":"868b96d3-8a3d-4b7d-a6e4-0b2faa3c4c4a","displayText":"Pablo Martínez"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"The orchestra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The singer Pablo Martínez, who is also nicknamed after the orchestra, was its main figure after his time with the orchestra of Dioni Fernández and other groups. Merengue pages describe La Muralla as one of the key groups of the 1990s in which he recorded danceable songs with wide radio impact."}]},{"type":"paragraph","content":[{"type":"text","text":"Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band’s discography lists «Construyendo» (1993), «A ritmo de merengue» (1995) and «Nuestro 1er aniversario» (1995). Among its songs is «Que bonito», sung by Pablo Martínez."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The orchestra is documented through its records and through the career of Pablo Martínez, whose press profiles still list La Muralla among the orchestras he sang with."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'orquesta-la-muralla'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'orquesta-la-muralla' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9cce31c4-b32b-42bb-b1e2-d20363cbe7e0', 'artist', '868b96d3-8a3d-4b7d-a6e4-0b2faa3c4c4a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'orquesta-la-muralla' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Orquesta La Muralla was a Dominican merengue orchestra of the 1990s, associated with the singer Pablo Martínez.

**The orchestra**

The singer Pablo Martínez, who is also nicknamed after the orchestra, was its main figure after his time with the orchestra of Dioni Fernández and other groups. Merengue pages describe La Muralla as one of the key groups of the 1990s in which he recorded danceable songs with wide radio impact.

**Records**

The band’s discography lists «Construyendo» (1993), «A ritmo de merengue» (1995) and «Nuestro 1er aniversario» (1995). Among its songs is «Que bonito», sung by Pablo Martínez.

**Legacy**

The orchestra is documented through its records and through the career of Pablo Martínez, whose press profiles still list La Muralla among the orchestras he sang with.' WHERE slug = 'orquesta-la-muralla';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Orquesta La Muralla fue una orquesta dominicana de merengue de los años noventa, asociada al cantante "},{"type":"artistReference","attrs":{"occurrenceId":"00367604-7f71-4bdf-9458-0653acdd13f9","artistId":"868b96d3-8a3d-4b7d-a6e4-0b2faa3c4c4a","displayText":"Pablo Martínez"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"La orquesta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El cantante Pablo Martínez, a quien también se apoda por el nombre de la orquesta, fue su figura principal tras su paso por la orquesta de Dioni Fernández y otras agrupaciones. Páginas de merengue describen a La Muralla como una de las agrupaciones clave de los años noventa, con las que grabó canciones bailables de gran impacto radial."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La discografía de la banda incluye «Construyendo» (1993), «A ritmo de merengue» (1995) y «Nuestro 1er aniversario» (1995). Entre sus canciones figura «Que bonito», cantada por Pablo Martínez."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La orquesta está documentada a través de sus discos y de la carrera de Pablo Martínez, cuyos perfiles de prensa siguen enumerando a La Muralla entre las orquestas con las que cantó."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'orquesta-la-muralla'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'orquesta-la-muralla' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '00367604-7f71-4bdf-9458-0653acdd13f9', 'artist', '868b96d3-8a3d-4b7d-a6e4-0b2faa3c4c4a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'orquesta-la-muralla' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Orquesta La Muralla fue una orquesta dominicana de merengue de los años noventa, asociada al cantante Pablo Martínez.

**La orquesta**

El cantante Pablo Martínez, a quien también se apoda por el nombre de la orquesta, fue su figura principal tras su paso por la orquesta de Dioni Fernández y otras agrupaciones. Páginas de merengue describen a La Muralla como una de las agrupaciones clave de los años noventa, con las que grabó canciones bailables de gran impacto radial.

**Discos**

La discografía de la banda incluye «Construyendo» (1993), «A ritmo de merengue» (1995) y «Nuestro 1er aniversario» (1995). Entre sus canciones figura «Que bonito», cantada por Pablo Martínez.

**Legado**

La orquesta está documentada a través de sus discos y de la carrera de Pablo Martínez, cuyos perfiles de prensa siguen enumerando a La Muralla entre las orquestas con las que cantó.' WHERE slug = 'orquesta-la-muralla';

COMMIT;
