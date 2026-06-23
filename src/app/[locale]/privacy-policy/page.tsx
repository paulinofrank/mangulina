import type { Metadata } from "next";
import { Link } from "@/i18n/navigation";
import { getTranslations } from "next-intl/server";
import { createPageMetadata } from "@/lib/seo";

export const metadata: Metadata = createPageMetadata({
  title: "Privacy Policy",
  description:
    "Read Mangulina's Privacy Policy and learn how information is collected, used, and protected on the Dominican Music Database.",
  path: "/privacy-policy",
});

type PrivacySection = {
  title: string;
  paragraphs: React.ReactNode[];
  items?: string[];
  secondaryItems?: string[];
  secondaryIntroduction?: string;
  closingParagraphs?: React.ReactNode[];
};

const PRIVACY_SECTIONS: PrivacySection[] = [
  {
    title: "1. Information We Collect",
    paragraphs: [
      "Mangulina may collect limited information when visitors use the website, including:",
    ],
    items: [
      "Browser type and version",
      "Device information",
      "Operating system",
      "Pages visited",
      "Referring websites",
      "Date and time of visits",
      "General geographic region based on IP address",
      "Website performance and analytics data",
    ],
    closingParagraphs: ["We do not sell personal information."],
  },
  {
    title: "2. Information You Voluntarily Provide",
    paragraphs: ["You may choose to provide information when:"],
    items: [
      "Contacting us",
      "Submitting corrections",
      "Suggesting additions or edits",
      "Reporting copyright concerns",
      "Participating as a contributor",
    ],
    secondaryIntroduction: "Information you voluntarily provide may include:",
    secondaryItems: [
      "Name",
      "Email address",
      "Organization or affiliation",
      "Message content",
    ],
    closingParagraphs: [
      "We only use this information to respond to inquiries and improve the accuracy of the database.",
    ],
  },
  {
    title: "3. Cookies and Analytics",
    paragraphs: [
      "Mangulina may use cookies or similar technologies to:",
    ],
    items: [
      "Improve website performance",
      "Understand visitor behavior",
      "Measure traffic and engagement",
      "Maintain website security",
    ],
    closingParagraphs: [
      "We may use analytics services to better understand how visitors interact with the website.",
      "Users may disable cookies through their browser settings, although some features may not function as intended.",
    ],
  },
  {
    title: "4. How We Use Information",
    paragraphs: ["Information collected through the website may be used to:"],
    items: [
      "Operate and maintain the website",
      "Improve content and user experience",
      "Respond to inquiries",
      "Investigate abuse or security issues",
      "Monitor website performance",
      "Preserve the accuracy and quality of the database",
    ],
  },
  {
    title: "5. Information Sharing",
    paragraphs: [
      "Mangulina does not sell, rent, or trade personal information.",
      "Information may be shared only when:",
    ],
    items: [
      "Required by law",
      "Necessary to protect legal rights",
      "Necessary to investigate fraud, abuse, or security incidents",
      "Required to operate services provided by trusted third-party vendors",
    ],
  },
  {
    title: "6. Third-Party Services",
    paragraphs: [
      "Mangulina may include links to external websites, including:",
    ],
    items: [
      "Artist websites",
      "Social media platforms",
      "Music streaming services",
      "Video platforms",
      "Other music-related resources",
    ],
    closingParagraphs: [
      "We are not responsible for the privacy practices of third-party websites.",
      "Visitors should review the privacy policies of those services separately.",
    ],
  },
  {
    title: "7. Data Security",
    paragraphs: [
      "We take reasonable measures to protect information from unauthorized access, misuse, alteration, or disclosure.",
      "However, no website or internet transmission can be guaranteed completely secure.",
    ],
  },
  {
    title: "8. Children's Privacy",
    paragraphs: [
      "Mangulina is intended as a general audience informational resource.",
      "We do not knowingly collect personal information from children under the age of 13.",
      "If such information is discovered, reasonable efforts will be made to remove it.",
    ],
  },
  {
    title: "9. International Visitors",
    paragraphs: [
      "Visitors may access Mangulina from countries outside the United States.",
      "By using the website, visitors understand that information may be processed and stored in jurisdictions where the website and its service providers operate.",
    ],
  },
  {
    title: "10. Changes to This Privacy Policy",
    paragraphs: [
      "We may update this Privacy Policy periodically.",
      <span key="updated-date">
        Any changes will be posted on this page together with an updated
        &quot;Last Updated&quot; date.
      </span>,
      "Continued use of the website after changes become effective constitutes acceptance of the revised policy.",
    ],
  },
  {
    title: "11. Contact",
    paragraphs: [
      <span key="contact-page">
        Questions regarding this Privacy Policy may be submitted through the{" "}
        <Link
          href="/contact"
          className="font-medium text-[#002D62] underline underline-offset-4 hover:text-[#8B0000]"
        >
          Contact page
        </Link>
        .
      </span>,
      <span key="dmca-page">
        Privacy requests, corrections, and concerns may also be submitted
        through the{" "}
        <Link
          href="/dmca"
          className="font-medium text-[#002D62] underline underline-offset-4 hover:text-[#8B0000]"
        >
          Copyright &amp; DMCA page
        </Link>{" "}
        when applicable.
      </span>,
    ],
  },
];

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

function PolicyList({ items }: { items: string[] }) {
  return (
    <ul className="list-disc space-y-3 pl-6">
      {items.map((item) => (
        <li key={item}>{item}</li>
      ))}
    </ul>
  );
}

export default async function PrivacyPolicyPage() {
  const t = await getTranslations("pages");

  return (
    <main className="mx-auto max-w-5xl px-6 pb-10 pt-20 sm:pb-16 sm:pt-32">
      <header className="mb-12 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>Privacy Policy</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          Privacy Policy
        </h1>

        <p className="max-w-3xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          Mangulina is committed to protecting your privacy. This Privacy
          Policy explains what information we collect, how we use it, and the
          choices available to visitors of the Dominican Music Database.
        </p>

        <p className="mt-6 text-sm text-gray-500">{t("privacyPolicy.lastUpdated")}</p>
      </header>

      <div className="space-y-10">
        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            Welcome to Mangulina
          </p>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
            <p>
              Welcome to Mangulina (&quot;Mangulina,&quot; &quot;we,&quot;
              &quot;our,&quot; or &quot;us&quot;).
            </p>
            <p>
              This Privacy Policy describes how information may be collected,
              used, and protected when you visit or interact with the Mangulina
              website.
            </p>
            <p>
              By using this website, you agree to the practices described in
              this Privacy Policy.
            </p>
          </div>
        </section>

        {PRIVACY_SECTIONS.map((section) => (
          <section
            key={section.title}
            className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10"
          >
            <SectionEyebrow>{section.title}</SectionEyebrow>

            <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
              {section.paragraphs.map((paragraph, index) => (
                <p key={index}>{paragraph}</p>
              ))}

              {section.items && <PolicyList items={section.items} />}

              {section.secondaryIntroduction && (
                <p>{section.secondaryIntroduction}</p>
              )}

              {section.secondaryItems && (
                <PolicyList items={section.secondaryItems} />
              )}

              {section.closingParagraphs?.map((paragraph, index) => (
                <p key={`closing-${index}`}>{paragraph}</p>
              ))}
            </div>
          </section>
        ))}

        <section className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/[0.03] p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Privacy Questions</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              If you have questions about this Privacy Policy, information you
              have voluntarily provided, or how Mangulina handles privacy
              concerns, please contact us.
            </p>
          </div>

          <div className="mt-8 flex flex-col gap-3 sm:flex-row">
            <Link
              href="/contact"
              className="rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
            >
              Contact Mangulina
            </Link>
            <Link
              href="/terms-of-use"
              className="rounded-full border border-[#002D62]/20 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-[#002D62] transition-colors hover:bg-[#002D62]/5"
            >
              Terms of Use
            </Link>
          </div>
        </section>
      </div>
    </main>
  );
}
