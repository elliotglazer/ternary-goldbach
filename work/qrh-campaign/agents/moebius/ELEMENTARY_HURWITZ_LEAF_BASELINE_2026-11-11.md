# Elementary leaves for the shared Hurwitz seed circuit

2026-11-11. Paper construction and integer/rational metadata only. No log, root, cis, seed, prime or transform values were generated. No builds or source changes were made. This supplies an explicit independent-leaf baseline for the shared seed circuit. The separate grid-recurring construction belongs to zero_sum's task.

## Contract and source status

Let x=A/D be an exact positive rational with 1<=x<=3389, and t an exact rational with |t|<=10000. For an integer p>=1 set delta=2^-p. The target is the actual critical-line power

    B_x = x^(-1/2) exp(-i t log x).

The circuit below produces a dyadic complex center with absolute norm error <delta. It also separately supplies a log center and an inverse-square-root enclosure. Fixed-width input boxes or arbitrary noncomputable real inputs are not covered by this precision/termination statement.

The existing `SHARED_HURWITZ_EM_SEED_CIRCUIT` reduces its elementary inputs to precisely these functions and this x-domain. It does not contain the resulting values. Its unscaled height10000 rows require B_x error bits313,348,374,383,417 for P20,24,27,28,32. A newer scaled-jet proposal uses118 bits but remains a separate allocation until reviewed. The examples below include118 only to price that possible contract; they do not approve it.

Existing accepted ingredients are:

* `INTERVAL_PRIMITIVES_SOURCE_PLAN`: rational/complex interval semantics, square-root comparison witnesses, atanh logarithms, Machin pi and complex exponential tails.
* `FINITE_EM_RATIONAL_ELEMENTARY_BUDGET` and `FINITE_EM_INNER_ROUNDING_ALLOCATION`: explicit log2/pi caches, rounded Horner identities and error recurrences. Their old fixed lengths512/256/513 and input bounds1025/2^14 are not silently reused here.
* `SIGNED_DYADIC_ROUNDING_WITNESS_PLAN`: exact nearest-ties-toward-positive-infinity rounding, including negative inputs and operand-size caveats.

This note extends those mathematical schedules to rational x<=3389, |phase|<=100000 and variable p. The composed new theorem is not implemented in Lean or MM0. Integer/rational witness checks can use ordinary PA; their interpretation as statements about actual analytic functions still requires the analytic foundation and soundness lemmas. PA arithmetic by itself is not an already completed real-analysis library.

## 1. Logarithm and shared log2

Put ell=p+17, eta=2^-ell, and

    N=ceil((ell+6)/3)=ceil((p+23)/3), h_L=2^-(ell+8).

Choose and check k in {0,...,11} such that x=2^k u with 1<=u<2. This is exact rational range reduction; x<4096 guarantees the bound. Set v=(u-1)/(u+1), so 0<=v<1/3. For the shared log2 use v=1/3. Evaluate

    P_N(v)=2v sum_(j=0..N-1) v^(2j)/(2j+1)

by the recurrence w_N=0, w_j=1/(2j+1)+v^2 w_(j+1). Round each affine update and the final multiplication by2v with absolute real error <=h_L. For example a real grid of step2h_L permits that error. Its exact rational coefficients and divisions must be checked.

The atanh tail satisfies

    |log u-P_N(v)| <= 2*(1/3)^(2N+1)/((2N+1)*(1-1/9))
                       <3^(-2N)<2^(-3N).

The rounded recurrence has affine error <=9h_L/8, and multiplication by2v plus its rounding raises the bound to7h_L/4. Keep the shared log2 center on this inner grid, before canonical output rounding. Assemble k*log2_hat+logu_hat exactly, then round to grid eta/2, with error <=eta/4. Since k+1<=12,

    total log error
      <12*2^(-3N)+21h_L+eta/4
      <=(3/16+21/256+1/4)eta =133eta/256 <eta.

At x=1 the exact zero identity may bypass the circuit. Other exact power-of-two cases may reuse the proved cache but must retain the same final error and input identity. Log2 is a one-time proved cache entry at a specified precision, not a fresh constant-cost oracle per input.

Coarse domain control also follows without evaluating a logarithm: exp(1)>8/3 and (8/3)^9>3389 imply log x<9. Thus |-t*log_hat x|<100000 under this error budget. Form that approximate phase exactly over rationals. If an implementation rounds it, its extra phase error must be added.

## 2. Pi bootstrap and signed period reduction

Set eta_pi=2^-(p+22), h_pi=eta_pi/256 and

    M=ceil((p+28)/4).

Use M terms of each alternating arctangent polynomial at1/5 and1/239. The rounded Horner recurrence is w_M=0,

    w_j=1/(2j+1)-v^2*w_(j+1), followed by v*w_0.

Give each real gate error <=h_pi. Each polynomial's numerical error is <=29h_pi/24. In the exact Machin combination16*atan_hat(1/5)-4*atan_hat(1/239), the total is <=145h_pi/6. The analytic error is

    <=20/((2M+1)*5^(2M+1)) <4*2^(-4M)<=eta_pi/16.

Finally round to grid eta_pi/2, error <=eta_pi/4. The combined error is <eta_pi. Coarse alternating bounds already give 3<pi_hat<4 with a fixed rational margin under these small errors. The checker can explicitly verify those rational guards. The negative Machin coefficient is retained; it is not replaced by a positive sum except in the error estimate.

For an exact rational phase theta with |theta|<=100000, choose

    k=floor(theta/(2*pi_hat)+1/2), r=theta-2k*pi_hat.

Use the signed nearest-rounding witness, not truncation toward zero. Then -pi_hat<=r<pi_hat and |k|<2^15. True periodicity gives exp(i theta)=exp(i(theta-2k*pi)), and the real-phase Lipschitz inequality yields

    |exp(i(theta-2k*pi))-exp(i r)|
       <=2|k|*|pi-pi_hat| <2^16*eta_pi=delta/64.

This proves the uncertainty in the reduced phase. Reduction using an approximate pi does not give exact equality of the two cis values. Pi is shared once per precision, but each phase still requires its own exact signed quotient/period witness and reduced rational arithmetic.

## 3. Cis on the reduced interval

To use the already pinned complex exponential tail directly, take

    n=max(16,ceil((p+27)/2)), h_C=2^-(p+13).

Evaluate sum_(j=0..n-1) (i r)^j/j! by normalized Horner, with n-1 affine updates, and norm error <=h_C per complex update. The terminal constant is exactly1. For r real, multiplication by i*r is a rotation followed by real scaling. Each update can use two real products and one real addition instead of a generic complex product, followed by the prescribed coordinate rounding. Division by the positive integer j+1 is still actual rational work.

The Horner propagation is <=exp(4)h_C<81h_C<delta/64. This follows from the sum of the factors4^j/j!, not an assumption of benign roundoff. Exact suffix magnitudes are <=exp(4)<81; approximate suffix magnitudes are <82. These bounds also control integer-part widths.

For n>=16, the source condition4/(n+1)<=1/2 holds and `Complex.exp_bound'` gives tail <=2*4^n/n!. The integer inequality16!>2^44 implies4^16/16!<2^-12. Each subsequent ratio4/(n+1) is <1/4. Therefore

    2*4^n/n! <2^(21-2n)<=2^-(p+6)=delta/64.

Round the final complex polynomial center to coordinate grid delta/64. Nearest coordinate rounding has norm error <delta/64. The pi reduction error, tail, inner rounding and final rounding then sum to <delta/16. This is stronger than the delta/8 cis budget used by the seed leaf. The optional real-phase integral remainder removes the leading factor2 and can reduce the length by one in some cases; that optimization is not used in this baseline.

## 4. Inverse-square-root witness

Set g=p+3. Supply an integer m with 0<=m<=2^g and check

    m^2*A <= D*2^(2g) < (m+1)^2*A.                 (W)

For A,D positive, square-root monotonicity and reciprocal order give

    m/2^g <= 1/sqrt(x) < (m+1)/2^g.

Use a_hat=m/2^g. Its error is <delta/8 and 0<=a_hat<=1. No division by m is needed, so m=0 is valid when coarse p and large x make it necessary. The strict upper inequality handles exact-square endpoints correctly: if 2^g/sqrt(x) is integral, m equals that integer and the next integer remains a strict upper bound.

A producer can compute floor(D*2^(2g)/A) and its integer square root. A conservative alternative is binary search for the largest m satisfying the left inequality on[0,2^g], using at most g+1 bisection steps with a suitable exclusive upper sentinel. This is production work; it is not included for free in (W). The final verifier needs no logarithmic-length search: compute m^2, multiply by A, and obtain the upper expression by adding (2m+1)A. That uses one integer square, two general integer products and linear-size additions/comparisons, plus input/range/shift checks. Two independent squares are another valid but larger schedule.

Neither this witness nor the existing interval-primitives plan provides an already generated root table. It provides a small verification interface, potentially preferable to a long amplitude polynomial. Which producer is cheapest remains separate from the short verification path.

## 5. Complete leaf error

For theta=-t*log_hat(x), the log-induced cis error is at most

    |t|*eta <=10000*2^-(p+17)<delta/8.

Multiply the cis center by a_hat exactly, then round the result to coordinate grid delta/8, giving norm error <delta/8. Since a_hat<=1, use the decomposition a_hat*(cis_hat-cis_true)+(a_hat-a)*cis_true. The complete B_x error is

    <delta/16 +delta/8 +delta/8 +delta/8 =7delta/16<delta.

The four terms are reduced-cis error, log phase error, amplitude error and final product rounding. This includes the actual x^(-1/2) amplitude and signed phase. It does not assume independence between shared errors. Exports may use the larger radius delta to retain containment slack, but matching an existing immutable output still needs an actual full-containment check.

## 6. Finite operations and bit costs

These are arithmetic schedules, not primitive prover instructions. A rational division or a rounding gate includes exact product/remainder or inequality proofs; it is not priced as one machine instruction.

| Part | Finite baseline work |
| --- | --- |
| Shared log2 | N real Horner updates and one output multiplication, with N+1 inner real rounding gates |
| Each general log x | Range witness; v and v^2; N real Horner updates; final2v product; k*log2+logu and final output. Counting v^2, this is N+3 real multiplications and N+3 additions, one rational division for v, exact power-of-two scaling, and N+2 rounding gates. Reciprocal odd-integer coefficients are a shared checked table. |
| Shared pi | 2M real Horner updates, two final multiplications, exact signed Machin combination and its final gate. The squared rational arguments and odd reciprocals need checked setup. |
| Each cis | One signed period quotient/witness and reduction; n-1 affine updates, each two real products, one real addition and division by a positive integer; n-1 complex rounding gates plus one final complex gate |
| Each amplitude verification | One square, two integer products, additions/comparisons and checked shifts; m has at most g+1 bits |
| Final leaf | Exact rational t*log_hat and a_hat times the two cis coordinates, followed by a complex gate |

The N+3 log addition count includes the two additions forming v and one log2 assembly addition; forming reciprocal coefficient constants belongs to setup. Cis may precompute r/(j+1), paying one rational division per update, rather than hiding two divisions in the products. Exact zero identities can omit work only with their input proofs.

Illustrative precision metadata:

| p for B_x | log accuracy bits ell | log terms N | pi terms M per arctangent | cis terms n | amplitude scale bits g |
| ---: | ---: | ---: | ---: | ---: | ---: |
|118|135|47|37|73|121|
|383|400|136|103|205|386|
|417|434|147|112|222|420|

Let b bound the input rational numerator/denominator sizes, including the exact height. Rounded stored values have O(p+b) bits; the log/cis pre-gate arithmetic and signed rounding comparisons have O(p+b+log p) bits, with larger constant factors than the stored grid. In particular the old fixed-pilot pre-gate denominator bound below2100 bits is not a universal bound on these operands or their rounding cross-products. Each reset prevents an N-fold product of prior denominators, but raw cross-products and quotient witnesses still need explicit widths.

With M(w), D(w), A(w) denoting the chosen ordinary-proof costs of multiplication, rational quotient/comparison and addition at width w, this baseline has O(p) rounded polynomial stages per uncached log/cis and therefore a conservative O(p*(M(w)+D(w)+A(w))) checking model, w=O(p+b+log p). Constants, squares and unequal products should be priced separately in a real implementation. Final amplitude verification has O(1) such arithmetic operations, while binary-search production has O(p) square/product steps. This is not a lower bound on better root generation or a constant-time root oracle.

Pi and log2 can be proved once per sufficient precision and reused. Logs/amplitudes can be reused across heights only with exact argument/precision binding and actual storage or regeneration costs. The grid-recurring proposal can reduce the number of independent logs; its per-point transformations and error propagation must be added. The seed circuit's height recurrence additionally requests stricter step errors than delta. Substitute that smaller requested tolerance into p rather than applying this direct-leaf table unchanged.

## Source map and remaining proof work

Mathlib source below is at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, inspected under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/`. Goldbach source is the unchanged `23b2d68` checkout.

| Source | Available ingredient |
| --- | --- |
| `TernaryGoldbach/Prelim/RamareHarm.lean:31`, `RamPf.log_one_add_inv_bounds` | Finite atanh log sum and positive geometric remainder, applied to rational u>1; u=1 uses log1 |
| `Mathlib/Analysis/Complex/Exponential.lean:407`, `Complex.exp_bound'` | The explicit2*norm(z)^n/n! exponential remainder under norm(z)/(n+1)<=1/2 |
| `Mathlib/Analysis/SpecialFunctions/Complex/Arctan.lean:144`, `Real.hasSum_arctan` | Actual arctan power series |
| `Mathlib/Analysis/SpecificLimits/Normed.lean:1041`, `alternating_series_error_bound` | First-omitted-term error after monotonicity and summability |
| `Mathlib/Analysis/SpecialFunctions/Trigonometric/Arctan.lean:336` | Exact Machin identity |
| `Mathlib/Analysis/Real/Sqrt.lean:177,223–240` | `sq_sqrt`, `le_sqrt`, `sqrt_le_left`, `sqrt_le_iff` for the real order bridge |
| `Mathlib/Data/Nat/Sqrt.lean:30,32,52–57` | Integer floor-root square inequalities and `Nat.eq_sqrt`/`eq_sqrt'` |
| `Mathlib/Algebra/Order/Round.lean:178,182,195` | Nearest-ties-up identity, interval witness and half-unit error |

The new formal work is the variable-length Horner identity/error induction, rational range-reduction and cache adapters, actual cis periodicity/Lipschitz wrapper, inverse-root integer-to-real implication, ordinary arithmetic checker/representation and full leaf composition. The existing packet supplies mathematical ingredients, not a completed variable-p ordinary-MM0 leaf implementation. No new fundamental special-function evaluation algorithm is required for this baseline.

## Frozen input identities

* `INTERVAL_PRIMITIVES_SOURCE_PLAN`: `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC`.
* `FINITE_EM_RATIONAL_ELEMENTARY_BUDGET`: `50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541`.
* `FINITE_EM_INNER_ROUNDING_ALLOCATION`: `60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9`.
* Its independent review: `E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B`.
* Signed rounding independent review: `F0D115608E1742220E4CAB26EA8DA930D24F2D1D410ED34609EA7B7DC4DABDA5`.
* Inspected `Mathlib/Data/Nat/Sqrt.lean`: `259AF8DB2BE15E3A6DF78CC96743E4D6BD7D48DD831C1D2598CFDADDF891658B`.
* Inspected `Mathlib/Analysis/Complex/Exponential.lean`: `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0`.
* Inspected `Mathlib/Analysis/Real/Sqrt.lean`: `A3F48822DEC1066FAB121744C120630DB2207A7124CFE4077969D07529E70273`.
* Consuming `integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md`: `1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E`.

The separate `elementary_hurwitz_leaf_scalars_20261111.py`, SHA256 `089A83420A8950D3EDDC48F42231C7D1AF262313FE7A315150DB1F35D8B6770E`, checks only parameter formulas and rational constant margins. Its receipt has SHA256 `49051BA99167C7F8C5CD330621027762FC834939F4CEBA6AB9CCFA6CB8DEB509`. Five rows p=1,2,118,383,417 passed. The initial system `python` alias could not launch; the existing interval-environment interpreter then completed this standard-library-only scalar script. No elementary value was evaluated. These checks do not demonstrate a successful seed output or a fastest production method.
