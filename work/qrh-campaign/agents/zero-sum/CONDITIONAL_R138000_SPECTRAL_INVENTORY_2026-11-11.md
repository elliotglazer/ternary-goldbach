# Conditional spectral inventory for R138000

2026-11-11. Exact integer/rational metadata only. The cutoff frontier is under separate mathematical review; **this report does not adopt R138000 or validate its analytic derivation**. No character, root, FFT, L-function, zero or prime values were evaluated. No build was run, and all older files are unchanged.

Compared with the same R150000 mixed-radix schedule, R138000 retains .846399–.846400 of primitive nonprincipal labels, .899767–.899768 of large-conductor general complex products, and .899585–.899586 of large-conductor additions. These distinct ratios price distinct objects; none is a total runtime or final proof-cost ratio.

## Fixed profile and computation

The inspected mathematical proposal is `major-constants/EFFICIENCY_ORIGINAL_RH_CUTOFF_FRONTIER_2026-11-11.md`, SHA256 `92D9973CE90C99748317A4D029057B7D3A2522BC1DE30A5EA300F4A3EA61FEE6`. Its stated original-RH family keeps odd c<=138000 and conductors divisible by four with c<=276000. This inventory excludes conductor one, as its principal obligations are separate.

Every retained conductor has its old height: H(c)=100000000/c for odd c or c<=125000, and H(c)=200+75000000/c otherwise. For even c this is the stated maximum of those two expressions. The unchanged nominal nonnegative coarse grid has spacing5/64 and J(c)=ceil(64H(c)/5)+1 points, including zero. The last point can be above H(c). No guard or auxiliary Turing nodes are added or removed in this comparison.

The c=10000 switch is fixed. Above it, every full unit-group character transform uses the same positive unnormalized mixed-radix circuit as the frozen R150000 and R140000 inventories. All v=phi(c) outputs are computed before primitive filtering. For axis lengths m_i the per-conductor total in each operation category is J(c) sum_i (v/m_i) C_mixed(m_i). Conductor removal changes neither the circuit selection at a surviving axis nor its precision contract.

R138000 removes6000 odd conductors in(138000,150000] and6000 multiples of four in(276000,300000] from R150000. Relative to R140000 it removes1000 in each class. No affected conductor is in the unchanged small-conductor branch.

## Labels and coarse samples

| All nonprincipal conductors | R150000 | R140000 | R138000 |
|---|---:|---:|---:|
|Conductors|149999|139999|137999|
|Primitive labels|5543640187|4829158813|4692136729|
|Real primitive labels|121577|113481|111851|
|Nonreal inverse pairs|2771759305|2414522666|2346012439|
|Unit coefficients at one point per conductor|9118941848|7943636860|7718273228|
|Sum of nominal conductor-height nodes|10979779734|10906251119|10891026048|
|Coarse residue inputs / all character outputs|120706437078428|112067381988794|110351807778156|
|Coarse primitive outputs|80459602925766|74855673008489|73739622075701|

R138000 removes851503458 primitive labels relative to R150000, and137022084 relative to R140000. The latter retained ratio is .971626–.971627. Inverse-pair counts are bookkeeping only: no extra factor-of-two discount is applied to the all-output circuit. Conjugation, phase, real-axis and inclusive-height obligations remain unchanged.

| Large branch c>10000 | R150000 | R140000 | R138000 |
|---|---:|---:|---:|
|Conductors|142500|132500|130500|
|Primitive labels|5525163079|4810681705|4673659621|
|Unit coefficients at one point per conductor|9093611126|7918306138|7692942506|
|Sum of nominal conductor-height nodes|2863650650|2790122035|2774896964|
|Coarse residue inputs / all outputs|114223068442718|105584013353084|103868439142446|
|Coarse primitive outputs|75730502011007|70126572093730|69010521160942|
|Maximum number of height nodes|127989|127989|127989|

The R138000/R150000 coarse-residue ratio is .909347–.909348 and coarse-primitive-output ratio .911264–.911265. Removed large conductors have shorter height ranges, so primitive-label savings overstate sample savings.

## Five operation categories, large branch only

| Category | R150000 | R140000 | R138000 |
|---|---:|---:|---:|
|General complex products|3041383327064694|2787051874367696|2736537742659260|
|Complex additions/subtractions|6301213142003526|5773363484523660|5668480164659994|
|Quarter turns|279797486233036|256592386748025|251954587115486|
|Negations|66590728284|61675282036|60339019852|
|Dyadic scalings|271405257746112|248843952956864|244332926367552|

The R138000/R150000 ratios for these rows are .899767–.899768, .899585–.899586, .900489–.900490, .906117–.906118 and .900251–.900252. Relative to R140000, products retain .981875–.981876 and additions .981833–.981834.

These are complex circuit categories, not a choice between three- and four-real-product implementations. Operation width, root construction, interval bookkeeping and memory movement are not assigned costs. The receipt also contains all-conductor character-circuit totals as diagnostics; they must not be added to a separate small-conductor theta/time budget. Every small-branch record is exactly unchanged, including its18477108 primitive labels.

## Shared floors and setup

The maximum large-branch height index remains127988, hence127989 coarse height points. Reusing the previous fixed P24 adaptive alpha seed schedule therefore leaves its seed-grid union unchanged. Fewer conductors reduce contraction and transform work, not that fixed shared seed generation. No claim is made that the fixed seed schedule is optimal.

| Large-branch setup | R150000 | R140000 | R138000 |
|---|---:|---:|---:|
|Distinct axis lengths|13943|13103|12933|
|Active circuit nodes|37117|34721|34217|
|CT split lengths|30625|28520|28071|
|Bluestein kernel lengths|6472|6181|6126|
|Padded kernel entries|382342624|354678240|349646304|
|Chirp entries|153585028|145093425|143630374|
|Maximum padded length|262144|262144|262144|
|Full CT root-table entry upper bound|1436913503|1247555730|1210093865|

All profiles have16 radix-two lengths, four direct-prime lengths and26 direct-prime root entries. The padded-kernel-entry ratio R138000/R150000 is .914484–.914485. The maximum single padded array is unchanged. Entry totals are not simultaneous RAM requirements; kernels can be scheduled or streamed. The CT table count remains the same deliberately loose full-table upper bound, not minimal root storage.

For R138000, the once-per-precision kernel FFT setup costs (G,A,Q,N,S) are

    (2329463004,5707840416,174817026,0,0),

compared with (2559613840,6266229664,191164840,0,0) for R150000 and (2364827978,5793665952,177332939,0,0) for R140000. This excludes elementary chirp/root generation and any rebuild at higher precision. Cached kernel error still enters every consuming transform; sharing setup does not make its error zero.

## Verification and artifacts

The new standalone script preserves the integer circuit definitions from the frozen R140000 calculation and changes the candidate bound to138000. It recomputes R150000, recovers the original operation totals and canonical plan hash, and checks its entire recomputed R150000 profile against the hash-pinned R140000 receipt. It then compares R138000 both with R150000 and with that immutable R140000 profile. Small-branch equality is asserted. No old script is imported or rerun with its output side effects.

New active-plan hash: `af2932afd77dce5111c8f44b4ead6168f55e3dcc063b1e06d04fc5f6e71d1b8f`. Metadata status `PASS_CONDITIONAL_R138000_INTEGER_INVENTORY` means these integer checks passed, not that a mathematical cutoff or finite-RH certificate passed.

| Artifact | SHA256 |
|---|---|
|`conditional_r138000_mixed_inventory_20261111.py`|`656281DA20790A8FBCCC330C6276A130979A59A15AE35F790ABBBFDA44E38A23`|
|`conditional_r138000_mixed_inventory_20261111.json`|`0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F`|
|Prior `conditional_r140000_mixed_inventory_20261111.json`|`DA26BF4BA4744CF5AF096670873FE9CA258735A8EFA4DE09D0F490A56F36F5F7`|
|Original `mixed_radix_character_inventory_20261111.json`|`2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F`|

The prior R140000 report is SHA256 `4C2BF656CB85501D7268D2E6A29A33F1D4A716F8DE7E3D553493333A99638353`; the circuit report is `C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01`. Their algebra, interpretation and exclusions are unchanged. The complete proof still separately needs source evaluation, checked arithmetic, actual sign/contour success, exceptional repairs and Turing completeness, as well as the analytic justification for removing the conductors. This report establishes no runtime forecast or analytic adoption.
