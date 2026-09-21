BEGIN;

-- Mamajuana: grupo creado por el compositor y arreglista Eddy González, que mezcla ritmos afrocaribeños y contemporáneos con letras románticas; la ficha solo tenía una frase vacía. Fuentes (todas de la propia banda, sin prensa independiente abierta): biografía de Last.fm (versión de feb. 2011, editada por un usuario), Bandcamp y biografía de Deezer (mismo texto: debut con Sony International, «Mamajuana» y «Sin un beso suyo», 20,000 copias en dos semanas en Norteamérica, China en 2007, Mejor Nuevo Artista Dominicano 2001, nominación al Lo Nuestro 2002 y a los Casandra), perfil de Instagram, canal de YouTube (debut en 'Punto Final' para Sony Music, 2000), MusicBrainz (etiquetas bachata, merengue, reguetón; inicio 2001-07-31). Se omite la cifra de ventas y no se registran premios (año y categoría sin fuente independiente): todo va atribuido a la banda. Ojo: Eddie Gonzalez, nominado al Grammy en Tejano (46.ª edición), es otro artista; no se mezcla. Campos: birth_year 2001.

UPDATE artists SET birth_year = 2001 WHERE slug = 'mamajuana';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Mamajuana is a Dominican group created by the composer and arranger Eddy González, which its own biography describes as a mix of Afro-Caribbean and contemporary rhythms with romantic lyrics."}]},{"type":"paragraph","content":[{"type":"text","text":"Origins","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The group takes its name from the exotic drink of the Dominican Republic. Its biography dates its activity from 2001, and a video on its channel shows a debut on the television program «Punto Final» for Sony Music in 2000. A 2002 interview with Nikauly de la Mota presents its leader and members."}]},{"type":"paragraph","content":[{"type":"text","text":"Records and tours","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"According to its own biography, the group’s debut album, distributed by Sony International, included the songs «Mamajuana» and «Sin un beso suyo». In 2007 it became one of the first Dominican groups to perform in China. The band also states that it was named best new Dominican artist in 2001 and was nominated for the Premio Lo Nuestro in 2002 and for the Premios Casandra."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The Instagram profile of Eddy González credits him as the creator of «Tomando Mamajuana». The band is documented mainly through its own channels and biography."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'mamajuana'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'mamajuana' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Mamajuana is a Dominican group created by the composer and arranger Eddy González, which its own biography describes as a mix of Afro-Caribbean and contemporary rhythms with romantic lyrics.

**Origins**

The group takes its name from the exotic drink of the Dominican Republic. Its biography dates its activity from 2001, and a video on its channel shows a debut on the television program «Punto Final» for Sony Music in 2000. A 2002 interview with Nikauly de la Mota presents its leader and members.

**Records and tours**

According to its own biography, the group’s debut album, distributed by Sony International, included the songs «Mamajuana» and «Sin un beso suyo». In 2007 it became one of the first Dominican groups to perform in China. The band also states that it was named best new Dominican artist in 2001 and was nominated for the Premio Lo Nuestro in 2002 and for the Premios Casandra.

**Legacy**

The Instagram profile of Eddy González credits him as the creator of «Tomando Mamajuana». The band is documented mainly through its own channels and biography.' WHERE slug = 'mamajuana';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Mamajuana es un grupo dominicano creado por el compositor y arreglista Eddy González, que su propia biografía describe como una mezcla de ritmos afrocaribeños y contemporáneos con letras románticas."}]},{"type":"paragraph","content":[{"type":"text","text":"Orígenes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El grupo toma su nombre de la exótica bebida de la República Dominicana. Su biografía data su actividad desde 2001, y un video de su canal muestra un debut en el programa de televisión «Punto Final» para Sony Music en 2000. Una entrevista de 2002 con Nikauly de la Mota presenta a su líder y a los integrantes."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos y giras","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Según su propia biografía, el álbum debut del grupo, distribuido por Sony International, incluyó las canciones «Mamajuana» y «Sin un beso suyo». En 2007 se convirtió en una de las primeras agrupaciones dominicanas en actuar en China. La banda afirma además que fue reconocida como mejor artista nuevo dominicano en 2001 y que fue nominada al Premio Lo Nuestro en 2002 y a los Premios Casandra."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El perfil de Instagram de Eddy González lo acredita como creador de «Tomando Mamajuana». La banda está documentada sobre todo a través de sus propios canales y de su biografía."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'mamajuana'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'mamajuana' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Mamajuana es un grupo dominicano creado por el compositor y arreglista Eddy González, que su propia biografía describe como una mezcla de ritmos afrocaribeños y contemporáneos con letras románticas.

**Orígenes**

El grupo toma su nombre de la exótica bebida de la República Dominicana. Su biografía data su actividad desde 2001, y un video de su canal muestra un debut en el programa de televisión «Punto Final» para Sony Music en 2000. Una entrevista de 2002 con Nikauly de la Mota presenta a su líder y a los integrantes.

**Discos y giras**

Según su propia biografía, el álbum debut del grupo, distribuido por Sony International, incluyó las canciones «Mamajuana» y «Sin un beso suyo». En 2007 se convirtió en una de las primeras agrupaciones dominicanas en actuar en China. La banda afirma además que fue reconocida como mejor artista nuevo dominicano en 2001 y que fue nominada al Premio Lo Nuestro en 2002 y a los Premios Casandra.

**Legado**

El perfil de Instagram de Eddy González lo acredita como creador de «Tomando Mamajuana». La banda está documentada sobre todo a través de sus propios canales y de su biografía.' WHERE slug = 'mamajuana';

COMMIT;
