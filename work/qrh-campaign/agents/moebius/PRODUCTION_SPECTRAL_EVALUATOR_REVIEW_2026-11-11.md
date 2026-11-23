# Independent review of the production spectral evaluator research

Date: 2026-11-11. Verdict: **pass for the sampled-Cauchy mathematical wrapper and the two bounded external-library demonstrations, with one minor length correction**. The RS source descriptions are faithful within their stated scope. No full contour, winding certificate, finite strip, or independent/formal verification of the RS point evaluator is established.

The correction is in the final family's suggestive AFE length: `sqrt(10^8/(2*pi))` lies strictly between 3989 and 3990. Its floor is 3989; a ceiling-based length is 3990. The frozen note's statement that the real square root is at most 3989 is inaccurate. No verified family algorithm or successful benchmark depends on that wording. The author acknowledged the correction; the frozen note was left unchanged.

## Frozen inputs and bounded replay

Inputs under `agents/zero-sum/`:

| File | SHA256 |
|---|---|
| `PRODUCTION_SPECTRAL_EVALUATOR_2026-11-11.md` | `8494e089bb937b0595dec607eee0d49b4f549134a9371230d3a74a67c74daf9a` |
| `rs_panel_benchmark_20261111.py` | `caccea1dada0d8bdad105fdff6404b19953509bb98f6b4d08bfed877de49ba0d` |
| `rs_panel_benchmark_20261111.json` | `79e020183d5877e680dd1be7d56ecc5ceec2cd8d23c1c3d7e4f2621f7cbe6800` |
| `rs_cauchy_block_benchmark_20261111.py` | `3a06a92d1f09d6ed8b1bab8ddda946bd15dc2b3eb134400b0714c0727bd9d79e` |
| `rs_cauchy_block_benchmark_20261111.json` | `2a5e255442b3151fb08109d326c18c1a856c08eba6dc3d1d751d0981fa778f26` |

The independent check script is `moebius/production_spectral_review_20261111.py`, with a corresponding JSON. It first verifies all five hashes. It executes unchanged benchmark source text with output paths redirected into the reviewer's directory, preserving the frozen JSONs. Both bounded replays pass their reported patterns: all six direct-panel cases give 0,0,16,16 successes for widths 2^-4,2^-8,2^-12,2^-16 respectively. The sampled-Cauchy blocks require two leaves at sigma=.5025 and one at sigma=.555, as reported.

The script then rebuilds both models independently at 192 bits, using trigonometric root enclosures and conjugate-root powers for the DFT. Crucially it replaces the growth majorant by the existing source's elementary bound, detailed below. Both complete local vertical blocks still pass, with the same two/one half-plane leaves. Five extra point-overlap comparisons per block are diagnostics, not the basis for whole-block acceptance. All samples still use FLINT's zeta routine; a second call or higher precision is not independent verification of its analytic RS implementation.

## Discrete Cauchy alias and truncation bound

For a reusable theorem, require m to be a positive integer, 0<r<rho<R, and f holomorphic on a neighborhood of the closed radius-R disk centered at c. Suppose |f|<=M there. Write

    f(c+z)=sum_(n>=0) a_n z^n,
    b_k=(1/m)sum_(j=0..m-1) f(c+rho*omega_j)*omega_j^(-k).

Cauchy's estimate gives |a_n|<=M/R^n. Absolute convergence at rho allows interchanging the Taylor series with the finite sum. Exact root orthogonality gives

    b_k=sum_(l>=0) a_(k+lm)*rho^(k+lm),  0<=k<m.

For `P(c+z)=sum_(k<m) b_k*(z/rho)^k`, the omitted true Taylor tail on |z|<=r is bounded by

    M*(r/R)^m/(1-r/R).

The alias contribution is bounded by

    M*sum_(k=0..m-1)(r/R)^k
       *sum_(l>=1)(rho/R)^(lm)
    <= M/(1-r/R) * (rho/R)^m/(1-(rho/R)^m).

Adding these terms yields exactly the frozen wrapper's bound. It is conservative because it drops the factor `1-(r/R)^m` from the finite k-sum. There is no missing factor rho^-k: it cancels the rho^k carried by each aliased coefficient. This argument does not use zeros, RH, or a discretization of the target panel.

The interval implementation encloses samples at exact points on the sampling circle. Decimal centers and transcendental roots are represented by balls containing their exact intended values. The target polynomial uses one fixed exact rational center; every relevant consistent choice is included in those coefficient intervals. Reusing interval roots or discarding their correlations can widen the enclosure but does not lose the exact coefficients. Multiplying by an independently enclosed inverse root likewise preserves inclusion. Root orthogonality is invoked for the exact roots, not asserted as an identity of approximate midpoint numbers.

Horner evaluation propagates sample and arithmetic uncertainty already present in the coefficients. The analytic alias/truncation radius is additional and is safely enlarged to a coordinate square. The interval radius constructor must use an upper bound for an uncertain radius; the installed interface's behavior was checked in earlier reviews, and the independent implementation explicitly passes the error's upper endpoint.

## Growth majorant: original and independent replacement

The frozen M is correctly obtained from the Rademacher inequality stated in [FLINT's pinned growth-bound implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_bound.c). On both outer disks, sigma lies in [.0025,1.055], so eta=.1 is valid. The exponent `(1.1-sigma)/2` is nonnegative and less than .6. The estimates `|1+s|<T+3`, `|1-s|>T-1`, `2*pi>6`, and `zeta(1.1)<11` then give the proposed M. The independent scalar evaluation confirms M<44836 and error<3.240744e-15. This verifies substitution into that theorem; it does not independently prove Rademacher's inequality from its source comment.

A separate, coarser majorant avoids that unformalized growth input for these two blocks. The existing pinned Lean source `Explicit/ZetaGrowth.lean:177`, `norm_zetaF_le`, together with `zetaF_of_ne`, gives for sigma>0 and s!=1

    |zeta(s)| <= |s|/|s-1| + |s|/sigma.

For either radius-1/2 disk centered at sigma+iT, T=10^6, the exact geometry gives

    sigma >= 1/400,
    |s| < T+2,
    |s-1| > T-1.

Thus a valid disk bound is

    M_alt = 400000802
      > (T+2)/(T-1) + 400*(T+2).

The disk is far from the zeta pole. With m=64, R=1/2, rho=1/4, r=1/8, the exact rational alias factor times M_alt is below 2.9e-11. This larger error is still small enough: the independent .5025 block has two positive-imaginary half-plane leaves with lower margins exceeding .1324 and 1.7555, while the .555 whole block has a positive-imaginary margin exceeding .2233. The exact rational error and interval margins are stored in the independent JSON.

This improves the proof provenance of the local wrapper without proving the RS sample values. The elementary bound also has a transparent general-height expression `(T+2)/(T-1)+400(T+2)` in the same disk geometry for T>=1500; this is only a growth bound, not a global nonvanishing or cost guarantee.

## What the local interval samples establish

Each benchmark's target is a single vertical segment of length 1/4, centered at height one million. Its adaptive bisection covers that complete segment by adjacent dyadic intervals. Success means every resulting whole image enclosure lies in an open coordinate half-plane. It is stronger than checking sample-point nonvanishing, because the analytic Cauchy error controls all points between samples.

The .555 experiment is still a zeta evaluation, not a generic primitive-character L-function. No compatible rational image polygon, complete rectangle, or winding is present in these files. The blocks cannot be used to conclude anything about an untested part of the vertical edge. Direct-panel failures merely mean their enclosures do not certify a coordinate sign, not that a zero exists. Timings and relative-accuracy diagnostics are measured library behavior, not proof-runtime estimates.

## Pinned RS source claims

The [dispatcher](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta.c) uses the stated imaginary-midpoint threshold `24*prec*sqrt(prec)` together with a real-part restriction. At 128 bits the threshold is about 34755. The note appropriately labels dispatch as inferred rather than instrumented.

The [assembly routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs.c) uses two auxiliary values off the critical line, combines the reflected-conjugate one with X(s), and treats negative heights by conjugation. For inexact inputs it evaluates a midpoint and adds a derivative-bound error proportional to the input radius, with possible working-precision reduction. Those facts support the note's explanation of broad-ball deterioration, but do not prove its numerical size globally.

The [auxiliary routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_r.c) checks uniqueness of the integer floor of sqrt(t/(2*pi)), computes corrections, adds their certified error before multiplication by the phase and a^(-sigma), and then adds the Dirichlet sum. The heuristic choice of correction order is followed by the separate bound routine; it is not the acceptance error bound itself.

The [remainder routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_bound.c) matches the report's factorial/exponent expression and its domain restrictions. Uniform interval inputs must satisfy those restrictions throughout; the code can return an unbounded result otherwise. The reported c1 is conservative and uses an upper real endpoint. A formal theorem must still connect its coefficient normalization and full hypotheses to the analytic RS result. This review does not perform that derivation.

The [coefficient routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_f_coeffs.c) really divides by a series involving 2cos(pi*p), so the removable-singularity warning is justified. The [jet routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_jet_rs.c) rejects lengths above two and uses symmetric differences plus Cauchy bounds for value/first derivative. It is not a ready high-order Taylor evaluator. These source checks validate the note's implementation descriptions; they do not validate FLINT's complete RS mathematics or every special-function enclosure.

## Operation counts and limits

Exact independent arithmetic confirms:

| Quantity | Value |
|---|---:|
| Quarter-unit blocks on the positive edge [1500,10^6] | 3994000 |
| 64 point samples per block | 255616000 |
| Conservative two 399-term sums per sample | 203981568000 summands |
| Naive 64-by-64 DFT products per block | 4096 |
| Radix-two 64-point butterflies per block | 192 |
| Proposed raw coefficient fields over that edge | 16359424000 bytes |

At t=10^6, floor sqrt(t/(2*pi)) is 398. Sampling-disk heights remain below the next floor threshold; using 399 as the per-sum bound is conservative. The EM comparison ceil(10^6/3)=333334 is also correct. These are summand and encoding counts, not times, total arithmetic operations, allocations, or verified proof sizes. Exponents, metadata, samples, witnesses, corrections and special-function costs remain outside the quoted byte/summand figures.

The fixed-m sampling/RS architecture has the claimed T^(3/2) *Dirichlet-summand* scale when summing sqrt(t) across a fixed block mesh. It does not bound total adaptive certificate size or required precision. The family's proposed square-root length needs the floor/ceiling correction stated at the start, and remains only a heuristic design parameter. No complexity conclusion for all 5543640188 primitive characters follows from it.

## Disposition and remaining obligations

Accept the wrapper derivation, interval sample interpretation, bounded replay, independent two-block calculation, and corrected arithmetic workload descriptions. The original Rademacher growth substitution is consistent with its pinned source statement; the alternative Abel growth bound provides a source-backed route for these local models. The only identified correction is the real versus floored family AFE length.

Still required are independently justified RS point enclosures or a formally checked alternative evaluator; correction and removable-singularity handling; special-function, branch and interval contracts; complete contours with shared vertices and exact winding; and a genuine Dirichlet-family evaluator with exhaustive indexing and completeness. No full-contour success, finite spectral assertion, formal RS verification, or forecast of cheap completion is implied. Frozen reports and canonical Lean sources were not edited.
