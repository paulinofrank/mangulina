// Bounded integration guard: run against a production build or a deployed site.
// Example: npm run check:seo -- --origin http://localhost:3000
import assert from 'node:assert/strict';
import { load } from 'cheerio';
import { spawnSync } from 'node:child_process';
import { existsSync } from 'node:fs';
import { delimiter, join } from 'node:path';

const originArg = process.argv.indexOf('--origin');
const origin = new URL(originArg >= 0 ? process.argv[originArg + 1] : 'https://mangulina.do').origin;
const deploymentArg = process.argv.indexOf('--deployment');
const deployment = deploymentArg >= 0 ? process.argv[deploymentArg + 1] : null;
if (deployment && !/^https:\/\/[a-z0-9-]+\.vercel\.app$/.test(deployment)) throw new Error('Expected a Vercel deployment URL');
const results = [];
async function inspect(path, canonicalPath, expectedCount, { noindex = false } = {}) {
  let html, headerRobots = '';
  if (deployment) {
    // vercel curl uses the existing project authorization without exposing tokens.
    const cli = process.platform === 'win32' ? (process.env.PATH ?? '').split(delimiter)
      .map(dir => join(dir, 'node_modules', 'vercel', 'dist', 'vc.js')).find(existsSync) : null;
    if (process.platform === 'win32') assert.ok(cli, 'Vercel CLI must be installed on PATH');
    const response = spawnSync(cli ? process.execPath : 'vercel',
      [...(cli ? [cli] : []), 'curl', path, '--deployment', deployment, '--', '-fsS'],
      { encoding: 'utf8', timeout: 60000 });
    assert.equal(response.status, 0, `${path}: staged HTTP request failed`);
    html = response.stdout;
  } else {
    const response = await fetch(origin + path, { signal: AbortSignal.timeout(45000) });
    assert.equal(response.status, 200, `${path}: HTTP status`);
    html = await response.text();
    headerRobots = response.headers.get('x-robots-tag') ?? '';
  }
  const $ = load(html);
  $('script, style').remove();
  assert.ok($('h1').text().trim(), `${path}: server-rendered heading missing`);
  const canonical = $('link[rel=canonical]').attr('href');
  assert.equal(canonical, 'https://mangulina.do' + canonicalPath, `${path}: canonical`);
  const robots = [$('meta[name=robots]').attr('content'), headerRobots].filter(Boolean).join(',');
  assert.equal(/noindex/i.test(robots), noindex, `${path}: indexing directive`);
  const songs = $('a[href]').map((_, e) => $(e).attr('href')).get().filter(href => /^\/(es\/)?songs\//.test(href));
  assert.equal(songs.length, expectedCount, `${path}: server-rendered recording links`);
  const links = $('nav a[href]').map((_, e) => $(e).attr('href')).get();
  results.push({ path, canonical, recordingLinks: songs.length, passed: true });
  return { songs, links };
}
try {
  for (const locale of ['', '/es']) {
    const first = await inspect(locale + '/archive/1997', locale + '/archive/1997', 50);
    const second = await inspect(locale + '/archive/1997/page/2', locale + '/archive/1997/page/2', 50);
    assert.ok(first.links.includes(locale + '/archive/1997/page/2'), 'Archive needs a crawlable next-page anchor');
    assert.ok(second.links.includes(locale + '/archive/1997'), 'Archive needs a crawlable previous-page anchor');
    assert.notDeepEqual(second.songs, first.songs, 'Archive page two must contain its own records in HTML');
    const directory = await inspect(locale + '/songs?page=2', locale + '/songs?page=2', 48);
    assert.ok(directory.links.some(href => href.includes('page=3')), 'Directory needs a next-page anchor');
    assert.ok(directory.links.some(href => href.includes('page=1')), 'Directory needs a previous-page anchor');
  }
  await inspect('/songs?q=amor', '/songs', 48, { noindex: true });
  console.log(JSON.stringify({ origin: deployment ?? origin, checkedAt: new Date().toISOString(), passed: true, results }, null, 2));
} catch (error) {
  console.error(JSON.stringify({ origin, passed: false, error: error.message, results }, null, 2));
  process.exitCode = 1;
}
