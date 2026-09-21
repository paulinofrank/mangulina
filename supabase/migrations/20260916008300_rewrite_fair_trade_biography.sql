BEGIN;

-- Fair Trade: banda de metalcore y groove metal de Santo Domingo, no 'rock alternativo' genérico. Fuentes: Discolai (16 may. 2022, lista de bandas de metal dominicanas: debut en 2018 en Rock R Us! Vol. 1, «Officer Down» mar. 2019, «Your Forever» may. 2021, quinteto y alineación; 25 ago. 2025, «Forged Within» con Luis Toribio como nuevo vocalista; 24 sep. 2025, Sabotaje 2025 de Rock Local Radio, 'veteranos del metalcore capitalino, regresan con nueva alineación'), MusicBrainz (inicio 2018). Conflicto: el apellido del bajista sale Beren (Discolai 2022) frente a Batista (un resumen de la Enciclopedia Rock Dominicano en Instagram): se usa el de Discolai, sin apellido en el texto para evitar el error. Un nombre anterior, Supernaut, sale solo de un resumen de Instagram: no se usa. Campos: birth_year 2018 (formación), primary_genre rock.

UPDATE artists SET birth_year = 2018, primary_genre = 'rock' WHERE slug = 'fair-trade';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Fair Trade is a Dominican metalcore and groove metal band from Santo Domingo, active since 2018."}]},{"type":"paragraph","content":[{"type":"text","text":"Beginnings","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band made its debut in 2018 at the concert «Rock R Us! Vol. 1». A 2022 survey of Dominican metal bands described it as a quintet formed by the singer Michael Tatis, the bassist Joel Beren, the guitarists Engels Guzmán and José Alfredo Ferreiras and the drummer Aleksander Varela. Its first single, «Officer Down», came out in March 2019, followed by «Your Forever» in May 2021."}]},{"type":"paragraph","content":[{"type":"text","text":"New lineup","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In August 2025 the band released «Forged Within», presented in a review of new releases as a new stage for the group, with Luis Toribio making his debut as vocalist. The lyrics deal with turning pain and failure into strength. The band, called a veteran of Santo Domingo’s metalcore scene, also appeared with its new lineup on the bill of Sabotaje 2025, organized by Rock Local Radio."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fair Trade is documented through its singles «Officer Down», «Your Forever» and «Forged Within» and through coverage in the Dominican independent-music press."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'fair-trade'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'fair-trade' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Fair Trade is a Dominican metalcore and groove metal band from Santo Domingo, active since 2018.

**Beginnings**

The band made its debut in 2018 at the concert «Rock R Us! Vol. 1». A 2022 survey of Dominican metal bands described it as a quintet formed by the singer Michael Tatis, the bassist Joel Beren, the guitarists Engels Guzmán and José Alfredo Ferreiras and the drummer Aleksander Varela. Its first single, «Officer Down», came out in March 2019, followed by «Your Forever» in May 2021.

**New lineup**

In August 2025 the band released «Forged Within», presented in a review of new releases as a new stage for the group, with Luis Toribio making his debut as vocalist. The lyrics deal with turning pain and failure into strength. The band, called a veteran of Santo Domingo’s metalcore scene, also appeared with its new lineup on the bill of Sabotaje 2025, organized by Rock Local Radio.

**Legacy**

Fair Trade is documented through its singles «Officer Down», «Your Forever» and «Forged Within» and through coverage in the Dominican independent-music press.' WHERE slug = 'fair-trade';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Fair Trade es una banda dominicana de metalcore y groove metal de Santo Domingo, activa desde 2018."}]},{"type":"paragraph","content":[{"type":"text","text":"Inicios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La banda hizo su debut en 2018 en el concierto «Rock R Us! Vol. 1». Un repaso de 2022 a las bandas de metal dominicanas la describió como un quinteto formado por el cantante Michael Tatis, el bajista Joel Beren, los guitarristas Engels Guzmán y José Alfredo Ferreiras y el baterista Aleksander Varela. Su primer sencillo, «Officer Down», salió en marzo de 2019, y «Your Forever» siguió en mayo de 2021."}]},{"type":"paragraph","content":[{"type":"text","text":"Nueva alineación","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En agosto de 2025 la banda publicó «Forged Within», presentado en una reseña de novedades como una nueva etapa del grupo, con Luis Toribio en su debut como vocalista. La letra trata de convertir el dolor y el fracaso en fortaleza. La banda, llamada veterana del metalcore capitalino, figuró también con su nueva alineación en el cartel de Sabotaje 2025, organizado por Rock Local Radio."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fair Trade está documentada a través de sus sencillos «Officer Down», «Your Forever» y «Forged Within» y de la cobertura de la prensa de música independiente dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'fair-trade'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'fair-trade' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Fair Trade es una banda dominicana de metalcore y groove metal de Santo Domingo, activa desde 2018.

**Inicios**

La banda hizo su debut en 2018 en el concierto «Rock R Us! Vol. 1». Un repaso de 2022 a las bandas de metal dominicanas la describió como un quinteto formado por el cantante Michael Tatis, el bajista Joel Beren, los guitarristas Engels Guzmán y José Alfredo Ferreiras y el baterista Aleksander Varela. Su primer sencillo, «Officer Down», salió en marzo de 2019, y «Your Forever» siguió en mayo de 2021.

**Nueva alineación**

En agosto de 2025 la banda publicó «Forged Within», presentado en una reseña de novedades como una nueva etapa del grupo, con Luis Toribio en su debut como vocalista. La letra trata de convertir el dolor y el fracaso en fortaleza. La banda, llamada veterana del metalcore capitalino, figuró también con su nueva alineación en el cartel de Sabotaje 2025, organizado por Rock Local Radio.

**Legado**

Fair Trade está documentada a través de sus sencillos «Officer Down», «Your Forever» y «Forged Within» y de la cobertura de la prensa de música independiente dominicana.' WHERE slug = 'fair-trade';

COMMIT;
