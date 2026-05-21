import { supabase } from "@/lib/supabase";

export default async function DebugPage() {
  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("*")
    .limit(5);

  console.log("DEBUG VIEW:", data, error);

  return (
    <pre>{JSON.stringify({ data, error }, null, 2)}</pre>
  );
}
