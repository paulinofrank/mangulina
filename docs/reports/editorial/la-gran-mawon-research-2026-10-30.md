# La Gran Mawon — revisión de ficha borrador (30 de octubre de 2026)

> **Seguimiento del 30 de octubre:** La ficha ya fue publicada y Mítiko figura ahora en dos relaciones estructuradas, `founder_of` y `member_of`, ambas desde 2011. La comprobación inicial de este informe precedió esos registros. En la revisión posterior aparecieron ya guardados; Codex no añadió ni duplicó relaciones. Véase el manifiesto `la-gran-mawon-mitiko-founder-member-manifest.json` para los UUID y la verificación en ambas fichas públicas.

## Alcance

Ficha existente `a7f7bc09-9356-41f0-9509-273b1724c452`, slug `la-gran-mawon`. El editor pidió revisar y enriquecer esta ficha con datos reales. La escritura se limita a campos de esta agrupación y a sus documentos biográficos español e inglés. La ficha sigue en `draft`; ambos documentos biográficos terminados deben quedar en `published`. No se importan ni alteran lanzamientos, pistas, créditos, imágenes, otras fichas, seguridad ni despliegues. No se abre la URL pública del borrador.

## Decisiones por campo

| Campo | Valor decidido | Evidencia y límite |
| --- | --- | --- |
| Identidad y tipo | `La Gran Mawon`; `group` (se conservan) | [Entrevista del grupo en La Galería](https://lagaleriamag.com/who-is-la-gran-mawon-in-conversation-with-the-up-coming-afrodominican-band/), [Instagram oficial](https://www.instagram.com/lagranmawon/) y [Linktree enlazado desde esa cuenta](https://linktr.ee/lagranmawon). El catálogo ya contiene la ficha y siete lanzamientos asociados. |
| Rol principal | `musician` | El valor anterior `band` no figura en el selector administrativo y aparecía como un rol vacío al recargar la ficha. La banda está documentada como colectivo de músicos en [La Galería](https://lagaleriamag.com/who-is-la-gran-mawon-in-conversation-with-the-up-coming-afrodominican-band/); `musician` es una opción válida para agrupaciones, ya utilizada por otra banda del catálogo. `group` sigue expresando que no es una persona. |
| Año de formación | `2011` | [La Galería](https://lagaleriamag.com/who-is-la-gran-mawon-in-conversation-with-the-up-coming-afrodominican-band/) narra las improvisaciones de 2011; [Retajila, «Una isla es un universo», pp. 139–143](https://retajila.com/descargas/UNA_ISLA_ES_UN_UNIVERSO_2016_2017.pdf) confirma el origen del proyecto. No hay fecha de formación exacta sustentada. |
| Origen y provincia | `Santo Domingo`; `Distrito Nacional` | La banda sitúa las sesiones fundacionales en plazas de la Zona Colonial de Santo Domingo en [La Galería](https://lagaleriamag.com/who-is-la-gran-mawon-in-conversation-with-the-up-coming-afrodominican-band/). Para una agrupación, el campo Origin guarda la ciudad de procedencia. La Zona Colonial está en el Distrito Nacional. |
| Género principal y otros | `fusion`; `folklore`, `reggae` | [La Galería](https://lagaleriamag.com/who-is-la-gran-mawon-in-conversation-with-the-up-coming-afrodominican-band/) y la [entrevista a Mítiko de 2013](https://zachary-jones.com/zambombazo/entrevista-paso-corto-la-gran-mawon-fusion-afrocaribena/) describen la mezcla de música tradicional afrodominicana con reggae y rock. Valores existentes en la taxonomía; la lista no repite `fusion`. `folklore` describe las raíces dominicanas, no afirma un género exclusivo. |
| Otras ocupaciones | `[]` | `band` estaba duplicado en `occupations`; la ficha no documenta un segundo rol colectivo aplicable. El tipo de artista permanece `group`. |
| Etiqueta de repertorio | `secular` | El repertorio documentado en [Spotify](https://open.spotify.com/artist/6YLVFLxxNTruuMRMRCEN5Y) y [Apple Music](https://music.apple.com/us/artist/la-gran-mawon/1149054625) no es de música cristiana. Las referencias a tradiciones espirituales afrocaribeñas no equivalen a una etiqueta de música cristiana. |
| Sexo/género | `null` (se conserva) | El formulario de agrupaciones no ofrece el campo. No se deduce género colectivo de fotos o integrantes. |
| Spotify | `6YLVFLxxNTruuMRMRCEN5Y` | [Perfil de Spotify](https://open.spotify.com/artist/6YLVFLxxNTruuMRMRCEN5Y) con la discografía de la banda; se normaliza la URL anterior al ID de artista de 22 caracteres. |
| Instagram | `lagranmawon` | [Cuenta oficial](https://www.instagram.com/lagranmawon/) abierta en Chrome; enlaza a su [Linktree](https://linktr.ee/lagranmawon). |
| Facebook | `LaGranMawon` | El Linktree oficial lleva a [la página de Facebook](https://www.facebook.com/LaGranMawon/), identificada como La Gran Mawon, músico/banda. |
| YouTube | `@LaGranMawon` | El Linktree oficial lleva al [canal de la banda](https://www.youtube.com/channel/UCzJ1FJoY_KhxEpn2gKKbZPQ), cuya página muestra el handle `@LaGranMawon`. Se guarda el handle, no el ID del canal ni su URL. |
| Website | sin cambio | Se verificó el Linktree oficial como puente de identidad. No se identificó un sitio independiente de la banda. |
| Retrato | sin cambio | No se suministró una imagen con derechos de reutilización claros; la ficha sigue sin imagen. |

## Sustento biográfico

- [La Galería, entrevista directa](https://lagaleriamag.com/who-is-la-gran-mawon-in-conversation-with-the-up-coming-afrodominican-band/) documenta las sesiones de la Zona Colonial, la alineación en la fecha de la entrevista, la fusión de ritmos y la función de Mítiko. La alineación citada no se presenta como permanente.
- [Retajila, pp. 139–143](https://retajila.com/descargas/UNA_ISLA_ES_UN_UNIVERSO_2016_2017.pdf) identifica a Mítiko, Zahir y Gato como integrantes originales constantes, «Fuego Petró» como primer sencillo (2013), la producción homónima de siete canciones en agosto de 2016, la escritura de «La Culebra» y una presentación en Nueva York en 2017. Algunas plataformas llaman álbum a la edición de 2016 y otras EP; la biografía usa el término neutral «producción».
- [Entrevista de 2013 con Mítiko](https://zachary-jones.com/zambombazo/entrevista-paso-corto-la-gran-mawon-fusion-afrocaribena/) explica el sentido de «mawon»; se atribuye como explicación del músico, sin afirmar una etimología académica independiente.
- [Apple Music: perfil de artista](https://music.apple.com/us/artist/la-gran-mawon/1149054625) y [álbum «Radio Katharsis»](https://music.apple.com/us/album/radio-katharsis/1704765111) respaldan la cronología de grabaciones y la edición de 2023. [Z101](https://z101digital.com/la-gran-mawon-lanza-candela-pa-lo-pie-y-celebra-concierto-este-viernes/) documenta «Candela Pa Lo Pie» y su mezcla de gagá y jazz.
- [DISCOLAI, octubre de 2023](https://discolai.com/2023/10/04/mira-los-nuevos-videos-de-la-gran-mawon-junto-a-vakero-altherego-ivana-loyola-felipe-y-joaquin-cruz-diomedes-jimenez-kashmir-jones-y-mediopicky/) documenta la colaboración con Vakeró en «Te Doy Seguro»; [Rutgers](https://globalracialjustice.rutgers.edu/event/afro-dominican-music-racializing-caribbean-panelconcert) el evento de febrero de 2024 con Xiomara Fortuna y Yasser Tejeda; [Diario Libre](https://www.diariolibre.com/revista/musica/2024/03/10/isle-of-light-un-coctel-musical-a-orillas-del-mar/2638565) la actuación en «Isle of Light» ese año.

## Identidades, referencias y pendientes

Los destinos de referencia verificados en el catálogo son Mítiko (`648cd724-dccf-4174-8d13-18b9cfd0ce1e`), Vakeró (`ec8ba439-3772-49ff-a218-05f5dc615763`), Xiomara Fortuna (`8e29188a-215b-4c6c-b34a-45b381765e46`) y Yasser Tejeda (`a3a0551d-7f39-42f3-b30b-05a9d3c83ab2`), todos `published`. Zahir y Gato no tienen fichas encontradas por nombre. No se incluyen fechas personales ni una plantilla actual no verificada.

La auditoría inversa encontró menciones literales de «La Gran Mawon» en cuatro biografías **ya publicadas** y sin referencia estructurada: Los Sufridos EN (`b721d349-ea2e-4f18-9652-e3b5148073d5`, rev. 3) y ES (`4cf3dbc5-912a-4507-8f22-40b43cff3552`, rev. 2), y Mítiko EN (`b20736f2-e6a3-4a4c-94df-c88e31f65b32`, rev. 1) y ES (`12433f83-6c84-4b1f-859b-31ade027b65c`, rev. 1). Esas biografías pertenecen a otros artistas y permanecen sin cambio; enlazar ahora a una ficha draft podría llevar a un 404. Revisar esos cuatro documentos cuando se autorice la publicación de la agrupación y los cambios en las biografías ajenas.

La fecha exacta de formación, un sitio web independiente y una imagen reutilizable siguen sin verificar. Esta revisión no audita ni importa la discografía existente.

## Resultado guardado y comprobaciones

- `artists.id=a7f7bc09-9356-41f0-9509-273b1724c452`: `status=draft`, `type=group`, `primary_role=musician`, Origin `Santo Domingo`, Province `Distrito Nacional`, `formation_year=2011`, `primary_genre=fusion`, `genres=[folklore,reggae]`, `artist_tags=[secular]`, y los cuatro identificadores sociales y musicales normalizados. `occupations=[]` ya no duplica el rol. Verificado en base de datos y en el editor administrativo tras recargar.
- Biografía inglesa `0e00fcdd-27d9-40b8-a76e-544a80a0967f` y española `6239c7bb-717a-46f0-a982-6f6520b03ff3`, ambas `published`, revisión 2; comprobadas en el editor. Los doce nodos de referencia tienen sus doce relaciones correspondientes. Integridad: cero bloqueos y cero advertencias.
- El informe de integridad emite dos avisos **informativos** `legacy_compatibility_mismatch`: la regla editorial exige espejos Markdown con encabezados `**...**`, mientras que ese comparador contrasta el texto plano del documento con el Markdown sin retirar las marcas. Los espejos se generaron de las mismas secciones y se comprobaron contra el manifiesto; no hay deriva de contenido.
- Los siete IDs de lanzamientos asociados a la agrupación se compararon antes y después y permanecieron idénticos. No se alteraron filas de música. No se refrescó caché pública ni se solicitó la URL pública del borrador.
- En esta primera comprobación aún no existía una relación formal de membresía/fundación con Mítiko; se observaron posteriormente las dos relaciones descritas en la nota de seguimiento al inicio. Las cuatro biografías ajenas con menciones sin enlace siguen anotadas arriba.

## Archivos de esta revisión

Todos son nuevos y están bajo `docs/reports/editorial/`:

- `la-gran-mawon-profile-content.json` — propuesta final de campos y textos en ambos idiomas.
- `la-gran-mawon-profile-manifest.json` — estado anterior y manifiesto de la primera escritura.
- `la-gran-mawon-complete-profile.ts` — preparación, guardado y comprobación de la primera escritura.
- `la-gran-mawon-saved-verification.json` — comprobación histórica de la revisión 1.
- `la-gran-mawon-reference-revision-manifest.json` — manifiesto de enlaces adicionales a Mítiko.
- `la-gran-mawon-reference-revision.ts` — guardado y comprobación de la revisión 2.
- `la-gran-mawon-role-correction-manifest.json` — cambio `band` → `musician` con guardia de concurrencia.
- `la-gran-mawon-role-correction.ts` — guardado y comprobación del rol.
- `la-gran-mawon-role-verification.json` — estado final del rol.
- `la-gran-mawon-final-verification.json` — estado final de la ficha y los documentos.
- `la-gran-mawon-research-2026-10-30.md` — evidencia, alcance, decisiones y pendientes.
