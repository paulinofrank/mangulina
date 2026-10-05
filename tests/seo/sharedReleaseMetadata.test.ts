import assert from 'node:assert/strict';
import test from 'node:test';
import { releaseSeoTitle } from '../../src/lib/seo';

test('shared compilation metadata includes every primary artist in both locales', () => {
  const release = { title: 'La combinación perfecta', type: 'compilation', artist: { name: 'Tony Seval' }, artists: [{ name: 'Tony Seval' }, { name: 'Aramis Camilo' }, { name: 'El Zafiro' }] };
  assert.equal(releaseSeoTitle(release, 'es'), 'La combinación perfecta - Compilación de Tony Seval · Aramis Camilo · El Zafiro');
  assert.equal(releaseSeoTitle(release, 'en'), 'La combinación perfecta - Compilation by Tony Seval · Aramis Camilo · El Zafiro');
});

test('legacy solo release and artistless release metadata retain their fallback', () => {
  assert.equal(releaseSeoTitle({ title: 'El muerto', type: 'album', artist: { name: 'Tony Seval' }, artists: [] }, 'es'), 'El muerto - Álbum de Tony Seval');
  assert.equal(releaseSeoTitle({ title: 'Recopilación', artists: [] }, 'es'), 'Recopilación - Información del lanzamiento');
});
