# Conductor 10004 raw Fourier head

The HOL4 theorem `c10004_raw_head_error` covers every integer numerator from 1 through 10004 and every height index from 0 through 84200. The deterministic integer head, divided by 2^100, approximates

    exp ((-1/2 - i*5*h/64) * log (a/10004))

within Euclidean error 2^-85. Its inputs are the stored grid120 state pairs. The integer recurrence multiplies a stored state by a grid122 step, then rounds the result back to grid120. The terminal head uses the product in grid240 and rounds once by 2^140 to reach grid100.

The proof bounds terminal rounding by 2^-100. An arbitrary numerator state contributes at most 2^-96. The conductor state has the stronger bound (3/5)2^-98, obtained by checking its initial inverse-square-root integer and propagating its error through 84200 steps. Its exact norm is at most 1/100. After multiplication by 10004, the combined budget occupies 0.781594 of the 2^-85 allowance (rounded up).

`rawhead02.log` records both exported theories. The build took 45.37 CPU seconds with an 861792 KiB peak. A separate process loaded the exported theories, checked four exact conclusions, hypotheses, theorem tags and the allowed axioms. Its audit run took 15.41 CPU seconds with a 772180 KiB peak. The receipt is `rawheadaudit01.log` and the file digests are in `rawheadaudit01_output.sha256`.

At h=1, `h1-head-match/H1FiniteHeadsScript.sml` certifies all 4800 archived grid100 head pairs against this integer construction. The fresh audit also matched all 300 packed numbers to the heads used by `C10004FullAdmission.full_admit` and `C10004FullIdentity.full_identity`, and re-encoded the original TSV in residue order. The receipt is `h1-head-match/matchaudit02.log`. The archived implementation and the deterministic producer have one real and five imaginary grid122 step-coordinate differences across the 4801 states. Their emitted grid100 heads agree at h=1.
