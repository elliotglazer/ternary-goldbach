# Review of large-residue finite-difference occupancy

2026-11-11. PASS at source, exact-metadata and conditional cost-model scope. No correction required. This review binds `prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md`, SHA256 `99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1`.

The report identifies where one explicitly charged initialization could be amortized. It does not admit a replacement arithmetic circuit, prove its numerical error or operand widths, or establish a speedup. No polynomial, Hurwitz, L-function, transform, prime candidate or zero values were computed. No build or frozen-file edit occurred.

## 1. Source and selected-grid reconstruction

I read the frozen note and entire metadata program, the selected five-band operation schedule and its review, the shifted-Hurwitz input, and the retained primary `int-l-func5.11.cpp` consumer. The primary consumer at lines 705-735 evaluates only `gcd(a,c)=1` residues. Its nearest-anchor branch sends exact half ties downward in the intended rule. Its floating decisions are not adopted as exact certificates. The new integer formula supplies that distinction correctly.

The actual polynomial has 20 output coefficients and degree at most 19, whatever the higher source order needed to produce those coefficients. Bands 1-4 use fine denominators 1024,2048,4096,8192. The final m159 construction has source denominator4096 but output normalization8192 and fine denominator16384. The receipt uses the fine denominator, not the source denominator, for occupancy. It does not change the accepted alpha tail or translation bias.

I independently reconstructed the height formula as one rational ceiling over the full expression, then converted the closed height to its final grid index and intersected it with each band. Height-index ranges are 0..6400,6401..12800,12801..25600,25601..64000,64001..84199+e, for e in {0,167,320,640}. Each conductor is clipped at its own last index. This reproduces the selected count of 125400 large conductors, the 7133015232 unit inputs per complete common layer, and all four saved weighted residue totals. Principal and small-conductor branches are excluded.

The main total is 59962061953248 unit residue-height inputs, hence exactly 1139279177111712 old 19-stage Horner stages. A statement about reducing this subtotal cannot remove separate elementary head terms, conductor normalization, character transforms, phase, signs, counts or seed production.

## 2. Bucket geometry and nonunit accounting

For fine denominator G and 1<=a<c, the exact tie-down condition is

    (2j-1)c < 2Ga <= (2j+1)c.

The clipped lower and upper integer bounds in the author note follow directly. The strict lower endpoint and weak upper endpoint matter at ties. Conductor16384 in the fourth band has G8192 and genuine unit ties; the example was checked explicitly.

For a cyclic set of c integers, successive boundaries differ by c/G. Therefore cell lengths are floor(c/G) or ceil(c/G), with multiplicities determined by their total c. The zero cell contains floor(c/(2G))+ceil(c/(2G)) integers. Splitting it into sizes floor(c/(2G)) and ceil(c/(2G))-1 removes a=0 and correctly separates the two endpoint anchors. Empty cells remain in the histogram. This proves the author's constant-size formula rather than inferring it from a sample average.

An independent expression for the number of nonempty clipped buckets is

    B_c = min(c-1,G-1) + 1[c>=2G] + 1[c>2G].

It agrees with every reconstructed histogram. The strict distinction between the last two tests handles c=2G. Every bucket of length ell needs ell-1 integer-a advances after initialization, so total advances are c-1-B_c. After height weighting, B+A equals all numerator visits; subtracting the unit outputs R gives exactly the charged nonunit visits.

This is deliberately an all-numerator traversal. Buckets without units are still initialized and traversed. The receipt does not claim an all-family distribution of unit-only run lengths. Bounded example lists verify units in selected cells, and exact totients give the aggregate unit baseline, but neither is used to infer favorable uncomputed unit gaps. In particular, even conductors cannot have unit numerators differing by one. An implementation which skips those positions requires a different jump or restart circuit and cost proof.

## 3. Difference circuit and price test

At a fixed conductor, height and anchor, consecutive numerators change the normalized displacement by D_output/c. Thus the same degree19 finite polynomial is sampled on an arithmetic progression. Twenty initial polynomial evaluations cost 380 original-format Horner stages. A triangular forward-difference table has 19+18+...+1=190 subtractions. The update identity

    Delta^j p(a+1) = Delta^j p(a) + Delta^(j+1) p(a)

requires 19 additions per advance, with ascending in-place order or simultaneous old-state semantics. Descending in-place order would not implement this identity. Initial polynomial evaluations beyond a cell or even beyond 1..c-1 are algebraically legitimate for initialization only; the note correctly does not claim actual Hurwitz approximation there.

The complete stated comparison is

    19 R C_H versus 380 B C_I + (190 B + 19 A) C_A.

Initialization and old Horner stage prices are separately named. Only in the explicit equal-stage-price simplification C_I=C_H does the necessary positive stage-count test become R>20B. For positive addition price, the remaining strict comparison is

    C_H/C_A > (10B+A)/(R-20B),

before any other changed costs. The receipt's `eligible` fields mean this limited screen. They do not mean error-admitted, cheaper at real widths, or spectrally successful. For a hybrid restricted to those conductors, all excluded unit outputs still pay their old Horner cost; the saved subset fields are not a complete replacement ledger.

The main first-band aggregates are R=44637243437690, B=812309501875, A=81859927243205. Their displayed threshold 89983022261955/28391053400190 lies strictly between3 and16/5. The second whole band fails R>20B, though 53503 of its main-scenario conductors pass individually. The first band has 106331 passing conductors. No conductor in bands3-5 passes this particular screen in any of the four scenarios. In the final band every occupied integer bucket has length one, so its advance total is zero even before filtering to units.

These results do not rule out cheaper initialization, unit-aware pruning, different anchors or basis conversions. The reference sometimes initializes many short or zero-unit buckets, so it would be especially unsound to convert its failure into a universal lower bound.

## 4. Error, width and source obligations retained

The new recurrence is not a dependency-closed pruning of the accepted Horner circuit. It changes intermediate quantities and therefore does not inherit its rounding/error proof. A rounded difference state has binomial error amplification over a run. All initialization and later gate errors need a complete bound. Conversely, an exact common-denominator construction can avoid recurrence rounding, but must pay its integer width and final output rounding.

For dyadic coefficients with common denominator2^b and h=(Ga-jc)/(2c), a sufficient denominator for every degree19 term is 2^b(2c)^19. Since 2c<=531600<2^20, the denominator exponent can add almost380 bits beyond b. This is only one operand component; numerator magnitudes, setup, sign/carry proofs and final conversion also require accounting. The author correctly makes no equal-width addition claim.

The source C consumer at lines 733-735 adds a separate elementary term to the Taylor contraction. The report leaves that term and all subsequent normalization/character/count work unchanged. It also correctly rejects sharing difference states solely because conductors use a common anchor: their step D_output/c differs, and each height has a different polynomial. Reuse requires identical bound objects, step and start index or a newly proved conversion.

## 5. Independent checks and exact pins

Owned metadata-only checker `moebius/review_large_residue_bucket_occupancy_20261111.py` passed **1117805 exact checks**. It imports no author program or evaluator. It reconstructs totients using Mobius/divisor inversion, independently reconstructs all height weights, and compares all 40 band/parity/scenario cohorts: full length histograms, active conductor counts, unit/nonunit visits, bucket and advance counts, necessary-screen subsets and every cost-model field. It checks bucket geometry by direct boundary inversion on six conductors and all five fine grids, and checks every retained example list.

The check began on the saved receipt before the author note was frozen. The final author receipt hash is unchanged and matches the hash recorded in the independent receipt. This review does not replay the author's 4473802 assertions or authenticate its row digest as omitted evidence. It directly compares the mathematical aggregate fields instead. All five input hashes were independently checked. No actual character table or spectral result is established by these arithmetic identities.

| Artifact | SHA256 |
|---|---|
| prime-estimates author note | `99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1` |
| `prime-estimates/large_residue_bucket_occupancy_20261111.py` | `549EDC2159B6843527DB1A45014571AEF46926835BA60DEC5CC8C8E5150A06B9` |
| `prime-estimates/large_residue_bucket_occupancy_20261111.json` | `19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB` |
| `moebius/review_large_residue_bucket_occupancy_20261111.py` | `AC5E309CE539173DC2D1C8E5D979FE090C2E70FCD65C853350F501BC2547A66F` |
| `moebius/review_large_residue_bucket_occupancy_20261111.json` | `A451BC6F493D1EB6D23348DB8EAAD083045B0B2630855A720FE1B81A6A6B4D3E` |
| root `minimal_theta_nonprincipal_schedule_20261111.json` | `96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265` |
| major-constants `RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md` | `483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716` |
| zero-sum `REVIEW_RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md` | `712090B83A3C31F58C2642B329B8122661F9AB4D675F0665342D69FAD47E562D` |
| integration `SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md` | `861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895` |
| moebius primary `platt-reuse-sources/int-l-func5.11.cpp` | `3D9B2B23B35129899048C23806AA42A4F2B08BE10304611AC9E1C913300FE852` |

Agent paths are relative to `work/qrh-campaign/agents`; the root schedule is under `work/qrh-blueprint`. The frozen note and receipt are accepted as a feasibility gate for a future explicit circuit, not as permission to deduct Horner work from the current selected schedule. Error, full arithmetic/proof cost, implementation and actual certificate acceptance remain open.
