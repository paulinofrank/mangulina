// src/app/admin/page.tsx
'use client';

import { useState, useEffect, useCallback } from 'react';
import { getSupabaseClient } from '@/lib/supabase';
import type { Artist } from '@/types/music';
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

type FeaturedArtistRow = {
  artist_id?: string | null;
};

export default function AdminDashboard() {
  const supabase = getSupabaseClient();

  // Data State
  const [artists, setArtists] = useState<Artist[]>([]);
  const [featuredId, setFeaturedId] = useState<string>('');
  const [loading, setLoading] = useState(false);

  // Form State aligned with public.artists schema
  const [selectedArtistId, setSelectedArtistId] = useState<string>('');
  const [name, setName] = useState('');
  const [province, setProvince] = useState('');
  const [dateOfBirth, setDateOfBirth] = useState('');
  const [birthPlace, setBirthPlace] = useState('');
  const [bio, setBio] = useState('');
  const [isReligious, setIsReligious] = useState(false);
  const [facebook, setFacebook] = useState('');
  const [instagram, setInstagram] = useState('');
  const [genres, setGenres] = useState('');
  const [artistTags, setArtistTags] = useState('');

  const fetchData = useCallback(async () => {
    const { data: artistsData, error: aError } = await supabase
      .from('artists')
      .select('*')
      .order('name', { ascending: true });

    if (artistsData) setArtists(artistsData as Artist[]);
    if (aError) console.error('Error fetching artists:', aError);

    const { data: featData } = await supabase
      .from('featured_artist')
      .select('artist_id')
      .maybeSingle();

    const row = featData as FeaturedArtistRow | null;
    if (row?.artist_id != null) setFeaturedId(String(row.artist_id));
  }, [supabase]);

  useEffect(() => {
    queueMicrotask(() => {
      void fetchData();
    });
  }, [fetchData]);

  const handleSelectArtistForEdit = (id: string) => {
    const artist = artists.find(a => a.id === id);
    if (artist) {
      setSelectedArtistId(artist.id);
      setName(artist.name || '');
      setProvince(artist.province || '');
      setDateOfBirth(artist.date_of_birth || '');
      setBirthPlace(artist.birth_place || '');
      setBio(artist.bio || '');
      setIsReligious(artist.is_religious || false);
      setFacebook(artist.facebook || '');
      setInstagram(artist.instagram || '');
      setGenres(artist.genres?.join(', ') || '');
      setArtistTags(artist.artist_tags?.join(', ') || '');
    } else {
      resetForm();
    }
  };

  const resetForm = () => {
    setSelectedArtistId('');
    setName('');
    setProvince('');
    setDateOfBirth('');
    setBirthPlace('');
    setBio('');
    setIsReligious(false);
    setFacebook('');
    setInstagram('');
    setGenres('');
    setArtistTags('');
  };

  async function updateFeatured() {
    setLoading(true);
    // Fixed "never" error for Featured Artist upsert
    const { error } = await supabase
      .from('featured_artist')
      .upsert({ id: 1, artist_id: featuredId });

    if (error) alert('Security/Policy Error: ' + error.message);
    else alert('Success! Spotlight updated.');
    setLoading(false);
  }

  async function handleSaveArtist(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);

    const artistData = {
      name,
      province,
      date_of_birth: dateOfBirth || null,
      birth_place: birthPlace,
      bio,
      is_religious: isReligious,
      facebook,
      instagram,
      genres: genres.split(',').map(g => g.trim()).filter(g => g !== ''),
      artist_tags: artistTags.split(',').map(tag => tag.trim()).filter(tag => tag !== '')
    };

    let error: { message: string } | null = null;
    if (selectedArtistId) {
      const { error: updateError } = await supabase
        .from('artists')
        .update(artistData)
        .eq('id', selectedArtistId);
      error = updateError;
    } else {
      const { error: insertError } = await supabase
        .from('artists')
        .insert([artistData]);
      error = insertError;
    }

    if (error) {
      alert('Error saving artist: ' + error.message);
    } else {
      alert(`Success! ${name} has been saved.`);
      resetForm();
      fetchData();
    }
    setLoading(false);
  }

  return (
    <div style={{ padding: '40px', maxWidth: '800px', margin: '0 auto', fontFamily: 'var(--font-outfit), sans-serif', color: 'var(--color-flagblue)' }}>
      <header style={{ marginBottom: '40px', borderBottom: '2px solid #eee', paddingBottom: '20px' }}>
        <h1 style={{ fontSize: '2.5rem', fontWeight: 900, letterSpacing: '-0.05em' }}>
          MANGULINA<span style={{ color: 'var(--color-wikicrimson)' }}>™</span> ADMIN
        </h1>
      </header>

      {/* SPOTLIGHT CONTROL */}
      <section style={{ background: '#fff', padding: '25px', borderRadius: '16px', border: '1px solid #eee', boxShadow: '0 4px 20px rgba(0,0,0,0.05)', marginBottom: '30px' }}>
        <h2 style={{ marginTop: 0, fontSize: '1.2rem', fontWeight: 800, textTransform: 'uppercase' }}>Homepage Spotlight</h2>
        <div style={{ display: 'flex', gap: '12px', marginTop: '15px' }}>
          <select
            value={featuredId}
            onChange={(e) => setFeaturedId(e.target.value)}
            style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #ddd' }}
          >
            <option value="">-- Select Featured Artist --</option>
            {artists.map(a => <option key={a.id} value={a.id}>{a.name}</option>)}
          </select>
          <button onClick={updateFeatured} disabled={loading || !featuredId} style={{ padding: '12px 24px', background: 'var(--color-flagblue)', color: '#fff', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 'bold' }}>
            Update Spotlight
          </button>
        </div>
      </section>

      {/* ARTIST EDITOR */}
      <section style={{ background: '#fdfdfd', padding: '30px', borderRadius: '16px', border: '1px solid #eee' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
          <h2 style={{ margin: 0, fontSize: '1.2rem', fontWeight: 800, textTransform: 'uppercase' }}>
            {selectedArtistId ? 'Edit Artist Profile' : 'Create New Artist'}
          </h2>
          {selectedArtistId && <button onClick={resetForm} style={{ fontSize: '0.8rem', color: 'var(--color-wikicrimson)', background: 'none', border: 'none', cursor: 'pointer' }}>Cancel Edit</button>}
        </div>

        <div style={{ marginBottom: '25px', paddingBottom: '20px', borderBottom: '1px solid #eee' }}>
          <label style={{ fontSize: '0.8rem', fontWeight: 700, display: 'block', marginBottom: '8px' }}>SEARCH ARCHIVE TO EDIT</label>
          <select
            value={selectedArtistId}
            onChange={(e) => handleSelectArtistForEdit(e.target.value)}
            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid var(--color-flagblue)' }}
          >
            <option value="">-- Start New Entry --</option>
            {artists.map(a => <option key={a.id} value={a.id}>{a.name}</option>)}
          </select>
        </div>

        <form onSubmit={handleSaveArtist} style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '15px' }}>
            <input placeholder="Full Name" value={name} onChange={e => setName(e.target.value)} required style={inputStyle} />
            <input placeholder="Province" value={province} onChange={e => setProvince(e.target.value)} style={inputStyle} />
            <input type="date" value={dateOfBirth} onChange={e => setDateOfBirth(e.target.value)} style={inputStyle} />
            <input placeholder="Birth Place" value={birthPlace} onChange={e => setBirthPlace(e.target.value)} style={inputStyle} />
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '15px' }}>
            <input placeholder="Facebook URL" value={facebook} onChange={e => setFacebook(e.target.value)} style={inputStyle} />
            <input placeholder="Instagram URL" value={instagram} onChange={e => setInstagram(e.target.value)} style={inputStyle} />
          </div>

          <input placeholder="Musical genres/styles (comma separated)" value={genres} onChange={e => setGenres(e.target.value)} style={inputStyle} />
          <input placeholder="Tags / classification (comma separated)" value={artistTags} onChange={e => setArtistTags(e.target.value)} style={inputStyle} />

          <textarea placeholder="Biography / Archive Notes" value={bio} onChange={e => setBio(e.target.value)} style={{ ...inputStyle, minHeight: '120px', resize: 'vertical' }} />

          <div style={{ display: 'flex', alignItems: 'center', gap: '15px', padding: '10px 0' }}>
            <label style={{ fontWeight: 700, fontSize: '0.9rem' }}>Christian / Religious Artist?</label>
            <div
              onClick={() => setIsReligious(!isReligious)}
              style={{
                width: '50px', height: '26px', background: isReligious ? 'var(--color-flagblue)' : '#ccc',
                borderRadius: '13px', position: 'relative', cursor: 'pointer', transition: '0.3s'
              }}
            >
              <div style={{
                width: '20px', height: '20px', background: '#fff', borderRadius: '50%',
                position: 'absolute', top: '3px', left: isReligious ? '27px' : '3px', transition: '0.3s'
              }} />
            </div>
          </div>

          <button type="submit" disabled={loading} style={{ padding: '18px', background: 'var(--color-flagblue)', color: '#fff', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '0.1em' }}>
            {loading ? 'Processing...' : selectedArtistId ? 'Update Archive Entry' : 'Save New Artist'}
          </button>
        </form>
      </section>
    </div>
  );
}

const inputStyle = {
  padding: '12px',
  borderRadius: '8px',
  border: '1px solid #ddd',
  fontFamily: 'inherit'
};
