# Exact-rational unit-group transform pilot at conductors 40 and 120

2026-11-11. All four requested conductor/sample combinations completed. The pilot evaluates actual centered Hurwitz coefficients, applies the positive tensor character transform, and returns the six primitive rows at each conductor, at s=1 and s=1/2+10i. All 24 selected output rectangles include coefficient truncation and elementary arithmetic errors. No builtin L-function, zeta, Gamma, HardyZ, Riemann-Siegel, FFT, or floating elementary evaluator is used.

These are external candidate arithmetic certificates with source-faithful paper semantics. They are not Lean proofs or a finite-spectrum certificate. Point rectangles do not certify a contour, winding, zero count, or completeness.

## 1. Frozen artifacts and mathematical inputs

All paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| New script `prime-estimates/unit_group_transform_pilot_20261111.py` | `9C0739E966109EC71A251182668A4A6670174C2248CADE3C3D271033CD2E2800` |
| New receipt `prime-estimates/unit_group_transform_pilot_20261111.json` | `0630A8FBCB5C20A191D4DA8AEF5FE367F6FBE090FE8463C5CD0A4E2D5987EFEC` |
| Reused exact-arithmetic helpers `prime-estimates/principal_k0_point_certificates_20261111.py` | `9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22` |
| Transform plan `integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866` |
| Transform review `audit/REVIEW_UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `222346A598FB72100005E065A6BFA77DCDE91B8B8F9F068847BE9DCBA0FB558D` |
| Analytic EM proof `major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md` | `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485` |
| EM proof review `moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md` | `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1` |

The script verifies the helper file's hash before importing its rational operations, Machin pi, atanh log, and squared-bound square root routines. Importing it does not execute its earlier point pilot. The helpers and their elementary semantics were independently reviewed in `independent-feasibility/REVIEW_PRINCIPAL_K0_POINT_CERTIFICATES_2026-11-11.md`, pin `B7F4AE6E4A727265321C948B8DED6299B0EB3D2C387C039F2ACA7D579C9C4935`.

The character source is the reviewed manifest `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, pin `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`, and its review `integration/REVIEW_FAMILY_CHARACTER_MANIFEST_2026-11-11.md`, pin `EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664`. Mathlib is pinned at `56a005855ea17e0b0958f73ec801ae140b0a1679`, and Goldbach at `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

## 2. Actual CRT coordinates and primitive rows

For c=40 use dimensions (2,2,4), with input coordinate (e,f,g) and local residues

`((-1)^e*5^f mod 8, 2^g mod 5)`.

The CRT idempotents for factors (8,5) are (25,16). Their required congruences are checked exactly. The last coordinate is fastest. The resulting residue array is

`[1,17,9,33,21,37,29,13,31,7,39,23,11,27,19,3]`.

The primitive labels are (e,1,r), where e=0,1 and r=1,2,3. Their flattened indices are 5,6,7,13,14,15. The character value at coordinate (x,y,z) is `(-1)^(e*x+y)*i^(r*z)`.

For c=120 use dimensions (2,2,2,4), local factors (8,3,5), coordinates (e,f,h,g), local residues

`((-1)^e*5^f mod 8, 2^h mod 3, 2^g mod 5)`,

and CRT idempotents (105,40,96). The primitive labels are (e,1,1,r), e=0,1 and r=1,2,3, at flattened indices 13,14,15,29,30,31. The character value is the product of the corresponding three order-two signs and the positive order-four root.

For both conductors the script checks that the CRT image contains exactly the units, with no repetitions, and that the zero coordinate represents residue 1. It also independently decodes each residue using the tables

```
mod 8: 1 ->(0,0), 5 ->(0,1), 7 ->(1,0), 3 ->(1,1),
mod 5: 1 ->0, 2 ->1, 4 ->2, 3 ->3,
mod 3: 1 ->0, 2 ->1.
```

Every residue-defined character exponent is checked against its tensor-coordinate exponent for every label and unit. Every nonprincipal row has exact zero character sum. This is checked in Gaussian integers, not by a small numerical residual.

All roots needed by these two groups are exactly 1, i, -1, -i. Their rectangles are degenerate exact rectangles. Multiplication is a signed coordinate permutation. No approximate trigonometric root or unidentified algebraic root enters the transform. These values agree with the manifest's positive roots `exp(2*pi*i/m)` for m=2,4. Parity and inverse labels are retained in each output record.

## 3. Explicit Hurwitz evaluator and its error

Write q=a/c, N=64, p=12, B=N+q, and `(s)_r=product_(j=0..r-1)(s+j)`. Every q is strictly between zero and one. The finite part used is

```
F_q(s) = sum_(k=0..63) (k+q)^(-s) + (1/2)*B^(-s)
         + sum_(r=1..12) B_(2r)/(2r)! * (s)_(2r-1) * B^(1-s-2r).
```

The reviewed EM proof gives, on Re(s)>-23 away from s=1,

`hurwitzZeta(q,s)=F_q(s)+B^(1-s)/(s-1)+R_q(s)`.

The remainder is the negative periodic-Bernoulli integral with rising-factorial length 24. Its absolute bound follows from

`abs(B_24(fract x))/24! <= 4/6^24`.

This bound uses the source Bernoulli Fourier series, the elementary bound `sum_(n>=1)n^(-24)<=2`, and pi>3. No numerical zeta value or table of Bernoulli maxima is used. Integrating the positive power gives

`abs(R_q(s)) <= 4*abs((s)_24)*B^(1-Re(s)-24)/(6^24*(Re(s)+23))`.

The script uses a rational upper bound uniform over all its q:

```
E(sigma,tau) = 4*product_(j=0..23)(sigma+j+abs(tau))
              *64^(1-sigma-24)/(6^24*(sigma+23)).
```

Here `abs(s+j)<=sigma+j+abs(tau)`, sigma>0, and B>64 with a negative exponent. At sigma=1/2, `64^(1/2-24)=8/64^24` exactly. The two rational errors are approximately 9.7860*10^(-40) at s=1 and 5.7363*10^(-31) at s=1/2+10i; the exact rationals are stored in the receipt. A norm error E permits adding [-E,E] to each coordinate. This direction requires no square-root-of-two factor.

Bernoulli numbers are generated by the ordinary exact rational recurrence with B_1=-1/2, and all recurrence equations through B_24 are checked. The correction signs and the rising factorial lengths are retained; they are not replaced by absolute values in the finite sum.

At the complex sample, positive-base powers have the form

`x^(-1/2-10i) = (1/sqrt(x))*(cos(10*log x)-i*sin(10*log x))`.

The implementation uses certified log and square-root intervals and evaluates sine/cosine at the negative angle. Their finite degree cutoffs are 48, with the uniform exponential tail `2*4^48/48!` after a checked pi-based reduction into [-4,4]. Argument uncertainty is included through their Lipschitz bound 1. Integral shifts of the exponent in EM multiply by exact rational powers of B. At s=1 the powers are exact positive rational reciprocals. The final c^(-s) uses the same formulas.

Every elementary operation rounds outward to a 128-bit dyadic interval with exact inclusion checks. Thus elementary errors are included before the analytic remainder is added. No elementary exp is needed at these two particular real parts.

## 4. Why the s=1 differences are the actual source differences

This source join is essential. Define the ordinary regularized function on the EM domain by

```
H_q(s) = F_q(s) + (B^(1-s)-1)/(s-1) + R_q(s),
H_q(1) = F_q(1) - log(B) + R_q(1).
```

The quotient has a removable singularity, with the displayed value. The remainder integral is holomorphic for Re(s)>-23 by a locally uniform integrable power/log majorant, as in the reviewed EM proof. Therefore H_q is holomorphic on that connected half-plane. On Re(s)>1 it equals the convergent Hurwitz series minus 1/(s-1).

The source `NumberTheory/LSeries/HurwitzZeta.lean:89,97` regularizes its individual totalized Hurwitz value with `1/((s-1)*GammaR(s))`. Consequently the scalar assertion `H_q(1)=source hurwitzZeta(q,1)` is not used and need not be true.

Instead fix q0=1/c. On Re(s)>1,

`H_q(s)-H_q0(s)=source hurwitzZeta(q,s)-source hurwitzZeta(q0,s)`.

The right side is entire by the actual `differentiable_hurwitzZeta_sub_hurwitzZeta` theorem at line 104. Both sides are holomorphic on Re(s)>-23. Analytic uniqueness extends this equality to that entire half-plane, including s=1. This proves the precise source meaning of every centered coefficient in the receipt.

For a nonprincipal character chi, the exact character sum is zero. Therefore

```
sum_a chi(a)*H_(a/c)(s)
 = sum_a chi(a)*(H_(a/c)(s)-H_(1/c)(s))
 = sum_a chi(a)*source hurwitzZeta(a/c,s).
```

Multiplication by c^(-s) gives the actual `DirichletCharacter.LFunction` by its source finite-sum definition, `LSeries/ZMod.lean:85` and `DirichletContinuation.lean:60`. The identity is valid also at s=1. It requires no conditionally convergent Dirichlet series there and no principal-value interpretation.

The script thus stores ordinary deflated coefficient boxes, sets the reference difference exactly to zero, and subtracts its box from the others. All reference uncertainty is retained. At s=1 the coefficients and remainders are real, as follows directly from the finite formula and real periodic-Bernoulli integral, so their imaginary intervals can be exactly zero.

The principal transform row is retained only as an intermediate centered-array output. It is not multiplied and advertised as a principal L-value. In particular, no principal value or finite part at s=1 is claimed. All selected labels are primitive and nonprincipal.

## 5. Tensor computation and direct comparison

For each sample the pilot first evaluates one common array of coefficients on the full unit group, then applies an unnormalized positive transform along each axis, in coordinate order. Each stage is retained. If j axes have been processed, its exact meaning is the sum over those j input coordinates weighted by their positive character roots. Finite distributivity proves the next stage, so the final array is exactly the positive character transform of the centered coefficients.

There is no factor 1/phi(c). The final scale is c^(-s). All complex interval additions and multiplications propagate their coordinate bounds outward. Reusing coefficients introduces no independence assumption and no statistical error reduction.

For the diagnostic direct sum, the implementation iterates actual integer residues in increasing order, reconstructs each character from its local residue tables, and weights the ordinary H_q boxes without centering. Exact vanishing of the character sum justifies equivalence to the centered computation. The accumulation order and data indexing differ from the tensor path. Every one of the 24 resulting direct rectangles overlaps its tensor rectangle. Overlap is a diagnostic; the source/finite-sum identities and enclosure propagation give the mathematical justification. Independent coefficients and character checks are assigned to the separate reviewer.

For readability, the following table displays rounded centers, not replacement certificate endpoints. The receipt contains the exact rational rectangles. For c=40 the labels abbreviate (e,1,r); for c=120 they abbreviate (e,1,1,r).

| c | (e,r) | Center at s=1 | Center at s=1/2+10i |
| ---: | --- | --- | --- |
| 40 | (0,1) | 0.845086554 + 0.522292214i | 1.029582247 + 0.715659222i |
| 40 | (0,2) | 1.150086523 | 1.555304093 + 0.533843434i |
| 40 | (0,3) | 0.845086554 - 0.522292214i | 0.036366470 - 0.674635819i |
| 40 | (1,1) | 0.911940169 - 0.322771430i | 3.193558484 - 0.574437151i |
| 40 | (1,2) | 0.993458827 | 2.377996379 - 1.162689430i |
| 40 | (1,3) | 0.911940169 + 0.322771430i | 0.833108342 + 0.928043842i |
| 120 | (0,1) | 1.067755274 + 0.153725430i | 0.347245657 + 1.984269975i |
| 120 | (0,2) | 1.147147442 | 1.708094065 + 0.595324805i |
| 120 | (0,3) | 1.067755274 - 0.153725430i | 0.407585744 + 0.458370631i |
| 120 | (1,1) | 0.789456500 - 0.186365399i | 0.889191037 - 1.266421507i |
| 120 | (1,2) | 1.127932331 | 0.153339736 + 0.317411394i |
| 120 | (1,3) | 0.789456500 + 0.186365399i | 0.022226565 - 0.378995335i |

Every selected coordinate interval has width below 2*10^(-37) at s=1 and below 1.367*10^(-29) at s=1/2+10i. Same-sample inverse rows at the nonreal sample are visibly not generally conjugates; the code does not impose that false relation.

## 6. Rejection tests and retained evidence

Each of the four runs includes these deliberate mutations:

* Reversing the sign of every twiddle, while keeping output labels fixed, gives rectangles disjoint from the correct direct result at all four nonreal character labels. The two real character labels are unchanged, as expected. The bad transform is rejected; Parseval alone would not detect this permutation.
* Swapping the input residues at flattened indices 1 and 2 fails the exact residue-character exponent test. Running that corrupted permutation through the tensor calculation also gives disjoint selected rectangles for all six labels at both samples and conductors.
* Changing the selected first label's five-power coordinate f from 1 to 0 fails the primitive predicate. At c=40 its conductor drops below 40, and at c=120 below 120. It is not accepted merely because it is still a valid ambient character.

The receipt contains 96 ordinary deflated coefficient records and 96 centered coefficients, 352 tensor-stage entries, all full centered transform outputs, 24 selected rows with parity/inverse labels, and their direct diagnostic rectangles. Each coefficient record includes q, B, its finite head sum, B^(-s), half term, all twelve Bernoulli corrections, pole-difference term, analytic error bound, and final deflated box. The exact parameters and helper pin allow deterministic replay of each omitted individual head term. No external library result is accepted as a coefficient oracle.

## 7. Runtime and remaining proof boundary

The single pilot completed in 11.0055 seconds of measured wall time and 10.96875 seconds of CPU time. The retained execution session was 68823; it finished with exit code zero and no live process remains. A bounded guard stops the computation before ten minutes. These are Python measurements only, with no Lean runtime implication.

The computation has no missing elementary numerical primitive for these samples. Formal use would still require the rational interval checker, the reviewed EM/ordinary-deflation source join, exact CRT/character identification, and the tensor finite-sum correctness proof to be implemented and checked in Lean. This experiment does not supply any of those proof terms. The two small conductors and two isolated samples support a transform prototype only; they do not establish a full-family cost, contour coverage, or a finite spectral conclusion.
