# Incorporación de La Doncella del Acordeón

Ejecutado por Codex el 15 de octubre de 2026 después de la aprobación explícita «Sí» del editor al manifiesto la-doncella-del-acordeon-profile-manifest.json. Se conserva el manifiesto original sin reescribir la propuesta como si hubiera sido ejecución.

## Registros creados

- Artista: d3749b0e-ffa0-4e2e-907a-1242c21c4560, La Doncella del Acordeón, slug la-doncella-del-acordeon, estado draft.
- Biografía en inglés: eefb5bc7-7685-407a-9f1e-58eb99157f4e, schema_version 1, revisión 1, draft.
- Biografía en español: 7e4b417a-fb9a-4ac0-b3e9-ef6e27499339, schema_version 1, revisión 1, draft.

Antes: ningún perfil ni documento localizado para esta identidad. Después: todos los campos de artist_fields y ambos documentos coinciden exactamente con el manifiesto aprobado. Los espejos bio_en y bio_es pasaron de NULL a los Markdown aprobados. Las fuentes y discrepancias están documentadas en la propuesta; no se amplió el contenido biográfico.

El artista se creó mediante una inserción protegida por comprobación transaccional de duplicados. El formulario no ofrece accordionist como rol principal, por lo que se conservó el valor aprobado mediante la conexión Supabase. Las dos biografías se guardaron mediante Save draft en el editor administrativo, usando sus endpoints y validación habituales. Los espejos de compatibilidad se sincronizaron mediante UPDATE limitado al UUID nuevo y con condición de estado draft y valores previos NULL; el endpoint editorial no los sincronizó automáticamente.

## Comprobaciones

- Búsqueda repetida por nombre, nombres personales, aliases y slug, sin coincidencia previa.
- Restricciones y columnas consultadas antes de insertar; no se escribieron columnas generadas.
- Comparación programática de todos los campos aprobados y de ambos árboles documentales: coinciden.
- Validador validateEditorialDocument del proyecto: ambos válidos.
- buildEditorialIntegrityReport ejecutado sobre el nuevo perfil y sus dos documentos: cero bloqueos, dos advertencias y dos informaciones.
- Las advertencias draft_shadowing_public_compatibility corresponden a los espejos poblados junto a documentos draft. El perfil también permanece draft. Las informaciones legacy_compatibility_mismatch se deben a que el comparador usa texto plano y los espejos conservan los títulos Markdown exigidos por el formato editorial; no hay diferencia de redacción respecto del manifiesto.
- Cero nodos artistReference y cero relaciones de referencia para las dos biografías.
- Los otros 904 artistas conservaron checksum 5d6eb8075a6da562bcb91fb9a6ca8d5a antes/después de crear y guardar las biografías. No se ejecutó ninguna escritura sobre otro UUID de artista.
- Recarga del editor: biografía española persistida en draft, revisión 1, comprobada visualmente.
- Caché refrescada con scripts/revalidate.ts --artists la-doncella-del-acordeon. Respuesta exitosa de https://mangulina.do/api/revalidate para un artista. El primer intento de red falló; el intento con permiso de red finalizó correctamente.

## Archivos de auditoría

Se crean este informe, la-doncella-del-acordeon-saved.json (lectura posterior de los registros), la-doncella-del-acordeon-verification.json (resultado del validador e integridad) y la-doncella-verify.ts (comparación reproducible). La propuesta y el manifiesto originales quedan preservados. No se modificó código de aplicación ni seguridad.

## Pendientes editoriales

El perfil no está publicado y no tiene imagen. No se importó discografía. Fecha y lugar de nacimiento siguen sin establecer; se conservan las limitaciones y conflictos de fuentes de la propuesta. Las menciones recíprocas en La Princesa del Acordeón siguen pendientes de autorización separada; no se alteraron esos documentos. Los enlaces sociales son exactamente los aportados por el editor y aprobados en el manifiesto, con las limitaciones de acceso ya registradas.
