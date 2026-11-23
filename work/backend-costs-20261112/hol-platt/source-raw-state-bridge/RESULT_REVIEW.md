# Raw source states at the sampled times

`c10004_raw_state_error` covers each integer `x` from 1 through 10004 in the [c10004 raw source schedule](../../raw-state-compact/C10004_LIVE_DATA_SCHEDULE.md). The source initializer returns `SOME initial`. Starting from that actual integer pair, the persistent integer recurrence has strict Euclidean error below `2^-96` on its `2^120` grid for every update index `0 ≤ j ≤ 90000`. The theorem states the target as

\[
\exp\!\left[\left(-\tfrac12-i\,\tfrac{5j}{64}\right)\ln x\right].
\]

The step comes from `source_raw_step (source_raw_log129 (logroot$LOG 2 x) x)` on the `2^122` grid. The proof chooses the integer exponent, proves the source logarithm domain test, and proves successful construction of the initializer. `srb_target_components` identifies the amplitude `sqrt(1/x)` and phase `−t ln x`. `srb_target_step` proves the exact complex multiplication identity between consecutive times. The imported source-state theorem then bounds all 90000 updates with one induction.

`source_raw_state_log2` proves the same statement for every integer `0 < x < 2^19`. At the strict upper endpoint, the floor base-two logarithm becomes 19, outside the log producer's proved `k ≤ 18` range. The c10004 specialization includes both requested schedule endpoints.

The theorem gives an analytic error bound for the integer recurrence. Its applications to the products in a raw head, the Euler–Maclaurin branch, or a finished Platt block require their own enclosures.

`rawbridge02` built the module in 18.54 CPU seconds and 47.29 seconds elapsed, with 765,128 KiB peak RSS. A separate HOL process in `rawbridgeaudit01` reloaded four exact statements, checked their empty hypotheses and theorem axiom tags, and restricted reload tags to `DISK_THM`. Its theory ancestry contained the four standard HOL axioms. The audit took 9.48 CPU seconds and 15.54 seconds elapsed. Both runs returned zero. The SHA-256 of `SourceRawStateBridgeTheory.dat` is `b16b23b753640ed8d3bba94b73e0ce8e5f7de0566d56995480ab8749d6f2a4eb`.
