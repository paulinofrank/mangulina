# José Peña Suazo / La Banda Gorda — image and slug review

**Date:** 2026-11-19

## Scope authorized by the editor

- Exchange the profile images for José Peña Suazo (`770d5443-ff68-46a3-ba3e-43ac3f1cd7c1`) and La Banda Gorda (`b41d4bd2-9303-4834-885e-e7dee35a0287`).
- Change the group slug to `la-banda-gorda` while preserving the current address.
- Create the founder relationship if it does not already exist.

## Completed

- The public `artists-images` objects were exchanged and read back successfully.
  - José Peña Suazo now serves the former La Banda Gorda portrait (SHA-256 `fc47d46bfd501b6b3a918e6e46dcec7357319feea875059ed082b8c963b9e493`).
  - La Banda Gorda now serves the former José Peña Suazo portrait (SHA-256 `1d6c7879b357d1f917f2d1debf0a93752883a3e83dec70bd12053254731c1a41`).
- Both artist rows retain `has_image = true`; `image_updated_at` was set to `2026-11-20T03:55:32.605+00:00`.
- The public profile caches for both current slugs were invalidated through the governed revalidation endpoint and both pages were visually checked. The group page now displays the portrait formerly shown on the person page, and the person page now displays the portrait formerly shown on the group page.
- No `artists-images-original` objects exist for either UUID, so there was no original-resolution object to exchange.
- The relationship already exists and was not duplicated:
  - José Peña Suazo → La Banda Gorda
  - `founder_of`, 1994–present
  - note: “Founder, lead singer and continuing general director; the only constant member.”

## Deferred — slug change

- Current database values remain:
  - La Banda Gorda: `jose-pena-suazo-y-la-banda-gorda`
  - history: `[]`
- The slug-history migration is present in the repository, but the public resolver that reads `slug_history` is not deployed: `https://mangulina.do/artists/la-banda-gorda` currently returns the not-found page.
- Per `docs/ARTIST_SLUG_REDIRECTS.md`, changing the slug before that resolver is deployed would break the existing public address. No slug value was changed and no redirect history was written.
- The safe next step is to deploy the resolver, then change the group slug in one governed write so the old address permanently redirects to `/artists/la-banda-gorda`.

