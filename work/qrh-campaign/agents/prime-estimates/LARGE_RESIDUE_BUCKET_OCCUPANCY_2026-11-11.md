# Exact occupancy gate for residue finite-difference blocks

2026-11-11. Integer metadata and paper cost identities only. No polynomial values, Hurwitz/L-values, transforms, prime candidates, zeros or builds were computed. No frozen schedule is changed and no finite-difference saving is credited.

The main large branch's 59,962,061,953,248 unit residue/height inputs reproduce its 1,139,279,177,111,712 degree19 Horner stages. Exact nearest-anchor bucket geometry shows where a replacement might amortize initialization. The first band has long runs and passes the aggregate necessary stage-count test for the explicit reference circuit below. A subset of second-band conductors passes that test. No third-, fourth- or fifth-band conductor passes it under that circuit. In the final band every occupied bucket has length one, even before removing nonunits: there is no within-bucket advance to reuse there.

These conclusions concern an explicitly charged reference initialization and all-numerator traversal. They do not prove that every possible finite-difference or basis-conversion algorithm loses in the later bands. Unit-aware pruning, a cheaper initialization, different anchor geometry or jumps across nonunits would be different circuits with different proof obligations.

## 1. Actual selected objects

The pinned minimal-theta schedule's large object retains 125,400 primitive nonprincipal conductors: odd 10000<c<=132900 or 4|c with 10000<c<=265800. The sum of phi(c) is 7,133,015,232. Small conductors and conductor one are outside this report. The actual old contraction evaluates only unit numerators 1<=a<c, gcd(a,c)=1, at alpha=a/c.

The primary implementation `int-l-func5.11.cpp:705–735` loops over precisely those unit numerators. Lines 712–724 choose the nearest alpha row with an exact halfway point falling down in the intended rule (`fraction>0.5` rounds up). The floating implementation is source evidence for the convention, not a certificate of its correct numerical decisions. This report uses exact integer inequalities for the same convention. `calc_r_n`, starting at line 248, is the Horner contraction; the current accepted schedule fixes its output order at P20.

The shifted-Hurwitz paper defines the actual normalized degree19 polynomial at a fine anchor beta. Its displacement is h=D_output*(a/c-beta), with |h|<=1/4. All five bands retain 20 output coefficients. The first four source orders are P27; the final source uses P28, D_source=4096, N=1500 and m159. None of those source orders replaces the output order20.

| Band | Height indices, inclusive | D_output | Fine anchor denominator G=2D_output |
|---:|---|---:|---:|
|1|0..6400|512|1024|
|2|6401..12800|1024|2048|
|3|12801..25600|2048|4096|
|4|25601..64000|4096|8192|
|5|64001..84199+e|8192|16384|

The four scenarios have e=0,167,320,640. Each conductor has its own last index; the displayed global bands must be clipped to that last index. In particular the final source D4096 does not give an alpha bucket width1/8192: its delivered fine denominator is16384.

For c>10000, put d=531600/c and u=96/5 for odd c; d=1063200/c and u=191/10 for even c. The selected height is

`H(c)=ceil(200+max(f, (3927/1250)*u*d))`,

with f=240 odd and255 even. The last index is `L_c=ceil(64H(c)/5)+e`. For a band [l,h], its exact multiplicity is

`w(c,band,e)=max(0,min(L_c,h)-l+1)`.

This counts height zero once, gives boundary heights to their earlier band, and preserves the closed final target. The extra scenarios still do not guarantee a successful Turing surplus.

## 2. Exact all-numerator bucket distribution

For each integer a in 1..c-1, define the nearest fine-anchor index, with ties down, by

`j(a)=floor((2G*a+c-1)/(2c))`,   `0<=j(a)<=G`.

Equivalently bucket j contains exactly the clipped integer interval

`max(1,floor((2j-1)c/(2G))+1) <= a <= min(c-1,floor((2j+1)c/(2G)))`.       (1)

Thus its open/closed tie rule is `(2j-1)c<2Ga<=(2j+1)c`. The same nearest-anchor Taylor bound holds at a tie. Unit ties cannot be dismissed: c=16384, G=8192 is an active example, with odd a lying on bucket upper boundaries.

There is an exact constant-size histogram formula. Write c=L*G+r, 0<=r<G. On the cyclic residue set 0..c-1, G nearest-grid cells have lengths L or L+1, with counts G-r and r. This follows because successive cell boundaries differ by c/G, so their integer counts differ by at most one and sum to c. The cyclic cell at zero has size

`z=floor(c/(2G))+ceil(c/(2G))`.

Remove one occurrence of z from that cyclic histogram. Replace it by the two endpoint bucket sizes

`ell_0=floor(c/(2G))`, `ell_G=ceil(c/(2G))-1`.

This splits the wrap cell and excludes a=0. Empty endpoint cells remain in the histogram. The resulting G+1-cell histogram has total length c-1. It is exact for divisible and nondivisible endpoints, c<G, and ties; it is not an average occupancy approximation.

The receipt records this distribution after weighting every conductor by w(c,band,e), separately for odd/even conductor cohorts. It also records exact unit outputs phi(c), all c-1 visits, and skipped nonunits c-1-phi(c). Totients are reconstructed by the integer divisor identity `sum_(d|c) phi(d)=c`; no prime table or candidate primality test is used.

**This is not a histogram of unit-only run lengths or unit counts in every bucket.** The proposed reference traversal visits every numerator in every nonempty integer bucket, including all nonunits. A bucket containing no units still incurs initialization and traversal in that reference. The report does not silently prune it. Bounded examples retain exact unit lists for selected buckets, but those examples are not extrapolated to the family.

For even conductors, units are odd, so distinct consecutive units cannot differ by one. A recurrence that advances only between unit outputs must handle skipped positions or certify a variable-step jump. Those advances are not free. For odd conductors there can be consecutive-unit runs, but no uncomputed unit-run distribution is credited here.

## 3. Exact weighted results

Let R denote unit residue/height inputs, B the number of nonempty integer bucket/height instances, and A the number of integer-a advances within those buckets. Then

`B+A=sum_c w(c)*(c-1)`,

`R=sum_c w(c)*phi(c)`,

and the difference is exactly the number of skipped nonunit visits. These relations are checked independently of the old Horner totals.

For the main scenario:

| Band | Active conductors | R: unit outputs | B: initialized buckets | A: advances | Maximum length |
|---:|---:|---:|---:|---:|---:|
|1|125400|44,637,243,437,690|812,309,501,875|81,859,927,243,205|260|
|2|99106|10,919,369,148,972|725,285,829,066|19,505,481,437,147|104|
|3|32477|3,364,154,098,594|967,359,258,753|5,366,004,434,402|20|
|4|10267|1,007,584,876,992|1,087,509,289,700|1,046,288,676,756|5|
|5|822|33,710,391,000|83,135,221,033|0|1|

The fifth-band conductors here are all even. Its zero advances are a property of the exact all-numerator geometry, not merely of a unit filter. Changing this would require changing the polynomial/anchor organization; the current bucket permits no two numerators.

The receipt includes all four full histograms and cohort totals. Selected scenario summaries are:

| e | Active band2 conductors | Max bucket lengths, bands1--5 | Band1 conductors passing phi(c)>20B_c | Band2 passing |
|---:|---:|---|---:|---:|
|0|99106|260,104,20,5,1|106331|53503|
|167|104324|260,109,20,5,1|106331|58721|
|320|108798|260,114,21,5,1|106331|63195|
|640|123081|260,130,21,5,1|106331|77478|

Here B_c counts nonempty buckets per one height of that conductor/band. No conductor in bands3--5 passes the displayed test in any scenario. The test's limited cost meaning is defined next; it is not an admission rule for a numerically stable replacement.

## 4. Falsifiable initialization/advance model

Fix one actual coefficient polynomial p(a) of degree at most19 in a single bucket and height. Consecutive integer numerators give an arithmetic progression in h, with step D_output/c. A standard exact reference initialization evaluates the **same polynomial** at a0,a0+1,...,a0+19 using20 Horner evaluations, then forms the triangular table of forward differences. This costs380 Horner stages and190 complex subtractions. The state contains Delta^j p(a0), j=0,...,19.

Advance by replacing D_j with D_j+D_(j+1) for j=0,...,18 in **ascending** order, or with simultaneous old-state semantics. The top state is unchanged. This gives the next forward-difference state and requires19 complex additions. Descending in-place updates would be a different recurrence and are not justified by this formula.

This conservative reference initializes every nonempty bucket even when its length is below20, then advances ell-1 times to expose all ell requested polynomial positions. It does not count the initialization values as free outputs from other buckets. Some initialization positions can lie outside the bucket or even outside 1..c-1; they are evaluations of the finite polynomial for algebraic setup only, not claimed actual Hurwitz approximations at those positions. Their arithmetic and widths still need proof. A long-bucket-only construction and short-bucket fallback is a distinct, potentially better circuit.

Let C_H be the complete price of an original Horner stage, C_I the price of an initialization Horner stage and C_A the price of a difference addition/subtraction at its actual widths. The reference comparison, before any unshared setup/transport costs, is

`old = 19R*C_H`,

`new = 380B*C_I + (190B+19A)*C_A`.                      (2)

No reason is given to identify C_I with C_H automatically. Exact rational initializations can have larger operands; rounded initializations can demand tighter precision. In the deliberately simplified **equal-stage-price model** C_I=C_H, a positive stage-count saving requires R>20B. If this holds, the exact break-even condition is

`C_H/C_A > (10B+A)/(R-20B)`,                           (3)

before all remaining differing costs. The receipt labels the corresponding per-conductor subset `eligible`; this means only this necessary equal-stage-price screen. It is not a successful optimization, a full cost ranking or a numerical error certificate.

For the complete first main band, the ratio in (3) is

`89983022261955/28391053400190`,

which lies between3 and16/5. The complete second and later main bands fail R>20B, although the second band's conductor-specific passing subset remains a possible target. These arithmetic facts narrow the next investigation. They are not a theorem that a different O(P^2) basis conversion, an optimized unit-aware circuit or different proof representation cannot succeed elsewhere.

The original Horner baseline evaluates only units. Equation (2) charges every nonunit advance and every nonempty zero-unit bucket. It does not compare the new work against an inflated all-residue Horner baseline. Coefficient setup cannot be shared across unrelated conductors merely because they use the same fine anchor: the step D_output/c differs. Difference states also change at every height as the coefficient values change. Genuine reuse must bind the same polynomial, step and starting index.

## 5. Missing circuit/error and representation obligations

The current output coefficients and their numerical/Taylor error contracts remain valid inputs. Replacing the finite evaluation does not license their raw values or successful signs, nor does it remove the separate alpha^-s term, conductor normalization, character transform or later Hardy/count stages. Primary source lines733–735 explicitly add that separate term to the polynomial contraction.

A rounded forward-difference recurrence needs a new quantitative error proof. Initial state errors propagate through binomial coefficients: after v advances, the zeroth-state error can contain `sum_(j=0)^19 binomial(v,j)*e_j`, plus separately propagated gate errors. The maximum observed run length260 makes this finite, but it does not make old per-Horner rounding tolerances sufficient. A stable or compensated circuit needs its actual proof.

An exact shared-grid integer alternative avoids that accumulated numerical error but grows denominators and numerators. For output coefficients on denominator2^b and normalized displacement `(G*a-j*c)/(2c)`, a common denominator is `2^b*(2c)^19`. The powers and coefficient products, exact initialization, signs, carries, data binding and final division/rounding must be priced. At c<=265800, even the denominator's contribution beyond b can approach380 bits. It is therefore unsound to count each new addition as an old narrow Horner addition without a width analysis.

The next useful proof target is a bounded exact or rigorously rounded circuit for long buckets in bands1--2, with a priced short-bucket fallback and actual unit-output binding. The occupancy data are sufficient to test a specified circuit there. They do not establish the total saving in (2), choose a winning implementation, or authorize evaluations. There is no universal runtime or Lean/MM0 acceptance claim.

## 6. Reproducible metadata and pins

`large_residue_bucket_occupancy_20261111.py` performs4,473,802 exact checks. It imports no former producer, FFT or evaluator. It derives totients by divisor inversion, validates them against bounded gcd counts, checks the histogram by direct enumeration for c=2..257 and six small power-of-two grids, retains six larger endpoint/tie examples, and reconstructs all four complete height-weighted schedules. The old residue, conductor-height and19-stage totals match exactly. The row digest is a reproducibility aid, not a proof of omitted metadata.

The 181,690-byte receipt contains full weighted length histograms for every band/cohort/scenario, unit and nonunit totals, reference and necessary-screen costs, and the actual example bucket/unit lists. It is an all-numerator certificate design, not an unrecorded all-unit-run computation.

| New artifact | SHA256 |
|---|---|
|large_residue_bucket_occupancy_20261111.py|549EDC2159B6843527DB1A45014571AEF46926835BA60DEC5CC8C8E5150A06B9|
|large_residue_bucket_occupancy_20261111.json|19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB|

| Frozen input, workspace-relative | SHA256 |
|---|---|
|work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json|96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265|
|work/qrh-campaign/agents/major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md|483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716|
|work/qrh-campaign/agents/zero-sum/REVIEW_RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md|712090B83A3C31F58C2642B329B8122661F9AB4D675F0665342D69FAD47E562D|
|work/qrh-campaign/agents/integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md|861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895|
|work/qrh-campaign/agents/moebius/platt-reuse-sources/int-l-func5.11.cpp|3D9B2B23B35129899048C23806AA42A4F2B08BE10304611AC9E1C913300FE852|

The sign-only successor leaves this large branch unchanged, so these large-object pins remain the correct comparator. No earlier schedule, source file, parameter or frozen result was altered. Independent review is required before treating this new occupancy gate as accepted metadata.
