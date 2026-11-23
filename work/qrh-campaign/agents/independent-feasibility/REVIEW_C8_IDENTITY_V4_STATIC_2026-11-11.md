# Independent static review of C8 identity diagnostic V4

Verdict: **PASS for source preparation only.** No substantive concern remains in the reviewed bounded design. This does not authorize execution or establish any process identity, telemetry capability or cause of V3's counters. V2 and V3 remain failed attempts.

## Frozen packet

Paths are relative to `work/qrh-campaign/agents/`.

| File | SHA256 |
|---|---|
| `audit/c8_supervisor_capability_preflight_20261111_v4.py` | `08A6AB509952DC830002433B53892ED1E4B717B139611C45E5BF16E6FF6777AB` |
| `audit/coordinator_c8_capability_run_20261111_v4.py` | `07426FC9A9D1A0E51A2E4BD69930027FCCC8C7DE6F0047739273BBD9A32A68E1` |
| `audit/c8_supervisor_benign_child_20261111_v4.py` | `B0E008A7344824D1651D5F86B8232171508CCCF6016CB4A74DEB32F4F97A455D` |
| `audit/C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V4_2026-11-11.md` | `0EAFC886790B7AF8B6C7DB0C7098343269EC5B4979AE07C92644494553446209` |
| `audit/c8_supervisor_capability_preparation_20261111_v4.json` | `5B5CA7666FF24F9736332CAACB9F703703573BBB9C50A6DC4FE897208FB3AEBD` |

Independent AST/hash receipt: `independent-feasibility/c8_identity_v4_static_review_20261111.json`, SHA256 `CC806BF105C1BE0B3398A11D4794654B60DB29A634158E3961A613C31811782E`. All five pins match; all three Python sources parse and compile as text. No target module was imported or executed. The outer source pins the exact inner source, CAPS has the same AST as V3, V3's failure receipts are unchanged, and the V4 authorization manifest was absent at review.

I inspected the child source, inner identity/PID-list/handshake functions, full V3-to-V4 changes, outer identity binding and retained cleanup paths, and final specification. The prior V3 review `D13EA2C6…7574E075` covers unchanged lifecycle/ABI mechanisms. The selected identity diagnosis `F544727E…0CBBB678` and its independent review `8F5DB8DC…6E2E18CF6` supply the primary-source interpretation; this review checks their implementation without querying Windows.

## Identity and snapshot checks

The child logs native self PID, handle-derived PID, creation FILETIME and bounded native image spellings at baseline. The supervisor records equivalent startup data. Each parent queries the original creation handle before resume. Comparison requires valid queries, equal PID, equal creation time, and exact native image spelling. Current-module versus queried-image spelling is also checked for the self records. A path alias can therefore cause rejection; the code never normalizes an alias into purported proof of identity. Matching path text does not prove loaded-file bytes, and the input file hashes retain their separate role.

The bindings use DWORD process IDs, pointer-sized handles, FILETIME structures, explicit Boolean returns and 4096-WCHAR buffers. Image completeness requires native success and a positive returned length strictly below capacity. A live process's exit FILETIME is not used for identity. Numeric handles are process-local diagnostics, not cross-process identifiers.

At each existing normal baseline/held handshake, class-1 accounting and a class-3 PID list are recorded. The PID buffer holds eight pointer-sized entries. Completeness requires native success, equal assigned/listed counts, at most eight entries, sufficient returned bytes within the buffer, and distinct positive PIDs. Partial or failed queries remain recorded with completeness false, not treated as an empty job.

The original listed PID is inspected through the still-retained original handle. Membership is checked against the explicit owned job, and PID/creation-time/image continuity is required. Unknown PIDs are opened only for query/synchronization, one at a time, then closed in `finally`. Their records explicitly say `later_opened_candidate_only`. The code does not assert that an instance opened after a list query must be the same instance named by the earlier PID. Unknown entries cannot make the snapshot valid even if their later identity queries succeed. The only valid list is the singleton original PID with successful membership and continuity.

These are point-in-time observations. The handshake does not make accounting, PID enumeration and later identity calls atomic, and two valid lists cannot exclude a short-lived historical association. The original lifetime-count predicates remain mandatory. No completion ports or notification threads were added.

## Persistence and bounded behavior

The raw PID-list record is attached and checkpointed before per-entry work. Subsequent entries are checkpointed while the owned observation handle is protected by `finally`. Unexpected per-entry exceptions can therefore leave a useful partial record; they cannot fabricate completeness. Baseline self-match is saved before the PID-identity gate is rejected, so an additional PID does not suppress that named comparison. The outer wrapper saves its startup-versus-original comparison before rejecting an inner nonzero exit, when the preceding exit/output stages reach that code.

The V3 limits and containment remain: 30-second acceptance limit, 48 MiB explicit fixture allocation, 256 MiB conservative observer-plus-child bound, 4 MiB output, outer active-limit two, inner active-limit one, assignment before resume, bounded pipes, original-handle termination/waits and descendant cleanup. Unknown observation handles are never used to terminate by PID. There are at most eight inspected entries per snapshot and one additional observation handle concurrently. Successful normal completion requires both existing handshakes; early failure may retain only a prefix.

The new identity work can cause earlier failure or exceed an existing time/log/record limit. The specification correctly permits rejection rather than silently widening caps. Long image strings can exceed the 16 KiB log or 64 KiB record budgets despite the individual 4096-WCHAR limit. This is not a promise that the fixed attempt will succeed.

Inner total-processes one/limit-terminations zero and outer total-processes three/limit-terminations zero are unchanged. No observed V3 total has been substituted as an expected value. The child allocations, order and timeout behavior remain unchanged apart from added identity logging.

Checkpoint writes remain non-crash-atomic. Successful writes preserve evidence; failed or interrupted writes may leave invalid JSON. Acceptance still requires complete final source/manifest/receipt/console bindings and actual observed exit, not a PASS-shaped intermediate file. Native query availability and runtime cleanup remain empirical obligations of any separately authorized attempt.

## Scope and decision boundary

Two stale specification statements were corrected before these pins: missing accounting values are explicitly attributed to V2, and the prohibition on PID-reopened substitutes is scoped to original-handle memory/termination evidence while permitting the new observation-only candidates. V3's retained counters remain known, but their cause remains unknown.

The new manifest schema, source pins, file prefix and exclusive attempt ownership prevent reuse of earlier authorization or output files. A separate coordinator decision must precede any execution. This review performed only source reads, hashes, AST parsing and compile-on-text checks, writing its own receipt/report. It created no manifest, queried no process, ran no fixture and established no mathematical or Lean result.
