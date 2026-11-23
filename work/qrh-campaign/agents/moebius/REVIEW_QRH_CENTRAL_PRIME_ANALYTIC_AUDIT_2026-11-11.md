# Independent review: central prime sum and actual phase bins

Verdict: **PASS for the bounded source/mathematical implication described below.** No correction to the frozen author report is required. The phase signs, actual character comparison, finite contour normalization, selected-product coupling, exponents and uniformity agree with the source. This is not a full validation of the provider or its lower analytic estimates.

## Evidence and scope

Source root: `work/openai-math/lean/OAI/NumberTheory/DirichletL`, provider commit `4eaee87548250b2682affda7d05d947c05554bae`. The accompanying `check_central_prime_source_20261111.json` pins the 39 files read independently and records successful byte-hash verification of all 43 source pins in the author report. The script performs nine elementary exact rational checks and hashes those source bytes. It does not elaborate Lean, evaluate an L-function, or check the transitive axiom closure.

Author report: `integration/QRH_CENTRAL_PRIME_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `BC79FCD3332ABCF42E19A29ABC594685C98599C4038079957C09795190328376`, read in full. Its scope and list of lower obligations are accurate. The local wrappers `CentralSplit`, `CentralNormalized`, `CentralRamified`, `CentralProduct` and `CentralCosts` were also read to check the author's claims about actual slots, nonzero correction denominators, principal-target handling and full finite factorization; the deeper local Gauss estimates remain outside the verdict.

Reproduction artifacts, in the same directory as this review:

| Artifact | SHA-256 |
|---|---|
| `check_central_prime_source_20261111.py` | `46A648CF15B5EC9D4699A49D309F28D6223093041477B091B36A9476B716D18F` |
| `check_central_prime_source_20261111.json` | `18A92FDEBE658D23FFFB2AE977C039405A0FF6D6FBE93C0657D17B0D38F046DB` |

The checker exited successfully. These elementary arithmetic checks supplement the source derivations; they are not evidence for the analytic estimates.

The main independent focus was the actual phase amplitude and the prime estimate, from `Detector/RayPhaseBins` through `Hecke/PrimeAmplitudeActual`, `PrimeBin`, and the finite Mellin-contour proof. I also independently read the three-branch product, selected repeated product, fixed-primitive allocation, and final arithmetic assembly. Lower inputs listed in the last section are explicit boundaries of this review, not newly proved facts.

## Actual objects, phase and ray average

`Hecke/PrimeRow.lean` defines the canonical amplitude by the actual ideal-row coefficient on the ray identity class, with conjugation and normalization `D^(-1/2)`. `Detector/RayCharacterFamily.lean:73` identifies it with `rayPrimePolynomial` of `(rawRow u).inverse`, at real parameter `1-Re z` and frequency `Im z`. The complex weight W is not conjugated. The identity uses the actual inverse-character coefficient identity and the raw-row/ideal-row comparison outside S.

In `Detector/RayPhaseAmplitude.lean:64`, the original phase sum is exactly

\[
 -D^{z-1/2}Q,\qquad
 Q=D^{-1/2}\sum_{P\ \text{prime, ray identity}}
 \overline{\operatorname{row}_u(P)}W(NP/D)(NP/D)^{z-1}.
\]

Its norm is `D^(Re z-1/2)*norm Q` (line 91). In particular `Re z=17/50` gives the required `-4/25`, and the prime-polynomial real parameter is `33/50`. Positive norms and D justify the complex-power quotient identities; there is no unnoticed logarithm branch factor.

The pool-to-annulus comparison at `RayPhaseAmplitude:22` is exact. The support is contained in the *open* interval `(A,B)`, with A>0. Once every excluded ideal has norm at most AD, its weight is zero, including equality at AD. Lower-floor omissions and annulus additions have zero weight as well. `power_fixed_exclusions:104` makes this uniform in all allowed d and r using `d*r >= dmin*rmin>0`. No discarded-prime error or unproved smallness estimate is used.

`Hecke/PrimeRay.lean:25,45` applies exact finite ray orthogonality. The identity is the average over all quotient characters with factor `classNumber^(-1)`. At line 61 the triangle inequality cancels this factor against the number of characters, which is positive and equal to the class number. There is no extra conductor or class-number loss. This does not assert that arbitrary individual twists are nonprincipal.

## Nonprincipality, conductor and buffered height

`RayCharacterFamily:36` proves nonprincipality only for sufficiently large *supported FreeRows*. If a twist were principal, the inverse twist and primary-generator coefficient identities force the row's prime support into a fixed set depending on M, the row mask, and 72. The FreeRow exponent restriction then gives a fixed norm bound, contradicting largeness. The local support theorem and exceptional-row norm estimate remain lower algebraic inputs. The eventual theorem at line 98 is uniform over quotient labels; it is not a separate threshold selected for each character.

The conductor comparison at line 65 is

\[
 N\mathfrak f_{\text{twist}}\le C_{\rm row}\,NM\,N(u).
\]

`PrimeRows/CubePhaseBins:17` absorbs this fixed factor using the strict row margin `N(u)<=Z^(d-nu)` with nu>0. The lower norm hypothesis `Z^delta<=N(u)` supplies the nonprincipal threshold. Nonzero calibration supplies supportedness. These are separate requirements; none follows from a generic choice of ray character.

`RayCharacterFamily:109,121` compares the twist family's actual zero maximum to the source family's detector maximum, using its inclusion as a source-family summand. The floor case is handled separately. The conclusion is valid with the nonprincipal family already established; the proof does not insert QRH as an input.

For the cube, `|Im z|<=(3i+1)Z^tau` leaves room for the contour half-height `Z^tau/2`, inside `(3i+2)Z^tau`. The strict budget `2tau<dmin*cost` and fixed i<=n make `(3+(3i+2)Z^tau)^2 <= (Z^d)^cost` eventually uniform. The source zero maximum is taken at the larger height `3(i+1)Z^tau`. Neither the conductor factor nor this buffered height is omitted.

## Prime estimate: the checked analytic implication

`Hecke/PrimeDyadic.lean` defines the series as **`-deriv L/L`**, with coefficients `Lambda(I)*idealCoeff chi I`. Its `series_eq_tsum` uses the Hecke logarithmic-derivative identity in `Re s>1`; `twisted_coefficient_summable` supplies absolute summability there. `polynomial_mellin` then applies weighted Mellin inversion to a smooth compactly supported W, giving factor `1/(2*pi)` with the actual normalized `D^(-1/2)` polynomial. This checks the consumer-side hypotheses and normalization, not the proof of that lower inversion theorem.

`PrimeDyadicContour.polynomial_finite_shift` splits the absolutely integrable right vertical line into a finite segment and its complement. The finite rectangle identity replaces the segment by the left segment plus `I*(bottom-top)`. It needs nonvanishing on the *whole translated closed rectangle*. It does not silently send the horizontal edges to infinity or interchange a conditionally convergent series. Nonprincipality supplies entire L; local nonvanishing supplies holomorphy of `-L'/L`.

`PrimeDyadicEstimates.polynomial_bound_of_rectangle` bounds the left segment, both finite horizontal joins, and the right-line exterior tail. The left line is `a+8e-sigma`; the right line is `2-sigma`. Thus the normalized central power is `D^(a-1/2+8e)`, and the external power is `D^(3/2)`. Cauchy-kernel integration supplies pi in the vertical bounds. The two horizontal edges retain the width `|2-a-8e|`, bounded by 2 later.

The rectangle nonvanishing and logarithmic-derivative bound come from `PrimeDyadicControl.buffered_rectangle_control`. Its primitive-disk input is supplemented with an actual finite-deletion logarithmic derivative. In the primitive reduction, original L=primitive L times deletion factors in the positive half-plane; original nonvanishing implies primitive nonvanishing. The extra term `localBound(1/2)*log(N(radical modulus))` is retained in `binCost`. This is stronger bookkeeping than treating an imprimitive character as primitive for free.

`PrimeDyadicScale` and `PrimeDyadicScaled` use conductor norm <=U and the height-cost bound to obtain

\[
 \operatorname{binCost}\ll \log U\ll_{\kappa}U^\kappa.
\]

For D=U^r, 0<=r<=R, the central term is therefore
`O(U^((a-1/2+8e)r+kappa))`; the external term is
`O(U^(2R+kappa)/(1+Z^tau/2)^n)`.
`DyadicTailBudget.uniform_external_tail_order` chooses one n from tau,dmax,R,kappa before Z,d,a,i and the characters. `PrimeDyadicSource` uses uniform Mellin decay for the log-profile parameter in `[0,1]` and the fixed real strip `[-sigmaMax,2-sigmaMin]`. The inequality `8eR+kappa<=epsilon` bounds the central exponent by `(a-1/2)r+epsilon`; the tail becomes a constant, absorbed because that final exponent is nonnegative.

Finally `PrimeAnnular:35` converts the log-profile polynomial exactly to a finite sum with coefficient `Lambda(I)/log(NI)`. `PrimePowers.sum_prime_extraction` subtracts the prime-only sum, leaving just proper prime powers. Their coefficient has norm at most 1. Proper prime powers are powerful ideals, so `powerful_ideal_count` gives the extraction error `O(X^(1/2+xi))`; normalization gives `O(D^xi)` with a fixed support factor. `PrimeBin:13` chooses `xi=epsilon/(R+1)`, so `r*xi<=epsilon`; `a>=.51` makes this error compatible with the same upper bound. The compact profile norm is uniform in sigma and independent of frequency. The powerful-ideal counting estimate itself remains a lower input here.

## Capped bins and selected products

`Hecke/PrimeAmplitudeBins:11` uses zero separately, then the clamped floor of `log(norm Q)/(mesh*log D)`. This prevents a logarithm-of-zero argument. It gives finite labels `{0,cap}` together with mesh multiples up to the ceiling, where cap=`a-1/2`.

Clamping at cap **does not alone prove** `norm Q<=D^(g+mesh)`. `PrimeAmplitudeScale` first absorbs the uniform analytic constant using

\[
 \epsilon<r_{\min}\,\mathrm{mesh},\qquad
 d_{\min}(r_{\min}\mathrm{mesh}-\epsilon)>0.
\]

This gives the cap-level upper bound, which the cap branch actually consumes. Conversely, a positive bin gives `D^g<=norm Q` directly from the floor, hence `U^(2rg)<=norm Q^2`. These two directions have different premises. The finite zero-bin and cap-bin branches are both present. `product_upper` retains the sum of mesh losses, while `common_bin_selection` only applies the positive-bin lower bound on the selected positive labels.

At `Detector/CentralAllSlots`, each normalized slot is phase + regular error + repeated term. The regular sum costs `C_regular*N(u)^eps*Y^(-4/25)`. The repeated terms are controlled *jointly* with the one row-L factor, for every selected subset. In `RowReflectedAllocation`, one primitive character is selected before the finite prime set and its multiplicities. For multiplicity v>=2,

\[
 -(1-a-6e)\le(v-1)(a-1/2+6e)-1/2.
\]

The conductor deficit for that same primitive character therefore extracts a factor `(NP)^(-1/2)` at each selected repeated prime. Calibration zero is treated directly; nonzero calibration proves row nonprincipality. The pointwise repeated coefficient contributes `(NP)^(Re z)`, leaving `(NP)^(Re z-1/2)` as required. No independent choice of a favorable primitive character for each selected factor is allowed or made.

`CentralRepeatedSubset` includes the empty subset. Its estimate then controls the row L-factor alone. `CentralBranchProduct.coupled_product_bound` expands finite products and applies the joint estimate to each complementary subset, retaining one row L-factor. `three_branch_bound` uses p_j>=1 and returns `(E+2)^N`, not a product of N independent row-L costs. Absorbing `E=C_regular*N(u)^eps` gives the additional `N(u)^(eps*(N+1))` after the repeated-sum prefactor.

## Final central exponent and uniformity

`PrimeRows/CentralTargetCost` bounds the remaining scalar by

\[
 C\,N\eta^{2\varepsilon}N(u)^{3\varepsilon}(3+H)^{2\varepsilon},
\]

and the row cost by
`C*N(u)^(a-1/2+12e+4eps)*(3+H)^(2+2eps)`.
Together with the all-slot factor this gives exactly the declaration at `Detector/CentralPrimeSum:13`:

\[
 C\,N\eta^{2\varepsilon}
 N(u)^{a-1/2+12e+(N+8)\varepsilon}
 (3+(3i+2)T_0)^{2+4\varepsilon}
 \prod_jY_j^{-4/25}\prod_jp_j.
\]

The source theorem fixes N,e,eps,c,d,B,S and its source-exclusion/first-tail properties before choosing C. The subsequent constant is uniform over u, eta, the finite auxiliary character family, a,i,T0, prime pools, all permitted W,Y and x,w,z. The phase-bin eventual Z threshold may depend on the fixed modulus/ray data, support, smooth W and parameter budgets; it is not uniform in arbitrarily changing these fixed data. The central theorem itself assumes the phase-slot bounds and does not demand an imaginary-height bound on z; the cube/phase construction supplies the needed height restriction when producing those bounds.

## Remaining proof boundary

The checked implication still depends on genuine mathematical estimates and identities below this cut:

1. Primitive `HeckeLogarithmicActual.disk_control`, the buffered regular/reflected estimates and their analytic growth/functional-equation inputs.
2. Finite-deletion identities and derivative bounds; actual primitive reduction and conductor-deficit construction.
3. Weighted Mellin inversion, compact-profile vertical decay, and the Hecke Euler/logarithmic-derivative identities used on `Re s>1`.
4. The powerful-ideal count and selected/divisor-weighted sum estimates underlying extraction, regular-error sums and repeated-prime summation.
5. Actual local Gauss-polynomial/central-slot identities and numerical local estimates, plus raw-row reciprocity, supported-row nonprincipality and exceptional-support norm control.

These are the next lower proof obligations, not assumptions added to the desired final theorem. This review does not validate the entire imported source closure, check compiled declarations, or certify that the global 7/8 result is mathematically complete. No Lean build, L-value evaluation, numerical spectral computation, or author/source modification was performed.
