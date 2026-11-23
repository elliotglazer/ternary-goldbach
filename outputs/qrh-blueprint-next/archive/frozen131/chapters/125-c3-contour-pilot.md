# Conductor-three right-rectangle interval pilot

The complete external interval experiment passed for

    L(s,chi3), Re(s) in[111/200,2], Im(s) in[-33,33].

Here chi3 is the unique primitive character modulo3, with values1 and-1 on the two units. The requested height was32, so both closed endpoints +/-32 lie strictly inside the certified contour. This is a new check of the actual .555 boundary; no height20 pilot result is used as evidence for it.

The certificate has2950 whole panels, a closed shared rational polygon, and exact winding number0. A separate replay recomputed every whole-panel enclosure and the winding. This is a rigorous external interval calculation under the stated Euler--Maclaurin and homotopy arguments. Those arguments and the FLINT arithmetic are not kernel-checked Lean components. It verifies neither the selected Hp(3)=20,114,486 nor any other conductor.

## Files and measured scope

* `c3_right_rectangle_20261111.py`: self-contained evaluator, producer and replay checker. SHA256 `24D676376D36E39B89B718956F36FC0C6B3D0A6169053E5926D6043893D2DD4F`.
* `c3_right_rectangle_20261111.json`:2950 panels with exact rational input endpoints, shared rational image vertices and separating-axis witnesses. SHA256 `27613AB3B75E26E5E1B20A4E66290CF425FFBD1B8E926C17B3487485275A0225`.
* `c3_right_rectangle_checks_20261111.json`: additional constructor and rejected-input checks.

The environment was `work/qrh-campaign/interval-env/Scripts/python.exe`, python-flint0.9.0 and FLINT3.6.0, with128-bit midpoint precision. The Euler--Maclaurin parameters were N=80 and M=24. There were5896 panel evaluations,2946 subdivisions and maximum subdivision depth15. Timed construction after initialization took2.4091seconds; replay took .8355seconds. The JSON occupies1,983,209bytes. These are single toy-run measurements, not estimates for the full spectrum leaf. Startup, output serialization and independent review are not included in those internal timing fields.

Run the script to construct data, or pass `--replay` to check the existing JSON without rewriting it. The producer has explicit limits of30000 panel evaluations, depth25 and90seconds. Those limits were not approached. No full-height computation was started.

## Explicit analytic evaluator

The evaluated entire function is

    L(s,chi3)=3^(-s)[zeta(s,1/3)-zeta(s,2/3)].

No builtin L-function or zeta evaluator is used in acceptance. The script uses FLINT elementary real/complex balls for arithmetic, logarithms and exponentials. Its acceptance evaluator implements Euler--Maclaurin with an explicit independent remainder.

For a=1/3 or2/3 put B=N+a. Use

    zeta(s,a)=sum_(j=0)^(N-1)(j+a)^(-s)
      +B^(1-s)/(s-1)+B^(-s)/2
      +sum_(k=1)^M [B_(2k)/(2k)!]*(s)_(2k-1)*B^(1-s-2k)+R.

Bernoulli coefficients are generated as exact fractions, then enclosed in balls. Euler--Maclaurin expresses R as an integral against the periodic Bernoulli polynomial. The Fourier bound on that polynomial gives, for actual sigma=Re(s)>=sigma0=111/200,

    |R| <= 4*|(s)_(2M)|*B^(1-sigma0-2M)
               /[6^(2M)*(sigma0+2M-1)].

Indeed sup|B_(2M)({t})|/(2M)! is at most2*zeta(2M)/(2pi)^(2M), which is below4/6^(2M). Integrating (t+a)^(-sigma-2M) gives the stated denominator. Since B>1, replacing sigma by its lower bound increases the bound. The interval rising factorial encloses every actual point on the panel. The complex remainder disk is conservatively embedded in a rectangle with radius equal to the upward-rounded real error bound in both coordinates. The classical source formulas are [DLMF's Euler--Maclaurin representations](https://dlmf.nist.gov/25.11#iii) and [Bernoulli Fourier series](https://dlmf.nist.gov/24.8#i).

The contract sigma>=sigma0 applies to the actual contour points. A floating ball enclosing a rational point may extend slightly left of .555 through outward rounding. The evaluator does not claim its remainder is valid for every extra point in that rounded ball; it uses that ball for arithmetic and the exact rational domain for the analytic remainder. Every input panel is checked against the exact contour.

The apparent Hurwitz poles cancel analytically. Let B1=N+1/3, B2=N+2/3 and d=log(B2)-log(B1). Their difference is evaluated as

    B1^(1-s)*d*exprel((1-s)d),
    exprel(z)=(exp(z)-1)/z.

This avoids division by s-1 and is valid at s=1 by continuation. For exprel, the code sums degrees0 through18 and adds the uniform complex error bound exp(r)*r^19/20!, r>=|z|. Thus L(s,chi3) is represented without a spurious pole. The conductor-one zetaF correction from the strategy erratum is irrelevant to this nonprincipal conductor-three function.

Diagnostic comparisons at four points overlap FLINT's builtin Hurwitz values, or the known value L(1,chi3)=pi/(3sqrt3). These comparisons do not participate in acceptance and do not replace the explicit remainder proof.

## Whole-panel nonvanishing and exact winding

The input contour starts at(.555,-33), moves right, then up, left and down. It is counterclockwise. Recursive bisection produces horizontal or vertical rational panels, with no gaps. The replay checks every direction, bounds, adjacency, closure and total perimeter against that single rectangle.

For each panel, the evaluator receives one rectangular complex ball containing the whole panel, not just its endpoints. Acceptance requires one coordinate of its entire image enclosure to have a strict sign. That supplies an open half-plane excluding0. The two rational image vertices of the panel must lie in the same half-plane. Each input vertex uses the same rational image vertex on both neighboring panels, including closure.

The resulting rational polygon is homotopic to the actual function image: on each panel, straight interpolation between the true image and its polygon segment stays in the certified open half-plane. The shared vertices make the homotopies agree at panel boundaries. This proves both whole-boundary nonvanishing and equality of winding numbers. The replay does not trust the displayed image-ball strings; it reevaluates every panel and checks its recorded separating-axis witness.

The polygon winding number is computed with exact Fraction arithmetic using signed ray crossings. Half-open crossing rules account for vertices on the real axis. Every polygon edge avoids0 because it stays in its certified half-plane. The final integer is exactly0, without summing approximate arguments or rounding a numerical contour integral.

The checker has positive and negative orientation tests: a unit square around0 has winding1, its reverse has winding-1. A box containing0 is rejected. Additional tests reject a certificate with an image vertex replaced by0 and one with a panel deleted. Bounded constructor checks confirm that this installed Arb interface preserves uncertain midpoint input and enlarges by the upper bound of an uncertain radius. General soundness still relies on the interval library's arithmetic semantics, not merely on those examples.

## The precise mathematical implication

The primitive conductor-three L-function is entire. The argument principle therefore identifies this boundary winding with the number of zeros in the rectangle interior, counted with multiplicity. Zero winding and nonnegative multiplicities imply that there are none. Boundary nonvanishing excludes boundary zeros too.

In particular every nontrivial zero with |Im(s)|<=32 has Re(s)<.555. This implies the requested non-strict upper bound at the toy height. Real zeros and both imaginary signs are included directly. Neither simplicity nor a critical-line hypothesis is used, and no individual zero was located or isolated.

This conclusion remains an externally checked analytic computation awaiting independent review and, separately, formalization of the evaluator and argument-principle bridge. It is not a new axiom, a completed Lean declaration, a proof of the original shared spectral premise, or a runtime forecast for billions of characters. Existing source files and frozen research reports were not changed.
