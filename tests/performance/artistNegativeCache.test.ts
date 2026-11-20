import assert from 'node:assert/strict';
import {AsyncLocalStorage} from 'node:async_hooks';
import {createRequire} from 'node:module';
import test from 'node:test';

// Exercise Next's actual tags in an isolated request context; no network or DB.
Object.defineProperty(globalThis, 'AsyncLocalStorage', {value:AsyncLocalStorage, configurable:true});
const require = createRequire(import.meta.url);
const {workAsyncStorage} = require('next/dist/server/app-render/work-async-storage.external.js');
const {getImplicitTags} = require('next/dist/server/lib/implicit-tags.js');
const {revalidateArtistProfile} = await import('../../src/lib/revalidateArtistProfile');

test('artist publication invalidates concrete locale URLs, including cached 404s', async () => {
  const store = {incrementalCache:{}, route:'/api/admin/artists', page:'/api/admin/artists/route', pendingRevalidatedTags:[] as {tag:string}[]};
  workAsyncStorage.run(store, () => revalidateArtistProfile('previously-draft', 'test-artist'));
  const invalidated = store.pendingRevalidatedTags.map(({tag}) => tag);
  for (const path of ['/en/artists/previously-draft', '/es/artists/previously-draft']) {
    // Successful profiles and notFound renders both carry the concrete pathname.
    for (const route of ['/[locale]/artists/[slug]/page', '/_not-found/page']) {
      const implicit = await getImplicitTags(route, path, null);
      assert.ok(invalidated.some(tag => implicit.tags.includes(tag)), `${route}: ${path}`);
    }
  }
  assert.ok(!invalidated.includes('_N_T_/layout'), 'never invalidate the site layout');
  assert.ok(!invalidated.includes('_N_T_/[locale]/artists/[slug]/page'), 'never invalidate all artists');
});

test('a later slug correction invalidates every historical redirect destination', () => {
  const store = {incrementalCache:{}, route:'/api/admin/artists', page:'/api/admin/artists/route', pendingRevalidatedTags:[] as {tag:string}[]};
  workAsyncStorage.run(store, () => revalidateArtistProfile('latest-name', 'test-artist', ['first-name', 'second-name']));
  const invalidated = store.pendingRevalidatedTags.map(({tag}) => tag);
  for (const slug of ['first-name', 'second-name', 'latest-name']) {
    assert.ok(invalidated.includes(`_N_T_/es/artists/${slug}`));
    assert.ok(invalidated.includes(`_N_T_/en/artists/${slug}`));
  }
  assert.ok(!invalidated.includes('_N_T_/layout'));
});
