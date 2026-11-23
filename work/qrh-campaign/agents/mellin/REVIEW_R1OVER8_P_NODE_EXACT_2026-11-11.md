# Independent review of the complete rational r=1/8 P node

2026-11-11. **PASS at paper proof plus exact external arithmetic scope. No correction requested.** This packet reaches the actual P value at

`w=1/8+i*(pi/4-1/1000001)`,

with absolute error less than `2^-128` about the producer's exact 192-bit dyadic center. It is not merely a transport calculation. The finite theta terms, full omitted tail, elementary functions, five derivative transforms and final prefactor are all covered. No numerical oracle is an acceptance premise.

The exact enclosures also prove `Re(P)>10^12` and `Im(P)<-2*10^12`. The approximate value `1.089752494945126e12 - 2.208954416969382e12*i` is explanatory only. This result concerns one point, not any contour or spectral assertion, and is not a Lean proof.

## Frozen artifacts and independent computation

Paths are relative to `work/qrh-campaign/agents`.

| Item | SHA256 |
|---|---|
| `integration/R1OVER8_P_NODE_EXACT_2026-11-11.md` | `C11F586345B4C9F4C2FDD9A0B927902B323E53C9796AB06E509460454BA128A6` |
| `integration/r1over8_p_node_exact_20261111.py` | `4EE532C9698CCD8B462D40A1D102CE6DAD35741173C7D43F911C3AE7B2F15286` |
| `integration/r1over8_p_node_exact_20261111.json` | `DDF8B38A52FEBB70F019E805068ED4480CB086C8A27A00A86DAA0D05882AF584` |
| Independent `mellin/review_r1over8_p_node_exact_20261111.py` | `0F0576795660C1342F936454F8DBD447C8A921B33633C5D3DAEA891A80BDE132` |
| Independent `mellin/review_r1over8_p_node_exact_20261111.json` | `B65E9FF0EFE985507E17CF033E6D03A3E4C73C6AD50CE2119FC63F39D2FD89BD` |

The author's read-only recomputation passed. The independent script also passed, importing neither the author implementation nor any numerical library. It uses a 384-bit outward grid instead of 320, 140 arctangent terms instead of 128, degree-99 Horner exponential polynomials instead of degree-95 recurrence, a full 168-term complex Taylor polynomial instead of separate even/odd recurrences of total length 160, and five paired theta2 modes instead of four. It applies the S transforms by explicit triangular matrix multiplication and computes the fourth inverse power by a different multiplication order.

Its entire resulting box lies within `2^-128` in the l1 metric of the producer's exact reported center. Since Euclidean distance is bounded by l1 distance, this independently verifies the claimed center and radius. Intersection of the two boxes was checked as a consistency observation, but is not used as the proof of either enclosure. Neither old external P samples nor floating-point agreement is used.

## Seed, word and actual normalization

The accepted seed is the r=1/8 product

`tau=exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))=i*exp(2w)`.

It is distinct from the earlier r=0 seed. The seed review is pinned at `0D17AC890A1E87D8B226484B78B32B085EC87753E26998AF02D0F5F47C4955E8`; the full-word review is pinned at `5F6D22F549CF251EC44DAC4D436DAD0FF5A077902C22B81978F359AECAAC6C28`. Their exact boxes and principal-root identifications are reused, not regenerated or replaced by unrelated approximate points.

The type chain under the six translations and five inversions is

`theta3 -> theta4 -> theta2 -> theta2 -> theta4 -> theta4 -> theta2 -> theta2 -> theta4 -> theta4 -> theta2 -> theta2`.

Only translations 4, -12 and 6 act on theta2; their factors are -1, -1 and -i. The initial odd translation swaps theta3/theta4 without an extra phase. The code correctly starts reconstruction with -i at the terminal point, then inserts -1 after inverse stages 3 and 1. The product is -i, but none of the five local A factors or their derivatives is discarded.

For each S step, at its own t, the holomorphic identity with `A=1/sqrt(-i*t)` gives

`f=A*g`,

`f'=A*(-g/(2t)+g'/t^2)`,

`f''=A*(3g/(4t^2)-3g'/t^3+g''/t^4)`.

Independent differentiation verifies all coefficients, particularly -3 in front of g'. The g derivatives are with respect to their own argument -1/t. Translation derivatives are one. The code uses the corresponding t and A from each stage and propagates all three entries; there is no confusion between a derivative in the transformed argument and a composition derivative.

The final prefactor is correctly `exp(1/16)*cis(pi/8-1/2000002)`, not a unit-modulus number. The final formula

`P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))`

expands to the accepted positive-index kernel with coefficients `-12*pi*n^2*exp(5w/2)` and `8*pi^2*n^4*exp(9w/2)`. It retains the actual unhalved-xi normalization. The analytic theta and xi plans are pinned by the independent checker; their remaining formalization obligations are not silently treated as existing Lean declarations.

## Elementary function enclosures

Every ordinary arithmetic operation is on full rational input intervals. Outward floor/ceiling rounding contains its exact range. Complex reciprocal uses positive squared-modulus lower bounds; forgetting numerator/denominator correlation only enlarges the result. The current code is permitted to be less sharp than the earlier exact reciprocal-extremum checker because it accepts the resulting larger enclosure rather than trying to fit a prescribed narrow output.

For pi, the producer's even 128-term arctangent sums are lower bounds and adding the next term gives upper bounds. The terms decrease geometrically for 1/5 and 1/239. Machin's subtraction reverses the second interval's endpoints. I inspected `Real.four_mul_arctan_inv_5_sub_arctan_inv_239` at `Trigonometric/Arctan.lean:336` and `Real.hasSum_arctan` at `Complex/Arctan.lean:144` in the pinned Mathlib tree. The independent computation uses the same source identity with different, longer rational sums.

For positive exp, halving produces t<=1/2. The first 96 terms are nonnegative; the producer's upper tail `2^-96*97/(96!*96)` is exactly a conservative specialization of `Real.exp_bound'`. Alternatively, each later term ratio is at most 1/194, so the stated factor 97/96 safely exceeds the required geometric factor. Squaring preserves a positive interval enclosure; reciprocal handles negative arguments; monotonicity permits separate endpoint evaluation. I inspected `Real.exp_bound` and `Real.exp_bound'` at `Complex/Exponential.lean:516,523`. The independent degree-99 calculation uses the geometric factor `202/201` after the first omitted term `2^-100/100!`.

For cis, the integer k is only a proposed range-reduction index. What matters is the verified full interval inclusion `X-2*k*Pi subset [-4,4]`. Each actual angle is reduced by the same integer times the actual pi. Periodicity then applies regardless of whether the proposed integer was the closest possible one. The producer recurrences contain the real and imaginary parts of all polynomial terms of degrees 0 through 159. `Complex.exp_bound'` at `Complex/Exponential.lean:407`, with `|y|/161<=4/161<1/2`, bounds the full complex remainder by `2*4^160/160!`; each coordinate error is bounded by that number. Evaluating interval polynomials is sound even across trigonometric turning points. The independent full complex Taylor calculation uses N=168 and its corresponding remainder.

Thus the elementary routines require only exact finite arithmetic and the stated analytic series/periodicity facts. No computed transcendental value is assumed correct merely because a library returned it.

## Complete theta tail and error accounting

The terminal box has Y=Im(v)>=9. The code evaluates the paired modes a=1/2,3/2,5/2,7/2 of

`theta2^(j)(v)=2 sum_(n>=0) (pi*i*a^2)^j exp(pi*i*a^2*v)`.

The factor two and absence of a zero mode are correct. For all j<=2 and a>=1/2,

`2*(pi*a^2)^j exp(-pi*Y*a^2) <=64 exp(-2Y*a^2)`.

This follows from `(pi*a^2)^j<=16a^4`, `a^4<=2exp(a^2)` and `3Y-1>=2Y`. With u=9/2 and `(u+k)^2>=u^2+k`, the whole omitted tail is at most

`64 exp(-2Y*u^2)/(1-exp(-2Y)) <=128 exp(-364)<=2^-357`.

It is a norm bound for each derivative, so widening both coordinates by that amount is safe. The independent five-mode calculation starts its tail at u=11/2 and uses `2^-537`, since `2*9*(11/2)^2>=544`.

The producer's separately reported tail-only norm amplification is valid: it bounds the actual analytic tail under the exact complex linear transforms. It is not the radius of the enlarged coordinate box. That distinction is explicit in the report. Every coordinate widening and every coefficient/rounding uncertainty also passes through the full interval calculation, whose final l1 radius is checked directly. The tail-only bound is not added twice, nor substituted for the total error.

## Verdict boundary

The complete result is a nonzero P enclosure for this one prescribed point. The initial seed is now supported by its separate accepted rational certificate; the word is supported by full-input arithmetic; the new elementary and theta-series arguments reach the actual kernel. There is no remaining numerical-oracle premise within this bounded paper argument.

The scripts are external exact computations, not verified executables or Lean proofs. Formalizing the analytic adapters, interval-operation soundness and finite arithmetic remains open. The author's four output mutation checks are accurately described as serialization consistency checks, not independent semantic fuzz tests. No whole panel, Fourier integral, zero count, additional node or family claim is accepted. All previous frozen artifacts were preserved.
