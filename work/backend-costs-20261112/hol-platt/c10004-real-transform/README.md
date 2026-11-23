# Two-height native transform

The two spectrum files give all 2,301 primitive positive frequencies for conductor 10004 at s = 1/2 + 5hi/64, h = 1, 2. Columns re and im are integer centers on the 2^-81 grid. The last column bounds the complex absolute error in grid units for the unnormalized sum of the character-weighted Hurwitz values. The fastest index is k61, and k4 is always 1. These inputs come from the direct Arb Hurwitz reference. The historical translated polynomial producer and the canonical signed completion have separate obligations.

reference.py follows the selected tensor in ../c10004-transform/C10004TransformScript.sml. All leaves, bridges, omitted zero modes, axis order and positive-infinity tie rounding follow the SML equations. The checker computes a separate direct dot product on each axis. It uses exact integer numerators and rounds once after summation. Thus its evaluation order differs from the recursive rounded transform. The six checks in character_check.py also use independent FLINT Dirichlet L evaluations, multiplied by 10004^s.

For the error calculation, write S = 2^81 and express center and radius in grid units. The rounded Hurwitz source has Euclidean radius below 1. A nonspecial root differs from its true unit root by less than 1/S in complex absolute value, from the coordinate isolation bins in ../c10004-roots. At a direct dot product, the error for a term with input center c and radius e is bounded by e + |c|/S. This follows by multiplying the input error by the exact unit root and the root approximation error by c. Roots on coordinate axes incur only e. Summation adds the radii. Rounding both center coordinates after the sum adds less than 1. The code uses integer ceilings throughout and adds the measured distance from the resulting direct center to the recursive integer output. These bounds rely on the native source rounding and root isolation checks. The calculation and timings here are native, outside the HOL kernel.

| h | CT seconds | Direct seconds | Max center gap, grid units | Max error bound, grid units |
|---|---:|---:|---:|---:|
| 1 | 0.093 | 0.481 | 528 | 13,299 |
| 2 | 0.086 | 0.443 | 540 | 13,391 |

Each CT applies 24,720 rounded three-product actions and performs 37,821 complex additions or subtractions outside those actions. The timed CT region includes Python counter updates. Receipt files record hashes, file sizes and timings. For Conrey labels 3, 3335 and 7 across the two heights, the largest discrepancy from the independently evaluated L-value times 10004^s was below 141 grid units. The native wall times measure these two nodes only.

## Signed conductor-completed values

completed.py uses the campaign's Hardy normalization Z = epsilon (q/pi)^((s+a)/2) Gamma((s+a)/2) L(s,chi). The integer spectra enclose q^s L(s,chi). Each input complex disk is covered by a rectangle of the same coordinate half-widths. At 176 bits, Arb propagates those rectangles through the phase and the shared gamma/conductor factors for each parity and height. Every imaginary projection contained zero. The reality of the exact function follows from the primitive functional equation with the chosen phase.

The positive character transform of exp(2 pi i r/q) gives the Gauss sum. Parity is (1+k41+k61) mod 2 because the local generators represent minus one at exponents 1, 20 and 30. Dividing the sum by i^a sqrt(q) gives W. The campaign two-chart plan permits a fixed overlap rule and representative ordering. This run chooses the lexicographically smaller frequency pair, uses the positive-real chart whenever Re(W)>-1/2 is certified, and otherwise uses the positive-imaginary chart after certifying Re(W)<1/2. The partner takes the conjugate phase. The choice holds at both heights. Among the 1,151 orbits, 761 used the positive-real chart and 390 the positive-imaginary chart. The self-inverse label (20,30) has real unit W, and its enclosure excluded -1, so W=1 and epsilon=1. The signed values refer to these explicit choices. Multiplication by an additional strictly positive damping factor in other campaign observables preserves the signs but changes the distances below.

| Height | Positive | Negative | Inconclusive | Lower bound for smallest absolute value | Minimizing channel (k41,k61) |
|---|---:|---:|---:|---:|---|
| 5/64 | 1,732 | 569 | 0 | 0.054714599808 | (26,11) |
| 10/64 | 1,679 | 622 | 0 | 0.020481192915 | (8,31) |

153 channels had opposite endpoint signs. Single-worker wall time was 0.373 seconds for the shared Gauss and phase tables and 0.057 and 0.050 seconds for the two completion passes, including writing the rows. completed-receipt.json binds both integer-spectrum inputs and completed outputs. The native diagnostic covers these two heights. Formal source, phase and completion adapters and any zero-count closure remain separate work.
