require("dotenv").config();
const {Client}=require("pg");
(async()=>{
 const c=new Client({connectionString:process.env.DATABASE_URL}); await c.connect();
 const {rows}=await c.query("select slug,name,status,first_name,last_name,second_last_name,birth_place,province,date_of_birth,facebook,instagram,youtube,updated_at,has_image from artists where slug='ronny-cruz'"); console.log(rows);
 console.log((await c.query("select slug,name,status,instagram,facebook,youtube from artists where name ilike 'o%to%cruz%' or slug ilike '%otto%cruz%' or slug ilike 'oto-cruz%'")).rows);
 console.log((await c.query("select count(*)::int n from artist_family_relationships")).rows);
 console.log((await c.query("select column_name from information_schema.columns where table_name='artist_family_relationships' order by ordinal_position")).rows.map(r=>r.column_name).join(","));
 await c.end();
})();
