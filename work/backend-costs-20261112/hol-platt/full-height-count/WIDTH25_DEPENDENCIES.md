# Width-25 closed-count dependency audit

At conductor 10000, `ShortGuardTheory.parity_width25_even` and `ShortGuardTheory.parity_width25_odd` establish `parity_test = T` for the two archived inverse pairs. `ShortGuardScript.sml` reuses the four `CountReceiptTheory.runs_{000,010,100,110}_checked` main scans, checks the truncated auxiliary scans and supplies literal Booleans for the endpoint signs. `FullCountTheory.strict_inequality` expands the integer saturation test. The shift by one in `parity_test_def` implements the upper threshold of two above the combined main count.

`FullCountTheory.endpoint_parity` evaluates a Boolean fold over a supplied list of multiplicities. `ShortGuardTheory.exact_pair_count` consumes parity agreement between each positive-channel multiplicity total and its observed flip count, the decomposition `n = m1 + m2 + 2 * off`, and both count bounds. It then uses `FullCountTheory.exact_count_of_parity` to conclude `n = k1 + k2`.

The application to actual completed L-function zeros still requires these proofs.

1. Transfer the archived endpoint and bracket signs to the real Hardy functions, including strict signs at zero and at the cutoff on both channels. Apply continuity to the disjoint main brackets for the lower bound.
2. Enumerate all positive critical-line roots below the cutoff with multiplicities. Prove the normalized function changes sign across a root exactly when its order is odd and has constant sign between consecutive roots. Identify the resulting endpoint signs with the Boolean fold.
3. Identify negative critical-line roots with positive roots of the inverse character, preserving multiplicity. Pair the off-line roots by reflection across the critical line, preserving the closed height interval and multiplicity, including at heights zero and either cutoff. These facts give the decomposition consumed by `exact_pair_count`.
4. Transfer the weighted auxiliary bracket sum and the archived phase and Turing allowances to the upper bound on the same closed count. The checked saturation inequality then gives `n < k1 + k2 + 2`.

This audit inspected the existing HOL scripts and receipts. It did not rerun the kernel or estimate the frequency of successful width-25 counts at other conductors.
