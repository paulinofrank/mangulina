'use client';

import { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase';

export default function AdminDashboard() {
  // Data State
  const [artists, setArtists] = useState<any[]>([]);
  const [featuredId, setFeaturedId] = useState<string>('');
  const [loading, setLoading] = useState(false);

  // Form State for New Artist
  const [newName, setNewName] = useState('');
  const [newRegion, setNewRegion] = useState('');
  const [newGenre, setNewGenre] = useState('');

  // 1. Load data on mount
  useEffect(() => {
    fetchData();
  }, []);

  async function fetchData() {
    // Get all artists for the list and dropdown
    const { data: artistsData, error: aError } = await supabase
      .from('artists')
      .select('*')
      .order('name', { ascending: true });
    
    if (artistsData) setArtists(artistsData);
    if (aError) console.error('Error fetching artists:', aError);

    // Get current featured artist
    const { data: featData } = await supabase
      .from('featured_artist')
      .select('artist_id')
      .maybeSingle();
    
    if (featData) setFeaturedId(featData.artist_id);
  }

  // 2. Handle Update Featured
  async function updateFeatured() {
    setLoading(true);
    // Uses upsert on ID 1 to ensure we only ever have one featured row
    const { error } = await supabase
      .from('featured_artist')
      .upsert({ id: 1, artist_id: featuredId });

    if (error) {
      alert('Failed to update featured artist: ' + error.message);
    } else {
      alert('Success! Homepage updated.');
      fetchData();
    }
    setLoading(false);
  }

  // 3. Handle Add New Artist
  async function addArtist(e: React.FormEvent) {
    e.preventDefault();
    if (!newName) return;

    const { error } = await supabase
      .from('artists')
      .insert([{ 
        name: newName, 
        origin_region: newRegion, 
        genre: newGenre 
      }]);

    if (error) {
      alert('Error adding artist: ' + error.message);
    } else {
      alert(`${newName} added to database!`);
      setNewName('');
      setNewRegion('');
      setNewGenre('');
      fetchData(); // Refresh the list
    }
  }

  // 4. Handle Delete Artist (Careful!)
  async function deleteArtist(id: string) {
    if (!confirm('Are you sure? This will remove the artist from the database.')) return;

    const { error } = await supabase.from('artists').delete().eq('id', id);
    if (error) alert(error.message);
    else fetchData();
  }

  return (
    <div style={{ padding: '40px', maxWidth: '900px', margin: '0 auto', fontFamily: 'system-ui, sans-serif', color: '#333' }}>
      <h1 style={{ fontSize: '2rem', marginBottom: '10px' }}>DOMIDB Control Center</h1>
      <p style={{ color: '#666', marginBottom: '30px' }}>Manage your database content and homepage spotlight.</p>
      
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '40px' }}>
        
        {/* LEFT COLUMN: MANAGEMENT */}
        <div>
          <section style={{ background: '#f9f9f9', padding: '20px', borderRadius: '12px', border: '1px solid #eee', marginBottom: '30px' }}>
            <h2 style={{ marginTop: 0 }}>Spotlight Settings</h2>
            <p style={{ fontSize: '0.9rem', color: '#555' }}>Choose who appears in the Featured Artist section.</p>
            
            <div style={{ display: 'flex', gap: '10px', marginTop: '15px' }}>
              <select 
                value={featuredId} 
                onChange={(e) => setFeaturedId(e.target.value)}
                style={{ flex: 1, padding: '10px', borderRadius: '6px', border: '1px solid #ccc' }}
              >
                <option value="">-- Select Artist --</option>
                {artists.map(a => (
                  <option key={a.id} value={a.id}>{a.name}</option>
                ))}
              </select>
              <button 
                onClick={updateFeatured} 
                disabled={loading || !featuredId}
                style={{ padding: '10px 20px', background: '#000', color: '#fff', border: 'none', borderRadius: '6px', cursor: 'pointer', opacity: loading ? 0.5 : 1 }}
              >
                Update Homepage
              </button>
            </div>
          </section>

          <section style={{ background: '#fff', padding: '20px', borderRadius: '12px', border: '1px solid #eee' }}>
            <h2 style={{ marginTop: 0 }}>Add New Artist</h2>
            <form onSubmit={addArtist} style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
              <input 
                placeholder="Artist Name (e.g. Fefita la Grande)" 
                value={newName} 
                onChange={e => setNewName(e.target.value)} 
                required 
                style={{ padding: '10px', borderRadius: '6px', border: '1px solid #ccc' }}
              />
              <input 
                placeholder="Origin Region (e.g. Santiago)" 
                value={newRegion} 
                onChange={e => setNewRegion(e.target.value)} 
                style={{ padding: '10px', borderRadius: '6px', border: '1px solid #ccc' }}
              />
              <input 
                placeholder="Genre (e.g. Merengue Típico)" 
                value={newGenre} 
                onChange={e => setNewGenre(e.target.value)} 
                style={{ padding: '10px', borderRadius: '6px', border: '1px solid #ccc' }}
              />
              <button 
                type="submit" 
                style={{ padding: '12px', background: '#8B0000', color: '#fff', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 'bold' }}
              >
                Save to Database
              </button>
            </form>
          </section>
        </div>

        {/* RIGHT COLUMN: LIST */}
        <div style={{ borderLeft: '1px solid #eee', paddingLeft: '40px' }}>
          <h2 style={{ marginTop: 0 }}>Current Artist List ({artists.length})</h2>
          <div style={{ maxHeight: '500px', overflowY: 'auto', marginTop: '20px' }}>
            {artists.map(artist => (
              <div 
                key={artist.id} 
                style={{ 
                  display: 'flex', 
                  justifyContent: 'space-between', 
                  alignItems: 'center', 
                  padding: '12px 0', 
                  borderBottom: '1px solid #f0f0f0' 
                }}
              >
                <div>
                  <strong>{artist.name}</strong>
                  <div style={{ fontSize: '0.8rem', color: '#888' }}>{artist.origin_region || 'No Region'} • {artist.genre || 'No Genre'}</div>
                </div>
                <button 
                  onClick={() => deleteArtist(artist.id)}
                  style={{ color: '#ff4444', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.8rem' }}
                >
                  Delete
                </button>
              </div>
            ))}
          </div>
        </div>

      </div>
    </div>
  );
}