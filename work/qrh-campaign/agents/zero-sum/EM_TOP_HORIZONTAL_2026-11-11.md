# Explicit Euler–Maclaurin certificate for the short top path at height one million

2026-11-11. New alternative to the existing RS-backed top-path certificate, which remains unchanged. No builtin zeta, Hurwitz, Gamma, RS, zero-count helper or indexed-zero function is called. No long vertical run, zero enumeration, Lean build or canonical edit occurred. Independent review is required.

## Result

The complete horizontal path from2+iT to1/2+iT, T=1000000, is covered by six quarter-unit finite-EM Taylor models. Every whole-block zeta image has positive real part. The smallest certified real lower endpoint exceeds.07608735429. All seven shared actual endpoint enclosures are obtained from these same models, without seven additional long sums.

The canonical continuous argument therefore gives

    0.4913678844069164 < S(T) < 0.4913678844069188.

Using the reviewed normalized count identity and Binet allowance1/8, exact rational integer extraction gives

    N(1000000)=1747146.

The count interval lies inside(1747145.87499999,1747146.12500000) and contains exactly that one integer. This is an external arithmetic/analytic certificate at the actual top height, not a Lean theorem. It does not prove the narrow strip below this height or supply sign-change intervals. No RH or QRH premise is used for the top-path evaluation.

## Files, measurement and scope

Files in this directory:

* `em_top_horizontal_20261111.py`: explicit EM/Taylor evaluator, panel checks, elementary argument and exact count extraction.
* `em_top_horizontal_20261111.json`:76,378 bytes, containing all144 complex Taylor coefficient balls, six full-block image boxes, seven shared endpoint balls, rational error bounds, S/F/count intervals and timing/memory data.

Use the existing interval-env Python and `--recompute` to rerun without overwriting the frozen JSON. The script recomputes the enclosures and assertions; it does not rely on stored coefficient strings for acceptance. It is not a separately verified interval checker.

Final recorded run:15.8597 seconds internal wall time, including.5117 seconds to initialize333334 logarithms. Peak process working set58,081,280 bytes; final working set57,384,960 bytes, measured through Windows GetProcessMemoryInfo. Interpreter startup and final JSON serialization lie outside the internal timer. The first difficult block centered5/8 took1.7125 seconds. Since the projected remaining work fit the120-second cap, the run completed all six blocks. No interval or height was relaxed. An initial memory-counter binding error was repaired before the recorded run; it did not change any analytic or arithmetic parameter.

Precision128 bits, N333334, B=N+1, M32 Bernoulli corrections, Taylor length K24 (degree23), outer radius R1, target radius h1/8. Block centers are5/8,7/8,9/8,11/8,13/8,15/8, all at imaginary heightT. Construction proceeds left to right; the canonical argument path uses the same covering in reverse.

## Finite entire model and EM error

Let

    A(s)=sum_(n=1..N)n^(-s) + B^(-s)/2
      + sum_(k=1..M) B_(2k)/(2k)! * (s)_(2k-1)*B^(1-s-2k),
    g(s)=(s-1)*A(s)+B^(1-s).

This finite g is entire. The actual source entire function is zetaF(s)=(s-1)zeta(s), with removable value1 at1. For all actual top-path points sigma>=1/2, the periodic Bernoulli EM remainder gives

    |zetaF(s)-g(s)| <= (S+1)*4*product_(j=0..63)(S+j)
        *B^(1-1/2-64)/(6^64*(1/2+64-1)),

where S bounds |s| over the target block. The script uses S=|center+iT|+1/8. The Bernoulli coefficients are exact Fractions converted to outward balls. The bound uses2pi>6 and zeta(64)<2 in the integral remainder. It is the same explicit EM contract used in the reviewed head evaluator, now at the stated high T and N.

The error concerns zetaF. It is not silently used as a zeta error before division by s-1. On each target block the largest EM bound is below1.975e-12 for zetaF, hence roughly2e-18 after division by |s-1|>=T.

All positive integer powers are evaluated as exp(-s log n) using real log n. The evaluator never calls a builtin special-function value. Its entire finite expression is expanded with interval acb_series arithmetic, so all rounding and cancellation remain in the coefficient balls.

## Entire-g Taylor tail: no EM assumption on the outer disk

The outer disk has radius1. Its leftmost real part can be -3/8 on the first block. The EM remainder is NOT asserted there. Only the finite entire g is bounded there, which is sufficient for Cauchy's Taylor estimate.

For a center c+iT, set

    sigma0=c-1, S0=|c+iT|+1,
    V=N*max(1,N^(-sigma0))+B^(-sigma0)/2
      +B^(-sigma0)*sum_(k=1..32) |B_(2k)/(2k)!|
          *product_(j=0..2k-2)(S0+j)*B^(1-2k).

The elementary bound sum_(n<=N)n^(-sigma0)<=N*max(1,N^(-sigma0)) avoids another333334-term sum. Then

    |g(s)| <= Mout=(S0+1)*V+B^(1-sigma0)

on the full outer disk. Cauchy's coefficient estimate gives degree23 remainder

    Etaylor=Mout*(1/8)^24/(1-1/8)

on the closed target disk. This is added to the separate EM error. Finite-g coefficient computation and its outer bound require no zeta growth theorem, no RS remainder and no analytic continuation beyond the finite expression's evident entirety.

The full zetaF error bounds are:

| Block center | EM upper bound | Taylor-tail upper bound |
|---|---:|---:|
|5/8|1.975e-12|9.502e-9|
|7/8|1.975e-12|3.955e-10|
|9/8|1.975e-12|8.068e-11|
|11/8|1.975e-12|8.068e-11|
|13/8|1.975e-12|8.068e-11|
|15/8|1.975e-12|8.068e-11|

The first is the least favorable block. Its zeta error from these analytic remainders is below9.504e-15. This is far smaller than the observed positive real margin. Arithmetic error is separately present in the model balls; it is not discarded on that comparison.

## Whole-panel and shared-endpoint checks

For each block, evaluate the degree23 polynomial by Horner arithmetic on the entire real interval of offsets[-1/8,1/8]. Add a square enclosing the combined zetaF remainder disk, then divide by the entire box s-1. This denominator excludes0 since Im(s)=T. The quotient therefore encloses actual zeta at every point of the block. The test requires its real part to be strictly positive.

Each block also evaluates its endpoints through the same model. An endpoint already stored from an adjacent block is reused; the new enclosure is checked to overlap it. Both enclosures separately enclose the actual endpoint value under the model contract, and all have positive real part. The seven exact endpoints are1/2,3/4,1,5/4,3/2,7/4,2 at heightT. Their identity and coverage are asserted.

No subdivision was needed. A failure of the right-half-plane assertion would fail this run rather than be interpreted as success from endpoint samples. The120-second bound is checked during long loops and between blocks. The successful receipt contains all six required blocks.

## Canonical argument and count

On the vertical line Re(s)=2, absolute convergence gives

    Re zeta(2+it)>=2-zeta(2)>1/4.

Thus the canonical argument starting at positive zeta(2) remains its principal argument all the way to2+iT. The computed horizontal path is also entirely in the right half-plane, so the same branch continues to1/2+iT. Consequently S(T) is the principal imaginary logarithm of the shared endpoint value, divided by pi. There is no untracked multiple of2pi. The code checks that the2+iT endpoint's real part exceeds1/4.

Whole-path nonvanishing includes the critical-line endpoint. The zeta functional equation and conjugation reflect any nontrivial zero at ordinateT with beta<1/2 to one in the certified half-segment, so no nontrivial zero occurs exactly at the counting height. This standard source-level transport remains part of the formal count bridge.

As in the reviewed integration top-count route, use

    F(T)=T/(2*pi)*(log(T/(2*pi))-1)+7/8,
    N(T)=1+theta(T)/pi+S(T),
    |1+theta(T)/pi-F(T)|<1/8.

Only the elementary expression F, the new endpoint logarithm, and the rational allowance are evaluated. Gamma and theta are not evaluated numerically. The exact count interval is:

    [283490626192642055771359059095699756891 / 162259276829213363391578010288128,
     283490666757461414190427358818849167195 / 162259276829213363391578010288128].

Its exact ceiling at the lower endpoint and floor at the upper endpoint both equal1747146. The normalized count identity and Binet estimate are analytic inputs from the separately reviewed count route, not consequences of EM or values imported from the earlier RS receipt. The code neither compares to a known count nor rounds a midpoint to force one.

## Consequence and remaining limits

This replaces the external RS value dependency for this short top-path/count leaf with the already developed explicit EM plus finite-g Taylor method. It does not remove RS from unrelated proposed production evaluators or formally prove EM in Lean. The pinned source function identification, analytic EM remainder, Taylor enclosure, elementary interval primitives, branch/count identity and closed-height multiplicity transport still require their formal bridges.

The remaining principal narrow-strip proof includes the low interval[14,1500] as well as[1500,10^6]; head counts do not prove either strip. Nothing here certifies those long vertical boundaries or the family's Hcert rectangles. The existing RS-backed certificate and frozen131 package remain unchanged.
