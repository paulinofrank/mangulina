import { createClient } from "@supabase/supabase-js";
import * as dotenv from "dotenv";
dotenv.config();

const supabase = createClient(process.env.SUPABASE_URL!, process.env.SUPABASE_SERVICE_ROLE_KEY!);

async function test() {
  const { data, error } = await supabase.storage
    .from('artists-images')
    .upload('test.txt', 'Hello World', { upsert: true });

  if (error) console.error("❌ Still 403:", error);
  else console.log("✅ 403 IS GONE! Upload successful.");
}
test();