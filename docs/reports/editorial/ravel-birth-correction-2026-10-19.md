# Ravel — birth information correction

Authorized scope: broaden global public Facebook research and correct verified birth fields for Ravel, artist dacae9ad-a2cd-4d80-9404-123e775642cf. No other artists, biographies, discography or publication changes.

## Evidence-backed field manifest

Primary source: https://www.facebook.com/ravel.eltipo/posts/pfbid02FiEtGaMkF8NKdzjpfJcPLU7CFXDdQjYWzNedFXQnyuEYmr1GPrTpZvmE3RQEXpLZl

Opened original public post from official Ravel El Tipo account after global Facebook search `Ravel nació`. Facebook search displayed March 15, without an explicit year in the inspected date. Full text preserved in ravel-birthplace-facebook.txt. The author explicitly states: “Su nombre es Guillermo Ravel nacio en Sabana grande de Boya municipio de monte Plata de la Republica Dominicana.” This is birth evidence, not inferred residency. City spelling normalized with accents.

| Field | Before | Proposed |
| --- | --- | --- |
| birth_place | null | Sabana Grande de Boyá |
| province | null | Monte Plata |
| date_of_birth | null | unchanged |
| birth_year | null | unchanged |
| status | draft | unchanged |

Global searches also examined `Ravel cumpleaños`, `"Ravel El Tipo" "cumple"`, `Ravel 9 abril`, and `Ravel happy birthday`. Results included other people's birthdays and career anniversaries; these do not establish his age. Facebook automatically substituted `travel` in the English search; the exact-query option was selected. Existing April 9, 2021 greeting remains a day/month lead without a verified birth year. No inference from school age, migration dates, appearance or career anniversaries.

The original post also includes childhood and career information outside this narrow field correction; no biography or discography changes are included here. Historical creation manifests remain unchanged. No deployment or manual cache refresh is needed for this draft-only correction.

Execution verified: the conditional update returned the target artist with birth_place = Sabana Grande de Boyá, province = Monte Plata, status = draft, date_of_birth and birth_year still null. Reloaded admin, reselected Ravel, and confirmed both saved fields visually. Screenshot: ravel-birth-correction.png. Production access: targeted Supabase read/update and one admin reload; no deployment or cache refresh. Facebook retained its travel substitution after selecting the exact-query option, so that search was not treated as an exhaustive exact-name result.
