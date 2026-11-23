# Independent review of the complete small-theta length frontier

2026-11-11. **PASS at conditional parameter, dimension and cost-model scope; no correction required.** Bound author: `audit/ALL_THETA_TIME_LENGTH_FRONTIER_2026-11-11.md`, SHA256 `BD024EE476AD011DCF47F7BFAA95D984FA061F05AAFFDBBCFC0D215294A657A0`. Its script is `10793282DD8C990CCE2C66D987115233EEE86DB7DE4237C62FD6183038E3A91B`; final receipt is `97DB46A0EEA2BFB064433F425D828BA309B85287A312B19BBCEE3D2C516DD78D`. No analytic values, transforms, primes, zeros or builds were evaluated. No frozen predecessor was changed.

## Admission and complete enumeration

I read the full frozen note and script, the earlier minimal-theta producer and independent review, and the variable-order and raw-interface contracts. I independently regenerated all 130 cohort/theta selectors: Wbar and epsilon, the least strict tail integers K and L, the X bound, complete n0 Gaussian tail, seed precision, prefactor and elementary-circuit safety inequalities. The exact regenerated values agree with the saved selectors. The corrected rounded-bucket requirement remains in force; this review does not revive the original exact-accumulation sentence.

The period inequalities are correctly equivalent to the original backend requirements. With m the closed grid index and Delta=5/64,

    N theta >= 2mK,   5N >= 5m+128K,   5N >=384

are exactly `N Delta >= max(2V K/theta,V+2K,6)`. I constructed the least power of two by repeatedly testing these integer inequalities, rather than using the author's rational ceilings and next-power expression. For every one of the 1949740 candidates I checked both admission and failure at the preceding power. I also independently reconstructed the integer certificate height and m, including the separate auxiliary scenarios.

Grouping the exact lengths gives all 44585 representatives. Their one-length/two-length row counts agree in all four scenarios: 3870/3629, 3862/3637, 3849/3650 and 3826/3673. Every two-length case has ratio two; the larger length's least-theta representative is 64. Each group representative satisfies the Wbar/V domain, frequency support, complete closed prefix, minimum N=2^18 and interpolation-order conditions. The improved bandwidth bound and raw sample-radius condition remain valid at the new lengths.

The earlier accepted selector is still correct: the first theta reaching N<=N128 agrees with its saved list in every row. That does not imply N128 is the minimum across later theta values.

## The eighteen interior exceptions

All 18 listed exceptions are reproduced independently. Their smaller length is available only at theta127, and both endpoint lengths are twice as large. I checked the displayed table itself against its integer formulas and the receipt, not just the receipt's count of exceptions.

For main c=745, m=576448, K127=231 and K128=233. At N=2097152, the theta127 first slack is 19328 and the second is 7573952; theta128's first slack is -189312. The preceding power fails at theta127. Thus the interior improvement is a genuine exact selector effect. It is not evidence of an FFT evaluation, numerical accuracy margin or successful signs. The two competing period floors and integer K jumps make endpoint-only minimization unsound.

## What the cost pruning does and does not establish

At fixed row and N, the frequency count, n0, Gaussian term envelope, conductor axes, character channels and all declared loop dimensions are fixed. For a,b>=0, not both zero, the adjacent-theta ratio is

    3 (a W_(theta+1)^2+b)/(a W_theta^2+b)
      >=3 theta^2/(theta+1)^2 >2.

This proves the relevant direction for time, omega and positive-scale recurrence allowances. The independently checked selectors have inactive competing `1/Wbar` branch and sigma equal to delta divided by `1024(3^11+1)^4`. Delta and sigma decrease by at least a factor two at each step. The other named tolerances follow from positive fixed multipliers and minima with fixed safety bounds. The bucket and coefficient/prefactor rounding allowances remain charged and have the required direction.

The adaptive order is nondecreasing as theta increases because M/epsilon increases. A smaller theta can use a larger admitted order with its already proved kernel norms. This supplies an option for avoiding new kernel setup; it does not make arbitrary cache reuse free.

The resulting pruning is valid for the stated sufficient-circuit score: identical circuit templates at equal N, common valid magnitude envelopes, costs nondecreasing with required fractional precision, and a setup plan whose cost does not increase under replacement. Within that model the least theta for each N suffices. It is not unconditional dominance between independently optimized implementations. Wbar and raw magnitude can grow at smaller theta, different tilts have different numerical leaves, and shared caches can favor a discarded choice. Actual sign margins and repair work can also differ. Preserve all 65 choices if these cost-model hypotheses are unavailable. The note explicitly retains those limitations and does not mistake its adjacent one-bit observation for a general temporary-width theorem.

The global objective correctly includes the shared setup/proof union as a coupled term. Rowwise optimization is valid only after establishing separability or paying for a fixed common cache. A smaller N changes omega and the coefficient sampling grid; old longer-array data cannot simply be relabeled.

## Count reconciliation and consumer scope

I checked that the saved all-theta64 and N128 category objects equal their previously reviewed endpoint inventories. Independently, I reconstructed primitive counts by divisor subtraction from Euler phi and recomputed every dimension-sensitive category difference between N128 and the minimum-N policy. This includes Gaussian, bucket, character, prefactor/radial, time-root, butterfly, full-output and conjugate-copy differences; all unaffected categories have zero difference. Every reported difference and resulting minimum-N total matches.

In the main scenario the checked differences are 1678745600 Gaussian unit gates, 68286103168 character butterflies and 61264625664 time butterflies. These compare declared loop counts, with changed precision and setup costs still unpriced. Exported grid geometry is unchanged. This review does not claim a fresh reconstruction of every unchanged foundational axis inventory; those remain accepted predecessor inputs.

The receipt deliberately retains amplitude-era omega/Y categories as a comparator. Raw-sign adoption removes them only once through its separately reviewed API. Interpolation/query arithmetic and all canonical sign/Turing work remain additions, not free consequences of the dimension frontier. Principal requirements, actual phases, both nonreal positive channels, central and closed-height conventions, failed signs and completeness remain unchanged. There is no successful-data or runtime conclusion.

## Evidence

Owned checker `zero-sum/review_small_theta_full_frontier_20261111.py`, SHA256 `F96EA300B818446ABAB5038B974739BD6F865EB7878FF8D688BCBBE0D8DF7A41`, and final receipt `zero-sum/review_small_theta_full_frontier_final_20261111.json`, SHA256 `6BD7464D4FA1E78DB68170364B548A323B39B07AB679909E6FEEACF691E004F8`, pass **4140178 exact checks**. The final receipt binds the author note, script, final metadata and four predecessor pins. It includes all 130 admissions, all 1949740 integer length tests, groups, representative domains, all 18 displayed exception rows and typed count differences. The earlier preparatory review receipt is preserved but is not this final bound evidence.

No author code or evaluator was imported or executed. The underlying theta analytic estimates and the accepted interpolation/phase/count interfaces are reused at their reviewed scope. Choosing a production policy, producing actual arrays and signs, closing counts, implementing an ordinary proof checker and pricing total work remain separate obligations.
