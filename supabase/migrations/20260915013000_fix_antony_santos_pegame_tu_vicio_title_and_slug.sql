BEGIN;

-- Corrige el título y slug de la grabación de Antony Santos en el álbum 'Enamorado' (1999).
-- El título original contenía la errata "Págame tu vicio" en lugar de "Pégame tu vicio".
-- Para evitar conflicto con las grabaciones existentes de Eddy Herrera (pegame-tu-vicio-eddy-herrera[-2..8])
-- y las otras versiones de Antony Santos (pegame-tu-vicio-antony-santos[-2..5]), se asigna el slug
-- unívoco canónico 'pegame-tu-vicio-antony-santos-6'.

UPDATE recordings
   SET title = 'Pégame tu vicio',
       slug = 'pegame-tu-vicio-antony-santos-6',
       metadata = jsonb_set(metadata, '{title}', '"Pégame tu vicio"'),
       updated_at = now()
 WHERE id = '04b5b553-ea3f-47d5-b865-17b9a8717324';

UPDATE tracks
   SET metadata = jsonb_set(
         jsonb_set(metadata, '{track,title}', '"Pégame tu vicio"'),
         '{recording,title}',
         '"Pégame tu vicio"'
       ),
       updated_at = now()
 WHERE id = 'de03953e-a920-4495-adbb-2f5070c613de';

COMMIT;
