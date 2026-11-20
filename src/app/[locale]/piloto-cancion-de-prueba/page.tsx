import { notFound } from "next/navigation";
import { setRequestLocale } from "next-intl/server";
import SongPersonnelCredits from "@/components/organisms/SongPersonnelCredits";
import type { CreditItem } from "@/components/organisms/SongCreditsSection";

export const metadata = { robots: { index: false, follow: false } };

const workCredits: CreditItem[] = [
  { role: "composer", name: "Juan Luis Guerra" },
  { role: "lyricist", name: "Techy Fatule" },
];

const recordingCredits: CreditItem[] = [
  { role: "lead_performer", name: "Pablo Martínez", slug: "pablo-martinez" },
  { role: "featured_performer", name: "Alex Bueno" },
  { role: "guest_performer", name: "Sandy Reyes" },
  { role: "backing_vocalist", name: "Milly Quezada" },
  { role: "arranger", name: "Ramón Orlando" },
  { role: "musical_director", name: "Dioni Fernández" },
  { role: "conductor", name: "José Antonio Molina" },
  { role: "producer", name: "Virgilio Feliz" },
  { role: "co_producer", name: "Luis Armando Rivera" },
  { role: "executive producer", name: "Techy Fatule" },
  { role: "beat_programmer", name: "Chris Hierro" },
  { role: "recording_engineer", name: "Arturo Piña" },
  { role: "recording_engineer", name: "Germán Lorenzo" },
  { role: "mixing_engineer", name: "Virgilio Feliz" },
  { role: "mastering_engineer", name: "Manuel Tejada" },
  ...[
    ["Guandulito", "guira", "Güira", "Güira"],
    ["Rafaelito Román", "tambora", "Tambora", "Tambora"],
    ["Johnny Ventura", "congas", "Congas", "Congas"],
    ["Ramón Orlando", "piano", "Piano", "Piano"],
    ["Max Santos", "bass_guitar", "Bass guitar", "Bajo eléctrico"],
    ["Juan Luis Guerra", "guitar", "Guitar", "Guitarra"],
    ["Guy Frómeta", "drums", "Drums", "Batería"],
    ["Sandy Gabriel", "saxophone", "Saxophone", "Saxofón"],
    ["Wilfrido Vargas", "trumpet", "Trumpet", "Trompeta"],
    ["Aisha Syed Castro", "violin", "Violin", "Violín"],
  ].map(([name, code, name_en, name_es]) => ({
    role: "instrumentalist",
    name,
    instruments: [{ code, name_en, name_es }],
  })),
];

export default async function PilotSongPage({ params }: { params: Promise<{ locale: string }> }) {
  if (process.env.NODE_ENV !== "development") notFound();
  const { locale } = await params;
  setRequestLocale(locale);
  const spanish = locale === "es";

  return (
    <main className="mx-auto max-w-5xl space-y-5 px-5 py-10">
      <p className="rounded-lg border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-950">
        {spanish
          ? "Piloto local. El single y todas las participaciones son ficticios."
          : "Local preview. The single and all credits are fictional."}
      </p>
      <header className="rounded-xl border border-black/5 bg-white/60 p-6">
        <h1 className="text-4xl font-black text-[#002D62]">Canción de Prueba</h1>
        <p className="mt-2 text-xl font-semibold text-gray-600">El Equipo de Dioni Fernández</p>
        <p className="mt-3 text-sm text-gray-600">Single · Merengue</p>
      </header>
      <SongPersonnelCredits workCredits={workCredits} recordingCredits={recordingCredits} />
    </main>
  );
}
