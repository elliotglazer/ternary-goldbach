# Independent review of finite EM coefficient semantics

2026-11-11. **PASS as a source-faithful paper derivation and formalization plan.** No blocking mathematical or API defect was found. This review does not establish a Lean theorem or validate native coefficient boxes by kernel computation.

## Bound version and inspected sources

The reviewed file is `agents/major-constants/EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md`, SHA256 `ADE7149EE7D5C3586A2AA7267C39363828747D801DE5EF1F4508A21B737F69D3`.

The following hashes were independently checked before acceptance:

| Source | SHA256 |
| --- | --- |
| `mellin/psi_head_counts_20261111.py` | `D7F187FA357EACA184A2214F8952B396B9D2DF42348580993005B7DA00252A9A` |
| `zero-sum/em_top_horizontal_20261111.py` | `F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10` |
| `major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md` | `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485` |
| `moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md` | `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1` |

Direct source reads used the local Mathlib checkout at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`; `git rev-parse HEAD` returned the required `56a005855ea17e0b0958f73ec801ae140b0a1679`. The target project's source pin is `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

This review compared the actual expression trees and read the named API signatures. It did not run a Lean build, change canonical or frozen files, or rerun the full numerical producers. The separately completed top-2000 cross-check is not a substitute for the general semantics argument reviewed here.

## 1. Expression, index and factorial audit

Both producers sum the positive bases n=1 through N, put B=N+1, and evaluate

```
D(s) = sum_n exp(-s log n) + exp(-s log B)/2
       + exp(-s log B) * sum_(k=1..M) b_k B^(1-2k) (s)_(2k-1),
g(s) = (s-1)D(s) + exp((1-s)log B).
```

The half term is inside D. The last exponential is outside multiplication by s-1. Inspection of `Evaluator.finite` and top `model` confirms these parentheses. At height 1500 the head chooses N=500 and B=501. At height one million the top chooses N=333334 and B=333335. The Bernoulli recurrence has B_1=-1/2; correction coefficients retain their signed values.

The loop `range(1,2*M)` multiplies by `s+j-1` before retaining odd j. For M=32, this produces rising-factorial lengths 1,3,...,63, including the final k=32 term. The EM error separately uses factors indexed 0,...,63, hence length 64. No correction or remainder index is shifted by one.

The coefficient recurrences are correct:

* E_n[j]=exp(-c log n)(-log n)^j/j! follows from its stated recurrence, including E_1[0]=1 and E_1[j]=0 for j>0.
* Multiplication of the polynomial `(c+z)_r` by `c+r+z` gives `P_(r+1)[j]=(c+r)P_r[j]+P_r[j-1]`. All uses of the old array are necessary; an ascending in-place update would not implement this rule.
* Finite convolution gives D[j], and multiplication by c-1+z gives `G[j]=(c-1)D[j]+D[j-1]+H[j]`. The negative index is zero, particularly at j=0.
* H[j]=B E_B[j] is an exact identity for B>0. Independent exponential evaluations need only contain their respective exact constants; their interval boxes need not coincide.

Every G[j] is the normalized derivative `g^(j)(c)/j!`. Dividing again by j! in Horner evaluation would be wrong. Conversely using raw derivatives directly would be wrong. The proposed statement and both source arrays use the normalized convention consistently.

Truncation after every finite addition/product is sound below K: coefficient j only refers to pairs r,j-r with both indices at most j<K. Discarded high coefficients cannot affect a retained coefficient. This proves finite coefficient agreement; it does not assert equality of a truncated polynomial with the analytic function away from its center.

The optional recurrence for exp of a general analytic series follows by comparing coefficients in E'=A'E: `n e_n=sum_(j=1..n) j a_j e_(n-j)`. The actual head and top only need affine A, where it reduces to E_n's elementary recurrence.

## 2. Checked Mathlib interfaces and convergence

Paths below are relative to the pinned Mathlib directory.

| API inspected directly | Relevant exact content |
| --- | --- |
| `Analysis/Calculus/IteratedDeriv/Lemmas.lean:309`, `iteratedDeriv_add` | Additivity under `ContDiffAt` hypotheses. |
| Same file `:366`, `iteratedDeriv_const_mul` | Constant multiplication under finite differentiability. |
| Same file `:418`, `iteratedDeriv_mul` | Sum over `range(n+1)` of `choose n i * iteratedDeriv i f * iteratedDeriv (n-i) g`. |
| `Analysis/Calculus/IteratedDeriv/Defs.lean:339`, `AnalyticAt.hasFPowerSeriesAt` | Precisely the scalar array `iteratedDeriv n f x / n.factorial`, over a complete nontrivially normed characteristic-zero field. |
| `Analysis/Analytic/OfScalars.lean:38,85` | `ofScalars` and `coeff_ofScalars` recover the scalar coefficient with no additional factorial. |
| `Analysis/Normed/Algebra/Exponential.lean:487-496` | Exponential HasSum, global power-series radius and analyticity. |
| `Analysis/SpecialFunctions/Exponential.lean:209` | `Complex.exp_eq_exp_ℂ` identifies the complex and normed-algebra exponentials. |
| `Analysis/Normed/Ring/InfiniteSum.lean:153` | `hasSum_sum_range_mul_of_summable_norm` gives the Cauchy convolution of absolutely summable series. |
| `Analysis/Calculus/IteratedDeriv/ConvergenceOnBall.lean:27` | `AnalyticOn.hasFPowerSeriesOnSubball` additionally requires the selected radius be no larger than the formal series radius. |
| `Analysis/Complex/Liouville.lean:42` | Cauchy's bound requires R>0, `DiffContOnCl` on the ball, and the sphere bound; conclusion is `norm(iteratedDeriv n f c) <= n! C/R^n`. |

The factorial division of Leibniz's formula gives ordinary convolution because `choose(n,i)i!(n-i)!=n!`. All denominators are nonzero over the complex numbers. Entire finite g discharges the differentiability hypotheses.

`AnalyticAt.hasFPowerSeriesAt` alone does not imply convergence on an arbitrary requested panel. The plan correctly supplies the missing step: each exponential expansion converges absolutely everywhere, polynomial factors have finite support, and the Cauchy-product API preserves convergence of their finite products and sums. Alternatively one may establish the needed radius lower bound before invoking `hasFPowerSeriesOnSubball`. Thus no unjustified radius extension is used.

## 3. Primitive enclosure audit

Real endpoint operations, the four-product hull, complex multiplication, positive rational division, and outward dyadic floor/ceiling all preserve containment. True floor/ceiling are needed at negative values. Forgetting correlations between reused logarithm constants is conservative rather than unsound.

For positive rational b=2^m u, 1<=u<=2 gives v=(u-1)/(u+1) in [0,1/3]. The proposed FTC identity and finite geometric expansion yield

```
log u = 2 sum_(j<p) v^(2j+1)/(2j+1) + R,
0 <= R <= 2 v^(2p+1)/((2p+1)(1-v^2)).
```

Indeed the remaining integrand is `2 t^(2p)/(1-t^2)` on [0,v]; replacing its denominator by 1-v^2 and integrating gives exactly the stated tail. There is no missing factor 2 or shifted exponent. The u=1 endpoint gives zero remainder. Multiplication by a negative scale m reverses log2 interval endpoints, as required. The proposed interval arithmetic handles that sign.

For the exponential, let 0<=r<=1/2 bound every norm in the scaled box, and truncate after degree p. The first omitted term has norm at most `r^(p+1)/(p+1)!`; all subsequent ratios are at most r/(p+2). The geometric sum therefore gives the displayed radius

`r^(p+1)/(p+1)! / (1-r/(p+2))`.

Its denominator is strictly positive. Enclosing a norm error by the same error in both coordinate directions is sound. The identity `exp(w)=exp(w/2^m)^(2^m)` then permits m interval squarings. Each multiplication encloses the square of every contained exact point; interval dependency loss can widen the result but cannot omit that point. A finite box bound on |Re w|+|Im w| is sufficient to choose the scale, so no unproved square-root or argument-reduction routine is necessary.

These are sound mathematical wrappers. Their existence does not establish that a particular precision produces narrow enough boxes. A checker must reject a box it cannot verify, refine the witness, or use its own certified wider boxes and pass the final separation tests. The note explicitly preserves this distinction and does not accept FLINT as a proof oracle.

## 4. Enclosure induction and the two remainders

Induction on E/H coefficient indices, then rising-factorial length, then the finite expression tree proves containment of every exact G[j]. Denominators j+1 are positive. Truncated convolutions use only retained coefficients. This is a coherent small proof structure independent of a native series implementation.

Horner evaluation must use the displacement from the exact c. Both producers first form exact rational differences and only then convert to intervals. Given coefficient inclusion, interval Horner encloses the polynomial on the whole supplied displacement box.

Cauchy gives `|G[j]|<=C_out/R^j`. Absolute convergence and the geometric tail for 0<=h<R give

`|g(c+z)-sum_(j<K)G[j]z^j| <= C_out (h/R)^K/(1-h/R)`.

No factorial survives this expression. The finite entire g is the function to which Cauchy applies; the outer circle can extend beyond the region where the EM remainder bound is valid.

The separate zetaF-to-g error has factors of length 2M and bound

`(S+1) 4 product_(j<2M)(S+j) B^(1-sigma0-2M) /
 (6^(2M)(sigma0+2M-1))`.

Its underlying EM domain requires `sigma0+2M-1>0` and B>1; both source parameter sets satisfy these requirements. The head uses sigma0=-1/10 and h<=1/10; the top uses sigma0=1/2 and h=1/8. The outside factor S+1 bounds |s-1|. The two norm errors add by the triangle inequality before the top's value-level division by s-1. The top denominator excludes zero by its fixed positive imaginary part. The head targets entire zetaF and performs no such division near s=1.

The top outer sum estimate `N max(1,N^(-sigma))` is valid for positive integer bases: if sigma>=0 each summand is at most 1; otherwise each is at most N^(-sigma). The head's termwise bound is also valid. Neither is a claim about the sum of absolute coefficient values.

An externally supplied EM or exprel error box is only a pointwise remainder enclosure. It cannot be differentiated to obtain Taylor coefficients. The plan correctly requires expansion of the explicit finite analytic expression, followed by separate bounds for all remaining errors.

## 5. Acceptance boundary

The note's claim is accepted: it supplies a complete paper derivation of the intended finite coefficient rules and their interval inclusion invariant, with applicable existing analytic APIs. It does not claim those wrappers or the concrete numerical witnesses have been kernel checked.

In particular, overlapping native and independent coefficient boxes is not a proof that the proposed native box contains the exact coefficient. The stated alternatives are sound: prove the native operation semantics, or use an exact checker whose proved output is contained in the proposed box, or use the checker's output itself. The head geometry-only data and top stored-coefficient data require different replay interfaces but share the same exact invariant.

The nonprincipal discussion is accepted only as reuse of those algebraic rules for a separately pinned finite expression. Its Hurwitz shift B=N+a, character-transform convention, pole cancellation and exprel remainder still need the corresponding exact analytic target and proofs. This review adds no unproved spectral premise and makes no full-family or final Goldbach closure claim.

No correction to the frozen note was required. No Lean launch, new dependency, canonical edit, native_decide proof step or axiom was introduced.
