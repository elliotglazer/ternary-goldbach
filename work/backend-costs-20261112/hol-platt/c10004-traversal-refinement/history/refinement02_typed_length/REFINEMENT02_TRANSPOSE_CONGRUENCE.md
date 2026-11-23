# Use the proved rectangular input equality

Refinement01 passed pair lookup reconstruction, arbitrary-input pair/chunk contracts and rectangular reconstruction. The transpose proof reduced to transporting its result across that already proved rectangular input equality. Its final simplification did not perform that congruence, so the proof now finishes with first-order equality reasoning. No function, theorem conclusion or premise changes. The previous source, receipts and saved state remain under history/refinement01_transpose_congruence.
