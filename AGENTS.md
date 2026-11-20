# Mangulina shared AI instructions

Applies to Perplexity, Claude, Gemini/Antigravity, Copilot, Codex and other assistants. If your tool does not automatically load repository instructions, explicitly read this file and its linked documents before starting. These instructions grant no access or write permission.

## Start here

- Read [docs/AI_INSTRUCTIONS.md](docs/AI_INSTRUCTIONS.md), [docs/DATA_GOVERNANCE.md](docs/DATA_GOVERNANCE.md), and [docs/ROLE_DICTIONARY.md](docs/ROLE_DICTIONARY.md). Preserve existing project rules and historical evidence.
- For artist profile creation or correction, also read [docs/ARTIST_PROFILE_WORKFLOW.md](docs/ARTIST_PROFILE_WORKFLOW.md): required field research, social handles, Spotify identity, form-compatible values and final visual verification.
- For any discography, music research, credit, import, identity or duplicate task, also read [docs/discography.md](docs/discography.md) and its relevant references.
- Read CLAUDE.md, GEMINI.md and applicable scoped rules when using those tools. For biographies read docs/EDITORIAL_BIOGRAPHY_FORMAT.md; for code/build work read docs/BUILD_NOTES.md and applicable framework guidance.
- For discography scope, research, identity, credits and review gates, docs/discography.md supersedes conflicting older instructions. For any remaining conflict, identify the exact passages and ask the editor before the affected action. Do not silently rewrite governance or select the rule permitting the broadest action.

## Production usage workflow

Follow [docs/AI_PRODUCTION_USAGE_POLICY.md](docs/AI_PRODUCTION_USAGE_POLICY.md) for every task. Default to local development and bounded verification. Production deployments and broad production verification require explicit user instruction; editorial database work does not by itself authorize a deployment. Release checklists describe an authorized release, not permission to start one. Preserve all existing editorial, publication, shared-record and security gates.

## Scope and execution

- For artist URL or slug changes, follow [docs/ARTIST_SLUG_REDIRECTS.md](docs/ARTIST_SLUG_REDIRECTS.md). Preserve evidenced previous addresses and reserve them to the same artist UUID.

- State the named artists, existing UUIDs if available, releases/date range, deliverables and authorized action before working. Research-only is the default for discography tasks without explicit write authorization.
- Work autonomously within that scope. Permission to research, audit or prepare a proposal does not authorize imports, publication, merges, deletions, deployment or changes to other artists.
- Do not modify database/schema, application code, music data, biographies, media, identifiers or publication state as a side effect of documentation or research.
- Shared records can affect other artists. Report dependencies and obtain explicit expanded authorization before changing them. Leave unrelated findings in a separate backlog.
- Accuracy outranks completeness. Preserve uncertainty, original titles, literal credits, provenance, existing identities and URLs. Never infer identity from title, ISRC, MBID or provider IDs alone.
- International works for Dominican contributors must be original compositions or first releases for the international artist; re-recordings or covers of pre-existing Dominican songs by foreign performers are strictly excluded from cataloging.
- Personal names and stage names are independent. An artist may use their second surname, first surname, middle name or another documented form professionally. That choice is not evidence against a documented full personal name. Populate the corresponding personal-name fields from sourced information supplied or confirmed by the editor; retaining the full name only as an alias is not a substitute. Preserve documented surname order and genuine source conflicts without imposing naming assumptions. See docs/ARTIST_PROFILE_WORKFLOW.md.
- Collective-name hygiene: do not prepend a generic descriptor such as “Orquesta”, “Grupo”, “Banda” or “Conjunto” to a catalog artist's name merely because the record is a group or orchestra. Preserve the documented canonical name exactly. Keep the descriptor only when reliable evidence shows that it is part of the proper name (for example, “Orquesta Internacional” associated with Ramón Orlando). Distinguish the entity type from the proper name in profile fields, biographies and artist references; if the stored canonical name is wrong, correct the artist record under the approved scope rather than altering the wording ad hoc.
- Musical genres must always come strictly from the frozen database taxonomy (`genres` table). Never invent musical genres or subgenres (e.g. do not invent or use terms like «merengue jocoso»). If a genre is not in the database, do not invent it: ask the editor.
- Present an evidence-backed change manifest before catalog writes. Obtain explicit approval for destructive actions, merges, shared-record changes and publication; follow the detailed gates in docs/discography.md.
- When the editor requests an artist profile, create or complete that artist's profile with artists.status = draft and publish its completed, validated English and Spanish biography documents (editorial_documents.status = published), without an additional approval step. Biography publication prepares the content for the artist's eventual release; it does not publish the draft artist profile. Record the sourced field manifest and verify both statuses; draft artist status does not waive accuracy or identity checks. This exception does not authorize publishing the artist profile, publishing biographies for an already public artist without authorization, destructive actions, shared-record changes, expanded artist scope, discography imports or security changes.
- Finish with exact files/records changed, before/after values, evidence, checks, unresolved issues and anything requiring editorial review. State clearly when no data changed.

## Supabase Security: Hands Off (applies to every AI tool)

No AI assistant or agent may alter Supabase security: RLS, policies, grants, function security, roles, auth settings, keys, or advisor dismissals. Read, audit and propose only; a human applies. Autonomous or bypass-permissions modes do not apply to this. Full rule: [docs/SUPABASE_SECURITY_POLICY.md](docs/SUPABASE_SECURITY_POLICY.md).
