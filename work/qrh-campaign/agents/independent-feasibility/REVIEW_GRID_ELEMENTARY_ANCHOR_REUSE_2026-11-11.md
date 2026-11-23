# Independent review of grid elementary anchor reuse

2026-11-11. **PASS at paper and exact-metadata scope.** No mathematical correction is required. The proposed blocks cover the actual shared rational input grids, the finite real Taylor bounds close the stated absolute-error budgets, and the stage and anchor counts match an independent reconstruction. This does not certify any elementary value, seed, transform or zero, and does not establish a runtime improvement.

## Frozen inputs and evidence

Paths below are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| zero-sum/GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md | E564A8DDEC5F0AD69F5CF22DFC89147F81EA165B6E6D17B4CF0EFB0EEA3824AF |
| zero-sum/grid_elementary_anchor_metadata_20261111.py | 10AB9F92831A32605FD89F37C9BBD385A9B580D53B382D22D7F0FC72D7B1DC54 |
| zero-sum/grid_elementary_anchor_metadata_20261111.json | 3F9CDE0D49019291509B8382133085CCD6B02F9E496D17C1CB70A4F4C01AABED |
| integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md | 1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E |
| prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md | 251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231 |
| major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md | 60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9 |
| zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md | E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B |
| independent-feasibility/review_grid_elementary_anchor_20261111.py | 4057E3F61AE47DB169D43507EA259A553D4C5189980AE06E42B9223EF5604063 |
| independent-feasibility/review_grid_elementary_anchor_20261111.json | 46B2CC6D57A172BB051324D50EA3ACB051B80183116DD256082E1C91AE261218 |

The independent script imports no producer code. It checks all seven input pins and reconstructs the integer partitions, all saved grid fields, degree selection, atanh tail thresholds, finite binomial bounds and error allocations. It completed 4,478 exact checks with status `PASS_INDEPENDENT_EXACT_METADATA`. Only integers and rational numbers were evaluated; no logarithm, root, phase or analytic function was evaluated. The scaled report is used here to check its direct elementary-leaf interface, not to replace its separate full review.

## Coverage and finite Taylor argument

The old five meshes embed exactly in the finest D=8192 mesh; doubling gives D=16384. Their input endpoints are within [1,3389]. Starting at n=D, each block ends at min(3389D,n+floor(n/128)-1), and the next begins at its successor. Thus there are no gaps or duplicates, including the last endpoint. Every block is nonempty and 128j<n for every actual offset j. The independent counts are 1,046 and 1,045 anchors, respectively, among 27,754,497 and 55,508,993 points. The elementary geometric-growth argument also proves the coarse bound below 3,073 blocks without a numerical logarithm.

For log(1+u), integrate the finite geometric identity to obtain error at most u^(K+1)/(K+1). For (1+u)^(-1/2), the stated derivative formula and binom(2k,k)<=4^k bound its Taylor remainder by u^(K+1) on the real segment [0,u]. These are real finite Taylor arguments; neither a complex branch nor an interchange of infinite sums is required. The looser common bound 2*128^(-(K+1)) gives degree19 at p135 and degree17 at p121. All seven precision examples and the independent atanh thresholds match.

## Error and representation checks

The log budget 9E/16 is correct for the stated **exact rational coefficients** and one rounded affine Horner operation per stage. A separately rounded coefficient would require another allocation; paying an additional 2e would still fit, but is not the displayed circuit. Likewise, splitting the fused affine operation into separately rounded multiplication and addition changes the named gate count and must be charged.

For amplitude, all precomputed coefficients derive from the same approximate anchor. Decompose the error as (ahat-a_true)*(1+u)^(-1/2), then ahat times the polynomial remainder, then the individual coefficient and gate errors. This retains anchor error E/4 and uses |ahat|<=5/4. The resulting 21E/32 bound is valid. Coefficients must be formed directly from the common anchor or by a separately justified recurrence. Returning the anchor directly at j=0 is sound. No error accumulates between distinct points.

On the common grid 2^-g with g=p+5, the log affine expression has denominator dividing n0*2^g*k, while amplitude has denominator dividing n0*2^g. The old/new raw denominator bit caps are therefore 170/171 for log135 and 151/152 for amplitude121. These are unreduced denominator caps, not total serialized operand widths. The bounded Horner states give numerator caps of the same order with constant guard bits. Binomial setup incurs O(p+K) widths only per anchor.

These width claims require bounded dyadic anchor centers and the indicated common coefficient grid. Arbitrary huge-denominator anchor encodings would not satisfy them. One can request sufficiently accurate dyadic anchors and include their final rounding in the E/4 budget. The report does not supply those certificates. Exact quotient/remainder or rounding checks remain required at every implemented gate; native array operations alone are not standard-axioms acceptance.

## Cost and consumer scope

The independently reproduced combined log/amplitude stage counts are 999,124,236 and 1,998,286,128. They exclude anchor certification, anchor additions, final rounding, coefficient construction, storage and later phases. The alternative 43-term atanh bound at p135 correctly includes the shared log2 error; its unfinalized cache requirement matters. The two-square-inequality inverse-root witness is also sound and may have a different cost profile. Neither comparison selects a runtime winner.

For the scaled direct leaf, delta=2^-118, E_L=2^-135 and E_A=2^-121 satisfy 10000E_L<=delta/8 and E_A=delta/8. Combining this with a separately certified cis error delta/8 and product rounding delta/8 gives total below delta, including the approximate-amplitude cross term. This does not make the phase evaluation free, establish every seed enclosure, or transfer these precisions to the optional height recurrence. That recurrence has its own smaller step-error target.

The proposed improvement is therefore a valid shared elementary setup circuit with explicit finite obligations. Actual bounded dyadic anchors, certified arithmetic and phase implementations, resource measurements, and downstream seed/sign/completeness checks remain open. No prior frozen artifact was modified.
