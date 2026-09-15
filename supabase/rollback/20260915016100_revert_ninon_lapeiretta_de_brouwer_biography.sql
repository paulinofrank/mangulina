BEGIN;

-- Revierte 20260915016100_rewrite_ninon_lapeiretta_de_brouwer_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ninon-lapeiretta-de-brouwer' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ninon-lapeiretta-de-brouwer') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ninón Lapeiretta de Brouwer was a pioneering figure in Dominican musical and cultural life, a woman who dedicated herself to the promotion and development of serious music in the country during a period when such efforts required exceptional determination and vision. Born in 1907 in Santo Domingo, she lived through the full arc of the twentieth century''s transformation of Dominican cultural institutions and played an active role in shaping the musical environment that later generations of Dominican artists would inherit.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her contributions extended beyond performance to include teaching, advocacy, and the kind of institution-building work that rarely receives the recognition it deserves but without which cultural life cannot sustain itself across generations. Lapeiretta de Brouwer was part of a small but dedicated community of Dominican musicians and educators who believed that the country deserved serious musical institutions and worked throughout their careers to make that vision a reality.","type":"text"}]},{"type":"paragraph","content":[{"text":"She passed away in 1989, leaving behind a legacy that is honored by those who understand the crucial importance of cultural infrastructure to any nation''s artistic development.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ninon-lapeiretta-de-brouwer';
UPDATE artists SET bio_en = 'Ninón Lapeiretta de Brouwer was a pioneering figure in Dominican musical and cultural life, a woman who dedicated herself to the promotion and development of serious music in the country during a period when such efforts required exceptional determination and vision. Born in 1907 in Santo Domingo, she lived through the full arc of the twentieth century''s transformation of Dominican cultural institutions and played an active role in shaping the musical environment that later generations of Dominican artists would inherit.

Her contributions extended beyond performance to include teaching, advocacy, and the kind of institution-building work that rarely receives the recognition it deserves but without which cultural life cannot sustain itself across generations. Lapeiretta de Brouwer was part of a small but dedicated community of Dominican musicians and educators who believed that the country deserved serious musical institutions and worked throughout their careers to make that vision a reality.

She passed away in 1989, leaving behind a legacy that is honored by those who understand the crucial importance of cultural infrastructure to any nation''s artistic development.', bio_es = NULL,
       date_of_death = '1989-09-29'
       WHERE slug = 'ninon-lapeiretta-de-brouwer';

COMMIT;
