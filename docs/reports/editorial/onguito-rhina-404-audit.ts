import fs from 'node:fs';
import dotenv from 'dotenv';
import {createClient} from '@supabase/supabase-js';
dotenv.config({quiet:true});
const db=createClient(process.env.NEXT_PUBLIC_SUPABASE_URL||process.env.SUPABASE_URL!,process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY||process.env.SUPABASE_ANON_KEY!,{auth:{persistSession:false,autoRefreshToken:false}});
const results=[];
for(const slug of ['onguito-wa','rhina-ramirez']){
 const row=await db.from('artists').select('id,name,slug,status').eq('slug',slug).eq('status','published').maybeSingle();
 const rpc=await db.rpc('get_artist_profile_page',{artist_slug:slug});
 const url=`https://mangulina.do/es/artists/${slug}`;
 const response=await fetch(url); const html=await response.text();
 results.push({slug,publicRow:row.data,rowError:row.error?.message??null,rpcArtist:rpc.data?{id:rpc.data.id,name:rpc.data.name,slug:rpc.data.slug}:null,rpcError:rpc.error?.message??null,url,httpStatus:response.status,headers:Object.fromEntries(['age','x-vercel-cache','x-nextjs-cache','x-nextjs-prerender','cache-control'].map(k=>[k,response.headers.get(k)])),title:html.match(/<title>(.*?)<\/title>/s)?.[1],hasNotFound:html.includes('NEXT_HTTP_ERROR_FALLBACK;404')});
}
fs.writeFileSync(`docs/reports/editorial/onguito-rhina-404-${process.argv.includes('--after')?'after':'audit'}.json`,JSON.stringify({checkedAt:new Date().toISOString(),results},null,2));console.log(JSON.stringify(results));
