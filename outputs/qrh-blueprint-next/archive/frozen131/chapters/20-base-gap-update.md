# Base-gap research update

The original consumer permits more than the fixed .0121 coefficient used in its current proof. It needs |S_etaStar(alpha,x)| <= y*ghatY(y,150000), where y=x/49. The exact function, rather than a convenient constant lower bound for it, is the relevant target.

## Available allowance

The source formula yields a uniform paper lower bound ghatY(y,150000)>.04712 for every y>=1e25. A sharper bound matched to the QRH power is

    y^(1/8)*(ghatY(y,150000)-.000481-.000001098)>79.

Thus a proved spectral contribution at most79*y^(-1/8), including any contour remainder not already allocated, would fit after the displayed main-term and removed-prime allowances. This is an allowance, not a proof of that spectral estimate. The lower-bound derivation uses explicit rational logarithm certificates and a monotone lower envelope; it does not misuse the existing upper estimate .060272 at y=1e25.

## A direct branch from Type I/II

Reduce the rational approximation to 2*alpha, not alpha. If the original denominator is q, the reduced denominator is Q=q/gcd(q,2). The new paper branch covers

    100000<=Q<=150000,  Q/phi(Q)<=1.05.

The existing pointwise Type I/II bound, integrated with the actual Gaussian convolution on w in[.05,8] and trivial bounds on both tails, gives

    |S_etaStar|/y < .0379020785151 < .038.

This fits even the simpler uniform allowance .0404. It preserves the existing arcs and all minor numerical cells. The proof checks the rescaled approximation at every w, including w>1; the twist must scale with w.

Independent source and mathematical review accepted both the variable-allowance derivation and this direct branch. A separate exact-rational replay checked the geometry, logarithmic and power bounds, Gaussian-tail arithmetic, and final comparison. These are paper-level results with explicit existing Type I/II inputs, not checked Lean declarations.

An exact integer totient sieve counts8268 reduced denominators satisfying the displayed branch condition:4256 primes and4012 composites. This count is an external coverage diagnostic, not a Lean proof.

This is a deduction from the existing Type I/II theorem. That theorem still has a PlattGRH dependency. The branch removes the need for an additional character-family estimate on these denominators only after the separately tracked prime, Mobius, and totient inputs to Type I/II are replaced. It does not close the remaining base-gap region.

## The positive-detector test

The later exhaustive rational classifier extends the direct branch to 49,034 reduced denominators. Its full accepted list was independently reproduced. A separate binned comparison, retaining the common scale-dependent R coefficient, proves five sufficient rectangles at paper level, including Q>=50000 with Q/phi(Q)<=1.6 and Q>=120000 with Q/phi(Q)<=1001/192. The latter includes the smooth denominator120120. Independent review accepted the affine comparison, integration remainder, and exact arithmetic. The source Type I/II inputs remain conditional. These newer results supersede the original 8,268-case count as the known extent of the direct branch; they do not close the remaining region.

The first proposed character-family detector was tested at original modulus149993, twist.082, and y=1e25. Moving the real center closer to1 improves the estimate, but the research note gives a lower obstruction above.068 for nonnegative pointwise majorants formed from the specified positive detectors with real centers>=1.02. The source upper envelope at this scale is.060272. Independent mathematical review confirms the obstruction for a detector combination shared across the family, or shared within each parity. It does not cover arbitrary character-dependent coefficients.

This tests a particular proof method, not actual zeros or the truth of the gap bound. Moreover this modulus is covered by the direct Type I/II branch, so failure of a spectral method here no longer forces that method into the final proof. Spectral research should focus on denominators outside the direct branch, with their actual imprimitive Gauss weights.

## Dependency correction

An earlier interface table incorrectly called the off-larger-arcs theorem norm_S_etaStar_le_ghat unconditional. Its source has an explicit Fact PlattGRH binder. The corrected map follows it through Prop1123b, the pointwise Type I/II bounds, and the global totient estimate. The numerical definition ghatY itself and its elementary lower bounds are independent of that binder.

The finite six-prime totient argument repairs the bounded base-gap use. It does not replace the separate global totient bound for unbounded denominators in the off-arcs argument. Both obligations remain explicit.

## Status

These are research derivations, exact external arithmetic, and specified routes for later formalization. No Lean compiler was run and no original Lean theorem was changed. The QRH provider, weighted mass, major averages and mixed term, remaining base-gap region, and moderate-range prime/Mertens replacements remain incomplete.

    DRAFT_ANCHORS: 0
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0
    SEALED_THIS_TURN: 0

The full goal remains active. The preceding turn made progress by validating the new energy derivation and publishing its corrected numerical requirements; this turn narrows the remaining base-gap task and corrects its source dependencies.
