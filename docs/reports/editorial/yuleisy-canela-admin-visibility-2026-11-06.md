# Yuleisy Canela — admin visibility diagnosis

- Artist `15ebe282-0d3d-47ed-8aaa-6c901dee5478` exists in the production database as `draft`; both biography documents are `published` revision 1.
- The authenticated production API returns her with `GET /api/admin/artists?id=15ebe282-0d3d-47ed-8aaa-6c901dee5478`.
- The admin editor and unpublished inventory use `GET /api/admin/artists?all=1`. That response contains only 1,000 artists (80 drafts). The database contains 1,006 artists (81 drafts). Thus Yuleisy is absent from the loaded browser list, although the record exists.
- Root cause: the endpoint's `.limit(2000)` exceeds the Supabase/PostgREST per-response cap of 1,000 rows. The apparent 2,000-row request is silently capped. Alphabetical ordering places Yuleisy outside the returned set.
- Local code change: page through the complete ordered catalog in 500-row requests, with `name, id` ordering. `npx tsc --noEmit` and targeted ESLint both pass.
- Production deployment has **not** been authorized or performed. The live editor still uses the old code. No cache purge, artist publication, or database rewrite was performed for this diagnosis.
- The public artist page is absent for a separate, expected reason: `artists.status = draft`. The profile workflow requires explicit authorization to publish the artist.
