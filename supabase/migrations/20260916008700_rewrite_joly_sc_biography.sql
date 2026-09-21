BEGIN;

-- Joly SC: artista urbano de San Cristóbal, nacido el 23 de mayo de 1999; el relleno era un párrafo genérico sobre San Cristóbal. Fuentes: su canal oficial de YouTube (canciones, colaboradores, listas de lanzamientos), Apple Music (Pa fumar, 18 abr. 2025, hip-hop/rap), MusicBrainz (Pa fumar 17 abr. 2025; 'Dominican urban artist'; nacimiento 1999-05-23 igual a la fila). No hay prensa ni entrevista; la descripción oficial del canal no se pudo abrir. Ficha mínima, sin pronombres: la fila marca gender female pero ninguna fuente lo confirma. Campos: sin cambios.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Joly SC is a Dominican urban artist from San Cristóbal, born on 23 May 1999, who works between trap, perreo and reggaeton."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The artist’s official YouTube channel includes «Medusa Freestyle», produced by DJ Hackxx, and the single «Pa fumar», released in April 2025 and classified as hip hop and rap on streaming platforms. Other songs on the channel are «Haciendo dinero», with Gabriel Dflow; «Demonia», a Detroit-style trap with Stevenx3; «Nueva orden», with Willmelody; a trap version of «Working» and «Sin diploma». «Sentones», a perreo reggaeton, brings together Joly SC with DJ Hackxx, Gabriel Dflow, Willmelody, Lil CrashXX and David Flow, and «Infiel» includes Gabriel Dflow and JD la Familia. Release playlists on the channel date several of these songs to July 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Joly SC belongs to the emerging urban scene of San Cristóbal and is documented through the artist’s own channels and the release credits."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'joly-sc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'joly-sc' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Joly SC is a Dominican urban artist from San Cristóbal, born on 23 May 1999, who works between trap, perreo and reggaeton.

**Songs**

The artist’s official YouTube channel includes «Medusa Freestyle», produced by DJ Hackxx, and the single «Pa fumar», released in April 2025 and classified as hip hop and rap on streaming platforms. Other songs on the channel are «Haciendo dinero», with Gabriel Dflow; «Demonia», a Detroit-style trap with Stevenx3; «Nueva orden», with Willmelody; a trap version of «Working» and «Sin diploma». «Sentones», a perreo reggaeton, brings together Joly SC with DJ Hackxx, Gabriel Dflow, Willmelody, Lil CrashXX and David Flow, and «Infiel» includes Gabriel Dflow and JD la Familia. Release playlists on the channel date several of these songs to July 2026.

**Legacy**

Joly SC belongs to the emerging urban scene of San Cristóbal and is documented through the artist’s own channels and the release credits.' WHERE slug = 'joly-sc';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Joly SC es un artista urbano dominicano de San Cristóbal, nacido el 23 de mayo de 1999, que trabaja entre el trap, el perreo y el reguetón."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El canal oficial de YouTube del artista incluye «Medusa Freestyle», producido por DJ Hackxx, y el sencillo «Pa fumar», publicado en abril de 2025 y clasificado como hip hop y rap en las plataformas. Otras canciones del canal son «Haciendo dinero», con Gabriel Dflow; «Demonia», un trap estilo Detroit con Stevenx3; «Nueva orden», con Willmelody; una versión trap de «Working» y «Sin diploma». «Sentones», un perreo reguetón, reúne a Joly SC con DJ Hackxx, Gabriel Dflow, Willmelody, Lil CrashXX y David Flow, e «Infiel» incluye a Gabriel Dflow y JD la Familia. Las listas de lanzamientos del canal fechan varias de estas canciones en julio de 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Joly SC pertenece a la escena urbana emergente de San Cristóbal y está documentado a través de los canales del propio artista y de los créditos de sus lanzamientos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'joly-sc'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'joly-sc' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Joly SC es un artista urbano dominicano de San Cristóbal, nacido el 23 de mayo de 1999, que trabaja entre el trap, el perreo y el reguetón.

**Canciones**

El canal oficial de YouTube del artista incluye «Medusa Freestyle», producido por DJ Hackxx, y el sencillo «Pa fumar», publicado en abril de 2025 y clasificado como hip hop y rap en las plataformas. Otras canciones del canal son «Haciendo dinero», con Gabriel Dflow; «Demonia», un trap estilo Detroit con Stevenx3; «Nueva orden», con Willmelody; una versión trap de «Working» y «Sin diploma». «Sentones», un perreo reguetón, reúne a Joly SC con DJ Hackxx, Gabriel Dflow, Willmelody, Lil CrashXX y David Flow, e «Infiel» incluye a Gabriel Dflow y JD la Familia. Las listas de lanzamientos del canal fechan varias de estas canciones en julio de 2026.

**Legado**

Joly SC pertenece a la escena urbana emergente de San Cristóbal y está documentado a través de los canales del propio artista y de los créditos de sus lanzamientos.' WHERE slug = 'joly-sc';

COMMIT;
