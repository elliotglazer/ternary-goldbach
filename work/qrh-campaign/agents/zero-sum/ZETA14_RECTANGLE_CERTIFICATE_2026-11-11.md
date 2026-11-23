# External certificate for the zeta low-zero leaf through height14

The complete external interval calculation passed on the rectangle

    -1/10<=Re(s)<=11/10,  -14<=Im(s)<=14

for the entire source function zetaF. Every boundary panel has a strict nonvanishing enclosure, and the closed rational image polygon has exact winding number0. The argument principle therefore excludes zeros of zetaF throughout the rectangle, including its boundary. In particular there are no nontrivial zeta zeros with |gamma|<=14. The real sides strictly contain the critical strip, and the horizontal sides themselves are certified nonzero. No QRH or finite RH statement is used.

This is the actual height14 external finite-data leaf, unlike the earlier conductor-three toy. It is still an external interval certificate plus a mathematical argument-principle proof, not a Lean theorem or an imported axiom. Independent review has been requested. No canonical Lean files or frozen reports changed.

## Function and source identity

At the pinned source commit23b2d68ca344203d4384e0aff7affa4ec034bef9, `Explicit/ZetaGrowth.lean:17` defines

    zetaF=Function.update (fun s => (s-1)*riemannZeta(s)) 1 1.

The source supplies the identity away from1 and differentiability of this entire function. The evaluator uses the pole-cancelled continuation with value1 at1. It does not treat raw zeta as entire, and does not add a zero at the removable point. At0 the value is1/2, not0. The source-to-evaluator analytic identity remains a formalization obligation.

## Explicit Euler--Maclaurin evaluation

The acceptance evaluator uses elementary FLINT/Arb ball operations and a separately stated analytic remainder. It does not call a builtin zeta routine. Parameters are N=80, M=24, sigma0=-1/10, and B=N+1=81. Define

    A(s)=sum_(n=1)^N n^(-s)+B^(-s)/2
         +sum_(k=1)^M [B_(2k)/(2k)!]*(s)_(2k-1)*B^(1-s-2k).

Euler--Maclaurin gives zeta(s)=A(s)+B^(1-s)/(s-1)+R(s). On actual points with Re(s)>=sigma0, the remainder obeys

    |R(s)|<=4*|(s)_(48)|*81^(-46.9)/(6^48*46.9).

The Bernoulli numbers in A are exact fractions. The periodic Bernoulli Fourier bound gives sup|B_48({t})|/48!<=2*zeta(48)/(2pi)^48<4/6^48. Integrating the resulting power tail gives the denominator sigma0+48-1=46.9. The exponent1-sigma0-48=-46.9 is also valid at the new negative real boundary. Since81>1, using the lower real-part bound is conservative. See the classical [Euler--Maclaurin representation](https://dlmf.nist.gov/25.11#iii) and [Bernoulli Fourier formula](https://dlmf.nist.gov/24.8#i).

The actual acceptance formula is

    zetaF(s)=(s-1)*(A(s)+R(s))+exp((1-s)*log81).

The pole cancels before interval arithmetic. This identity is entire and gives1 at s=1 directly, with no division by s-1. The complex remainder disk is enlarged to a rectangular error ball, then the ball multiplication by(s-1) includes its full contribution. No residue term is omitted.

The ball representing a rational boundary panel can extend slightly beyond the exact real-part endpoint through outward rounding. The analytic remainder contract is asserted for the actual contour points, all of which have real part>=-1/10. The polynomial and elementary ball operations enclose those actual points. The evaluator does not claim the same fixed-floor remainder for every additional point in the rounded input ball.

This adapts the independently reviewed conductor-three evaluator, with a different function, real-part floor and pole cancellation. The previous chi3 difference-of-Hurwitz formula and exprel approximation are absent. Five builtin or exact-value comparisons are recorded only as diagnostics; they do not enter acceptance.

## Panel and winding certificate

The contour starts at(-.1,-14), follows the bottom edge rightward, then the right edge upward, the top edge leftward and the left edge downward. Recursive rational bisection produced13994 accepted panels. Replay verifies their directions, exact endpoints, adjacency, closure and total perimeter, so the input path traverses this rectangle once counterclockwise.

For each entire panel the script evaluates one complex ball enclosing the function image. Acceptance requires either its real or imaginary coordinate to have a strict sign. This is a certified open half-plane that excludes0. Two rational image vertices are chosen in the same half-plane. Adjacent panels use exactly the same vertex, including the final join to the first panel.

Straight homotopy between the true image and the rational polygon stays within the corresponding open half-plane on every panel. The shared vertices make it continuous at joins. Thus the actual image is nonzero throughout the boundary and has the polygon's winding number. Sampling only endpoint values would not establish this conclusion; the complete-panel image bounds are essential.

The winding is computed by exact rational signed ray crossings, with half-open rules for real-axis vertices. Each edge avoids0 because it lies in its strict half-plane. The resulting integer is exactly0. No approximate sum of arguments is rounded to the nearest integer. Replay ignores the stored descriptive image-ball strings and recalculates every interval witness from the exact input panels.

The inherited checker tests distinguish clockwise and counterclockwise unit squares, reject a box containing0, and reject a zero image vertex. Its mathematical soundness still depends on the interval arithmetic semantics, the Euler--Maclaurin identity, and the homotopy/argument-principle bridge. Those are not claimed as Lean-checked here.

## Frozen artifacts and measurements

The interpreter is `work/qrh-campaign/interval-env/Scripts/python.exe`, with python-flint0.9.0, FLINT3.6.0 and128-bit midpoint precision.

| Artifact | SHA256 |
| --- | --- |
| `zeta14_right_rectangle_20261111.py` | `F7748958058E921636E4372BC74C3B55C5AE24E062B27C648907482BDFE71955` |
| `zeta14_right_rectangle_20261111.json` | `257638F8D8E7F3D8B8552859E3F3E1357AEF29994914B11170BE67CDD068661B` |

Construction used27984 panel evaluations and13990 subdivisions, with maximum depth16. The accepted panel count is13994. Timed construction after initialization took7.8494seconds; replay took2.1999seconds. The data file occupies9,120,762bytes. The producer was bounded by30000 evaluations, depth25 and90seconds, and completed within those limits. These measurements exclude startup and output serialization and are not a general performance forecast.

Running the script produces the certificate; `--replay` checks the frozen JSON without rewriting it. The script records its own hash and arithmetic-library versions in the data. Independent evaluation and review are separate from this successful local replay.

## Precise conclusion and limits

Holomorphy of zetaF on a neighborhood of the rectangle, boundary nonvanishing and winding0 imply that the sum of zero multiplicities in its interior is0. Multiplicities are nonnegative, so there are no interior zeros. Nonvanishing on the horizontal edges also excludes gamma=+/-14. For a nontrivial zero with0<beta<1, s differs from1 and the source identity zetaF(s)=(s-1)zeta(s) transfers the exclusion to zeta.

The computation therefore supplies an external certificate for this actual low-zero leaf. It uses neither zero simplicity nor an assumed zero list, and includes gamma=0 and both signs directly. It does not yet supply the Lean evaluator, checker theorem, source-function identification or formal argument-principle application. No higher-height zeta count or other conductor is certified by this artifact.
