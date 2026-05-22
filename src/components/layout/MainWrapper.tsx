export default function MainWrapper({
  children,
  className = "",
}: {
  children: React.ReactNode;
  className?: string;
}) {
  return (
    <main className={`pt-16 pb-16 ${className}`}>
      {children}
    </main>
  );
}
