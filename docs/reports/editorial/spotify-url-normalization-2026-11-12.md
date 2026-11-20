# Spotify artist URL normalization

One guarded update saved all six IDs with no retries. A separate production read verified all six exact values and original publication statuses and found zero remaining URL values. No production cache refresh or deployment was performed.

The November 12 production review found six full artist URLs in artists.spotify. The editor authorized storing the bare IDs. Each proposed value comes from the exact URL already saved on that profile.

| Artist | UUID | Status | Before | After |
| --- | --- | --- | --- | --- |
| Billete MC | 76a0749b-c9ae-45cf-a054-64a9613d2395 | draft | https://open.spotify.com/artist/5m7Wf6SNn2RKZcPWrrlhkV | 5m7Wf6SNn2RKZcPWrrlhkV |
| Cheo Zorrilla | 15b91d81-9b3a-4f6a-8f9a-cdee3fc85af0 | published | https://open.spotify.com/artist/3Bu5zMtwHgpyB6Yf0jacU0 | 3Bu5zMtwHgpyB6Yf0jacU0 |
| Jón Lyno | 363e4c02-a724-4862-a4ee-e73f6a61cf1f | draft | https://open.spotify.com/artist/2JwCM61wuu7hWT50bT6Ryl | 2JwCM61wuu7hWT50bT6Ryl |
| Mítiko | 648cd724-dccf-4174-8d13-18b9cfd0ce1e | published | https://open.spotify.com/artist/080cBR2AZfCWAiemP8CAvy | 080cBR2AZfCWAiemP8CAvy |
| Repike | 021f8b5d-6868-4023-8182-5b4bc04a6ae1 | draft | https://open.spotify.com/artist/406XOWQKGdfIAHJ33CfgU8 | 406XOWQKGdfIAHJ33CfgU8 |
| Simarabo | 29df481d-e897-47d7-8248-12e067a03b69 | draft | https://open.spotify.com/artist/4GB5UFMfWrmjLtCqnUzFQO | 4GB5UFMfWrmjLtCqnUzFQO |
