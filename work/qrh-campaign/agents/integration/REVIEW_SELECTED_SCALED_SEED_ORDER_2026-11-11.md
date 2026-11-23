# Review of the local P27 seed-order selection

2026-11-11. PASS for the fixed allocation and consumer interface, with no correction requested. This binds `work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md`, SHA256 `579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1`. I read the full note, checked all six prerequisite pins, and independently reconstructed its rational error fraction and operation differences. No analytic values, builds or production runs were used.

Both orders use the reviewed scaled coefficients U_k=C_k/D^k, the same coarse D and height schedule, N and m64, base-power tolerance2^-118 and internal rounding2^-122. The seed-radius eta=2^-100 here is the coarse coefficient radius. It must not be relabeled as a uniform radius for every translated fine coefficient. The existing differentiated/weighted translation error contract remains in force.

For P27, the complete isolated alpha bound divided by2^-82 is exactly

    10065943424467492228678097495
      /32076363635089380005973590016 <1/3.

I reconstructed it from the two separate Taylor tails,2532eta,633*330*2^-110 and1688*2^-100. P28 has more slack, but no additional correctness condition in the selected consumer asks for that slack. Each method retains20 coefficients, uses the same scaled final displacement |h|<=1/4 and exports the same character-summed absolute alpha bound2^-82. The real segments and endpoint treatment are unchanged. The downstream fixed-order Horner and character-transform schedules do not acquire a P28-only mathematical premise.

Let A=sum_b D_b H_b=717521408 over the five pinned bands. The right endpoint uses only20 coefficients in both methods, so it does not contribute to the differences. Independent exact arithmetic gives sum_b N_b D_b H_b=2068094728192. Therefore the P28-minus-P27 differences are:

| Category | Difference |
|---|---:|
| Coarse coefficient slots | 717,521,408 |
| Head reciprocal scales | 2,068,094,728,192 |
| Head additions | 2,068,094,728,192 |
| E stages | 717,521,408 |
| Bernoulli weighted terms | 45,921,370,112 |
| Midpoint updates | 14,350,428,160 |

The last two counts are64A and20A. The common elementary argument/height pairs, log and phase setup, and final-order20 work do not shrink merely because the coarse order changes. Short per-coefficient output and assembly loops also omit the top coefficient, but the report does not need an artificial single price for those operations.

The subset statement has a precise algorithmic meaning. In the P28 pruned Pascal schedule, remove the20 updates whose target index is26. The remaining ordered list of update indices is exactly the P27 schedule. The independent metadata check verifies this identity. Likewise the P27 head and endpoint recurrences omit the top coefficient and last needed E stage at each full coarse anchor. Existing uniform precision and magnitude caps still apply.

This does not mean the surviving intermediate values equal those in a P28 run. P28's top coefficient propagates into lower shifted coefficients. P27 can produce different numerical centers, and no containment in old fixed boxes has been established. Adaptive sign-margin exploitation, precision retuning, a different tail allocation, or different implementation scheduling could alter the comparison. The note explicitly excludes those stronger conclusions. A subset of this mathematical circuit also does not by itself imply fewer Lean reduction steps or faster ordinary-MM0 checking without representation costs.

P27 is therefore justified as the default comparator inside this fixed scaled construction. This does not eliminate unshifted P24 or independently generated fine P20 as end-to-end competitors, and does not prove a globally cheapest spectral method.

The exact evidence is `integration/selected_scaled_seed_order_review_20261111.json`, SHA256 `78D56C5764CF154E8BD3A307E9F2BADD00A6356807F41618A8B0A037B48F6A00`, relative to `work/qrh-campaign/agents`. It records the author and prerequisite pins, all six count differences, the exact error fraction and the ordered-stage deletion identity. It was produced by independent integer/Fraction metadata calculation, without importing an author evaluator.
