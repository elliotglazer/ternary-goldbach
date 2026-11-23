# Independent review of the height-one-million top count

2026-11-11. **PASS as an external interval certificate under the stated analytic-count and point-evaluator contracts.** The complete top path, argument normalization and integer extraction are sound. Both a full frozen replay and a different-parameter independent replay of every block passed. This is not a Lean count theorem, a formal RS verification, a narrow-strip certificate, or a zero/sign enumeration.

## Frozen inputs and independent work

Paths below are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
|---|---|
| `integration/PRINCIPAL_TOP_COUNT_2026-11-11.md` | `27e092ef982bd02618f6987c68b58b4653e876f99f55bfdb5b6c38f4669ff94b` |
| `integration/principal_top_count_20261111.py` | `323ef8e439db952972a81d11bd4216a56f27d8f93e665ad482ab328ab0e9846a` |
| `integration/principal_top_count_20261111.json` | `452e2d603602da6fb05558f79f8451ff1e9ac26031f54e30a0b9a349cb3c2b2a` |
| `audit/PRINCIPAL_COMPLETENESS_ROUTE_REVIEW_2026-11-11.md` | `fb268ad7ace08954435194d51bf6fc3c358ae7838e8ccfae7087b0e0f84eaa11` |

The frozen script's read-only `--replay` regenerated the complete certificate and returned `PASS_EXTERNAL_REGENERATED_CERTIFICATE_MATCH`. This checks all384 original model samples,384 coefficients, six panels, seven endpoint balls and argument/count intervals through the author's implementation.

The new `review_principal_top_count_20261111.py` imports no author code. It first checks the stored rational geometry, model error and count arithmetic. It then independently recomputes **all six blocks**, using192-bit precision,80 samples per block, outer radius3/8 and sample radius3/16, instead of128 bits,64 samples,1/2 and1/4. The target radius remains1/8. It uses inverse powers of each root in the DFT instead of the producer's modulo-indexed root array. All480 model evaluations and seven endpoint evaluations use FLINT zeta, so this is a different-model replay, not a second independently proved zeta implementation.

The script and its JSON are beside this review. It calls no count helper, indexed-zero routine, historical zero database or zero enumeration. No Lean build, native build, dependency change, canonical edit or frozen-package change occurred.

## Whole-panel Cauchy enclosures

The input path consists exactly of the contiguous oriented panels

    2 -> 7/4 -> 3/2 -> 5/4 -> 1 -> 3/4 -> 1/2,

all at imaginary height1000000. The stored centers and endpoints match these rational values. Every original block accepts one whole panel, at depth0, with positive real part. The exact stored lower bounds all exceed.07608. The panel tests do not merely sample endpoints.

The actual-source bound is `Explicit/ZetaGrowth.norm_zetaF_le:177`, together with `zetaF_of_ne`, giving

    |zeta(s)| <= |s|/|s-1| + |s|/Re(s)

when Re(s)>0 and s!=1. Each original closed outer disk has Re(s)>=1/8, |s|<=T+3 and |s-1|>=T-1/2. Consequently M=8000026 is valid for actual zeta throughout every disk. The disks avoid the pole and have a holomorphic neighborhood. This uses the existing elementary source growth proof; no Rademacher bound or empirical outer maximum is assumed.

For analytic f with |f|<=M on the outer disk, root orthogonality gives

    b_k = sum_(l>=0) a_(k+l*m)*rho^(k+l*m).

Bounding the omitted true Taylor terms and retained aliases separately gives exactly

    M/(1-r/R)*[(r/R)^m+(rho/R)^m/(1-(rho/R)^m)].

The coefficient normalization in both programs is correct: b_k multiplies ((s-center)/rho)^k. Ball-valued sample points and roots enclose the exact roots-of-unity definitions; their numerical uncertainties remain in the coefficients. Horner evaluation encloses the whole real target interval. Adding the same positive error to both coordinate radii safely encloses its complex error disk. The frozen error interval contains the independently computed exact rational formula.

For the alternate model, the outer real-part minimum is1/4 and |s-1|>=T-3/8. Thus the same source inequality gives the smaller M=4000014. The new exact error is below5e-18, approximately4.9631010461e-18. All six alternate whole-panel boxes have strictly positive real lower endpoint; their approximate lower endpoints are

    .9507654, .9369339, .9293302, .9266120, .9327271, .07608906.

These are successful full blocks with different sample circles, not selected point spot-checks. They still rely on FLINT's zeta enclosures and elementary interval arithmetic.

## Shared endpoints and the continuous argument

There are exactly seven rational endpoint keys, shared by adjacent panels. Every actual endpoint ball has positive real part, and the initial one exceeds1/4. The seven alternate192-bit endpoint balls lie inside their frozen128-bit boxes. All independently recomputed panel increments lie inside the frozen increment intervals.

The vertical initialization is justified analytically, not by a top-endpoint test. Absolute Dirichlet convergence on Re(s)=2 gives

    Re zeta(2+i*u) >= 2-zeta(2) > 1/4

for all real u. The last inequality follows by taking the n=2 term separately and bounding the strictly decreasing n>=3 tail by the integral from2 to infinity. At u=0 zeta(2) is positive, so the continuous vertical argument starts at0 and equals the principal endpoint argument without an unknown multiple of2*pi.

Each horizontal increment is Im(Log(zeta(left))-Log(zeta(right))). This sign matches traversal from2+iT toward1/2+iT. Whole-panel positivity places the actual image in the logarithm's slit plane throughout, so the increment is the genuine continuous variation. All six panels select rotation1; their common chart and exactly shared endpoints also yield a direct telescoping check. The independent propagated S agrees with Im(Log(zeta(1/2+iT)))/pi and lies inside the frozen S interval:

    S(T) = .4913678844069175813986793384168674481058874699...

with the alternative interval radius below2.34e-57. The direct endpoint check would not be valid without the whole-path half-plane and vertical initialization arguments.

The top path excludes every nontrivial zero at heightT with real part>=1/2. Functional equation and conjugation transport any hypothetical left-half zero to the right half at that same height. Thus the full nontrivial top boundary is zero-free, including the critical-line endpoint. This supplies the off-zero-height condition of the counting identity and removes half-weight or boundary-count ambiguity. It locates no zeros belowT.

## Counting normalization and unique integer

I read the pinned independent completeness-route review. Its analytic contract is

    N(T)=1+theta(T)/pi+S(T),
    |1+theta(T)/pi-F(T)|<1/8,
    F(T)=T/(2*pi)*(log(T/(2*pi))-1)+7/8,

for this nonzero ordinateT>=1500. Here N counts all nontrivial positive-ordinate zeros with analytic multiplicity, and theta uses the normalized analytic Gamma logarithm. The reviewed argument-principle/xi derivation fixes the +1 and normalization without calibrating against a finite count. This review consumes that independently reviewed paper contract; it does not claim a second full audit or Lean proof of it.

Neither computation evaluates a count helper or principal log-Gamma as a substitute for the unwrapped phase. The numeric calculation uses only F, the newly propagated S, and the symmetric1/8 allowance. The alternate elementary F interval lies inside the frozen one.

The frozen exact rational interval encloses the exact sum of its F and S endpoint intervals with[-1/8,1/8]. The replay checks

    1747145.87 < lower <= N(T) <= upper < 1747146.13,
    ceil(lower)=floor(upper)=1747146.

The independent replay combines its F/S endpoints with the allowance using exact fractions and obtains the same unique integer. Exact endpoint addition avoids irrelevant radius-storage quantization when comparing two separately rounded Arb balls of nearly equal radius. This is an enclosure-and-integer argument, not nearest-integer midpoint rounding. No previously known count is used to set an argument branch or chooseT.

## Disposition and remaining obligations

Accept the short external top-path computation and its resulting external total multiplicity count1747146, with the analytic-count and FLINT point-evaluator contracts explicit. No change toT was made. The formal normalization identity, Binet estimate, source growth specialization, interval arithmetic, discrete-Cauchy lemma, actual RS coefficient/remainder and primitive soundness, argument-lift reasoning, and multiplicity/reflection carrier transport still need checked Lean proofs before this becomes a formal count theorem.

The result supplies neither1747146 disjoint Hardy sign-change intervals nor nonvanishing of either vertical strip boundary through one million. It therefore does not prove the remaining narrow strip, finite RH, the shared family assertion, or Goldbach. Those obligations cannot be replaced by this count's external PASS receipt.
