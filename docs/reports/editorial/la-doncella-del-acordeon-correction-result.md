# Corrección del procedimiento y de la ficha de La Doncella del Acordeón

15 de octubre de 2026 · Codex · Autorización explícita del editor: «Corrige el procedimiento y arregla el perfil».

## Cambios aplicados

Perfil d3749b0e-ffa0-4e2e-907a-1242c21c4560. El manifiesto la-doncella-del-acordeon-correction-manifest.json registra los diez campos antes/después y evidencia. Se aplicó mediante Update Artist Profile en Mangulina, enviando los cambios por el API administrativo. Se mantuvo draft.

| Campo | Antes | Después |
| --- | --- | --- |
| facebook | URL completa con /photos | ladoncella.delacordeon |
| instagram | URL completa | ladoncelladelacordeon |
| youtube | URL completa | @LADONCELLATIPICA |
| spotify | NULL | 1BQrf5mBYD08OVnexVwxA7 |
| gender | NULL | female |
| artist_tags | [] | [secular] |
| primary_role | accordionist, no representado en el selector | musician |
| occupations | singer, composer, arranger, bandleader, music educator | Se añade accordionist a esos cinco valores |
| type | Person | solo_artist |
| instruments | accordion, vocals | accordion, voice |

No se alteró la identidad ni el slug. El tipo y el instrumento se normalizaron a las opciones del formulario; los cambios conservan la misma persona y práctica musical. La fecha, el año y el lugar de nacimiento y la provincia permanecen NULL.

## Evidencia y límites

- Facebook, Información > Datos personales, consultado con el navegador: Género «Mujer»; ciudad actual Santo Domingo; ciudad de origen Río San Juan, Maria Trinidad Sanchez, Dominican Republic. URL: https://www.facebook.com/ladoncella.delacordeon/about . No mostraba fecha de nacimiento. Ciudad de origen no se adoptó como prueba de nacimiento.
- Spotify: búsqueda interna por La Doncella del Acordeon, perfil abierto https://open.spotify.com/artist/1BQrf5mBYD08OVnexVwxA7 . Muestra La Doncella Del Acordeon, repertorio de merengue y «Los hombres de ahora». Se contrastó con el canal oficial aportado por el editor, que identifica al padre Ramón Martínez y contiene la misma canción: https://www.youtube.com/watch?v=tFcjqriM4r8 y https://www.youtube.com/watch?v=wATuc_qdQDU . No se afirma haber escuchado el audio ni equivalencia entre versiones. No se importaron grabaciones.
- La etiqueta secular es clasificación editorial del repertorio de baile y canciones amorosas observado, según EDITORIAL_GUIDELINES.md; no es una afirmación de religión personal. El canal incluye actuaciones y tutoriales de merengue típico. Fuente: https://www.youtube.com/@LADONCELLATIPICA . No se copiaron contadores cambiantes a la ficha.
- Búsquedas web específicas por Yokaira Martínez, nombre completo, nacimiento, nacida y cumpleaños: sin fecha exacta verificable. Se encontraron notas que reproducen «22 años» con fechas de publicación diferentes (2015 y 2018); no permiten fijar año de nacimiento. El titular «nativa de Río San Juan» encontrado en Prensa Costa Norte no pudo abrirse y se mantuvo como pista, no como comprobación. No se usaron resultados de homónimos ni directorios de personas.
- Los handles siguen el contrato de src/lib/artistSocialLinks.ts. Las URLs originales permanecen en los documentos históricos.

## Procedimiento corregido

Se creó docs/ARTIST_PROFILE_WORKFLOW.md, con investigación obligatoria de campos, normalización de handles, búsqueda interna de Spotify, clasificación de repertorio, valores admitidos por el formulario, incertidumbre de nacimiento y comprobación visual tras recargar. Se enlazó desde AGENTS.md, docs/AI_INSTRUCTIONS.md y docs/README.md. No se cambiaron puertas de autorización ni reglas de seguridad. No se reescribieron manifiestos o informes históricos.

## Verificación

- Lectura de base de datos posterior guardada en la-doncella-del-acordeon-corrected.json.
- Comparación de los diez campos con correction-manifest: coincidencia exacta.
- Formatos de tres handles y Spotify comprobados; rol principal no duplicado en occupations.
- Formulario recargado y artista seleccionado de nuevo: Solo Artist, Musician, female marcado, secular pulsado, accordion y voice marcados, handles e ID de Spotify visibles y persistidos.
- Checksum de los otros 904 artistas idéntico antes/después: 5d6eb8075a6da562bcb91fb9a6ca8d5a.
- Las dos biografías conservan checksum 84245944a4d503c61be41400ee28c019; no se modificaron.
- git diff --check de los tres puntos de entrada modificados: sin errores de espacio; advertencias informativas LF/CRLF de Git.
- Comprobados los enlaces al procedimiento en los tres puntos de entrada. No se ejecutaron pruebas de aplicación porque no hubo cambios de código.
- La escritura por el API administrativo ejecuta la invalidación de cachés existente. No hubo despliegue ni publicación.

## Pendientes

Fecha y lugar de nacimiento siguen sin verificar. El perfil se entrega como borrador corregido con esos campos pendientes, no como ficha biográfica completa. Las menciones en otros perfiles continúan fuera del alcance. Imagen y medios existentes se preservaron y no se cargaron ni editaron en esta corrección.

Archivos de esta corrección: docs/ARTIST_PROFILE_WORKFLOW.md; AGENTS.md; docs/AI_INSTRUCTIONS.md; docs/README.md; este informe; la-doncella-del-acordeon-correction-manifest.json; la-doncella-del-acordeon-corrected.json. No cambió código de aplicación, esquema ni seguridad.
