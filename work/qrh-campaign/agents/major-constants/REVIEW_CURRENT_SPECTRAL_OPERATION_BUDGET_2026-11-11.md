# Independent review of the current spectral operation budget

2026-11-11. PASS for the stated composition of operation categories and conditional transfer of the existing P20/shifted-seed constructions. No error requiring correction was found. This is a component budget, not an end-to-end cost bound or an executed spectral computation.

## Frozen version

Paths in this paragraph are relative to `work/qrh-blueprint`.

| Artifact | SHA256 |
|---|---|
| CURRENT_SPECTRAL_OPERATION_BUDGET_2026-11-11.md | D0D428B355F2DBD025DBE2BD6C4D1DC846B63892A81506445EC242571A8C1C7F |
| compose_current_spectral_counts_20261111.py | D7929BE47E1FED59945A9C584AAC17B4FECE36F8F608BCB4986C05D77707D8E0 |
| compose_current_spectral_counts_20261111.json | 34A6EFE3835098016854040A19F75431AFCF20DE115BD93FF8F6A7117B64B958 |

I read all three, checked the seven pinned inputs, and independently reconstructed the five composed rows and their exact rational ratios. I did not execute the author script or repeat the full conductor inventory. Its inputs are my previously reviewed R132900 inventory and the source-pinned full-circuit baseline.

## Source counts and domain

The new large-branch input is exactly the fixed-original-order row: G=1849018578634950, A=3808420069398260, N=99513098256768. It is not the slightly smaller optimized-order row. The full-domain primitive-label count 4351723951 is correctly distinguished from these c>10000 operation/input counts. The small branch is excluded throughout the comparison.

The baseline G=4890157406463512 and A=11446911736111484 are the whole-axis column in section 5 of `MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md`, SHA256 `C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01`. Its N=114223068442718 is the reduced R150000 large-branch residue count. It is neither the full historical Platt computation nor the full mixed-radix column. The report states these distinctions correctly.

## Real arithmetic decomposition

For P normalized Taylor coefficients, Horner has exactly P-1 multiply/add stages. Multiplying a complex value by an exact real displacement uses two real products. Adding the next complex coefficient uses two real additions. Thus H=(P-1)N contributes 2H to both real categories. There is no extra multiply at the leading coefficient.

An ordinary complex multiplication uses four real products and two real additions. A general Gauss multiplication uses three products and five additions. For a fixed coefficient a+ib and input x+iy, one valid cached three-product formula is

    t=a(x+y), u=(a+b)y, v=(b-a)x;
    Re=t-u, Im=t+v.

It uses three products and three live additions, with the two coefficient sums cached separately. This supports the report's fixed-coefficient row. The transform G gates, including cached Bluestein convolution-kernel gates, have coefficients fixed with respect to the input transform. Their certified sums and uncertainties still require setup and error accounting; the formula does not presume unit modulus of the convolution kernel.

Consequently all three displayed composition formulas are correct. All five stored rows passed independent exact comparison, including the reduced numerator and denominator of each ratio. For example, the P20/four-product row has 11177572048296984 real products and 15096375029823604 real additions. The fixed-three row has 9328553469662034 products and 16945393608458554 additions. Its lower product count comes with more additions and setup.

An important implementation boundary is preserved: the original-order pruning theorem inherits an identical retained-gate reference circuit. Replacing that circuit's internal complex multiply by a three-product formula changes its arithmetic graph. The three-product rows here are valid algebraic operation decompositions, not already verified rounding/peak-width implementations of that graph. The report explicitly leaves widths, signed arithmetic, rounding proofs and coefficient uncertainty in the actual gate price; this review does not silently transfer the old per-gate bounds to a different implementation.

## P20 and shifted seeds

R132900 is a restriction of the reviewed R138000 family. It retains conductor 10001 and hence the shared height union j=0,...,127988 on the j*5/64 grid. The five band parameters and alpha meshes remain identical. The prior bound phi(c)/sqrt(c)<633 remains valid under the restriction. Thus the P20 target-cell remainder and P27/P28 shifted-seed estimates transfer without new analytic evaluation.

The actual seed function remains zeta(1/2+it,1+alpha), with normalized alpha derivatives. The final P20 contraction uses the fine mesh of denominator 2D. The shifted construction supplies its first twenty midpoint coefficients from genuine coarse coefficients of orders through P-1. The shift remainder is additional to the P20 target-cell remainder, and its differentiated coefficient bounds must be retained. In particular, a midpoint jet cannot simply be assigned the original uniform coarse-seed radius. The root report correctly conditions use on the differentiated budget and actual coarse certificates.

I independently recovered H=127989 and sum D*band_count=717521408. Accordingly P27 needs 19375637796 independent coefficient slots and 236782064640 shift stages; P28 needs 20093159204 slots and 251132492800 stages under that fixed scheme. These numbers do not fall with the removed conductors. Shift stages and all seed work are excluded from the reported transform-plus-Horner subtotals, so the composition does not count their omission as a saving.

The cited shared-EM review explicitly supports the largest-band P28 figures 383 base-error bits and 388 head-grid bits as sufficient fractional thresholds. They are not relative precisions or uniform total word widths. This budget neither prices nor re-proves that full producer.

## Evidence and limitations

Independent script `major-constants/review_current_spectral_counts_20261111.py`: SHA256 `81A76FACB719170D21557197D48629523A19C6FDF7C29A7EBEC7540C77A50F6A`.

Independent receipt `major-constants/review_current_spectral_counts_20261111.json`: SHA256 `96DBF947F0229175560EA711474821EDE053FA86E61761423B8B699124C2AF60`.

The exact run checked 45 row fields/ratios, all seven input pins and the stated shared-grid/shift counts. Display floats are presentation only; the ratios are stored and checked as exact fractions. No analytic values, transforms, prime certificates, Lean builds or full inventory reruns occurred.

The budget appropriately excludes seeds, heads/phases, setup, cheap operations, argument errors, rounding witnesses, interpolation, signs/completeness, small conductors, binary/ladder work, foundations, serialization and final assembly. Its ratios therefore cannot be promoted to runtime or total Lean/MM0 generation-and-verification savings. All frozen inputs were preserved.
