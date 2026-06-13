import "dotenv/config";
import { readFileSync } from "node:fs";
import pg from "pg";

const file = process.argv[2];
if (!file) {
  console.error("Usage: tsx apply-migration.ts <path-to-sql>");
  process.exit(1);
}

const sql = readFileSync(file, "utf8");
const client = new pg.Client({ connectionString: process.env.DATABASE_URL });

try {
  await client.connect();
  await client.query(sql);
  console.log(`Applied ${file} successfully.`);
} catch (error) {
  console.error(`Migration failed (transaction rolled back): ${error.message}`);
  process.exitCode = 1;
} finally {
  await client.end();
}
