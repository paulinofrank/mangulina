BEGIN;

-- Revierte 20260907014400_normalize_social_handles.sql.
--
-- NO invierte las transformaciones: RESTAURA LOS VALORES EXACTOS que tenían
-- las 60 filas afectadas, fotografiados en vivo justo antes de
-- aplicar la migración. Invertir no serviría: "https://www.youtube.com/@x" y
-- "@x" acaban en el mismo valor normalizado, y desde el resultado no se puede
-- saber cuál de los dos había.
--
-- OJO: esto también devuelve los TRES ENLACES ROTOS de Michel Camilo, Nancy
-- Amancio y Sandy Gabriel a su estado muerto. Solo tiene sentido revertirlo
-- entero si la migración se considera equivocada entera.

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCOCu9UL6eY4GOhPOv8jFwgw', instagram = NULL, facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'albert-mendez';

UPDATE artists SET youtube = '@AlexFerreiraOficial', instagram = 'alex_ferreira', facebook = 'alexferreiraoficial', website = 'alexferreira.com', updated_at = now()
 WHERE slug = 'alex-ferreira';

UPDATE artists SET youtube = '@grupoalfareros', instagram = 'alfareros', facebook = '100044564523848', website = 'www.alfareros.do', updated_at = now()
 WHERE slug = 'alfareros';

UPDATE artists SET youtube = '@andrevelozmusic', instagram = 'andrevelozny', facebook = 'EsAndreVeloz', website = 'www.andreveloz.com', updated_at = now()
 WHERE slug = 'andre-veloz';

UPDATE artists SET youtube = 'https://www.youtube.com/AnonMuller', instagram = 'anonmuller', facebook = 'AnonMuller', website = NULL, updated_at = now()
 WHERE slug = 'anon-muller';

UPDATE artists SET youtube = '@AnyPuello', instagram = 'anypuello', facebook = 'AnyPuelloMinistries', website = 'anypuello.com', updated_at = now()
 WHERE slug = 'any-puello';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCjIkPtG-TJ9X4u-e-1TwbYA', instagram = 'black45king', facebook = 'Black45King', website = NULL, updated_at = now()
 WHERE slug = 'black-45-king';

UPDATE artists SET youtube = 'https://www.youtube.com/bladimirvasquezmusic', instagram = 'bladimirvasquezmusic', facebook = 'Bladimirvasquezmusic', website = NULL, updated_at = now()
 WHERE slug = 'bladimir-vasquez';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCLAjvhiIcmmd0k9q2PGJjsA', instagram = 'bselideologo', facebook = 'bselideologo', website = NULL, updated_at = now()
 WHERE slug = 'bs-el-ideologo';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCT5PtkyTq8awX4MhBSPBG0Q', instagram = 'calacote', facebook = '101016618449185', website = NULL, updated_at = now()
 WHERE slug = 'calacote';

UPDATE artists SET youtube = 'GreilynCandelario', instagram = 'candelariooficial', facebook = 'candelariooficial', website = NULL, updated_at = now()
 WHERE slug = 'candelario';

UPDATE artists SET youtube = 'https://www.youtube.com/@carlosvpiano', instagram = 'carlosvpiano', facebook = 'carlosvpiano', website = 'https://www.carlosmanuelvargas.com', updated_at = now()
 WHERE slug = 'carlos-manuel-vargas';

UPDATE artists SET youtube = '@carmenjimenez8886', instagram = 'merenchatamusica', facebook = NULL, website = 'www.carmenjimenez.com', updated_at = now()
 WHERE slug = 'carmen-jimenez';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCMzTWO4jSsPZvVs-0NVvCYQ', instagram = 'chichiperaltaoficial', facebook = '114476885239803', website = 'http://www.chichiperalta.com.do', updated_at = now()
 WHERE slug = 'chichi-peralta';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCOD9UoJfh73GRySPBCKFhEA', instagram = 'crisisromani', facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'crisisromani';

UPDATE artists SET youtube = '@DanielSantacruzMusic', instagram = 'danielsantacruz', facebook = 'danielsantacruzpage', website = 'danielsantacruz.com', updated_at = now()
 WHERE slug = 'daniel-santacruz';

UPDATE artists SET youtube = 'DjArelisHot', instagram = 'djarelishot', facebook = 'DJArelishotofficial', website = NULL, updated_at = now()
 WHERE slug = 'dj-arelis-hot';

UPDATE artists SET youtube = 'https://www.youtube.com/@Dj_JoeCatador', instagram = 'https://www.instagram.com/dj_joecatador/', facebook = 'https://www.facebook.com/Djjoecatador', website = NULL, updated_at = now()
 WHERE slug = 'dj-joe-catador';

UPDATE artists SET youtube = '@EddyHerreraOficial', instagram = 'eddy_herrera', facebook = 'EddyHerreraOficial', website = 'eddyherrera.com', updated_at = now()
 WHERE slug = 'eddy-herrera';

UPDATE artists SET youtube = '@EgleydaOficial', instagram = 'egleydabelliard', facebook = NULL, website = 'egleyda.org', updated_at = now()
 WHERE slug = 'egleyda-belliard';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCQ6dQfakTelDZccSOtSof_g', instagram = NULL, facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'emil-cerda';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UC5gIeVsC3xSKeD5JGXo06Lg', instagram = NULL, facebook = 'chicoindigo', website = NULL, updated_at = now()
 WHERE slug = 'indigo';

UPDATE artists SET youtube = 'https://www.youtube.com/@jairopuellomusic', instagram = 'https://instagram.com/jairopuellooficial', facebook = 'https://www.facebook.com/jairopuellomusic', website = 'https://linktr.ee/jairopuello', updated_at = now()
 WHERE slug = 'jairo-puello';

UPDATE artists SET youtube = 'https://www.youtube.com/@JonClasic', instagram = 'jon_clasic', facebook = 'jcmusica', website = 'https://jonclasic.com', updated_at = now()
 WHERE slug = 'jc';

UPDATE artists SET youtube = 'https://www.youtube.com/@jeffhrmusic', instagram = 'jeffhrmusic', facebook = 'Jeffhrmusi', website = NULL, updated_at = now()
 WHERE slug = 'jeffrey-henriquez-rijo';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCUAoelF3PRB6JsoK7GtA8gA', instagram = 'thisisjeyless', facebook = 'jeylessonline', website = NULL, updated_at = now()
 WHERE slug = 'jeyless';

UPDATE artists SET youtube = 'joseanjacobo', instagram = 'joseanjacobo', facebook = 'joseanjacobomusic', website = 'https://www.joseanjacobo.com', updated_at = now()
 WHERE slug = 'josean-jacobo';

UPDATE artists SET youtube = '@juanfranciscoordonez8632', instagram = NULL, facebook = 'https://www.facebook.com/Juan-Francisco-Ordóñez-143283895701368/', website = NULL, updated_at = now()
 WHERE slug = 'juan-francisco-ordonez';

UPDATE artists SET youtube = '@juanluisguerra', instagram = 'juanluisguerra', facebook = 'juanluisguerra440', website = 'juanluisguerra.com', updated_at = now()
 WHERE slug = 'juan-luis-guerra';

UPDATE artists SET youtube = 'kingstreetz', instagram = 'KingStreetz', facebook = 'OfficialKingStreetz', website = NULL, updated_at = now()
 WHERE slug = 'king-streetz';

UPDATE artists SET youtube = '@LaArmadaMusic', instagram = 'laarmada.music', facebook = 'laarmada.music', website = 'www.laarmadamusic.com', updated_at = now()
 WHERE slug = 'la-armada';

UPDATE artists SET youtube = 'https://www.youtube.com/@lainsuperable', instagram = 'lainsuperable', facebook = 'LaInsuperableHD', website = NULL, updated_at = now()
 WHERE slug = 'la-insuperable';

UPDATE artists SET youtube = 'https://www.youtube.com/c/LaNoeAposentoAlto', instagram = NULL, facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'la-noe-aposento-alto';

UPDATE artists SET youtube = 'https://www.youtube.com/@lapiitohdangers', instagram = NULL, facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'lapiitoh-dangers';

UPDATE artists SET youtube = '@LAPIZCONCIENTERD', instagram = 'lapizconciente', facebook = 'lapizconcienteofficial', website = 'lapizmusic.com', updated_at = now()
 WHERE slug = 'lapiz-conciente';

UPDATE artists SET youtube = 'lasgemelasfantasticasrd', instagram = 'lasgemelasfantasticasrd', facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'las-gemelas-fantasticas-rd';

UPDATE artists SET youtube = '@loshermanosrosario', instagram = 'hermanosrosario', facebook = 'loshermanosrosario', website = 'www.loshermanosrosario.net', updated_at = now()
 WHERE slug = 'los-hermanos-rosario';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCi_pXjPB0r_rcvepHm6NbuQ', instagram = 'lucienlegrub', facebook = 'lucienlegrub', website = NULL, updated_at = now()
 WHERE slug = 'lucien-le-grub';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCGvBbcpAaYmeCL38oqx3ywQ', instagram = 'luisterrordias', facebook = 'terrordiaz', website = NULL, updated_at = now()
 WHERE slug = 'luis-terror-dias';

UPDATE artists SET youtube = 'maffioglobal', instagram = 'maffio', facebook = 'MaffioGlobal', website = NULL, updated_at = now()
 WHERE slug = 'maffio';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCbS5zvOg-cYkkYmWYibQ2vw', instagram = 'https://www.instagram.com/mannycruzrd', facebook = 'https://www.facebook.com/MannyCruzOficial', website = NULL, updated_at = now()
 WHERE slug = 'manny-cruz';

UPDATE artists SET youtube = NULL, instagram = 'https://www.instagram.com/djmanuelmiller', facebook = 'https://www.facebook.com/djmanuelmiller', website = NULL, updated_at = now()
 WHERE slug = 'manuel-miller';

UPDATE artists SET youtube = 'https://www.youtube.com/@Manyeeaudio', instagram = 'manyeeaudio', facebook = 'manyeeaudio', website = 'https://manyeeaudio.com', updated_at = now()
 WHERE slug = 'manyee-audio';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCtwIeKTuP1CNu9rY5v7gxiw', instagram = NULL, facebook = 'Mcllibre', website = NULL, updated_at = now()
 WHERE slug = 'mc-wayne';

UPDATE artists SET youtube = 'MichelCamiloOfficial', instagram = 'camilomichel', facebook = 'MichelCamiloOfficial', website = 'https://www.michelcamilo.com', updated_at = now()
 WHERE slug = 'michel-camilo';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCZ6aXNvFAeS_kTrjG-gBUlg', instagram = 'milly_quezada', facebook = 'MillyQuezadaOfficial', website = 'http://www.millyquezadaonline.com', updated_at = now()
 WHERE slug = 'milly-quezada';

UPDATE artists SET youtube = 'https://www.youtube.com/@musicologothelibro', instagram = 'musicologord', facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'musicologo-the-libro';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCb8ICkBRCEJOxl5jGSStSOQ', instagram = 'normalrd', facebook = 'normalrd', website = 'https://normalofficial.bandcamp.com', updated_at = now()
 WHERE slug = 'n-o-r-m-a-l';

UPDATE artists SET youtube = 'NancyAmancioOficial', instagram = 'nancyamancio', facebook = 'NancyAmancioOficial', website = NULL, updated_at = now()
 WHERE slug = 'nancy-amancio';

UPDATE artists SET youtube = '@naomialmontemusic', instagram = 'naomialmonteoficial', facebook = 'Naomialmonteemusic', website = 'linktr.ee/naomialmontemusic', updated_at = now()
 WHERE slug = 'naomi-almonte';

UPDATE artists SET youtube = 'https://www.youtube.com/c/NattiNatasha', instagram = 'https://www.instagram.com/nattinatasha', facebook = 'https://www.facebook.com/NattiNatashaOfficial', website = 'https://nattinatasha.com', updated_at = now()
 WHERE slug = 'natti-natasha';

UPDATE artists SET youtube = 'olgalaraesotracosa', instagram = 'olgalaraoficial', facebook = NULL, website = 'https://olgalara.com', updated_at = now()
 WHERE slug = 'olga-lara';

UPDATE artists SET youtube = 'https://www.youtube.com/user/FundacionSinfonia', instagram = NULL, facebook = 'FundacionSinfonia', website = 'https://www.sinfonia.org.do/', updated_at = now()
 WHERE slug = 'orquesta-sinfonica-nacional';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UC_tH4_Y3oO_UDNgS8i10sjA', instagram = NULL, facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'raulin-rodriguez';

UPDATE artists SET youtube = 'https://www.youtube.com/@sammythegreatest', instagram = 'https://www.instagram.com/sammygreatest/', facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'sammy-the-greatest';

UPDATE artists SET youtube = 'sandygabrieljazz', instagram = 'sandygabriell', facebook = 'sandy.gabriel.37', website = NULL, updated_at = now()
 WHERE slug = 'sandy-gabriel';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCGLOsNfRDaRJJ3I0giLOSow', instagram = NULL, facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'sandy-mc';

UPDATE artists SET youtube = 'https://www.youtube.com/channel/UCc1UoRoVlnaSsRM36LhzNPA', instagram = NULL, facebook = NULL, website = NULL, updated_at = now()
 WHERE slug = 'santiago-ceron';

UPDATE artists SET youtube = 'https://www.youtube.com/@vicentegarciamusic', instagram = 'vicentegarcia', facebook = 'vicentegarciamusic', website = 'http://vicentegarcia.io', updated_at = now()
 WHERE slug = 'vicente-garcia';

UPDATE artists SET youtube = 'https://www.youtube.com/@WilfridoVargas2021', instagram = 'wilfridovargas_oficial', facebook = 'wilfridovargasmusic', website = 'https://wilfridovargas.com/', updated_at = now()
 WHERE slug = 'wilfrido-vargas';

COMMIT;
