import { normalizeSearchText } from "./searchRanking";
import type { GlobalSearchResponse, SearchResult } from "./searchTypes";

export const SEARCH_ALGORITHM_VERSION = "progressive-v3";
// These words are downweighted only during recovery. Exact titles and phrases
// are checked first, so a song called "Who" or "Padre" is still searchable.
export const QUESTION_WORDS = new Set("quien quienes que cual cuales como donde cuando son es los las el la de del un una por para y a en padre padres dibujo who what which how where when is are the of a an for and drawing".split(" "));

export function searchTokens(query: string) {
  const words = [...new Set(normalizeSearchText(query).split(" ").filter(Boolean))];
  return words.filter((word) => !QUESTION_WORDS.has(word)).slice(0, 8);
}

function editDistance(a: string, b: string): number {
  let twoBack: number[] | undefined;
  let previous = Array.from({ length: b.length + 1 }, (_, index) => index);
  for (let i = 1; i <= a.length; i++) {
    const next = [i];
    for (let j = 1; j <= b.length; j++) {
      next[j] = Math.min(next[j - 1] + 1, previous[j] + 1, previous[j - 1] + (a[i - 1] === b[j - 1] ? 0 : 1));
      if (i > 1 && j > 1 && a[i - 1] === b[j - 2] && a[i - 2] === b[j - 1]) {
        next[j] = Math.min(next[j], twoBack![j - 2] + 1);
      }
    }
    twoBack = previous;
    previous = next;
  }
  return previous[b.length];
}

// Common letter confusions provide stronger evidence for two-error guesses.
// This is a spelling key, not a claim that arbitrary names sound identical.
function spellingKey(word: string) {
  return word.replace(/y/g, "i").replace(/m/g, "n").replace(/v/g, "b").replace(/z/g, "s");
}

export type RankedMatch = { result: SearchResult; tier: number; score: number; fuzzy: boolean };

function matchValue(value: string, query: string, alias: boolean, type: SearchResult["type"]): Omit<RankedMatch, "result"> | null {
  const text = normalizeSearchText(value);
  if (!text || !query) return null;
  if (text === query) return { tier: alias ? 1 : 0, score: 1, fuzzy: false };
  if (query.length >= 2 && text.startsWith(query)) return { tier: 2, score: query.length / text.length + 1, fuzzy: false };
  if (query.length >= 3 && text.includes(query)) return { tier: 2, score: query.length / text.length, fuzzy: false };
  const wanted = searchTokens(query);
  const words = text.split(" ");
  const distinctive = words.filter((word) => !QUESTION_WORDS.has(word));
  // Entire catalog name/title embedded in a question is strong phrase evidence.
  if (distinctive.length && (` ${query} `).includes(` ${text} `)) return { tier: 3, score: 3 + distinctive.length / Math.max(wanted.length, 1), fuzzy: false };
  if (!wanted.length) return null;
  const wordMatches = (token: string, word: string) => word === token || (token.length >= 3 && word.startsWith(token));
  const matched = wanted.filter((token) => words.some((word) => wordMatches(token, word)));
  const queryCoverage = matched.length / wanted.length;
  const recordCoverage = matched.length / Math.max(distinctive.length, 1);
  if (matched.length >= 2 && (queryCoverage >= 0.6 || recordCoverage >= 0.8)) {
    const positions = matched.map((token) => words.findIndex((word) => wordMatches(token, word)));
    const ordered = positions.every((position, i) => i === 0 || position > positions[i - 1]);
    const span = Math.max(...positions) - Math.min(...positions) + 1;
    return { tier: 3, score: matched.length + queryCoverage + recordCoverage + (ordered ? 0.3 : 0) + matched.length / span, fuzzy: false };
  }
  // One distinctive word in a long question must cover a complete short name;
  // one surname from a two-word query is insufficient evidence.
  if (wanted.length === 1 && matched.length === 1) return { tier: 4, score: recordCoverage, fuzzy: false };
  if (matched.length === 1 && distinctive.length === 1 && recordCoverage === 1 && wanted.length >= 3) return { tier: 4, score: queryCoverage, fuzzy: false };
  // Conservative word-level correction: each meaningful query word must have
  // its own corresponding record word. Short words are never corrected.
  const used = new Set<number>();
  let errors = 0;
  for (const word of wanted) {
    let best = -1;
    let distance = Infinity;
    for (let i = 0; i < words.length; i++) {
      if (used.has(i)) continue;
      const d = editDistance(word, words[i]);
      if (d < distance) { distance = d; best = i; }
    }
    const allowance = word.length >= 5 ? 2 : word.length >= 4 ? 1 : 0;
    if (best < 0 || distance > allowance || distance / Math.max(word.length, words[best].length) > 0.34) return null;
    used.add(best);
    errors += distance;
  }
  // Single artist words can recover insertions, deletions, substitutions and
  // swaps. Two-edit guesses must preserve the first letter and have >=6 letters.
  const candidateWord = words[[...used][0]];
  const singleArtistWord = type === "artist" && wanted.length === 1
    && wanted[0].length >= 4
    && (errors === 1 || (errors === 2 && wanted[0].length >= 6
      && wanted[0][0] === candidateWord[0]
      && wanted[0].length === candidateWord.length
      && spellingKey(wanted[0]) === spellingKey(candidateWord)));
  if (!errors || (!singleArtistWord && wanted.length / Math.max(distinctive.length, 1) < 0.65)) return null;
  if (type === "artist" && wanted.length === 1 && errors === 2
    && (wanted[0].length < 6 || wanted[0][0] !== candidateWord[0]
      || wanted[0].length !== candidateWord.length
      || spellingKey(wanted[0]) !== spellingKey(candidateWord))) return null;
  // A lone title word is especially ambiguous (Caminero vs Camionero).
  // Allow same-length spelling recovery, but do not infer a different title
  // from an inserted/deleted letter without additional matching words.
  if (type !== "artist" && wanted.length === 1 && (distinctive.length !== 1 || wanted[0].length !== distinctive[0].length)) return null;
  if (type !== "artist" && wanted.length === 1 && errors > 1) return null;
  return { tier: 5, score: 1 - errors / Math.max(query.length, 1) - (alias ? 0.12 : 0) + (type === "artist" && wanted.length === 1 && spellingKey(wanted[0]) === spellingKey(candidateWord) ? 0.1 : 0), fuzzy: true };
}

export function rankCatalogCandidate(result: SearchResult, query: string): RankedMatch | null {
  const normalized = normalizeSearchText(query);
  const values = [{ text: result.title, alias: false }, ...(result.type === "artist" ? (result.aliases ?? []).map((text) => ({ text, alias: true })) : [])];
  const matches = values.map(({ text, alias }) => matchValue(text, normalized, alias, result.type)).filter((value): value is NonNullable<typeof value> => value !== null);
  matches.sort((a, b) => a.tier - b.tier || b.score - a.score);
  return matches[0] ? { result, ...matches[0] } : null;
}

export function rankCatalogResults(candidates: GlobalSearchResponse, query: string): GlobalSearchResponse {
  const rank = (rows: SearchResult[]) => rows.map((row) => rankCatalogCandidate(row, query)).filter((value): value is RankedMatch => value !== null)
    .sort((a, b) => a.tier - b.tier || b.score - a.score || a.result.title.localeCompare(b.result.title) || a.result.id.localeCompare(b.result.id));
  const artists = rank(candidates.artists);
  const songs = rank(candidates.songs);
  const releases = rank(candidates.releases);
  const all = [...artists, ...songs, ...releases].sort((a, b) => a.tier - b.tier || b.score - a.score);
  const top = all[0];
  const next = all.find((match) => match.result.id !== top?.result.id && match.result.title !== top?.result.title);
  const suggestion = top?.fuzzy && top.score >= 0.65 && (!next || next.tier > top.tier || top.score - next.score >= 0.08)
    ? { text: top.result.title, id: top.result.id, type: top.result.type, slug: top.result.slug } : undefined;
  return {
    artists: artists.map((match) => match.result), songs: songs.map((match) => match.result), releases: releases.map((match) => match.result),
    search: { outcome: !top ? "no_match" : top.tier >= 3 ? "recovered" : "normal", version: SEARCH_ALGORITHM_VERSION, ...(suggestion ? { suggestion } : {}) },
  };
}
