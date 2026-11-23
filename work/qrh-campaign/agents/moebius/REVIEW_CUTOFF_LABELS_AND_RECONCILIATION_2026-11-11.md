# Review of cutoff labels and conditional cost reconciliation

2026-11-11. Verdict: PASS for independently reconstructed conductor/label/grid metadata, static interpretation of the R138000 script, and conditional arithmetic composition. No correction is required. This is not a new review of the complete cutoff proof, regeneration of the mixed-radix inventory, spectral certificate, operand-width theorem or runtime estimate.

## Bound artifacts and independent method

The reviewed root note is `work/qrh-blueprint/RECONCILED_CUTOFF_PRECISION_AND_REUSE_2026-11-11.md`, SHA256 `18CB96FB1F2F99F42703A40C40D1D8B343ED9F02A247799273B560591503421B`. Its script and receipt have hashes `F9B82CA50AF1BD48BCFECAC545D512349EC923381CC78F95F5235298388E4A3C` and `817E8FB021DAC5C993EEAA2631B8A9AA5A81B346904AA367F35A7E3CE85F6BFF`.

The R138000 spectral note under `agents/zero-sum` has SHA256 `C14E47FBD3EFBC67C541076B99CCF2949FA2BEDFA9217EFD3C87B9AA8617E78B`; its script and receipt are `656281DA20790A8FBCCC330C6276A130979A59A15AE35F790ABBBFDA44E38A23` and `0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F`. The immutable R140000 receipt is `DA26BF4BA4744CF5AF096670873FE9CA258735A8EFA4DE09D0F490A56F36F5F7`.

My independent script constructs totients by the integer identity sum_(d|n) phi(d)=n, subtracting completed divisor values from proper multiples. It then constructs primitive-character counts a(n) by sum_(d|n) a(d)=phi(n). This avoids both the author's factor-local formula and its smallest-prime-factor construction. The second identity expresses unique induction from a primitive conductor, with a(1)=1. Neither calculation constructs or evaluates a character or tests a candidate prime.

For real primitive labels I used the equivalent squarefree classification: one at odd squarefree c; one at c=4u with u odd squarefree; two at c=8u with u odd squarefree; zero otherwise. It follows from one primitive quadratic character at an odd prime, none at a higher odd prime power, and the primitive real counts one at4 and two at8. Multiplicativity under CRT gives the classification. Squarefreeness was checked by excluding multiples of every integer square, without prime enumeration. Nonreal inverse pairs are (a(c)-a_real(c))/2.

The independent calculation passed110 comparisons: all three all/large/small grid aggregates, three maximum locations, unchanged small-branch data, all16 root pins, and root labels and quoted-cost ratios. It does not execute either author's script. Owned files are:

| File under agents/moebius | SHA256 |
|---|---|
| `review_cutoff_labels_20261111.py` | `7924DCC5ED126A1EA0CC9504BD9B818AEB83334026D4766A2957D7FF601A0006` |
| `review_cutoff_labels_20261111.json` | `C78B976E1D869899E50273A6B47274001DE9A581F9DDA76C8C19599C6DE73061` |

Only exact metadata, divisor recurrences, hashes and rational arithmetic ran. No prime certificate, analytic value, transform, root or build was evaluated.

## Labels, heights and shared seed floor

For even R the eligible sets are disjoint: odd3<=c<=R and4-divisible c<=2R. Their total is R-1. Conductor one is excluded, and conductors2 modulo4 have no primitive labels. The independently reproduced counts are:

| R | Conductors | Primitive labels | Real primitive labels | Nonreal inverse pairs |
|---:|---:|---:|---:|---:|
|150000|149999|5543640187|121577|2771759305|
|140000|139999|4829158813|113481|2414522666|
|138000|137999|4692136729|111851|2346012439|

The script's multiplicative primitive formula is consistent with this independent construction: a(p)=p-2, and a(p^e)=(p-1)^2*p^(e-2) for e>=2. Its unit-group axes also distinguish the noncyclic power-of-two case correctly. The real/inverse-pair columns are bookkeeping, not a factor-of-two discount on the computed outputs.

The retained height is H(c)=10^8/c for odd c or c<=125000 and200+75000000/c otherwise. Its nominal point count is J(c)=ceil(64H(c)/5)+1. I independently reproduced sum J, sum phi, sum phi*J, and sum a*J in all three branches for all cutoffs. In particular the large-branch primitive counts are5525163079,4810681705 and4673659621; the small branch retains18477108 throughout.

These quantities are not interchangeable. Sum phi counts unit inputs for one point per conductor. Sum phi*J counts coarse residue inputs and, by the full transform's dimension, all character output slots. Sum a*J counts the primitive subset of those slots. None counts roots or successful sign tests. Sum J counts conductor-height pairs rather than distinct shared heights.

All cutoffs retain c=10001, which uniquely attains the large-branch maximum J=127989. Each conductor uses the same prefix grid j*5/64, so the shared union remains j=0,...,127988. Its last height is9999.0625 and can exceed a conductor's required H. This correctly explains why the previous fixed P24 schedule over complete alpha grids and height bands has the same seed union when reused verbatim. It is not a lower bound on every optimized seed scheme. A proof that permits sparse seed removal, new bands or changed precision could change that cost and needs separate accounting.

The maximum Bluestein padding262144 is quoted from the stored inventory, not independently regenerated here. Entry counts, maximum array size, shared seeds and simultaneous RAM remain distinct quantities. The R138000 script computes setup from the active circuit graph separately from J-weighted gate work; it does not multiply setup by every conductor-height use.

## Script interpretation and operation ratios

I read the full R138000 script. Eligibility changes only the conductor domain; the per-axis circuit functions do not depend on R. The character operation sum is J(c)*sum_i(phi(c)/m_i)*C_mixed(m_i). Every full unit-group output is produced before primitive filtering. The assertions compare the recomputed R150000 profile to the pinned prior profile and keep the small branch identical. Those assertions are source evidence about the producer, not an independent replay of its circuit plan in this review.

The quoted R138000/R150000 mixed ratios G and A are respectively

    1368268871329630 / 1520691663532347,
    944746694109999 / 1050202190333921.

They lie in the stated intervals [.899767,.899768] and [.899585,.899586]. I verified their arithmetic from stored totals, not the entire FFT inventory. They concern c>10000 only. The primitive-label ratio4692136729/5543640187, the height-weighted output ratios and the setup ratios measure other objects. Removing high conductors saves fewer samples proportionally than labels because those conductors have shorter required heights. The reports preserve this distinction.

All-conductor character-circuit totals are diagnostics; adding them to a separately priced small-conductor theta/time schedule would double-count that branch. Nonunit cached kernel magnitudes, coefficient uncertainty, complete signs/counts, repairs, auxiliary heights and field precision are absent from these gate counts. The script does not supply evidence for any of those claims.

## Root composition and its limits

The root compares R138000 mixed-radix G=2736537742659260,A=5668480164659994 with the c>10000 R150000 whole-axis baseline G_old=4890157406463512,A_old=11446911736111484. At the level of real operation categories, a four-product complex gate contributes4 products and2 additions. The fixed-coefficient three-product identity contributes3 products and3 runtime additions, provided its two coefficient presums are separately cached and charged.

Hence the root's conditional ratios are exactly

    3G/(4G_old) = 2052403306994445/4890157406463512,
    (2A+3G)/(2A_old+2G_old) = 2443321694662221/4084267285643749.

These reproduce the quoted approximately .4197009 and .5982277. The base A category is complex additions, so its factor2 is necessary. A genuinely variable Gauss gate instead contributes5 additions, not3. A cached Bluestein kernel is fixed relative to each new input but is not a unit coefficient and is not exact; its construction, error and magnitude remain in the appropriate budgets.

The root correctly binds the complex-product argument together with its addition-width erratum. It does not reuse the withdrawn additive-total columns. Exact common-grid internal arithmetic and the same final rounding can preserve the center/error contract, but grown operands, sign handling, coefficient presums and alignment proofs still cost work. Independently represented exponents alone do not supply a bounded common grid.

The mixed-radix precision result concerns a common sufficient absolute-error allocation and fractional precision under its stated input/output bounds. Its safety floors45/43 are not final output precisions or total operand widths. Neither that result nor the operation-count composition proves equal-width arithmetic or a runtime ratio. The root states these restrictions explicitly.

The root's original-RH cutoff adoption and numerical minor reserve are inherited from the named source/scalar reviews; I have checked their frozen references, not independently reconstructed those analytic estimates in this task. The root keeps QRH and the new R135000 candidate separate, and leaves broader existing Lean hypotheses, finite-RH production, numerical coverage and foundation/translation work open. Its NTT reuse statements agree with the separately frozen review7301FB9A..., including nominal final tiles, residual retention and the fact that512 MiB measures raw cached outputs only.

This review therefore accepts the independent label/grid reconstruction and the conditional reconciliation as written. It must not be cited as a full-inventory replay, a new cutoff theorem or numerical spectral verification.
