# Accuracy of the delayed-rounding conductor 10004 transform

All 9,204 primitive outputs at height indices 1, 2, 84198 and 84199 retained their previously recorded completed signs. The code recomputed packed numerators for those four lanes, rounded once at the output, evaluated an independent positive-exponent direct DFT with true Arb roots, and checked the original phase and completion. The packed source code and its root table are pinned in receipt.json. This is a native interval check.

## Error bound for arbitrary data

Write S=2^81 and express inputs and outputs in p81 grid units. Let X_a be the stored integer pair and let its Euclidean error from the true value in those units be at most e_a. Each approximate rotation uses a root whose error is strictly below 1/S. check.py compares every root-table entry with its own Arb evaluation of the true root. Trivial rotations are exact.

For every selected output and every input there is one path in the expansion. At a radix split, the input belongs to exactly one residue child and a fixed output selects exactly one child frequency v. Bridge and parent twiddles multiply that child's contribution. Induction first on the radix decomposition and then on the three tensor axes shows that the ideal path product is the exact positive character weight. Each path has at most d=9 potentially approximate roots. In fact individual paths may contain fewer. Special rotations, direct-row first terms and the radix-two signs receive the matching exact powers of S in the common-denominator representation. The final denominator relative to the input grid is S^9.

For exact roots w_j and approximants v_j, the product difference has norm at most (1+1/S)^d−1, by expanding the product of w_j+(v_j−w_j) and using |w_j|=1. Apply that error to the stored input. The ideal transform of the input error uses unit weights, so its norm is at most Σ e_a. Coordinate-nearest final rounding has Euclidean error at most 1/√2 grid unit. Thus a sufficient integer output radius is

    ceil(Σ e_a) + 1 + ceil(((1+1/S)^d−1) Σ ceil(|X_a|)).

This formula applies to source balls of arbitrary radii. Here the strict nearest-coordinate Hurwitz reference gives e_a<1, so 4,800 grid units suffice for the first term. For a production P20 input carrying larger analytic source errors one must insert its actual source radii. Discrete correctness of packed lane encoding is a separate obligation. For these four lanes the independent end-to-end Fourier comparison also checks their observed numerical results.

## Direct check and sign guard

The independent direct DFT is separable by the original 2,40,60 axes. It uses no Cooley–Tukey factorization and no approximate integer roots. For each channel the tighter data-dependent radius is 4,800 plus the upward-rounded absolute difference between the delayed output and the exact DFT of the stored centers. The generic radius is larger. The sign check uses the generic radius in **both** coordinates, recomputes the canonical unit phases, applies the original completion factors, verifies that the imaginary interval contains zero, and requires the real interval to lie strictly on the archived sign's side of zero. High-height rows include the original positive exp(πt/4) scaling. Output labels are (k41,k61) with k4=1.

| Height index | Generic radius | Maximum direct-check radius | Positive / negative | Lowest completed absolute lower bound | Label |
|---:|---:|---:|---:|---:|---|
| 1 | 57,077 | 5,484 | 1,732 / 569 | 0.054714599808 | (26,11) |
| 2 | 57,951 | 5,482 | 1,679 / 622 | 0.020481192915 | (8,31) |
| 84198 | 144,037 | 6,410 | 1,493 / 808 | 0.001867768720 | (29,6) |
| 84199 | 143,747 | 6,409 | 1,598 / 703 | 0.002725689110 | (29,50) |

Run check.py with the campaign interval-env interpreter and the -B flag. The output receipt records the exact input and original sign-file hashes. The four tested heights and this native algebraic argument do not establish a HOL theorem or a campaign-wide sign margin.
