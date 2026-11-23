# Review of the principal xi point pilot

2026-11-11. **PASS for the five external point enclosures. No correction required.** The producer's read-only replay passed, including exact agreement of every non-timing receipt field. A separate unshifted theta computation with different quadrature, truncation, precision, and summand factorization enclosed all five values more tightly. This is numerical evidence for these points under the reviewed analytic identity and external ball arithmetic, not a Lean theorem or a contour certificate.

## Frozen artifacts

Producer files in `../zero-sum/`:

* `PRINCIPAL_XI_POINT_PILOT_2026-11-11.md`, SHA256 `AEBEA66214042FCCB24A50ACBD26FA2284035B1D8B2942CE9F8FE9FA961F3E94`.
* `principal_xi_point_pilot_20261111.py`, SHA256 `264183495A1345B2EE6774D49F20864B4E218D14B09F73F23DF24E2A8BD653B2`.
* Its JSON receipt, SHA256 `BC521AE8AC5A53E7331909E0C80DB9B347905675D0680E3D192F0B3A29446A6D`.

Independent files in this directory:

* `review_principal_xi_points_20261111.py`, SHA256 `AC4D34960DD460D60D1EE2CDEE27A42488A9AAC0B21B7C310FBD5C2709A282CA`.
* Its JSON receipt, SHA256 `58382A4D98E0DC3611EB5C8A943CB9A2C7E5D5949024AE8B6DD68BF5D4618B15`.

The analytic inputs are the repaired integration note `PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`, hash `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, and its independent audit `ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2`. I read both complete documents and the relevant actual Xi source. The producer replay checks both analytic-input hashes before evaluation. Source pins remain Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

## Actual function and normalization

The source definition in `TernaryGoldbach/Explicit/Xi.lean` is

`xiF(s)=s(s-1)completedRiemannZeta0(s)+1`.

It has no factor one-half. The source `xiF_zero` and `xiF_one` give the values 1. The product theorem `xiF_eq`, together with `GammaR(2)=1/pi` and `riemannZeta_two`, gives xiF(2)=pi/3. I located `riemannZeta_two` in the pinned `NumberTheory/LSeries/HurwitzZetaValues.lean:226`. These special values are consistency checks; none is inserted into the numerical calculation.

The accepted differentiated-theta kernel is

`P(w)=sum_[n>=1](8pi^2 n^4 exp(9w/2)-12pi n^2 exp(5w/2)) exp(-pi n^2 exp(2w))`.

Its integral against exp((s-1/2)v) is the actual doubled xiF. The boundary term in the accepted integration-by-parts proof is +1. Thus no missing constant, spurious pole-cancellation zero, or standard-xi factor is hidden in the pilot.

The shifted integral gives `F_b(s)=exp(-ib(s-1/2))xiF(s)`. The producer correctly recovers xiF by multiplying by `exp(+ib(s-1/2))`. Both the sign and the shift by one-half matter. That multiplier is evaluated as a complex ball and multiplies the entire shifted enclosure, so it also propagates the analytic-error radius and its own rounding error.

## Domain and kernel evaluation

The producer parameters are b=1/8, r=1/4, kappa=1/2, T=2, h=1/64, K=192, V=3, N=12, and 160-bit ball precision. They satisfy

`|b|+r=3/8<pi/4`, and `cos(2(|b|+r))>=23/32>1/2`.

The accepted real-part domain was stated as [.4968,2], but its undifferentiated envelope uses only `|Re(s)-1/2|<=3/2`. That same inequality holds on [0,2]. The exact integral is entire, and the enlarged interval creates no singularity. The pilot's explicit extension to include s=0 is therefore valid.

For positive nodes the producer evaluates the finite displayed kernel. For a negative node it uses `P(-v+ib)=P(v-ib)=conjugate(P(v+ib))`, from the evenness of the full kernel and its real coefficients. This yields a valid approximation with the same tail radius. It is not a claim that the finite unreversed theta polynomial is itself even. The zero node is included once. Its finite complex value is retained rather than forced to be real.

For the independent finite-node checks I used the algebraically equivalent factorization

`P_N(w)=4 exp(w/2) sum_[n=1..N] z_n(2z_n-3)exp(-z_n)`, where `z_n=pi n^2 exp(2w)`.

At 192 bits, all 193 recomputed finite-node balls are contained in the corresponding frozen producer balls. The same is true for all six retained individual-term checkpoints. These are exact rational endpoint comparisons, not decimal comparisons.

## Analytic and numerical error accounting

The constants are exactly C=3/2, q=3/4, z0=9/4, A=113984/81 and M=455936/243. The three analytic errors are the accepted bounds

`E_quad=2M exp(Tr)/(exp(2pi r/h)-1)`,

`E_space=M exp(-q exp(2V))`,

`E_theta=h(2K+1)A exp(2V-q(N+1)^2)`.

The exponent envelope is uniform over all five points. The spatial threshold q exp(2V)>1 is checked, so comparing the two omitted discrete tails to the corresponding integrals is justified. No half-weight endpoint convention is required: this is a truncation of the infinite trapezoid sum with both endpoints included. The theta bound includes the differentiated kernel's n^4 and n^2 factors and both frequency signs.

The producer replay reproduced approximately 1.353416681e-40, 7.381140465e-129 and 3.066062054e-49 for the three terms. I separately evaluated all three expressions and their sum at 192 bits; every interval is contained in its producer counterpart. The producer adds a square whose coordinate radius is an upper bound on the summed norm error. This square contains the corresponding error disk. All finite summand arithmetic, accumulation, multiplication by h and recovery multiplication remain ball operations. Rounding is not inferred from an agreement test or discarded when the analytic radius is added.

The initial independent receipt parser encountered Python's integer-string length limit on an exact denominator with 76,844 digits. The review script now sets a bounded local limit of one million digits. This is a serialization issue, not a change to an interval, an error bound, or a producer file. The completed run passed after that adjustment.

## Independent unshifted calculation

To avoid merely replaying the same shifted formula, the second computation uses b=0, r=1/3, kappa=1/2, h=1/80, K=240, V=3, N=16 and 192-bit balls. Its outer-strip condition follows from `cos(2/3)>=7/9>1/2`. It evaluates P on real nonnegative nodes using the factorization above and forms

`h [P_N(0)+sum_[k=1..K] P_N(kh)(exp((s-1/2)kh)+exp(-(s-1/2)kh))]`.

This uses evenness on the real line. It has no shifted kernel, negative-node conjugation, or recovery phase, and hence independently tests those producer choices. Its analytic errors are bounded above by:

| Error | Upper-rounded value |
|---|---:|
| Trapezoid | 1.251e-69 |
| Spatial truncation | 7.382e-129 |
| Finite theta series | 2.512e-88 |

Arithmetic rounding remains in the final balls. All five independent enclosures have positive real part, and each complete complex rectangle is contained in the corresponding frozen producer rectangle. Their real-plus-imaginary radii are below 1e-50. The approximate values include

`xiF(1/2+2i)=0.9061997166258722226045610840174556281639...`,

`xiF(.5032+2i)=0.9061998951275306775656128215408062481699... + 0.0002697550776332801533863264051352521762544... i`.

The values at 0 and 1 contain 1, the difference from pi/3 at 2 contains zero, and the imaginary part at 1/2+2i contains zero. The independent source identity and valid enclosures establish correctness; containment and overlap are supplementary consistency checks. In particular, numerical containment of zero in an imaginary interval is not a proof of exact realness.

## Reproduction and limits

Both commands completed successfully:

```
work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/principal_xi_point_pilot_20261111.py --recompute
work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/moebius/review_principal_xi_points_20261111.py
```

The first command is read-only and compared every non-timing receipt field. The second writes only its own review receipt. Both bounded numerical runs finished in less than a second of reported shell wall time. No producer file changed.

The accepted numerical scope is precisely the five points 0, 1, 2, 1/2+2i and 629/1250+2i. There is no interval between them, contour, winding, zero count, high-height result, or larger zero-free domain certified here. The source-to-kernel and quadrature mathematics are reviewed paper arguments; their Lean implementation and formal verification of the external interval engine remain open. No builtin zeta, Gamma, Hurwitz-zeta, or L-function call was used as an acceptance input in either calculation.
