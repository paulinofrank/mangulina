function Pagination({
  currentPage,
  totalPages,
  onPageChange,
}: {
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
}) {

  if (totalPages <= 1) return null;

  return (
    <section className="pagination-container">

      {/* LEFT */}
      <div className="flex gap-2">
        <button
          onClick={() => onPageChange(1)}
          disabled={currentPage === 1}
          className="pagination-btn"
        >
          First
        </button>

        <button
          onClick={() => onPageChange(currentPage - 1)}
          disabled={currentPage === 1}
          className="pagination-btn"
        >
          Previous
        </button>
      </div>

      {/* CENTER */}
      <div className="hidden sm:flex flex-col items-center">
        <span className="text-[10px] uppercase tracking-[0.3em] text-gray-500">
          Page {currentPage} of {totalPages}
        </span>
      </div>

      {/* RIGHT */}
      <div className="flex gap-2">
        <button
          onClick={() => onPageChange(currentPage + 1)}
          disabled={currentPage === totalPages}
          className="pagination-btn"
        >
          Next
        </button>

        <button
          onClick={() => onPageChange(totalPages)}
          disabled={currentPage === totalPages}
          className="pagination-btn"
        >
          Last
        </button>
      </div>

    </section>
  );
}
