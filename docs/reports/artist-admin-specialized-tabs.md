# Artist admin specialized workspaces

## Audit completed before implementation

- One canonical `artists` editor and `/api/admin/artists` endpoint serve all records. The editor loads all statuses through the authorized admin endpoint, saves changed fields only, and uses the existing deletion/reference checks and cache invalidation.
- Existing editor type choices are `solo_artist`, `group`, and `duo`. The relationship API also recognizes legacy `person`. No new type values were introduced. Repository evidence establishes application-supported values; a live database read failed with network EACCES, so current database constraints and production counts were not verified.
- `primary_role` is a scalar; `occupations` is a list with legacy object-key compatibility. Roles include singer, musician, composer, songwriter, lyricist, producer, arranger, bandleader, musical director, orchestra, DJ and rapper. The occupation dictionary additionally documents instrument-specific occupations. Public role directories currently filter by primary role; this implementation does not change those rules.
- Instruments are an existing multi-value field. The form round-trips them through CSV into a list. There is no primary-instrument field. Existing values outside the checkbox shortlist are now also displayed, rather than silently hidden.
- `formation_year` and `dissolution_year` already exist in the September 12 migration, form and write payload. `ended` stores inactive status. `birth_place` already backs the public origin formatter, with province alongside it.
- Legacy collective birth/death years exist in repository data: the September 15 `expresion-joven` migration sets both formation and birth year, plus death year. These values are preserved but not exposed as group birth/death fields or copied into formation/dissolution years.
- Professional relationships use `artist_relationships`: source person, target collective, `member_of`, `founder_of`, `leader_of`, start/end years and notes. An end year marks former members/leaders. The API already canonicalizes reversed person/collective submissions. DELETE requires the source artist ID and admin authorization.
- Family relationships have their own existing manager and API. They remain available for individuals. They are not presented as group facts.
- Biographies use the existing structured `ArtistBiographyEditor`, `editorial_documents` and editorial endpoints. Direct biography writes remain rejected by the artist API.
- Media/interviews keep the existing `artist_media` flow and YouTube metadata integration. Images keep authorization, direct signed storage upload and server finalization, with MIME/25 MB checks.
- Existing tests cover artist field diffing, authorization/publication boundaries, family relationships, structured biography validation/lifecycle, image upload contracts, public directories and cache revalidation.
- Shared identity, genre, tags, status, social links, image, biography, media and relationship controls can all remain in one form. No duplicated editor or public-route change is necessary.

## Implemented behavior

- Three prominent, translated navigation controls filter the existing selector before ranking and limiting results.
- Solo Artists includes non-collective records, including musicians, contributors and unclassified legacy records, so uncertain classification never makes an existing record unreachable. It does not claim every record is a singer.
- Groups & Ensembles includes exactly `group` and `duo`; a role such as orchestra does not override the entity type.
- Musicians includes `solo_artist`/legacy `person` records with musician or documented instrument-specific occupations/primary roles, or a recorded non-voice instrument. The same canonical artist can appear in both person views.
- Navigation retains the open profile and all its draft state; a banner explains this. It changes the selector and instrument emphasis, not the selected record's type. A pristine new form adopts safe type defaults. New Artist explicitly starts a draft for the chosen workspace. New musicians default to primary_role musician, as requested in the follow-up; other workspaces leave the role blank. Existing records retain their roles.
- Replacing a profile asks before discarding unsaved facts, biography, media or professional relationship drafts. Returning to the already-selected record does not reload it.
- Group records hide personal names, stage name, gender, DOB/DOD and family controls; expose formation/dissolution, origin, province and inactive status; and retain all hidden stored values in the existing differential-save baseline. Collective type uses an exclusive Duo/Group radio selector. Other records retain their existing type selector and legacy values.
- One shared instruments section appears first in the musician view and remains available in the solo view. No primary instrument or exclusive roles were introduced.
- Group relationship management exposes incoming members/founders/leaders, marks former memberships/leadership, and retains existing outgoing relationships. Edits retain relationship direction; deletion supplies the actual source ID to the unchanged API.
- New creations are drafts. Existing status editing is unchanged. Saving artist facts preserves an unsaved biography/media/relationship draft instead of resetting it.
- Existing effect callbacks were deferred with cleanup to satisfy current lint rules; no authorization/API/public rendering logic was changed.

## Data-model limitations and future work (not implemented)

- There is no dedicated collective subtype taxonomy for band/trio/choir/project. Existing group/duo and role data are retained. If precise subtypes become required, first audit production values, then propose a nullable collective subtype field with an approved vocabulary. Backfilling by inference risks misclassifying all existing collectives; leave existing rows null pending editorial review.
- Legacy group birth/death years need editorial review, not automatic migration. No new column is needed to correct them because formation/dissolution columns already exist. Copying or clearing them without evidence could lose historical meaning.
- No primary-instrument storage exists or is needed for this presentation. If ranking becomes a separate requirement, propose it independently rather than reinterpreting array order.
- The pre-existing admin all-records query caps at 2,000 records; scalable server-side filtering/pagination is a separate improvement.
- A live authenticated end-to-end save/upload against a test database remains advisable. This task did not write production data.

## Scope

Task changes: artist admin page, `src/lib/adminArtistWorkspace.ts`, its focused test, `admin.workspaces` translations in both message catalogs, and this report. Existing/concurrent changes to other files and other translation sections were preserved. No database migration, deployment or commit was performed.

## Validation results

- `npx tsc --noEmit`: passed.
- `npm test`: 432 passed, zero failed (427 existing tests plus five workspace tests).
- ESLint on changed TS/TSX files: zero errors; one pre-existing Next.js image-element warning remains in the admin preview.
- Changed editor/message diff whitespace checks: passed. Whole-tree diff check also reports unrelated pre-existing trailing whitespace in `docs/AI_INSTRUCTIONS.md`, left untouched.
- Headless Chrome fixture checks bundled the actual editor and shared biography/family components, with only Next routing/image/link adapters and HTTP responses mocked. Passed existing solo/group/duo/musician differential saves; group person-field exclusion and formation years; incoming membership edits preserving source/target; instrument prominence; unsaved facts retained across navigation; cancelled discard; all three draft creation flows (before the follow-up musician-role default); media draft retention and submission; structured biography draft retention and submission; invalid image MIME rejection. No production writes occurred. The fixture harness does not verify production authentication, storage upload completion, database constraints or CSS layout.
- Existing image upload, biography, relationship, authorization, public-directory and revalidation regression tests passed. Public implementation files were not modified by this task.
- `npm run build`: attempted, blocked by Turbopack reading permission-restricted `research/sony-ovalles/runtime/typing_extensions.py` (Windows access denied, OS error 5). That unrelated directory was not changed.
- Read-only production audit: attempted, network access returned EACCES. Production row counts and deployment state of schema migrations remain unverified.

## Musician controls follow-up

The musician workspace hides Artist Type and Primary Role controls and places the shared Gender field across their two grid columns, alongside Primary Genre and Profile Status. New musicians retain internal solo_artist / musician defaults; existing canonical classifications are preserved. TypeScript and 12 focused tests passed; lint reports zero errors and the existing image warning.
