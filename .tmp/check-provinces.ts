import { createClient } from "@supabase/supabase-js";
import * as fs from "fs";
import * as path from "path";
import * as dotenv from "dotenv";

// Load .env file
dotenv.config({ path: path.join(process.cwd(), ".env") });

// Dominican Republic provinces
const DOMINICAN_PROVINCES = [
  "Azua",
  "Bahoruco",
  "Barahona",
  "Dajabón",
  "Duarte",
  "Elías Piña",
  "El Seibo",
  "Espaillat",
  "Hato Mayor",
  "Hermanas Mirabal",
  "Independencia",
  "La Altagracia",
  "La Romana",
  "La Vega",
  "María Trinidad Sánchez",
  "Monseñor Nouel",
  "Monte Plata",
  "Pedernales",
  "Peravia",
  "Puerto Plata",
  "Samaná",
  "Sánchez Ramírez",
  "San Cristóbal",
  "San Juan",
  "San Pedro de Macorís",
  "Santiago",
  "Santiago Rodríguez",
  "Santo Domingo",
  "Valverde",
  "Distrito Nacional", // Old name, now part of Santo Domingo
];

async function checkProvinces() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) {
    throw new Error("Missing Supabase credentials");
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  console.log("Fetching provinces from artists table...\n");

  const { data, error } = await supabase
    .from("artists")
    .select("province")
    .eq("status", "published")
    .not("province", "is", null);

  if (error) {
    console.error("Error fetching data:", error);
    process.exit(1);
  }

  // Get unique provinces from the database
  const dbProvinces = new Set<string>();
  const provinceCounts = new Map<string, number>();

  for (const row of data ?? []) {
    const province = row.province?.trim();
    if (province) {
      dbProvinces.add(province);
      provinceCounts.set(province, (provinceCounts.get(province) ?? 0) + 1);
    }
  }

  console.log("=== PROVINCES IN DATABASE ===\n");
  const sortedDbProvinces = Array.from(dbProvinces).sort();
  for (const province of sortedDbProvinces) {
    const count = provinceCounts.get(province) || 0;
    console.log(`${province.padEnd(30)} (${count} artists)`);
  }

  console.log("\n=== DOMINICAN REPUBLIC PROVINCES ===\n");
  DOMINICAN_PROVINCES.forEach((p) => console.log(p));

  // Normalize for comparison (remove accents, lowercase)
  const normalize = (str: string) =>
    str
      .normalize("NFD")
      .replace(/[̀-ͯ]/g, "")
      .toLowerCase();

  const normalizedDbProvinces = new Set(Array.from(dbProvinces).map(normalize));
  const missingProvinces = DOMINICAN_PROVINCES.filter(
    (p) => !normalizedDbProvinces.has(normalize(p))
  );

  console.log("\n=== MISSING PROVINCES ===\n");
  if (missingProvinces.length === 0) {
    console.log("✓ All provinces have artists!");
  } else {
    console.log(`${missingProvinces.length} provinces without artists:\n`);
    missingProvinces.forEach((p) => console.log(`  • ${p}`));
  }

  console.log("\n=== SUMMARY ===");
  console.log(`Total Dominican provinces: ${DOMINICAN_PROVINCES.length}`);
  console.log(`Provinces with artists: ${dbProvinces.size}`);
  console.log(`Missing provinces: ${missingProvinces.length}`);
}

checkProvinces().catch(console.error);
