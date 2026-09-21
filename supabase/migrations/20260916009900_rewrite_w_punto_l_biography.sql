BEGIN;

-- W punto L (Wilme Fermín Vicente): dembowero de Santo Domingo conocido como «W el que la prende», nacido el 9 de agosto de 1998; el relleno era un párrafo genérico sobre su nombre artístico. Fuentes: su canal oficial de YouTube (Desacato con Mr-R el Pasao, Te olvidé con El Negro Lirical, Quieren que te dé banda con Denyel el Cubano y El Negro Lirical, Puro con los puros prod. Yeri, Un party atoa prod. F1 El Control, Sin guemo prod. Sonido, Frío con los gretys con Denyel el Cubano, sept. 2025), SoundCloud (Ruth, prod. F1 el Control: dembow 'con colores de playero'), MusicBrainz (etiquetas dembow, un party atoa, ruth, desacato, te olvidé; nacimiento 1998-08-09), letras en Rimar.io. Ficha mínima: solo fuentes propias, sin prensa. Campos: aliases W el que la prende. Sin vistas ni suscriptores (regla 6).

UPDATE artists SET aliases = ARRAY['W el que la prende']::text[] WHERE slug = 'w-punto-l';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"W punto L —Wilme Fermín Vicente, born on 9 August 1998 in Santo Domingo— is a Dominican dembow singer who also calls himself “W el que la prende”."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His songs include «Ruth», a dembow produced by F1 el Control that, according to its description, tells the story of a young woman called Ruth and her father; «Un party atoa», also produced by F1 el Control; «Puro con los puros», produced by Yeri; and «Sin guemo», produced by Sonido. His official channel also carries videos with the artist El Negro Lirical, «Te olvidé» and «Quieren que te dé banda» (with Denyel el Cubano), and «Desacato», a collaboration with Mr-R el Pasao filmed by Moisés Films. In September 2025 he released «Frío con los gretys» with Denyel el Cubano."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is documented through his own channels and the releases on streaming platforms."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'w-punto-l'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'w-punto-l' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'W punto L —Wilme Fermín Vicente, born on 9 August 1998 in Santo Domingo— is a Dominican dembow singer who also calls himself “W el que la prende”.

**Songs**

His songs include «Ruth», a dembow produced by F1 el Control that, according to its description, tells the story of a young woman called Ruth and her father; «Un party atoa», also produced by F1 el Control; «Puro con los puros», produced by Yeri; and «Sin guemo», produced by Sonido. His official channel also carries videos with the artist El Negro Lirical, «Te olvidé» and «Quieren que te dé banda» (with Denyel el Cubano), and «Desacato», a collaboration with Mr-R el Pasao filmed by Moisés Films. In September 2025 he released «Frío con los gretys» with Denyel el Cubano.

**Legacy**

His work is documented through his own channels and the releases on streaming platforms.' WHERE slug = 'w-punto-l';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"W punto L —Wilme Fermín Vicente, nacido el 9 de agosto de 1998 en Santo Domingo— es un cantante dominicano de dembow que también se llama «W el que la prende»."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Entre sus canciones figuran «Ruth», un dembow producido por F1 el Control que, según su descripción, cuenta la historia de una joven llamada Ruth y su padre; «Un party atoa», también producida por F1 el Control; «Puro con los puros», producida por Yeri; y «Sin guemo», producida por Sonido. Su canal oficial incluye además videos con el artista El Negro Lirical, «Te olvidé» y «Quieren que te dé banda» (con Denyel el Cubano), y «Desacato», colaboración con Mr-R el Pasao filmada por Moisés Films. En septiembre de 2025 publicó «Frío con los gretys» con Denyel el Cubano."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra está documentada a través de sus propios canales y de los lanzamientos en las plataformas de streaming."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'w-punto-l'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'w-punto-l' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'W punto L —Wilme Fermín Vicente, nacido el 9 de agosto de 1998 en Santo Domingo— es un cantante dominicano de dembow que también se llama «W el que la prende».

**Canciones**

Entre sus canciones figuran «Ruth», un dembow producido por F1 el Control que, según su descripción, cuenta la historia de una joven llamada Ruth y su padre; «Un party atoa», también producida por F1 el Control; «Puro con los puros», producida por Yeri; y «Sin guemo», producida por Sonido. Su canal oficial incluye además videos con el artista El Negro Lirical, «Te olvidé» y «Quieren que te dé banda» (con Denyel el Cubano), y «Desacato», colaboración con Mr-R el Pasao filmada por Moisés Films. En septiembre de 2025 publicó «Frío con los gretys» con Denyel el Cubano.

**Legado**

Su obra está documentada a través de sus propios canales y de los lanzamientos en las plataformas de streaming.' WHERE slug = 'w-punto-l';

COMMIT;
