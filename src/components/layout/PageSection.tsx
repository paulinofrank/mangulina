export default function PageSection({
  children,
  className = "",
}: {
  children: React.ReactNode;
  className?: string;
}) {
  return (
    <section className={`my-4 mx-4 sm:mx-8 lg:mx-12 ${className}`}>
      {children}
    </section>
  );
}
