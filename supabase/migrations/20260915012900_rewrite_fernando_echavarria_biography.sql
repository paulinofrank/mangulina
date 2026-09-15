BEGIN;

-- Ficha de Fernando Echavarría.
--
-- La biografía de relleno lo describía en términos genéricos ("broad and adventurous
-- musical intelligence") y con un error de edad (61 años; en realidad tenía 62 al morir).
-- Nombre completo: first_name Fernando Arturo, second_last_name Acosta. Tres premios
-- registrados: Premios Casandra Honor al Mérito 2008, Reserva Musical Nacional 2011,
-- Premios Luna (Colombia) 2006. Babín Echavarría, su padre, no tiene ficha: ver
-- MUSICOS_PENDIENTES.md.

UPDATE artists SET first_name = 'Fernando Arturo', second_last_name = 'Acosta' WHERE slug = 'fernando-echavarria';

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Honor al Mérito' FROM awards a WHERE a.name = 'Premios Casandra'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Honor al Mérito');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2008, 'Por su trayectoria artística de más de 25 años', true, 'DiarioDigitalRD (2011); Acento (16 may 2011); LinkedIn (perfil propio)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'fernando-echavarria' AND a.name = 'Premios Casandra' AND cat.name = 'Honor al Mérito'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2008);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2011, NULL, true, 'Acento (16 may 2011, declarado por Banreservas); DiarioDigitalRD'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'fernando-echavarria' AND a.name = 'Reserva Musical Nacional' AND cat.name = 'Reserva Musical Nacional'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2011);

INSERT INTO awards (name) SELECT 'Premios Luna' WHERE NOT EXISTS (SELECT 1 FROM awards WHERE name = 'Premios Luna');

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Artista Internacional de Mayor Influencia' FROM awards a WHERE a.name = 'Premios Luna'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Artista Internacional de Mayor Influencia');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2006, 'Homenaje como el artista internacional de mayor influencia en la música colombiana de los últimos 20 años', true, 'Listín Diario (11 oct 2015); Diario Libre (29 nov 2015); Hoy Digital (10 oct 2016); La Jornada (México); El Nacional; Tropicana Colombia (10 nov 2006)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'fernando-echavarria' AND a.name = 'Premios Luna' AND cat.name = 'Artista Internacional de Mayor Influencia'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2006);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Fernando Echavarría — born Fernando Arturo Echavarría Acosta on 14 August 1953 in Santo Domingo, died 11 October 2015 — was a Dominican singer, composer and bandleader, the creator of «fusón», a homegrown Dominican fusion style built on a merengue base."}]},{"type":"paragraph","content":[{"type":"text","text":"A musical household","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was the son of the musician, composer, producer and comedian Babín Echavarría, and grew up between the Santo Domingo neighborhoods of San Carlos, San Juan Bosco and Gazcue."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Familia André» and «fusón»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In the early 1980s he founded «La Familia André» and, with it, the genre he named fusón: Afro-Antillean rhythms such as samba and cumbia layered with jazz and rock, held together by an underlying merengue pulse. «Pato robao», «Marcela» and «Donde e’ que e’» were among the group’s biggest hits; «Marcela» later opened "},{"type":"artistReference","attrs":{"occurrenceId":"92904c5c-e8e2-4d41-9827-eddf74cf7d36","artistId":"fb068903-a085-4a3f-b846-0be0b3e28934","displayText":"Henry García"}},{"type":"text","text":"’s debut album with his own orchestra."}]},{"type":"paragraph","content":[{"type":"text","text":"An influence, and a career in Colombia","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"artistReference","attrs":{"occurrenceId":"03d06afe-b76a-42c5-b7e3-6e522711c34d","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":" played percussion in La Familia André for seven years before forming his own group, Son Familia, and the DR Jazz Festival credits fusón’s blend of rhythms as an early influence on the fusion strain of Dominican music that later ran through acts such as "},{"type":"artistReference","attrs":{"occurrenceId":"08a07f3f-bb76-4439-89f1-927d95f3172e","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" and, in Colombia, Carlos Vives. Echavarría’s own songs found a particularly large audience in Colombia, where several became standards of popular music."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2006 Colombia’s Premios Luna paid him tribute as the international artist with the greatest influence on Colombian music over the previous two decades; in 2008 the Premios Casandra gave him its Honor al Mérito for a career already past twenty-five years; and in 2011 the state bank Banreservas declared him a Reserva Musical Nacional."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He died on 11 October 2015, at sixty-two, arriving at a Santo Domingo venue to perform. Weeks later, Colombia’s Premios Luna paid him a posthumous tribute, closing the circle of a career that had carried a homegrown Dominican fusion sound further afield than almost any of its time."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'fernando-echavarria'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'fernando-echavarria' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '92904c5c-e8e2-4d41-9827-eddf74cf7d36', 'artist', 'fb068903-a085-4a3f-b846-0be0b3e28934' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'fernando-echavarria' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '03d06afe-b76a-42c5-b7e3-6e522711c34d', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'fernando-echavarria' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '08a07f3f-bb76-4439-89f1-927d95f3172e', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'fernando-echavarria' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Fernando Echavarría — born Fernando Arturo Echavarría Acosta on 14 August 1953 in Santo Domingo, died 11 October 2015 — was a Dominican singer, composer and bandleader, the creator of «fusón», a homegrown Dominican fusion style built on a merengue base.

**A musical household**

He was the son of the musician, composer, producer and comedian Babín Echavarría, and grew up between the Santo Domingo neighborhoods of San Carlos, San Juan Bosco and Gazcue.

**«La Familia André» and «fusón»**

In the early 1980s he founded «La Familia André» and, with it, the genre he named fusón: Afro-Antillean rhythms such as samba and cumbia layered with jazz and rock, held together by an underlying merengue pulse. «Pato robao», «Marcela» and «Donde e’ que e’» were among the group’s biggest hits; «Marcela» later opened Henry García’s debut album with his own orchestra.

**An influence, and a career in Colombia**

Chichi Peralta played percussion in La Familia André for seven years before forming his own group, Son Familia, and the DR Jazz Festival credits fusón’s blend of rhythms as an early influence on the fusion strain of Dominican music that later ran through acts such as Juan Luis Guerra 4.40 and, in Colombia, Carlos Vives. Echavarría’s own songs found a particularly large audience in Colombia, where several became standards of popular music.

**Recognition**

In 2006 Colombia’s Premios Luna paid him tribute as the international artist with the greatest influence on Colombian music over the previous two decades; in 2008 the Premios Casandra gave him its Honor al Mérito for a career already past twenty-five years; and in 2011 the state bank Banreservas declared him a Reserva Musical Nacional.

**Legacy**

He died on 11 October 2015, at sixty-two, arriving at a Santo Domingo venue to perform. Weeks later, Colombia’s Premios Luna paid him a posthumous tribute, closing the circle of a career that had carried a homegrown Dominican fusion sound further afield than almost any of its time.' WHERE slug = 'fernando-echavarria';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Fernando Echavarría —nacido Fernando Arturo Echavarría Acosta el 14 de agosto de 1953 en Santo Domingo, fallecido el 11 de octubre de 2015— fue un cantante, compositor y director de orquesta dominicano, creador del «fusón», un estilo de fusión dominicano propio construido sobre una base de merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"Una casa de músicos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Era hijo del músico, compositor, productor y humorista Babín Echavarría, y creció entre los barrios San Carlos, San Juan Bosco y Gazcue, de Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Familia André» y el «fusón»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A inicios de los ochenta fundó «La Familia André» y, con ella, el género que llamó fusón: ritmos afroantillanos como la samba y la cumbia superpuestos al jazz y al rock, sostenidos por un pulso de fondo de merengue. «Pato robao», «Marcela» y «Donde e’ que e’» estuvieron entre los mayores éxitos del grupo; «Marcela» abrió después el disco debut de "},{"type":"artistReference","attrs":{"occurrenceId":"54959cf4-3cab-4905-b34e-fbdc1212f6a2","artistId":"fb068903-a085-4a3f-b846-0be0b3e28934","displayText":"Henry García"}},{"type":"text","text":" al frente de su propia orquesta."}]},{"type":"paragraph","content":[{"type":"text","text":"Una influencia, y una carrera en Colombia","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"artistReference","attrs":{"occurrenceId":"3e083b16-c198-4c03-b3ab-4f9c9f1470c5","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":" tocó percusión en La Familia André durante siete años antes de formar su propio grupo, Son Familia, y el DR Jazz Festival atribuye a la mezcla de ritmos del fusón una influencia temprana sobre la vertiente de fusión de la música dominicana que después recorrió a artistas como "},{"type":"artistReference","attrs":{"occurrenceId":"8a94d971-13bf-41d2-924d-6e5e2a828563","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" y, en Colombia, Carlos Vives. Las propias canciones de Echavarría encontraron un público especialmente grande en Colombia, donde varias se volvieron clásicos populares."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2006 los Premios Luna de Colombia le rindieron homenaje como el artista internacional de mayor influencia en la música colombiana de las dos décadas anteriores; en 2008 los Premios Casandra le dieron su Honor al Mérito por una carrera que ya pasaba de veinticinco años; y en 2011 el banco estatal Banreservas lo declaró Reserva Musical Nacional."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Murió el 11 de octubre de 2015, a los sesenta y dos años, al llegar a una tarima de Santo Domingo para presentarse. Semanas después, los Premios Luna de Colombia le rindieron un homenaje póstumo, cerrando el círculo de una carrera que llevó un sonido de fusión dominicano propio más lejos que casi ninguno de su época."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'fernando-echavarria'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'fernando-echavarria' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '54959cf4-3cab-4905-b34e-fbdc1212f6a2', 'artist', 'fb068903-a085-4a3f-b846-0be0b3e28934' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'fernando-echavarria' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3e083b16-c198-4c03-b3ab-4f9c9f1470c5', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'fernando-echavarria' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8a94d971-13bf-41d2-924d-6e5e2a828563', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'fernando-echavarria' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Fernando Echavarría —nacido Fernando Arturo Echavarría Acosta el 14 de agosto de 1953 en Santo Domingo, fallecido el 11 de octubre de 2015— fue un cantante, compositor y director de orquesta dominicano, creador del «fusón», un estilo de fusión dominicano propio construido sobre una base de merengue.

**Una casa de músicos**

Era hijo del músico, compositor, productor y humorista Babín Echavarría, y creció entre los barrios San Carlos, San Juan Bosco y Gazcue, de Santo Domingo.

**«La Familia André» y el «fusón»**

A inicios de los ochenta fundó «La Familia André» y, con ella, el género que llamó fusón: ritmos afroantillanos como la samba y la cumbia superpuestos al jazz y al rock, sostenidos por un pulso de fondo de merengue. «Pato robao», «Marcela» y «Donde e’ que e’» estuvieron entre los mayores éxitos del grupo; «Marcela» abrió después el disco debut de Henry García al frente de su propia orquesta.

**Una influencia, y una carrera en Colombia**

Chichi Peralta tocó percusión en La Familia André durante siete años antes de formar su propio grupo, Son Familia, y el DR Jazz Festival atribuye a la mezcla de ritmos del fusón una influencia temprana sobre la vertiente de fusión de la música dominicana que después recorrió a artistas como Juan Luis Guerra 4.40 y, en Colombia, Carlos Vives. Las propias canciones de Echavarría encontraron un público especialmente grande en Colombia, donde varias se volvieron clásicos populares.

**Reconocimientos**

En 2006 los Premios Luna de Colombia le rindieron homenaje como el artista internacional de mayor influencia en la música colombiana de las dos décadas anteriores; en 2008 los Premios Casandra le dieron su Honor al Mérito por una carrera que ya pasaba de veinticinco años; y en 2011 el banco estatal Banreservas lo declaró Reserva Musical Nacional.

**Legado**

Murió el 11 de octubre de 2015, a los sesenta y dos años, al llegar a una tarima de Santo Domingo para presentarse. Semanas después, los Premios Luna de Colombia le rindieron un homenaje póstumo, cerrando el círculo de una carrera que llevó un sonido de fusión dominicano propio más lejos que casi ninguno de su época.' WHERE slug = 'fernando-echavarria';

COMMIT;
