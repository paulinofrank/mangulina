interface SectionTitleProps {
  children: React.ReactNode;
}

export default function SectionTitle({ children }: SectionTitleProps) {
  return (
    <h2 className="text-xs font-normal tracking-wider text-[#002D62]/70 uppercase">
      {children}
    </h2>
  );
}
