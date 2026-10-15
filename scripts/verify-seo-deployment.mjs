import assert from 'node:assert/strict';
import { readFileSync, appendFileSync } from 'node:fs';
import { pathToFileURL } from 'node:url';

export const team = 'team_F1zAZJuK32zFWVzIjMD2x4OF';
export const project = 'prj_49xS0XvNy74hpJsdGxwsi9zEfRoU';
export function verifyDeployment(data, payload) {
  assert.equal(payload.project?.id, project, 'Unexpected dispatch project');
  assert.equal(payload.environment, 'production', 'Expected a production deployment');
  assert.match(payload.git?.sha ?? '', /^[a-f0-9]{40}$/, 'Expected a full commit SHA');
  assert.equal(data.projectId, project, 'Deployment project mismatch');
  assert.equal(data.teamId ?? data.ownerId, team, 'Deployment team mismatch');
  assert.equal(data.target, 'production', 'Deployment environment mismatch');
  assert.equal(data.readyState, 'READY', 'Deployment is not ready');
  assert.equal(data.gitSource?.type, 'github', 'Expected a GitHub deployment');
  assert.equal(data.gitSource?.sha, payload.git.sha, 'Deployment commit mismatch');
  assert.equal(data.gitSource?.ref, 'main', 'Only reviewed main deployments are eligible');
  assert.equal(String(data.gitSource?.repoId), '1222592281', 'Deployment repository mismatch');
  const url = `https://${data.url}`;
  assert.match(url, /^https:\/\/[a-z0-9-]+\.vercel\.app$/, 'Expected an immutable deployment hostname');
  const supplied = payload.url?.startsWith('https://') ? payload.url : `https://${payload.url}`;
  assert.equal(url, supplied, 'Dispatch URL does not match Vercel metadata');
  assert.match(data.id, /^dpl_[A-Za-z0-9]+$/, 'Invalid deployment ID');
  return { url, sha: data.gitSource.sha, deployment: data.id };
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    assert.ok(process.env.VERCEL_TOKEN, 'Configure VERCEL_TOKEN in the protected seo-release GitHub environment');
    const event = JSON.parse(readFileSync(process.env.GITHUB_EVENT_PATH, 'utf8'));
    const payload = event.client_payload;
    assert.equal(payload?.project?.id, project, 'Unexpected dispatch project');
    const host = String(payload.url ?? '').replace(/^https:\/\//, '');
    assert.match(host, /^[a-z0-9-]+\.vercel\.app$/, 'Invalid dispatched deployment URL');
    const response = await fetch(`https://api.vercel.com/v13/deployments/${host}?teamId=${team}`, {
      headers: { Authorization: `Bearer ${process.env.VERCEL_TOKEN}` },
      redirect: 'error', signal: AbortSignal.timeout(30000),
    });
    assert.equal(response.status, 200, 'Vercel deployment lookup failed');
    const verified = verifyDeployment(await response.json(), payload);
    for (const [key, value] of Object.entries(verified)) appendFileSync(process.env.GITHUB_OUTPUT, `${key}=${value}\n`);
    console.log('Verified deployment project, team, production environment, repository, main branch, URL and commit.');
  } catch (error) {
    console.error(error.message);
    process.exitCode = 1;
  }
}
