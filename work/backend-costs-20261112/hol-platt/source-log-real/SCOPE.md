# Logarithm tail proof candidate

The twelve fixed audit statements were recorded before the first build. They assert the analytic bound for the explicitly defined finite polynomial P_N(v) = sum of 2 v^(2j+1)/(2j+1), for j < N. The general bound is (9/4)(1/3)^(2N+1) on 0 <= v <= 1/3. The N=45 specialization is at most 2^-135, including ln 2 at v=1/3.

The proof uses ordinary real differentiation and the mean-value theorem. No Lean theorem is imported. There is no integer Horner refinement, rounding bound, range-reduction producer, exponential phase proof, complete sign/count block or throughput claim here. Those remain required for the active full objective. Exact conclusions, empty hypotheses and the standard HOL ancestry/tag conditions are checked on recorded-result reload. Reload is not independent whole-kernel replay.

The source and expected conclusions are frozen by source_expected.sha256 before each attempt. Preserve failed candidates before repairs. No statement changes are authorized implicitly by proof failures.
