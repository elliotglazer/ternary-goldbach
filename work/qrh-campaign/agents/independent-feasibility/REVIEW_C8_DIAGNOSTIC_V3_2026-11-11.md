# Independent review: C8 diagnostic V3 preparation

Verdict: **PASS, static source preparation only.** The paired V3 sources repair the evidence-loss path identified in the failed V2 attempt without relaxing its process-count predicates. This verdict neither authorizes another attempt nor establishes post-exit telemetry availability. Attempt 01 remains FAIL, with its exact accounting values and cause unknown.

## Frozen inputs

All paths below are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
|---|---|
| `audit/c8_supervisor_capability_preflight_20261111_v3.py` | `4488B65FB487CDF22E6B924410AA61032C20B423C88491C4E4984038337BA7C0` |
| `audit/coordinator_c8_capability_run_20261111_v3.py` | `299953B969E49E9E329BCC9DD790336D913AF1B4FAE0637330F8F9E55F9EAF32` |
| `audit/C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V3_2026-11-11.md` | `0B7CAC07BF8BBDC15F8FF895983C96EDE2410485283A814E032796C0F22F4D7B` |
| `audit/c8_supervisor_capability_preparation_20261111_v3.json` | `7AF0D112F17813121F638A2620526CC2BEE66D63B2A16822C8B4943A8AFBF0B1` |
| `audit/c8_supervisor_benign_child_20261111.py` | `4DC1257673F86240255F1B5331DA20BEAABE1B5DEFF85FF5E80D0A0EF58241BE` |

Independent source/AST receipt: `independent-feasibility/c8_diagnostic_v3_static_review_20261111.json`, SHA256 `6C251CB15A17905E9EE64700FF98E541BC49F226CD77447EF5E6499367EB41B6`. It records exact hashes, syntax-only checks, the outer-to-inner binding, unchanged caps, absence of the new runtime manifest, and preservation of the two principal failed-attempt receipts. Its first AST helper could not interpret the literal `dict` constructor; the corrected helper handles only constants, multiplication, and that constructor. Neither helper imported or executed the target modules.

The review inspected the final inner source and complete V2-to-V3 changes, the outer source changes and retained cleanup/acceptance paths, and the final specification. It reuses the accepted V2 ABI/lifecycle review rather than treating AST parsing as a semantic proof. The prior independent failed-attempt review is `REVIEW_C8_CAPABILITY_FAILED_ATTEMPT_2026-11-11.md`, hash `D8FA06375051E4EF273FB18A731245598F2A0EE3751241830EC142C925627F0F`; the accounting diagnosis is `audit/C8_FAILED_ACCOUNTING_DIAGNOSIS_2026-11-11.md`, hash `5B985DA1C1DA14409FCDF97E102BBCF503E79374761F226EF3B5904A453EE6B6`.

## Evidence ordering

An INCOMPLETE case is appended before launch. It is mutated in place, so a raised exception no longer prevents the case from entering `tests`. Handled failures retain `first_error`; later checkpoint/cleanup errors have separate fields. Cleanup failure marks the case FAIL. Successful writes retain the partial case even when no complete test result exists.

`account_snapshot` uses the existing class-1, 48-byte ACCOUNT layout. Each observation stores stage, logical job, handle correlation, monotonic time, requested/returned lengths, success, failure-only last error, all raw bytes, decoded fields, and field offsets/sizes. The native result and last error are captured before later API activity. A failed native call has `decoded_valid=false`: its bytes are diagnostic, not valid counters.

Each inner job has three possible snapshots: fresh before assignment, assigned before resume, and observed exit before closing its original process handle. Each returned snapshot is appended and checkpointed before rejecting native failure. The post-exit snapshot precedes later memory/exit/time validations. Both original count predicates are recorded before either is rejected. Early failure can prevent subsequent stages; the source does not promise three snapshots for every failed launch.

Polling and fresh-handshake child-memory results now enter the case and a checkpoint before `valid_memory`. Post-exit child memory, exit-query results, and process-time results likewise precede their validations. Observer queries are stored in the overall result before validation; ordinary exception handling then checkpoints them. This is useful diagnostic retention, not an exhaustive immutable history of every API call.

The outer wrapper saves its own fresh/pre-resume observations and post-exit accounting before rejecting supervisor exit 1. It records exit-zero, total-processes-three, and limit-terminations-zero separately. Thus a repeated handled inner accounting failure can yield both inner raw counters and outer raw counters instead of discarding both. Earlier failures, such as failed output draining, need not reach outer post-exit accounting.

## Conditions and containment remain intact

Inner acceptance still requires total processes 1 and limit terminations 0; outer acceptance still requires supervisor exit 0, total processes 3, and limit terminations 0. Fresh counts are observations, not a new assumed zero-count theorem. Missing native data, failed limits, unexpected values, incomplete cleanup, or broken final bindings cannot be promoted to PASS.

The child bytes are unchanged: normal held/released 16 MiB followed by late 32 MiB, and the separate idle timeout fixture. Caps remain 30 seconds, 48 MiB explicit allocation, 256 MiB conservative observer-plus-child peak bound, and 4 MiB aggregate output. Observation arrays reject excess entries; checkpoint/record encoding rejects beyond 64 KiB. These added diagnostics can make an attempt fail a cap; they do not justify retuning or a retry.

V2 containment is retained: outer suspended creation, assignment to active-limit-2 kill-on-close job before resume, inherited descendant containment, inner active-limit-1 jobs, explicit pipe-handle allowlist, bounded pipe capture, original-handle waits, and membership-checked descendant cleanup. No PID-based termination or broader filesystem mutation was introduced. A termination request is not treated as observed process exit.

## Limits and next gate

Checkpoint rewriting uses `wb`, flush and fsync. It is **not crash-atomic**: abrupt termination or failed storage can leave partial JSON and lose the preceding version. The specification correctly makes retention conditional on successful writes. No PASS-looking intermediate file is sufficient; successful observed exits, matching final console/receipt hashes, source/manifest bindings, and coordinator time/output accounting remain mandatory.

The V3 manifest path was absent at review. Its schema rejects V2 authorization and binds the exact outer source; the outer source pins the final inner bytes. This permits a later separately reviewed authorization, not reuse of attempt 01's manifest. The executable's behavior and Windows post-exit query availability remain empirical obligations of any such authorized run. Successful source review is not a capability result, a numerical result, or a Lean proof.

No Windows API, child fixture, mathematical evaluator, or source module was executed in this review. No runtime manifest or new attempt directory was created, and no producer or earlier evidence file was changed.
