import type { Metadata } from "next";
import { FaFacebook, FaInstagram, FaYoutube, FaTiktok } from "react-icons/fa6";

export const metadata: Metadata = {
  title: "Contact | Mangulina",
  description:
    "Get in touch with the Mangulina team. Reach us through our social channels or by email for questions, artist submissions, or collaboration inquiries.",
  alternates: { canonical: "/contact" },
};

const SOCIAL_LINKS = [
  { icon: FaFacebook,  label: "Facebook",  href: "https://facebook.com/MangulinaDo" },
  { icon: FaInstagram, label: "Instagram", href: "https://instagram.com/MangulinaDo" },
  { icon: FaYoutube,   label: "YouTube",   href: "https://youtube.com/@MangulinaDo" },
  { icon: FaTiktok,    label: "TikTok",    href: "https://tiktok.com/@MangulinaDo" },
];

export default function ContactPage() {
  return (
    <main className="mx-auto max-w-2xl px-6 pt-20 pb-6 sm:pt-32 sm:pb-8">

      <header className="mb-12 border-b border-black/10 pb-10">
        <h1 className="mb-4 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          Contact
        </h1>
        <p className="text-lg leading-relaxed text-gray-600">
          Have a question, a suggestion, or want to collaborate? We&apos;d love to hear from you.
        </p>
      </header>

      <div className="space-y-10">

        {/* Email */}
        <section>
          <h2 className="mb-2 text-xs font-semibold uppercase tracking-widest text-gray-400">
            Email
          </h2>
          <a
            href="mailto:hello@mangulina.com"
            className="text-lg font-medium text-[#002D62] transition-colors hover:text-[#CE1126]"
          >
            hello@mangulina.com
          </a>
        </section>

        {/* Social */}
        <section>
          <h2 className="mb-4 text-xs font-semibold uppercase tracking-widest text-gray-400">
            Follow Us
          </h2>
          <div className="flex flex-wrap gap-3">
            {SOCIAL_LINKS.map(({ icon: Icon, label, href }) => (
              <a
                key={label}
                href={href}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2.5 rounded-full border border-black/10 bg-white px-5 py-2.5 text-sm font-medium text-gray-700 shadow-sm transition-all hover:border-[#002D62]/30 hover:text-[#002D62] hover:shadow-md"
              >
                <Icon className="h-4 w-4" />
                {label}
              </a>
            ))}
          </div>
        </section>

      </div>
    </main>
  );
}
