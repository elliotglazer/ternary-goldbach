# Proper powers in the Gaussian prime window

For every real `10^15 ≤ x ≤ 10^27`, put `J = (x exp(−126.2/√x), x]`. The target in `LocalPowers.lean` bounds the von Mangoldt mass of nonprimes in J by 362,880, including any weight bounded above by one. This suffices for a mass allowance of `0.012√x`, since `√x ≥ 31,000,000` on the parameter range.

For exponent k ≥ 2, the length of the interval of possible bases is bounded by `√x − √(inf J)`. The sum of these square roots exceeds `1.98√x`, and J has width at most `126.2√x`. Their ratio is less than 64. The integer count is therefore at most 64, including its right endpoint. The proof sums the counts over the at most 90 possible exponent values and charges at most 63 per base. The analytic lower bound for primes and the other Gaussian errors belong to separate proof steps.

`PinnedCount.lean` preserves the complete declaration bodies of the Apache 2.0 source by Hubbard's Lean Lab. The imports have been narrowed for Lean 4.35.0. The upstream proof of `sum_nonprime_le` derives a unique exponent from the factorization, bounds its range and counts prime bases with multiplicity one for each exponent. [Upstream Count.lean at the inspected commit](https://github.com/sthubbar/goldbach-lean/blob/f003a97d7598923787920723668d62c16c82b81e/entries/dudek2014/LeanLab/PrimePowerWindow/Count.lean)

Reproduce with the existing read-only Mathlib dependencies from the pilot. Run `check.py` on `PinnedCount.lean`, then `LocalPowers.lean`, then `Audit.lean` using unique log labels and output module names `PinnedCount`, `LocalPowers` and `LocalPowersAudit`.

Lean 4.35.0 accepted the local specialization at trust level zero in 22.83 CPU seconds with no warnings. The separate axiom probe lists exactly `propext`, `Classical.choice` and `Quot.sound` for both the exact-window count and the weighted sum. See `local02.json` and `audit01.log`.
