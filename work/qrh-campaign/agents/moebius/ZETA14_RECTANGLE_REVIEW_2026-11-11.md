# Independent review of the zetaF height-14 rectangle

Date: 2026-11-11. Finding: **pass as an external interval certificate with a reviewed paper-level analytic implication**. The entire source function zetaF is nonzero on and inside `[-1/10,11/10] + i[-14,14]`, under the Euler--Maclaurin remainder proof and the interval-library arithmetic contract. Therefore there are no nontrivial zeta zeros with absolute ordinate at most 14. No RH premise is used. This is not a kernel-checked Lean theorem or a certificate through the much larger selected finite-family heights.

## Frozen data and independent checks

Reviewed input files under `agents/zero-sum/`:

| File | SHA256 |
|---|---|
| `ZETA14_RECTANGLE_CERTIFICATE_2026-11-11.md` | `8b852ca3e702749a9fed81f7c434be498a9d174067718c1504dd16f4d5411fca` |
| `zeta14_right_rectangle_20261111.py` | `f7748958058e921636e4372bc74c3b55c5ae24e062b27c648907482bdfe71955` |
| `zeta14_right_rectangle_20261111.json` | `257638f8d8e7f3d8b8552859e3f3e1357aef29994914b11170be67cdd068661b` |

The existing interpreter `work/qrh-campaign/interval-env/Scripts/python.exe` uses python-flint 0.9.0 / FLINT 3.6.0. The author's frozen replay passed all 13994 panels and exact winding zero. Its internal replay time in this review was approximately 2.144 seconds. It did not rewrite the certificate.

The independent implementation `moebius/zeta14_rectangle_review_20261111.py` does not import the author script. It uses N=96, M=20 and 192-bit midpoint precision, compared with the author's N=80, M=24 and 128 bits. It independently checks exact input geometry, shared rational vertices, and a rotated-axis winding count. Its evaluator includes the direct Hurwitz pole term and multiplies the resulting zeta enclosure by s-1; the contour stays away from s=1, so this alternative computation is valid there. It uses no builtin zeta or L-function calls. Bernoulli coefficients are enclosed independently using FLINT's Bernoulli routine.

The alternative evaluator was initially inconclusive on 8578 original panels. Keeping each original separating half-plane fixed, at most two extra bisections verified every original panel by finite union. The complete refined cover has 23068 leaves. There are no unresolved panels, and the script asserts this before reporting success. Its rotated exact winding computation counts two positive and two negative crossings. The final run took approximately 13.476 seconds internally. The independent JSON records these results and the input hashes. These timings describe only this bounded review.

## Exact function and pole removal

The pinned source `TernaryGoldbach/Explicit/ZetaGrowth.lean:17` defines

    zetaF(s) = (s-1)*riemannZeta(s) for s != 1,
    zetaF(1) = 1.

`zetaF_one` at line 22 and `differentiable_zetaF` at line 30 establish the removable value and entire extension. At zero, `riemannZeta_zero` gives zetaF(0)=1/2. Zero is not a trivial zero of this function; neither is one. The first negative even trivial zero is outside the rectangle. The checker does not divide by s or introduce an extra zero at either exceptional point.

Let B=81 and let G(s) denote the Euler--Maclaurin expression for zeta(s) with only the term `B^(1-s)/(s-1)` removed, retaining the finite sum, half term, Bernoulli terms, and remainder. The author's evaluator is

    (s-1)*G(s) + exp((1-s)*log B).

For s!=1 this is algebraically `(s-1)*zeta(s)`. At s=1 it is exactly 1 by analytic continuation, with no subtraction of divergent terms. The error in G is multiplied by s-1 through complex interval arithmetic, so the regularization does not discard a factor from the remainder. This cancellation happens before evaluation. Diagnostic comparisons at zero and one are consistent, but the exact source identity and analytic continuation, rather than those point tests, establish the function being counted.

The independent direct-pole evaluator is used only on the boundary: the vertical sides are -1/10 and 11/10, and the horizontal sides have ordinate +/-14. Every panel box used there excludes s=1. Holomorphy of the source entire function supplies the interior hypothesis for the argument principle; the independent boundary evaluation need not evaluate a raw zeta pole inside the contour.

## Complex remainder and full-panel enclosures

Euler--Maclaurin through the B_(2M) term has remainder controlled by the integral of the periodic Bernoulli polynomial times `(s)_(2M)(t+1)^(-s-2M)`. Its Fourier bound gives

    sup|periodic B_(2M)|/(2M)! < 4/6^(2M).

For actual sigma>=sigma0=-1/10, the magnitude of the remainder is therefore at most

    4*|(s)_(2M)|*B^(1-sigma0-2M)
      / (6^(2M)*(sigma0+2M-1)).

The denominator is positive for M=24 and for the independent M=20. No requirement sigma>0 is needed: convergence of this remainder only requires sigma+2M>1. Since B>1, replacing sigma by sigma0 increases the scalar integral bound. The norm of the complex power on a positive real integration base is exactly its real power, so there is no omitted exponential depending on the ordinate. The rising factorial is enclosed over the entire input panel ball. These are the same classical ingredients as [DLMF's Euler--Maclaurin representations](https://dlmf.nist.gov/25.11#iii) and [Bernoulli Fourier series](https://dlmf.nist.gov/24.8.E1).

The exact rational contour supplies sigma>=-1/10 even if an outward-rounded ball extends slightly left. The arithmetic enclosure may cover extra points; the analytic remainder contract is needed only for the actual contour points. The independent geometry check enforces that domain. Each complex remainder disk is enlarged to a coordinate square using an upward-rounded radius. No endpoint-only error estimate is substituted for a uniform panel bound.

Both runs rely on the external interval library's enclosure semantics for arithmetic, exp, log, norm, and radius conversion. The independent constructor probes confirm retention of uncertain midpoint input and an uncertain radius's upper bound in the installed version. Those probes are not a proof of the library implementation. No dependency installation or trusted theorem import was performed.

## Exact topology and the closed height endpoint

The path starts at `(-1/10,-14)` and goes right, up, left, down. The independent rational check verifies every segment's bounds and direction, consecutive adjacency, closure, and separate edge lengths

    6/5, 28, 6/5, 28.

The four full edges are covered once counterclockwise. There are no gaps and no restriction to a positive-height half-contour.

Each original panel's true image lies in an open coordinate half-plane excluding zero. Both rational polygon vertices lie in that same half-plane. The vertices are shared exactly by adjacent panels, including closure. Convex interpolation on each panel gives a nonzero homotopy from the actual boundary image to the rational polygon; shared vertices make the homotopies continuous at junctions. The independent refined cover proves membership in the same original half-plane, so it preserves this exact polygon without introducing new vertex assumptions.

The author's winding is computed by exact rational determinant signs and half-open ray crossings. Each polygon edge avoids zero because of its half-plane witness. The independent calculation uses a perpendicular ray and yields 2-2=0. Boundary strings and approximate arguments do not participate in either exact winding result.

The argument principle for the entire zetaF function identifies that winding with its number of interior zeros, counted with positive multiplicity. There are none. The half-plane witnesses separately exclude all boundary zeros. Consequently the contour height may equal the requested height 14: zeros with ordinate exactly +/-14 would lie on its certified horizontal edges and are excluded too. The real sides strictly contain the critical strip, and both real zeros and negative ordinates are included. Neither reflection nor a critical-line hypothesis is required.

For a nontrivial zero with `0<Re(s)<1`, one has s!=1 and zetaF(s)=(s-1)zeta(s)=0. Such a point with |Im(s)|<=14 would contradict this rectangle certificate. The source bridge `Explicit/ZetaZeroSums.lean:39` is consistent with that carrier; the elementary product identity already suffices in this direction.

## Accepted scope

The actual low-height exclusion has a complete externally replayed contour, a second independently implemented evaluator, exact winding zero, and a reviewed mathematical bridge. No correction to the frozen script or certificate is needed. Formalization of the Euler--Maclaurin evaluator, interval arithmetic, and argument principle remains necessary before treating this as a Lean-proved leaf. The result does not validate any higher finite spectrum, reciprocal-zero moment, or production-family assertion. No Lean build, canonical source change, or frozen artifact edit occurred.
