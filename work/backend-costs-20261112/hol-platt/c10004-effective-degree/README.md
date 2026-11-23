# Exact zero tails of band-1 mixed-grid Hurwitz inputs

On the +41 guard baseline, a shared height-dependent degree cap skips 126,782,212,733,568 of the 850,043,263,132,560 complex Horner stages across band 1. Each skipped coefficient on its **assigned integer grid** is provably zero under the original source error contract. The output is therefore bit-identical to the fixed K20/b94 circuit, including its existing error allowance. At t=5/64, the cap is degree eight for every fine cell.

## Per-height certificate

Let s=1/2+i(5h/64). The band-1 source normalizes each coarse derivative by D=512. For j≥1 and x=1+α, the decreasing-series integral bound gives

    |U_j| ≤ [∏_{r=0}^{j−1}|s+r|/(j! D^j)] [x^(−j−1/2)+x^(1/2−j)/(j−1/2)].

Both powers decrease on x≥1. The certificate takes x=1 to get a common upper bound for all coarse and fine anchors. For each product factor, count.py rounds the square root of (32+64r)^2+(5h)^2 upward on grid24 and divides by 64. The rest is exact rational arithmetic. Only the upper bound for j≥1 is needed; the triangular shift cannot propagate degree zero into a positive degree.

Start the positive-degree bounds at these analytic envelopes plus 2^-102 for each stored coarse coefficient. This source allowance is the proved band-1 scaled finite EM bound including its arithmetic and EM remainder. For all 330 pruned midpoint updates propagate A_j ← A_j+A_(j+1)/2+2^-110 in the original order. This gives a per-degree upper bound on the **stored** midpoint center, including all rounded shifts. Nonnegative coefficients make these bounds cover the untranslated even anchors and right endpoint too. The same loop run at increasing |h| produces nondecreasing bounds.

If the resulting degree-j norm is strictly below 2^(-b_j−1), both coordinates round to zero on grid b_j. Exact rational binary search finds the final qualifying h separately for each j. The effective degree at each h is the largest degree for which the inequality has not proved zero, with degree zero always retained. In particular, degree 19 must vanish through h=4577, degree 16 through h=2511, and every degree from 9 upward through h=10. The derived sufficient cap ranges from 8 to 19 over 0≤h≤6400.

For effective degree d, initial zero slots and products by zero keep the full circuit's accumulator exactly zero until the coefficient at d is loaded. Copying that coefficient directly gives the same accumulator as the original update. Exactly 19−d complete stages disappear. This argument retains the original coefficient grid and all later rounding points. This certificate covers the P27-to-P20 finite translation rather than using the derivative values at fine centers.

## Inventory and measured cases

For each conductor the calculation weights every h from zero through the end of its contiguous first-band prefix by φ(c). The prefix length is min(6401,J+extra+guard); every unguarded length was checked against its manifest field. The unguarded total of 44,637,243,437,690 residue evaluations and the guarded total of 44,739,119,112,240 agree with the original frontier ledger. For extra-node alternatives 0,167,320,640, all modifications to the prefixes concern heights past the proved savings. counts.json contains separate histograms for all eight alternatives.

Under the old per-stage byte templates, the removed operations account for 32,544,239,335,695,360 product events and 11,157,177,105,285,120 addition events in each alternative. These are gross savings in the evaluated Horner stages. Applying them in a proof checker requires a reusable height-and-degree certificate, binding to the specific source and rounding grids, and a Horner suffix identity. Full source generation and midpoint translation remain charged. A packed group of heights can skip only stages absent for every included lane unless its layout explicitly handles inactive lanes. Wall-time reduction has not been measured.

All 1,025 fine-anchor vectors at h=1 actually have highest integer degree 8. Running the shortened recurrence on all 4,800 residues reproduced the archived grid94 outputs exactly. Across the 64-height two-cell slab, 22 cell/height vectors have degree 8 and 106 have degree 9. Both shortening to the observed degree and shortening to the uniform height cap independently reproduced all 448 scalar outputs.

The scaled seed bound is in work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md. The stage shapes and prices come from the band1_K20_b94 record in the guarded residue evaluation frontier. The stored-center semantics and 330-update order are described in STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md and SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md. The run used the structural manifest hash in counts.json.
