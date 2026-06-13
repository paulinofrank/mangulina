// Probe what JSON Apple embeds in a public album page (one-off, read-only).
const url =
  "https://music.apple.com/us/album/quien-si-no-yo/388577355?i=388577902&uo=4";

const res = await fetch(url, {
  headers: {
    "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36",
    "Accept-Language": "en-US,en;q=0.9",
  },
});
console.log("status:", res.status);
const html = await res.text();
console.log("html length:", html.length);

const scriptTags = [
  ...html.matchAll(
    /<script([^>]*type="application\/(?:ld\+)?json"[^>]*)>([\s\S]*?)<\/script>/g,
  ),
];
for (const m of scriptTags) {
  console.log("---- script attrs:", m[1].trim().slice(0, 120));
  console.log("size:", m[2].length);
}

// Check for isrc anywhere
const isrcIdx = html.indexOf("isrc");
console.log("isrc found at index:", isrcIdx);
if (isrcIdx >= 0) console.log(html.slice(isrcIdx - 200, isrcIdx + 200));

// Dump the ld+json blob(s) trimmed
for (const m of scriptTags) {
  if (m[1].includes("ld+json")) {
    console.log("LD+JSON:", m[2].slice(0, 3000));
  }
}
