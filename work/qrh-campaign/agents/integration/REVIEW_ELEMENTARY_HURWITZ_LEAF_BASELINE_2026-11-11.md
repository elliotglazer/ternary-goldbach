# Independent review of the elementary Hurwitz leaf baseline

2026-11-11. PASS at the stated paper/source and exact-arithmetic scope, with no correction requested. This review binds `moebius/ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md`, SHA256 `0541F20C55B843683E3C496F8AEA63036A8A7AAF55A49C4F2B97ACC3FAC17C9D`.

I read the full report and independently reconstructed its variable-p proof. I inspected the actual source statements listed below and checked their relevant domains. An independent standard-library script verifies190 exact rational bounds, metadata relations and formal-polynomial identities. It imports no author module and generates no logarithm, square root, cis or Hurwitz value. No build, evaluator, prime scan or source edit occurred.

## 1. Logarithm and arctangent construction

For any p>=1, exact positive rational x<=3389 admits x=2^k u with k in0..11 and 1<=u<2. For u>1, the source log theorem applies at a=1/(u-1)>0, converting 1/(2a+1) into v=(u-1)/(u+1). The separate u=1 identity covers its excluded endpoint. Shared log2 uses v=1/3, so v^2<=1/9 throughout.

The N-term atanh polynomial has the claimed geometric remainder. Its rounded Horner error is at most9h_L/8 before multiplication by2v and at most7h_L/4 afterwards. In particular the cached log2 must retain that inner accuracy; replacing it by the final canonical log output would invalidate the stated cache budget. With N=ceil((p+23)/3), the combined log error is at most

    12*2^(-3N)+21h_L+eta/4 <=133eta/256<eta,
    eta=2^(-p-17).

The all-p implication uses the ceiling inequality3N>=p+23, not a finite table of sample precisions. The independent checks include all small ceiling residues and the three reported large examples, but those checks supplement this general argument.

For the arctangent polynomial the coefficient ratio is at most1/25. The pre-final error is at most25h_pi/24; the final multiplication by v and rounding give29h_pi/24. Multiplying by the absolute Machin coefficients16 and4 gives145h_pi/6. The negative coefficient remains in the value formula. The first omitted term theorem is applicable because the positive terms decrease and are bounded by a summable geometric series. The M-term combined tail is bounded by

    20/[(2M+1)5^(2M+1)] <4*2^(-4M) <=eta_pi/16,
    eta_pi=2^(-p-22), M=ceil((p+28)/4).

Adding the inner rounding and final eta_pi/4 gate stays below eta_pi. The coarse alternating lower bound and upper bound16/5 have enough rational slack to ensure3<pi_hat<4 even at p=1. There is no dependence on a numerical pi oracle.

## 2. Signed phase and cis

The phase theta=-t*log_hat(x) is formed exactly from the rational height and log center. The elementary bound log x<9 and the log error give |theta|<100000. The exact signed floor rule

    k=floor(theta/(2pi_hat)+1/2)

puts r=theta-2k*pi_hat in[-pi_hat,pi_hat), including negative half-integer ties. It gives |k|<2^15. True periodicity uses2k*pi, so an additional error is necessary and is present:

    |cis(theta)-cis(r)| <=2|k| |pi-pi_hat| <delta/64.

This does not claim exact periodicity for pi_hat. A rounded theta would require another error allocation; the proposed schedule does not round it.

The normalized exponential Horner recurrence has exact terminal1 and recurrence H_j=1+(ir)/(j+1) H_(j+1). It yields precisely the degree n-1 Taylor polynomial. Its accumulated rounding error is bounded by the sum of4^j/j!, hence by exp4<81. For n>=16 the source ratio condition4/(n+1)<=1/2 holds. The base inequality16!>2^44 and each subsequent ratio4/(n+1)<1/4 prove

    2*4^n/n! <2^(21-2n) <=delta/64

for n=max(16,ceil((p+27)/2)). This is a proof for every p, with no asymptotic assumption. The inner error81*2^(-p-13) and final complex grid error are each below delta/64. Together with the pi error, the cis center has error below delta/16 relative to cis(theta). Complex coordinate grids are converted to Euclidean errors correctly.

I independently expanded the formal normalized Horner polynomials and compared every coefficient with1/j!. This checks the recurrence indexing without evaluating it at an actual phase. The exact error-weight recurrence also stays below81 for all inspected lengths.

## 3. Inverse square root and final product

The integer witness

    m^2 A <= D 2^(2g) <(m+1)^2 A,
    g=p+3, A>0, D>0,

is equivalent by positive division and square-root order to

    m/2^g <=sqrt(D/A)<(m+1)/2^g.

Since x=A/D, this is the required inverse-root enclosure. The bound0<=m<=2^g follows from x>=1 and is also checked. At an exact square the nonstrict lower and strict upper conditions select the correct floor integer. The case m=0 requires no reciprocal of m. Computing floor(D 2^(2g)/A) then its integer square root produces such a witness, but that production work is distinct from verifying it.

Verification can form one square m^2 and recover the upper square through m^2+2m+1. Thus the report's one-square/two-general-product count is a valid possible schedule, with additions, comparisons, input checks and shifts still charged. The binary-search alternative is finite with g+1 steps and an exclusive upper sentinel2^g+1. Neither route is an already implemented constant-time root primitive.

Using the lower amplitude center gives0<=a_hat<=1 and amplitude error below delta/8. This bound avoids a product cross-term in the final decomposition. The error in B_x is strictly below

    delta/16 +10000*2^(-p-17)+delta/8+delta/8
      <7delta/16<delta.

The terms are respectively the reduced-cis error, log-induced phase error, amplitude error and final product rounding. The proof does not require independence of any shared errors.

## 4. Scaled-seed compatibility and cost scope

At p=118 the construction supplies the B_x radius2^-118 required by the now separately reviewed scaled seed circuit. The log accuracy is2^-135; N=47, M=37, n=73 and g=121. The report's statement that scaled seeds were pending is historical to its freeze and is not a mathematical defect. This review does not modify that report.

The final grid in the baseline can be delta/8, whereas the seed recurrence uses a finer grid of step2^-122. Those grids are nested for p=118, so the baseline center is representable exactly on the recurrence grid. If a different output format introduces another rounding, it must be charged; it cannot be hidden by renaming the radius.

Across-height multiplication chains need much smaller step errors than a direct B_x leaf. The report correctly requires substituting the stricter tolerance into p. Its118-bit example alone is not a certificate for such a chain. Reusing log, amplitude or pi data requires exact argument and precision binding.

The stated stage counts are counts of mathematical operations. Exact division, signed rounding witnesses, product widths, caches, output storage and arithmetic proof construction remain costs. Repeated grid reset keeps pre-gate widths O(p+b+log p), but it does not make these operations unit-cost or imply an end-to-end Lean/MM0 ratio. Generic polynomial/error lemmas, analytic interpretation, finite arithmetic checking and actual closed data remain unimplemented obligations.

## 5. Source and evidence ledger

Mathlib paths below use the unchanged local checkout named in the author report. The independent receipt records full file hashes. I checked these exact source locations:

| Source | Checked statement |
|---|---|
| `TernaryGoldbach/Prelim/RamareHarm.lean:31–67` | Actual finite log sum and remainder, requiring positive a |
| `Mathlib/Analysis/Complex/Exponential.lean:407–419` | Actual complex Taylor tail under norm(z)/(n+1)<=1/2 |
| `Mathlib/Analysis/SpecialFunctions/Complex/Arctan.lean:144–146` | Real arctangent series on norm(x)<1 |
| `Mathlib/Analysis/SpecificLimits/Normed.lean:1041–1062` | Alternating remainder requires antitonicity and Summable positive terms |
| `Mathlib/Analysis/SpecialFunctions/Trigonometric/Arctan.lean:335–338` | Exact Machin identity |
| `Mathlib/Analysis/Real/Sqrt.lean:177,223–240` | Square and square-root order identities with signs |
| `Mathlib/Data/Nat/Sqrt.lean:30–57` | Floor-root lower/strict upper bounds and characterization |
| `Mathlib/Algebra/Order/Round.lean:178–195` | Signed floor(x+1/2), half-open interval and absolute error |

No theorem with a similar name was treated as a completed composed leaf theorem. The real-phase Lipschitz and periodicity applications, range-reduction substitutions, rounded polynomial induction and integer-to-real root implication were checked mathematically here and remain formal proof work.

| Artifact | SHA256 |
|---|---|
| Author report | `0541F20C55B843683E3C496F8AEA63036A8A7AAF55A49C4F2B97ACC3FAC17C9D` |
| Author scalar script | `089A83420A8950D3EDDC48F42231C7D1AF262313FE7A315150DB1F35D8B6770E` |
| Author scalar receipt | `49051BA99167C7F8C5CD330621027762FC834939F4CEBA6AB9CCFA6CB8DEB509` |
| `integration/check_elementary_hurwitz_leaf_review_20261111.py` | `80A762AA58C808EE6BF27101C8FA268CA6B42186C6C22464BE7073CAFBFB1DE6` |
| `integration/check_elementary_hurwitz_leaf_review_20261111.json` | `D66E06B40B785217923B155B11579820E4EBE2388872D0B8EA73B5E1CB22D4DC` |

The independent receipt verifies nine local input pins and records eight inspected source hashes. Its190 checks include exact reproduction of all five saved scalar rows and formal Horner identities at the corresponding lengths. No author evaluator was imported or executed, and no elementary value was generated.
