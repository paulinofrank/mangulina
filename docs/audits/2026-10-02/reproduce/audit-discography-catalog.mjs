import 'dotenv/config';
import pg from 'pg';
import {writeFile} from 'node:fs/promises';
const client=new pg.Client({connectionString:process.env.DATABASE_URL,connectionTimeoutMillis:15000});
const queries={
artists:'select id,name,slug,status,primary_role,birth_year,death_year,formation_year from artists',
recordings:'select id,title,slug,artist_id,work_id,release_id,recording_year,mbid,metadata from recordings',
releases:'select id,title,slug,release_artist_id,release_year,type,release_group_id,mbid,metadata from releases',
tracks:'select id,release_id,recording_id,title_override,track_number,disc_number from tracks',
recording_credits:'select id,recording_id,artist_id,external_contributor_id,role,role_id,credited_as,metadata,created_at from recording_credits',
release_artists:'select * from release_artists',
works:'select * from works',work_credits:'select * from work_credits',
credited_works:'select * from credited_works',credited_work_credits:'select * from credited_work_credits',
work_credit_sources:'select * from work_credit_sources',credit_roles:'select * from credit_roles',
public_song_recordings:'select id,title,artist_id,artist_name,work_id from public_song_recordings'
};
try {await client.connect();await client.query('BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY');await client.query("SET LOCAL statement_timeout='60s'");
const data={snapshotAt:new Date().toISOString(),mode:'read-only'};
for(const [key,sql] of Object.entries(queries)){data[key]=(await client.query(sql)).rows;console.log(key,data[key].length)}
await writeFile('docs/audits/2026-10-02/catalog-snapshot.json',JSON.stringify(data,null,2));await client.query('ROLLBACK');
}catch(e){console.error(e.code??'',e.message.replace(/postgres(?:ql)?:\/\/\S+/g,'[redacted]'));process.exitCode=1}finally{await client.end()}
