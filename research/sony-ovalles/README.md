# Sony Ovalles audio research

Prepared from the 12 MP3 files provided by the user. All 12 were processed locally; combined measured duration: **2:53:05.789**.

## Start here

1. **audio-song-index.md** — 22 identified or probable selections in the tribute, approximate file-relative timestamps, broadcast attribution versus independent evidence, additional mentions, and unresolved passages.
2. **transcripcion_automatica.md** — combined Spanish automatic transcript. This is a draft, not a fully verified verbatim transcription. It explicitly marks longer untranscribed gaps and some low-confidence passages.
3. **catalogue.md** — broader research catalogue with sources and distinct arrangement, songwriting, production, and performance roles.
4. **transcripts/** — individual TXT files, raw JSON output, and approximate SRT subtitles for all 12 parts.
5. **clip_review.json** — additional automatic recognition of 15 short musical excerpts without voice filtering, used cautiously for song identification.

## Important findings and limitations

- The tribute ends during Part 08 around 08:25. Part 09 around 02:40 introduces a separate bolero special. Later songs are not automatically Ovalles credits.
- Arrangement, songwriting, and production are different roles. Album production does not establish per-track authorship or arrangement.
- La tierra tembló has a disputed arrangement attribution. Some identifications in rapid medleys remain provisional. A final Christmas-season excerpt remains unidentified.
- Whisper small (CPU int8) generated the transcript. Most files used batched decoding and voice-activity detection; Part 01 used unbatched decoding. Voice filtering omits much of the singing and may also miss speech over music. The raw transcript includes advertisements and station announcements as well as commentary and occasional recognized lyrics.
- Names, titles, dates, and other details in the raw transcript may be wrong even when not marked. Confidence flags are automated heuristics, not an accuracy guarantee. No claim is made of direct listening verification or a complete lifetime discography.
- All audio remained on this computer. A speech model and its runtime were downloaded for local processing. No database or application code was changed.

The ZIP bundle excludes speech-model weights, installed runtime packages, and the superseded initial base-model trial.
