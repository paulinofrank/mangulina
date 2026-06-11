import type { Metadata } from "next";
import Link from "next/link";
import type { ComponentType } from "react";
import {
  FaFacebook,
  FaInstagram,
  FaYoutube,
} from "react-icons/fa6";
import {
  Building2,
  CircleHelp,
  Copyright,
  FilePenLine,
  Mail,
  UserRoundCheck,
  UsersRound,
} from "lucide-react";

export const metadata: Metadata = {
  title: "Contact | Mangulina",
  description:
    "Contact Mangulina for artist updates, corrections, contributor opportunities, partnerships, copyright inquiries, and general questions about Dominican music.",
  alternates: { canonical: "/contact" },
};

type ContactCard = {
  title: string;
  description: string;
  buttonLabel: string;
  href: string;
  Icon: ComponentType<{ className?: string; "aria-hidden"?: boolean }>;
};

const CONTACT_CARDS: ContactCard[] = [
  {
    title: "Artist & Representatives",
    description:
      "Need to update a biography, add missing releases, submit corrections, provide official information, or enrich an artist profile?",
    buttonLabel: "Contact Artist Support",
    href: "mailto:artists@mangulina.do",
    Icon: UserRoundCheck,
  },
  {
    title: "Submit a Correction",
    description:
      "Found inaccurate information, missing credits, incorrect dates, or other data issues?",
    buttonLabel: "Report an Issue",
    href: "mailto:corrections@mangulina.do",
    Icon: FilePenLine,
  },
  {
    title: "Become a Contributor",
    description:
      "Interested in helping preserve Dominican music through research, documentation, historical information, or editorial review?",
    buttonLabel: "Become a Contributor",
    href: "/contributors",
    Icon: UsersRound,
  },
  {
    title: "Media & Partnerships",
    description:
      "Press inquiries, educational institutions, cultural organizations, archives, and collaboration opportunities.",
    buttonLabel: "Contact Partnerships",
    href: "mailto:partnerships@mangulina.do",
    Icon: Building2,
  },
  {
    title: "Copyright & DMCA",
    description:
      "Questions about copyright, attribution, images, or intellectual property concerns?",
    buttonLabel: "Copyright & DMCA",
    href: "/dmca",
    Icon: Copyright,
  },
  {
    title: "General Questions",
    description: "For anything not covered above.",
    buttonLabel: "General Contact",
    href: "mailto:hello@mangulina.do",
    Icon: CircleHelp,
  },
];

const SOCIAL_LINKS = [
  {
    icon: FaFacebook,
    label: "Facebook",
    href: "https://facebook.com/MangulinaDO",
  },
  {
    icon: FaInstagram,
    label: "Instagram",
    href: "https://instagram.com/MangulinaDO",
  },
  {
    icon: FaYoutube,
    label: "YouTube",
    href: "https://youtube.com/@MangulinaDO",
  },
];

const EMAIL_DIRECTORY = [
  "hello@mangulina.do",
  "artists@mangulina.do",
  "corrections@mangulina.do",
  "partnerships@mangulina.do",
  "copyright@mangulina.do",
];

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

export default function ContactPage() {
  return (
    <main className="mx-auto max-w-5xl px-6 pb-3 pt-20 sm:pt-32">
      <header className="mb-12 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>Contact</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          Get in Touch
        </h1>

        <div className="max-w-4xl space-y-4 text-lg leading-relaxed text-gray-700 sm:text-xl">
          <p>
            Whether you are an artist, researcher, contributor, rights holder,
            or music enthusiast, we would love to hear from you.
          </p>
          <p>
            Mangulina welcomes corrections, collaborations, historical
            research, artist updates, and general inquiries related to
            Dominican music.
          </p>
        </div>
      </header>

      <div className="space-y-10">
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>How Can We Help?</SectionEyebrow>

          <p className="max-w-3xl text-lg leading-relaxed text-gray-700">
            Choose the contact area that best matches your inquiry so it can
            reach the right part of the Mangulina team.
          </p>

          <div className="mt-7 grid gap-5 md:grid-cols-2">
            {CONTACT_CARDS.map(({ title, description, buttonLabel, href, Icon }) => (
              <article
                key={title}
                className="flex min-h-72 flex-col rounded-2xl border border-black/5 bg-[#FAF9F6] p-6 sm:p-7"
              >
                <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-[#002D62]/8 text-[#002D62]">
                  <Icon className="h-6 w-6" aria-hidden={true} />
                </div>

                <h2 className="mt-5 text-xl font-bold text-[#002D62]">
                  {title}
                </h2>
                <p className="mt-3 flex-1 text-base leading-relaxed text-gray-700">
                  {description}
                </p>

                <Link
                  href={href}
                  className="mt-6 inline-flex w-fit rounded-full bg-[#8B0000] px-5 py-2.5 text-center text-xs font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
                >
                  {buttonLabel}
                </Link>
              </article>
            ))}
          </div>
        </section>

        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-10">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            Follow Mangulina
          </p>

          <p className="max-w-3xl text-lg leading-relaxed text-white/90">
            Follow <strong>@MangulinaDO</strong> for project news, featured
            artists, Dominican music history, and database updates.
          </p>

          <div className="mt-7 grid gap-4 sm:grid-cols-3">
            {SOCIAL_LINKS.map(({ icon: Icon, label, href }) => (
              <a
                key={label}
                href={href}
                target="_blank"
                rel="noopener noreferrer"
                className="group flex items-center gap-4 rounded-2xl border border-white/15 bg-white/10 p-5 transition hover:border-white/30 hover:bg-white/15"
              >
                <span className="flex h-11 w-11 items-center justify-center rounded-full bg-white text-[#002D62]">
                  <Icon className="h-5 w-5" aria-hidden={true} />
                </span>
                <span>
                  <span className="block font-semibold text-white">{label}</span>
                  <span className="mt-0.5 block text-sm text-white/70">
                    @MangulinaDO
                  </span>
                </span>
              </a>
            ))}
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Email Directory</SectionEyebrow>

          <p className="max-w-3xl text-lg leading-relaxed text-gray-700">
            Contact the appropriate inbox directly. General questions can be
            sent to hello@mangulina.do.
          </p>

          <div className="mt-7 grid gap-4 sm:grid-cols-2">
            {EMAIL_DIRECTORY.map((email) => (
              <a
                key={email}
                href={`mailto:${email}`}
                className="flex items-center gap-4 rounded-2xl border border-[#002D62]/10 bg-[#002D62]/3 p-5 text-[#002D62] transition hover:border-[#8B0000]/25 hover:bg-[#8B0000]/3 hover:text-[#8B0000]"
              >
                <Mail className="h-5 w-5 shrink-0" aria-hidden={true} />
                <span className="min-w-0 break-all font-semibold">{email}</span>
              </a>
            ))}
          </div>
        </section>

        <section className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/3 p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Help Preserve Dominican Music</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              Mangulina grows through the contributions of artists, historians,
              researchers, collectors, music professionals, and passionate fans.
            </p>
            <p>
              If you have information that can help document Dominican music
              more accurately, we would love to hear from you.
            </p>
          </div>

          <div className="mt-8 flex flex-col gap-3 sm:flex-row">
            <Link
              href="/contributors"
              className="rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
            >
              Become a Contributor
            </Link>
            <a
              href="mailto:hello@mangulina.do"
              className="rounded-full border border-[#002D62]/20 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-[#002D62] transition-colors hover:bg-[#002D62]/5"
            >
              Contact Us
            </a>
          </div>
        </section>
      </div>
    </main>
  );
}
