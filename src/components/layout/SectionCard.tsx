export default function SectionCard({
  children,
  className = "",
}: {
  children: React.ReactNode;
  className?: string;
}) {
  return (
    <section
      className={`
        relative overflow-hidden 
        rounded-xl 
        border border-black/5 
        bg-white/60 
        backdrop-blur-md 
        shadow-sm 
        px-5 py-6 sm:px-6
        ${className}
      `}
    >
      {children}
    </section>
  );
}
