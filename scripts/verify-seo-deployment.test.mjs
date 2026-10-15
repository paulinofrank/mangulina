import test from 'node:test';
import assert from 'node:assert/strict';
import { verifyDeployment, team, project } from './verify-seo-deployment.mjs';

const sha = 'a'.repeat(40);
const payload = {project: {id: project}, environment: 'production', git: {sha}, url: 'mangulina-example.vercel.app'};
const metadata = {id: 'dpl_example', projectId: project, teamId: team, target: 'production', readyState: 'READY',
  url: payload.url, gitSource: {type: 'github', sha, ref: 'main', repoId: 1222592281}};
test('accepts only the matching production deployment', () => {
  assert.equal(verifyDeployment(metadata, payload).sha, sha);
});
for (const [label, edit] of Object.entries({
  project: {projectId: 'other'}, team: {teamId: 'other'}, preview: {target: 'preview'},
  notReady: {readyState: 'BUILDING'}, foreignHost: {url: 'attacker.example'},
  substitutedUrl: {url: 'different.vercel.app'},
  differentCommit: {gitSource: {...metadata.gitSource, sha: 'b'.repeat(40)}},
  branch: {gitSource: {...metadata.gitSource, ref: 'unreviewed'}},
  repository: {gitSource: {...metadata.gitSource, repoId: 1}},
})) test(`rejects ${label}`, () => assert.throws(() => verifyDeployment({...metadata, ...edit}, payload)));
