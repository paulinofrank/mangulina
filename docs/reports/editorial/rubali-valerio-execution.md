# Borrador de Rubali Valerio e instrucciones de aprobación

16 de octubre de 2026 · Codex.

El editor indicó: «Elimina eso de la aprobación. Es un borrador». Se actualizó la política para permitir crear o completar la ficha y las biografías draft del artista solicitado sin una segunda aprobación del manifiesto. Se conservan manifiesto, investigación, verificación y las puertas de publicación, cambios destructivos o compartidos, ampliación de alcance, discografía y seguridad.

## Instrucciones modificadas

- AGENTS.md: excepción explícita para ficha y biografías draft del artista solicitado.
- docs/discography.md: Gate B incorpora la excepción del editor, fechada 2026-10-16; Gate C y seguridad sin cambios.
- docs/ARTIST_PROFILE_WORKFLOW.md: el manifiesto queda como registro de evidencia, no pausa de aprobación de borrador; fecha actualizada.
- docs/AI_INSTRUCTIONS.md: referencia a la excepción y sus límites.

La redacción anterior exigía aprobación adicional del manifiesto antes de cualquier escritura. La nueva excepción elimina esa segunda aprobación para el borrador del perfil solicitado, conservando el control de alcance. No constituye permiso de escritura para tareas meramente documentales o de investigación.

## Creación aplicada

Artista: e9588b80-ca3b-4ae7-8fb3-ab86ce044e34, Rubali Valerio, slug rubali-valerio, status draft. Antes no se localizó identidad coincidente; después, todos los campos coinciden con artist_fields de rubali-valerio-profile-manifest.json. La propuesta y el manifiesto originales quedan preservados como evidencia histórica; su indicación de aprobación pendiente fue superada por la instrucción posterior del editor y este informe.

Biografías creadas mediante el editor administrativo y su endpoint editorial:

- Inglés: af2bf6c9-9890-4461-8a19-8a892cf1c226, revisión 1, schema_version 1, draft.
- Español: 4cc7d0eb-e216-4445-8c17-e0c36549eaad, revisión 1, schema_version 1, draft.

Ficha creada mediante Create Artist: cantante como rol principal; acordeonista como otra ocupación; accordion y voice; female; secular; fecha 1998-05-09 y año 1998; nacimiento Santo Domingo; provincia de procedencia Santiago. Handles e ID de Spotify exactamente como el manifiesto. No se cargó imagen ni se importó discografía. No se crearon familiares, agrupaciones ni artistas adicionales.

Las fuentes y la distinción entre los dos perfiles Spotify están en rubali-valerio-profile-proposal.md. El perfil enlazado por el canal oficial es 32Bi4KvyG9EsytLlllkiDD. La fecha y el nacimiento son declaraciones expresas del canal y Spotify, corroboradas por la prensa; Santiago corresponde a la ciudad de origen declarada en Facebook. No se afirma escucha de grabaciones ni equivalencia entre versiones.

## Verificación realizada

- Búsqueda previa repetida en todos los estados por nombre, primer nombre, aliases y slug: sin coincidencia.
- Guardado mediante los editores existentes, con sus invalidaciones de caché.
- Lectura posterior: rubali-valerio-saved.json.
- Comparación programática: todos los campos y ambos documentos coinciden exactamente con el manifiesto.
- validateEditorialDocument: ambos documentos válidos.
- buildEditorialIntegrityReport para el perfil y sus dos documentos: 2 documentos, 0 relaciones, 0 bloqueos, 0 advertencias, 0 informaciones.
- El nombre Lupe Valerio permanece en texto: no se localizó ese artista en el catálogo y no se creó otra identidad.
- Los otros 905 artistas mantienen el checksum ee8baff40d6a7804a1d3fe0e9a25d7f2 antes/después.
- Recarga y selección del perfil: fecha completa, provincia Santiago, tipo Solo Artist, rol Singer, género Perico Ripiao y estado Draft persistidos. Biografía española revisión 1 comprobada visualmente.
- git diff --check de las instrucciones modificadas sin errores; avisos LF/CRLF informativos.

## Columnas antiguas de biografía

bio_en y bio_es permanecen NULL. La revisión automática rechazó un intento de sincronizarlas mediante SQL porque el editor las presenta como snapshots congelados y las biografías deben guardarse por el endpoint editorial. No se reintentó ni se sorteó el rechazo. Las biografías autoritativas sí se guardaron satisfactoriamente mediante ese endpoint y pasan integridad. La descripción de espejos sincronizados en EDITORIAL_BIOGRAPHY_FORMAT.md difiere del comportamiento actual del editor/API; se documenta la discrepancia para revisión humana sin modificar esa regla ni inventar un mecanismo alternativo.

## Archivos y pendientes

Además de las cuatro instrucciones anteriores, se crean este informe, rubali-valerio-saved.json, rubali-valerio-verify.ts y rubali-valerio-verification.json. Los archivos de propuesta originales no se modifican. Imagen y publicación quedan fuera de lo ejecutado. No hubo cambios de esquema, seguridad, código de aplicación ni datos de otros artistas.
