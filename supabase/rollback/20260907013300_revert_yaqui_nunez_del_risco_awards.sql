BEGIN;

-- Revierte 20260907013300_yaqui_nunez_del_risco_awards.sql.
--
-- Orden inverso por las claves foráneas: adjudicaciones, categorías, premios.
-- Las dos categorías creadas sobre premios preexistentes (Casandra al Mérito y
-- Gloria Nacional de la Comunicación) también se borran, pero los premios que
-- las alojan NO se tocan.

DELETE FROM artist_awards
 WHERE artist_id = 'faff18bd-3dbc-477a-bc38-859d611887f0'::uuid
   AND category_id IN ('d618420c-be57-4f13-ea4a-914cdb387f64'::uuid,
                       'e729531d-cf68-4a24-fb5b-025edc498075'::uuid,
                       'f83a642e-d079-4b35-0c6c-136fed5a9186'::uuid,
                       '094b753f-e18a-4c46-1d7d-247afe6ba297'::uuid,
                       '1a5c8640-f29b-4d57-2e8e-358b0f7cb3a8'::uuid);

DELETE FROM award_categories
 WHERE id IN ('d618420c-be57-4f13-ea4a-914cdb387f64'::uuid,
              'e729531d-cf68-4a24-fb5b-025edc498075'::uuid,
              'f83a642e-d079-4b35-0c6c-136fed5a9186'::uuid,
              '094b753f-e18a-4c46-1d7d-247afe6ba297'::uuid,
              '1a5c8640-f29b-4d57-2e8e-358b0f7cb3a8'::uuid);

DELETE FROM awards
 WHERE id IN ('a3e51f76-8b24-4c90-bd17-6e2fa8054c31'::uuid,
              'b4f6208a-9c35-4da1-ce28-7f3ab9165d42'::uuid,
              'c507319b-ad46-4eb2-df39-803bca276e53'::uuid);

COMMIT;
