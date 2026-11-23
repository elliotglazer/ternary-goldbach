# The raw phase step on its output grid

`SourceRawStepTheory.source_raw_step_error` bounds the output of the original executable raw producer. If `source_log_domain x 1 k` and `k ≤ 18`, put `θ = −(5/64) ln(&x)`. Then

\[
\left|\operatorname{source\_pair\_value}_{2^{122}}\bigl(\operatorname{source\_raw\_step}(\operatorname{source\_raw\_log129}(k,x))\bigr)-(\cos\theta,\sin\theta)\right|\le 2^{-120}.
\]

The modulus is HOL4's Euclidean complex modulus. `SourcePhaseTaylorScript.sml` shows that each coordinate of the ideal Horner recurrence is the corresponding factorial-weighted Taylor sum. Its induction covers any starting index and number of terms. The coordinate derivative sequence rotates the pair `(cos x,sin x)` by a quarter turn at each derivative. `SourceRawTaylorScript.sml` applies HOL4's `MCLAURIN_ALL_LE` independently to both coordinates and bounds their sum of absolute errors by `2^74/73!` at degree 72 on `|u| ≤ 2`.

`SourceRawStepScript.sml` adds the final nine-bit regrid error `2^-122`, the internal rounding error `9·2^-131`, the Taylor remainder, and the log-induced phase perturbation `2·(5/64)·2^-128`. The mean value theorem supplies the Lipschitz bounds for both coordinates. The exact combined allowance is approximately `0.255005·2^-120`. This discharges the step-accuracy premise of `SourceStateBoundsTheory.source_raw_state_error_lt_dyadic96` with the source program's grids and term count.

`SourceInitialTheory.source_initial_accuracy` already gives the amplitude bound on successful initialization. A source-state bridge would combine those two results with the exact model recurrence. The Euler–Maclaurin phase producer and a block-wide enclosure have separate obligations.

The accepted `taylor02` build used 46.66 user seconds and 13.02 system seconds, with 120.31 seconds elapsed and 876,160 KiB peak RSS. Each input hash passed a post-build check. These are one-time construction costs. Evaluating all instances in a Platt block requires a separate measurement.

The independent `tayloraudit01` reload returned zero after checking four exact statements against separate quotations, empty hypotheses, empty theorem-specific axiom tags, and permitted disk reload tags. The ancestry contained `bool.SELECT_AX`, `bool.INFINITY_AX`, `bool.ETA_AX`, and `bool.BOOL_CASES_AX`. The audit used 11.72 CPU seconds and 18.56 seconds elapsed. Its output manifest records SHA-256 `0f6e27aa10f7899bfb1ee4ffb65c4622c710ac5b34b73e02a125236517fee7a7` for `SourceRawStepTheory.dat`.
