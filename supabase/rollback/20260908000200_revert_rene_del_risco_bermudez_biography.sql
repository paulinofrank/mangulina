BEGIN;

-- Reverts 20260908000200_rewrite_rene_del_risco_bermudez_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'René del Risco Bermudez',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'composer',
       primary_genre = 'ballads',
       date_of_birth = '1937-05-09',
       birth_year = 1937,
       date_of_death = '1972-12-20',
       birth_place = 'San Pedro de Macorís',
       province = 'San Pedro de Macorís',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'René del Risco Bermúdez was one of the Dominican Republic''s most celebrated literary and cultural voices of the twentieth century. Born on May 9, 1937, in San Pedro de Macorís — a city long associated with sugar cane, immigration, and cultural vitality on the southeastern coast of the island — he grew up immersed in a world where language, identity, and social struggle were inseparable.

He pursued his education with extraordinary dedication and became a central figure in the Dominican literary movement known as El Puño, a group of young intellectuals who gathered in the 1960s to push back against the cultural suffocation of the Trujillo dictatorship and its aftermath. Del Risco Bermúdez was not merely a poet confined to the page; he was a man of multiple artistic dimensions.

His verses combined colloquial Dominican speech with a sharp political consciousness, making his work both accessible and deeply resonant with readers who had lived through decades of authoritarian rule. He worked in journalism and was involved in radio, helping to shape the cultural conversation of his era through whatever medium was available to him. His poetry explored themes of love, national identity, African heritage, and the quiet dignity of everyday Dominican life.

Beyond his literary output, Del Risco Bermúdez was known for his charisma and his ability to bridge the worlds of high culture and popular expression. He had a deep affinity for music and is remembered by many Dominicans as someone who understood that merengue, poetry, and storytelling were all branches of the same cultural tree. He died in Santo Domingo in December 1972, at thirty-five.

The loss was mourned across Dominican intellectual and artistic circles as the premature end of a voice that had barely begun to reach its full power. Decades later, his work continues to be taught in Dominican schools and universities, and he is regarded as a foundational figure in the nation''s modern literary heritage.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'rene-del-risco-bermudez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"René del Risco Bermúdez was one of the Dominican Republic''s most celebrated literary and cultural voices of the twentieth century. Born on May 9, 1937, in San Pedro de Macorís — a city long associated with sugar cane, immigration, and cultural vitality on the southeastern coast of the island — he grew up immersed in a world where language, identity, and social struggle were inseparable.","type":"text"}]},{"type":"paragraph","content":[{"text":"He pursued his education with extraordinary dedication and became a central figure in the Dominican literary movement known as El Puño, a group of young intellectuals who gathered in the 1960s to push back against the cultural suffocation of the Trujillo dictatorship and its aftermath. Del Risco Bermúdez was not merely a poet confined to the page; he was a man of multiple artistic dimensions.","type":"text"}]},{"type":"paragraph","content":[{"text":"His verses combined colloquial Dominican speech with a sharp political consciousness, making his work both accessible and deeply resonant with readers who had lived through decades of authoritarian rule. He worked in journalism and was involved in radio, helping to shape the cultural conversation of his era through whatever medium was available to him. His poetry explored themes of love, national identity, African heritage, and the quiet dignity of everyday Dominican life.","type":"text"}]},{"type":"paragraph","content":[{"text":"Beyond his literary output, Del Risco Bermúdez was known for his charisma and his ability to bridge the worlds of high culture and popular expression. He had a deep affinity for music and is remembered by many Dominicans as someone who understood that merengue, poetry, and storytelling were all branches of the same cultural tree. He died in Santo Domingo in December 1972, at thirty-five.","type":"text"}]},{"type":"paragraph","content":[{"text":"The loss was mourned across Dominican intellectual and artistic circles as the premature end of a voice that had barely begun to reach its full power. Decades later, his work continues to be taught in Dominican schools and universities, and he is regarded as a foundational figure in the nation''s modern literary heritage.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rene-del-risco-bermudez'), 3)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
