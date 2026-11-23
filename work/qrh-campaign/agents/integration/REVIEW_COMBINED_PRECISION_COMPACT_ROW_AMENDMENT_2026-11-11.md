# Compact-row amendment and revised writer clearance

2026-11-11. PASS for the narrow schema amendment and source clearance for the exact revised writer. A rerun still requires explicit coordinator authorization. No writer was run during this review, and no data inventory was parsed.

The amendment is `major-constants/COMBINED_PRECISION_COMPACT_ROW_AMENDMENT_2026-11-11.md`, SHA256 `AACBB5CA78AA460F811FBDF90040741E9A546AC23381F9A9BF8DA9F53DC5A25B`. The inspected successor writer is `major-constants/combined_conductor_precision_assignment_20261111.py`, SHA256 `F67CF569467ED444A0BB8ED0F576166F4B289B8E5710CB769F08D3F22AF78408`, 31165 bytes. Paths are relative to `work/qrh-campaign/agents`.

## Failure and source history

I read the original standalone source `48886836AC2B6B28EE10F879C7627F6673F7BD99640858D780B249317669ECDE` in full before any run. I requested one failure-reporting fix: track an own-created output immediately after its exclusive open succeeds, before write/close can fail. The corrected source `D0764C6DFEB13453D4F47356EAC62A7138CEBF8F9963B6F2AC1E30C3F1D1F785` received clearance. The refused-preexisting-path case does not count as a file created by the run. The unexecuted initial source remains preserved.

The first authorized D076 execution stopped at its encoded-artifact cap after30371291 checks, before any output file was opened. The failure note `major-constants/COMBINED_PRECISION_FIRST_RUN_STOP_2026-11-11.md` has SHA256 `11FA5B695F37C9A2A0669282CDFC4D8A351D2FBD54E4A55AB240E0FD444938DD`. The failed source is preserved as `combined_conductor_precision_assignment_20261111_v2_failed.py`. The old diagnostic did not identify the failing artifact or actual encoded byte count. This review does not infer either value or certify unpublished results from the failed process. The new attempt will reconstruct everything again under its own authorization.

## Exact information retained

Schema2 stores thirteen fields through rho, retaining conductor identity, phi, primitive count, mixed/sharp/tight sums, S_base, D_local_old and all three precisions. It omits only the four deterministic new slack fields from serialization. It does not omit their computation or acceptance checks.

The unchanged selector loop computes the selected squared-budget slack, both safety slacks and the last failed budget. It accepts only when all selected slacks are nonnegative and, unless p=80, the previous budget is negative. Global safety already holds at80, so budget failure alone establishes the previous test's failure. The independent result checker must reconstruct all four quantities from each compact row and compare against the fixed mathematical contract. A success flag or digest cannot replace those checks.

All old and sharp rows retain their full exact comparisons, and both full cache closures must still match before new selection/publication. The new row schema identifier is changed explicitly. The cache artifact continues to bind the newly encoded row hash. The candidate circuit, error terms, source/input contract, precision range, cache masks and resource limits are unchanged.

## Size and source checks

The new explicit range check `1<=primitive<=phi<=c` complements the existing supplied-axis product and identity checks. Together with the existing bounds, the thirteen fields need at most84 decimal digits. Two brackets and twelve commas give98 bytes per row, and one outer separator gives99. Thus125400 rows need at most12414600 bytes including conservative separators. The separately checked row wrapper is at most1048576 bytes, giving13463176 bytes, below the unchanged33554432-byte row cap.

This is a static representation bound, not an estimate of the failed output. The amendment's comparison bound for the old seventeen-field format is also conservative: adding69,33,33 and87 characters for the four signed slack fields yields at most325 bytes per row with punctuation, or40755000 bytes before metadata. It does not prove that those maxima occurred.

I compared the full revised-source diff against the inspected failed version. The changes are limited to the amendment/failure pins, the explicit metadata range, thirteen-field row construction and schema2, the wrapper-size proof/check, and diagnostics containing artifact name, actual byte count and limit. The numerical selector and both predecessor reconstructions are unchanged. All output paths and encoded sizes are still checked before exclusive publication; the own-created-path fix remains intact.

The observed-memory policy, ten input allowlist,29 candidate limit, compact masks and all record/output caps remain as reviewed in `integration/REVIEW_COMBINED_CONDUCTOR_PRECISION_ASSIGNMENT_PREFLIGHT_2026-11-11.md`, SHA256 `E1DA5A7A4101326B2419EB9367D842405AB9965DC44B8807B33CE8F345C9B2B8`. An observed1GiB threshold is still not an absolute parser-peak guarantee. No shared-high cache, runtime/guard-weight fold, extra inventory, value production or proof emission is added.

The exact F67 source is cleared under the frozen preflight plus this amendment. Root authorization remains required before rerunning it. Final mathematical-result acceptance must wait for the successful frozen outputs and independent reconstruction. There is no new result or performance verdict here.
