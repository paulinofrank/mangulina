export default function SectionCard({
  children,
  className = "",
  compact = false,
}: {
  children: React.ReactNode;
  className?: string;
  compact?: boolean;
}) {
  const paddingClass = compact ? "px-5 pt-4 pb-3 sm:px-6" : "px-5 py-6 sm:px-6";

  return (
    <section
      className={`
        relative overflow-hidden 
        rounded-xl 
        border border-black/5 
        bg-white/60 
        backdrop-blur-md 
        shadow-sm 
        ${paddingClass}
        ${className}
      `}
    >
      {children}
    </section>
  );
}
