import "dotenv/config";
import fs from "fs";
import path from "path";
import fetch from "node-fetch";
import { getSupabaseClient } from "../src/lib/supabase";

const supabase = getSupabaseClient();

// Wikipedia API endpoint
const WIKI_API =
  "https://en.wikipedia.org/w/api.php?action=query&prop=pageimages&format=json&pithumbsize=600&origin=*";

async function fetchWikipediaImage(artistName: string) {
  const url =
    "https://en.wikipedia.org/w/api.php" +
    "?action=query" +
    "&prop=pageimages|pageterms" +
    "&format=json" +
    "&piprop=thumbnail|original" +
    "&pithumbsize=800" +
    "&redirects=1" +
    "&origin=*" +
    `&titles=${encodeURIComponent(artistName)}`;

  try {
    const res = await fetch(url);
    const text = await res.text();

    // Wikipedia sometimes returns HTML (rate limit, captcha, redirect)
    if (text.startsWith("<")) {
      console.log(`Wikipedia returned HTML for ${artistName} — skipping.`);
      return null;
    }

    const json = JSON.parse(text);

    const pages = json.query?.pages;
    if (!pages) return null;

    const page = Object.values(pages)[0] as any;

    // Try all possible image fields
    const image =
      page?.thumbnail?.source ||
      page?.original?.source ||
      page?.pageimage ||
      null;

    return image;
  } catch (err) {
    console.error("Wikipedia error:", err);
    return null;
  }
}


async function downloadImage(url: string, filename: string) {
  const res = await fetch(url);
  const buffer = await res.arrayBuffer();
  const filePath = path.join("tmp", filename);

  fs.writeFileSync(filePath, Buffer.from(buffer));
  return filePath;
}

async function uploadToSupabase(localPath: string, storagePath: string) {
  const fileBuffer = fs.readFileSync(localPath);

  const { data, error } = await supabase.storage
    .from("artist-images")
    .upload(storagePath, fileBuffer, {
      contentType: "image/jpeg",
      upsert: true,
    });

  if (error) {
    console.error("Upload error:", error);
    return null;
  }

  const { data: publicUrl } = supabase.storage
    .from("artist-images")
    .getPublicUrl(storagePath);

  return publicUrl.publicUrl;
}

async function updateArtistImage(artistId: string, imageUrl: string) {
  await supabase
    .from("artists")
    .update({ image_url: imageUrl })
    .eq("id", artistId);
}

async function run() {
  console.log("Fetching artists…");

  const { data: artists } = await supabase
    .from("artists")
    .select("id, name, image_url");

  if (!artists) {
    console.error("No artists found.");
    return;
  }

  // Ensure tmp folder exists
  if (!fs.existsSync("tmp")) fs.mkdirSync("tmp");

  for (const artist of artists) {
    if (artist.image_url) {
      console.log(`Skipping ${artist.name} — already has image.`);
      continue;
    }

    console.log(`Searching Wikipedia for: ${artist.name}`);

    const wikiImage = await fetchWikipediaImage(artist.name);

    if (!wikiImage) {
      console.log(`No image found for ${artist.name}`);
      continue;
    }

    const filename = `${artist.id}.jpg`;
    const localPath = await downloadImage(wikiImage, filename);

    const storagePath = `artists/${filename}`;
    const publicUrl = await uploadToSupabase(localPath, storagePath);

    if (publicUrl) {
      await updateArtistImage(artist.id, publicUrl);
      console.log(`Updated ${artist.name} → ${publicUrl}`);
    }

    // Respect Wikipedia API rate limits
    await new Promise((r) => setTimeout(r, 1200));
  }

  console.log("Done.");
}

run();
