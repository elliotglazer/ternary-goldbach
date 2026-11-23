# C8 benign Windows supervision capability preflight — version 4

2026-11-11. **Preparation only. No test process, Windows API call, evaluator, numerical experiment, or Lean build has been run for this packet.** Source parsing is not a capability result. The supervisor refuses to launch without a later hash-bound authorization manifest. Independent static review and a separate root execution decision are required.

Version 4 adds self-identity and synchronized job-PID observations to V3. All older sources, manifests and failed attempts remain unchanged. Child code changes only to record its baseline self-identity; allocations, fixture order, time/output/memory limits, containment and existing count predicates remain unchanged. Completion ports are not selected. No new run or runtime manifest is authorized by this preparation.

## Purpose and limits

A later separately authorized attempt would test whether this host can return a positive, consistent `PeakWorkingSetSize` after a benign process has exited, using the **same original handle** returned by suspended creation. It also exercises assignment to a one-process job before resume, normal completion, a deliberate timeout, and rejection of a failed memory query. It does not prove that every future Windows query succeeds, certify the OS implementation, run C8 mathematics, authorize the numerical pilot, or supply a hard working-set prevention guarantee.

The accepted conditional design is [C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md](C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md), SHA256 `EF2EF80F930AA029DE7418C9759A01465A867A40DFACAA0F9FE9B67ED8FC6B19`. Its independent review is [REVIEW_C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md](../independent-feasibility/REVIEW_C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md), SHA256 `AEA656CCB32B74151CB570EDFA58A63104771AF7E764DE9B95789299856251DF`.

The native bindings follow [GetProcessMemoryInfo](https://learn.microsoft.com/en-us/windows/win32/api/psapi/nf-psapi-getprocessmemoryinfo), [PROCESS_MEMORY_COUNTERS](https://learn.microsoft.com/en-us/windows/win32/api/psapi/ns-psapi-process_memory_counters), [AssignProcessToJobObject](https://learn.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-assignprocesstojobobject), and the process/job documentation linked in the accepted design. Successful-query semantics and post-exit query availability remain distinct. No fallback to sampled maximum, commit usage, or job committed-memory peaks is permitted.

## Fixed source and fixtures

The only launch implementation is [c8_supervisor_capability_preflight_20261111_v4.py](c8_supervisor_capability_preflight_20261111_v4.py). Its only child is [c8_supervisor_benign_child_20261111_v4.py](c8_supervisor_benign_child_20261111_v4.py). Exact hashes are recorded in the adjacent preparation receipt, then must be copied into the authorization manifest. No source imports of either file are part of preparation.

The executable is the base interpreter `C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe`, SHA256 `4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9`. Using the base executable avoids depending on a virtual-environment redirector's process behavior. The exact child arguments are `-I -S`, the frozen child path, `normal` or `timeout`, the new attempt directory, and the manifest's 32-character token. `-I -S` suppresses user environment/site import customization. Working directory is the new attempt directory; no shell, inherited handles, console window, child workers, network access, or evaluator import is used. The code calls `subprocess.list2cmdline` only as a quoting helper; it never calls a subprocess launcher.

The following tests are sequential and fixed, with no retry or parameter tuning:

1. NULL-handle query: call `GetProcessMemoryInfo` with a fresh zero-initialized counter structure and invalid NULL handle. Native failure and rejection by the same semantic memory-validation function are both required. The error code is recorded; no particular error number is assumed. This is not a stale-handle query.
2. Normal child: emit and flush/fsync `baseline`; wait at most five seconds for the exclusively created acknowledgment. Allocate and page-touch 16 MiB, emit `held`, and wait at most five seconds for its acknowledgment. The supervisor takes a **fresh** memory sample after reading each stage and before acknowledging it. Release the 16 MiB, collect garbage, emit `released`, then allocate and page-touch 32 MiB. Emit `finished` with a SHA256 of the exact preceding log bytes. Keep the late allocation alive through interpreter exit. Require exit code zero, exact four-stage sequence and allocation sizes, both acknowledgments, and the prefix hash. This uses 48 MiB cumulative explicit allocation, with at most 32 MiB explicitly live at once; interpreter overhead is separately subject to the observed peak gate.
3. Timeout child: emit/flush/fsync `idle`, then sleep for 60 seconds. The supervisor's fixed one-second deadline must cause `TerminateProcess` with code `0xC8F1`; it must observe a signaled exit, the expected code and exact one-stage log, then query memory on the original handle. Natural completion is a failure of this control. An expected timeout result is recorded separately from normal success.

Both cases require a new unnamed job with `ACTIVE_PROCESS_LIMIT | KILL_ON_JOB_CLOSE` (`0x2008`), limit one, and no breakaway flags. The job limits are read back. `CreateProcessW` uses `CREATE_SUSPENDED | CREATE_NO_WINDOW`; the process is assigned and membership checked before `ResumeThread` returns the expected previous count one. Failure of job compatibility or setup fails closed; there is no outside-job retry. Query final accounting and require `TotalProcesses=1` and `TotalTerminatedProcesses=0`. The latter counts job-limit violations, not the explicit timeout termination. Record, but do not require zero for, `ActiveProcesses` while retaining the process handle.

The 64-bit ABI sizes required at runtime are PMC 72, extended job limits 144, basic job accounting 48, STARTUPINFO 104 and PROCESS_INFORMATION 24 bytes. Pointer-sized fields are not truncated. Function argument and return types are explicit. Post-exit creation/exit FILETIMEs corroborate identity; they do not replace elapsed monotonic timing. Original-handle memory and termination evidence never substitutes a PID-reopened handle. V4 separately opens unknown PID candidates for the bounded identity observations described below.

## Limits and supervisor boundaries

The **whole preflight**, including both children, setup and final publication, has a 30-second acceptance limit. The inner clock begins at the supervisor's first module-level `time.monotonic_ns` call and includes later imports, argument parsing, input verification and finalization. It cannot measure the interpreter bootstrap preceding that call or prove completion after its last call. Therefore the execution coordinator must additionally time from before supervisor creation to its observed exit, enforce the same 30-second limit, and reject any late completion. The final process-exit record is mandatory. A displayed receipt or final line alone is insufficient.

The normal case has a 15-second case budget, the timeout case a one-second case budget. These clocks start before job setup; the reported per-case launch interval starts immediately before `CreateProcessW`. Short waits are 20 ms. All loops recheck the common absolute inner deadline; they do not reset a 30-second allowance for each child. Cleanup waits are at most two seconds and cannot turn a failed case into success. The caller must reject a whole attempt exceeding 30 seconds even if cleanup was necessary. Windows creation, scheduling, console output and asynchronous termination do not admit a promise of instantaneous physical prevention; the protocol enforces acceptance and requests termination. If cleanup does not observe exit, record `INCOMPLETE_TERMINATION` and fail. Closing the job handle remains a kill-on-close backstop, not evidence of observed exit.

The 256 MiB cap applies conservatively to the **supervisor plus each sequential child**, not separately to two simultaneous 256 MiB allowances. At every successful live child query, including the fresh handshake queries, the supervisor immediately makes a fresh current-process query. Both the sum of these two observed current working sets and the sum of the two reported cumulative working-set peaks must be at most 256 MiB. Queries are sequential, so their current-working-set sum is an observed pair, not an atomic simultaneous process-tree measurement.

Each child must have a successful positive post-exit working-set peak, at least every recorded live peak and the simultaneous current working set from that child's query. The normal child's final peak must also be at least 32 MiB. Failure of this last plausibility check is a failed capability fixture, not proof of an OS bug. No decrease in an observed cumulative peak is accepted. Immediately after each post-exit child query, the supervisor's fresh peak is added to that child's final peak and checked against 256 MiB. Later guards recheck every completed child's final peak against the newer observer peak, so observer growth during the second case or sealing cannot silently evade the first case's bound.

A final fresh observer query **after completion-file serialization** supplies the console's `final_observer_memory` and `conservative_peak_sums`, one sum per completed child. Both sums must be at most 256 MiB for acceptance. The two child peaks are not added together because the children run sequentially. A sum of individual lifetime peaks is a conservative bound on simultaneous usage during their overlapping lifetimes, conditional on the OS peak semantics; it is not a measured simultaneous process-tree peak. The supervisor is still alive at its final query. Therefore this is a bound using its cumulative peak through that query, not a post-exit observer measurement or a guarantee about unobserved later observer shutdown. The final console and observed supervisor exit are mandatory; the coordinator must not reinterpret this as complete post-exit telemetry for the observer itself.

The receipt stores each post-exit child/observer pair and conservative peak sum, plus the last guarded supervisor peak before sealing. The console binds the later post-seal observer query and the rechecked sums to the receipt SHA. Any failure after writing a PASS-shaped receipt, including this final peak test, prevents a bound final console/normal exit and therefore prevents acceptance.

Output is limited to 4 MiB in aggregate: the external authorization manifest size, every file in the exclusively created attempt directory, and the final bounded console line (allowing CRLF). Accounting intentionally counts the copied manifest again. A 64 KiB reserve covers the completion seal; no pending duplicate snapshot is written. The log reader limits each log to 16 KiB. The exact allowable directory entries are `attempt.json`, `completion.json`, `normal.jsonl`, `normal.baseline.ack`, `normal.held.ack`, and `timeout.jsonl`. Unexpected entries or symbolic links fail. Existing attempt directories and files are never reused. The sole rewrite is the supervisor's own exclusively created `completion.json`, first `INCOMPLETE`, then its final status; a finalization breach may downgrade it to `FAIL`.

Failure after a PASS-shaped file has been written but before final console/exit can leave that file behind. It is **not accepted**: a complete matching console seal and observed supervisor exit zero within the outer deadline are essential. Capture any traceback/outer tool logs within the coordinator's aggregate accounting; the internal accounting covers only the known files and final line. The fixed reviewed sources produce bounded error text; an externally forced abnormal termination is a failed attempt, not grounds for repeating it automatically.

## Authorization schema (no manifest supplied here)

No new manifest is created in preparation. The matching outer source reads only `coordinator_c8_capability_authorization_20261111_v4.json` (currently absent), and the inner loader rejects prior schema/authorization versions. The later root-created JSON has exactly these keys:

```json
{
  "schema": "c8-benign-preflight-v4",
  "authorize": "RUN_ONE_C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V4",
  "token": "32 lowercase hexadecimal characters",
  "attempt_name": "c8_benign_attempt_UNIQUE_SUFFIX",
  "pins": {
    "supervisor": "SHA256 of prepared supervisor",
    "child": "SHA256 of prepared child",
    "specification": "SHA256 of this specification",
    "executable": "4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9",
    "accepted_design": "EF2EF80F930AA029DE7418C9759A01465A867A40DFACAA0F9FE9B67ED8FC6B19",
    "accepted_design_review": "AEA656CCB32B74151CB570EDFA58A63104771AF7E764DE9B95789299856251DF"
  },
  "static_review": {"path": "absolute independent review .md path", "sha256": "SHA256"},
  "outer_runner_sha256": "SHA256 of the reviewed version4 outer runner",
  "caps": {
    "total_ns": 30000000000,
    "normal_ns": 15000000000,
    "timeout_ns": 1000000000,
    "cleanup_ns": 2000000000,
    "peak_bytes": 268435456,
    "aggregate_peak_bytes": 268435456,
    "output_bytes": 4194304,
    "explicit_allocation_bytes": 50331648
  }
}
```

JSON duplicate keys and excess fields are rejected; inputs are size-limited before parsing. The static review must resolve to a Markdown file inside the campaign agents directory and match its hash. The root must read and accept that review; the launcher verifies its bytes, not the meaning of the review's prose. Authorization is tied to the exact source/spec/interpreter bytes and output name. The token provides cross-file identity, not authentication against malicious same-user processes. The reviewed benign code and exclusive output ownership are the threat model.

## Completion schema and acceptance

`completion.json` has schema `c8-benign-completion-v4`, status, manifest/source pins, token/caps, the invalid-query control, two ordered test records, file inventory and hashes, inner elapsed time, and guarded supervisor peak. A test record contains case/outcome, PID, original-handle marker, exit code, launch-to-observed-exit interval, final raw memory result, live peaks/stage samples, creation/exit/kernel/user FILETIMEs, job accounting, exact child records and log SHA/size. The normal child additionally seals its preceding raw log bytes. These hashes detect mismatched artifacts; they are not measurements of correctness by themselves.

The final console line binds receipt SHA256, manifest SHA256, supervisor and child SHA256, status, inner elapsed, retained file bytes, the fresh post-seal observer memory query and the rechecked conservative peak sums. A coordinator record must bind that line to actual supervisor exit zero, launch/exit timestamps and measured aggregate output (including its own retained record/log overhead). Only then may all three controls be recorded PASS. A missing query, missing stage, deadline/byte/peak breach, unexpected code/count, failed cleanup, mismatch, or incomplete coordinator record is a failed/incomplete capability attempt. There is no runtime authorization in this specification and no automatic numerical follow-on.

## Preparation evidence

The adjacent `c8_supervisor_capability_preparation_20261111_v4.json` records AST and `compile(..., 'exec')` syntax checks performed on source text **without execution or module import**, plus source/specification/executable hashes. The independent reviewer should audit all native declarations, lifecycle and failure paths before any authorization manifest is created. No post-exit availability conclusion is claimed in that preparation receipt.


## Retained V3 persistence and matching outer wrapper

The V2 attempt failed the combined inner accounting guard without saving its counters. See `C8_FAILED_ACCOUNTING_DIAGNOSIS_2026-11-11.md`, SHA256 `5B985DA1C1DA14409FCDF97E102BBCF503E79374761F226EF3B5904A453EE6B6`. V3 subsequently retained its own counters; those do not reconstruct V2's missing values. No missing counter values are inferred and no acceptance predicate is weakened here.

The inner supervisor now appends an INCOMPLETE case object before launching. Bounded checkpoints rewrite only its exclusively created completion file and flush/fsync it. These writes are not crash-atomic: truncation or an interrupted write may leave incomplete JSON. Retention is conditional on a successful write; a missing/invalid checkpoint is never accepted. Each case retains original-handle/PID identity, read-back limits, membership, available live observations, post-exit memory and observer results, exit query, process-time query, and named predicates. Both polling and fresh handshake child-memory results are stored and checkpointed before their validity tests. The first exception is saved separately; later checkpoint/cleanup errors do not overwrite it in memory or a successfully written checkpoint. The complete case remains present on handled failure instead of disappearing through a failed function return.

Basic-accounting snapshots occur (1) on the fresh inner job before assignment, (2) after assignment before resume, and (3) after observed child exit before closing the original handle. Each snapshot records logical job identity and correlation handle value, integer monotonic time, class1, requested buffer size, returned length, Boolean native success, error only on native failure, raw bytes, every decoded field and ctypes field offset/size. A failed native query still preserves its raw bytes; `decoded_valid=false` explicitly forbids treating that decoding as valid OS data. Fresh-job counts are observations only. No new zero-count predicate is assumed.

Snapshots are persisted before native failure rejection or semantic count validation. At the final inner snapshot, both `total_processes_equals_one` and `limit_terminations_equals_zero` are recorded before either is checked. These are exactly the original acceptance values. The output neither guesses which condition should pass nor repairs observed counters. A different value remains FAIL.

The paired wrapper is `coordinator_c8_capability_run_20261111_v4.py`. It preserves V2 suspended creation, outer active2/kill-close/no-breakaway containment, explicit inherited handle list, bounded pipes, original-handle waits and descendant cleanup. It now saves raw outer accounting before rejecting a nonzero supervisor exit. Outer predicates remain exit0, total processes3, limit terminations0; on early fixture failure these can be false and remain diagnostic. Fresh/pre-resume outer snapshots are also retained. The outer file, manifest and inner version mutually bind through the later manifest's `outer_runner_sha256` and the wrapper's frozen inner source hash. This is not a circular mathematical assumption; these are runtime byte-integrity bindings.

All checkpoints count toward the unchanged output budget and replace rather than duplicate the current owned file. Lifecycle accounting uses exactly three snapshots per job, plus two synchronized handshake snapshots for the normal child in V4. Live observation arrays reject excess before adding a129th entry. Encoded checkpoints and outer records reject beyond64KiB. No event is silently dropped to manufacture compliance. An interrupted or oversized checkpoint can leave partial/incomplete evidence, which never satisfies the final console/exit/hash seal.

The matching outer V4's file prefix is new. It must reject an existing attempt directory, existing outer outputs, a prior manifest version, changed source pins, or missing independent review. The failed attempt01 and its manifests are immutable; this source preparation does not create attempt02 or authorize a repeat. Only AST/compile-on-text validation is permitted now.


## V4 self-identity and synchronized PID-list design

This version follows the accepted diagnosis `C8_DIAGNOSTIC_V3_ACCOUNTING_ANALYSIS_2026-11-11.md`, SHA `F544727EA186D440ABCF20C5FD77BCE72290D143753F687593F9AFB30CBBB678`, and independent review `../zero-sum/REVIEW_C8_V3_IDENTITY_DIAGNOSIS_2026-11-11.md`, SHA `8F5DB8DC9088E1FB5E3E7BE01357D39CB4C12C81E12D1B884E288DA6E2E18CF6`. It does not accept V3's totals2/4. Inner total1/termination0 and outer total3/termination0 remain unchanged.

The child baseline record gains `self_identity`. It contains native current PID, PID obtained from its pseudo handle, process creation FILETIME, native query statuses/errors, `QueryFullProcessImageNameW` image spelling, and `GetModuleFileNameW(NULL)` current executable spelling. Both image buffers are fixed at4096WCHAR; positive returned lengths strictly below capacity are required. Truncation or query failure is retained as incomplete data. The supervisor records the same native identity at startup, with its source hash and manifest nonce, before its fixtures.

Each parent captures the intended process's identity through the original retained creation handle before resume. The child self-record is compared at the baseline handshake; the outer wrapper records the supervisor startup comparison after exit, before rejecting a nonzero exit. Comparison requires valid native results, equal PID, equal creation FILETIME, and identical native image spellings. No case/alias/path normalization is used to convert differing strings into proof of executable equality. A differing spelling may merely be an alias, but is inconclusive under this strict diagnostic. The file hashes still bind the reviewed inputs; path equality is not a substitute for pinned file bytes or proof of loaded-image bytes.

The existing baseline and held acknowledgments now pause after two additional observations: raw class1 accounting and a class3 job PID-list snapshot. The list has fixed capacity8. The receipt stores both native counts, return length, raw buffer, success/error, list completeness and every returned PID. Completeness requires successful query, assigned count equal returned count, no more than8 entries, sufficient bounded returned bytes, and distinct positive PIDs. The raw list is attached and checkpointed before per-entry handle work, so later exceptions retain the partial snapshot. A failed or truncated list is retained before rejection and never interpreted as an empty job. The baseline self-versus-original comparison is recorded before rejecting the PID-list identity gate, preserving both diagnostic results.

For a listed PID equal to the intended original process PID, the code uses the already-retained original handle. For any other PID it opens query/synchronization access, one handle at a time, records membership and native identity, then closes that owned handle. Thus at most one extra observation handle is open concurrently and no more than8 entries are inspected per snapshot. The PID-only list observation and a later opened process instance are not claimed identical: unknown entries are explicitly labeled `later_opened_candidate_only`. PID reuse or a failed open remains inconclusive. These handles are never used to terminate by PID.

A valid snapshot must contain exactly the intended original PID and confirm its membership and retained-handle identity. Any additional PID, failed identity, mismatch, failed membership query, or incomplete list rejects the identity gate after persisting the observations. This makes failure informative without treating failure to obtain an identity as evidence of absence. Even two valid snapshots cannot prove a complete historical process inventory; the original lifetime-count predicates remain mandatory.

Exactly two handshake snapshots are allowed for a successful normal fixture; no extra fixture, pause type, completion port, notification thread, or child process is added. Accounting/list/native identity observations and source/nonce bindings are retained in the same bounded checkpoint and log files. The existing64KiB record and16KiB per-log limits remain fail-closed; unusually long image spellings can therefore cause an incomplete attempt rather than silent omission. No runtime estimate or expected successful outcome is claimed.

V4 preparation creates no authorization manifest or attempt directory. The selected filename is `coordinator_c8_capability_authorization_20261111_v4.json`, which must remain absent until a later root execution decision. A new independent static review and complete hash binding are required. Earlier failed attempts remain failed and immutable.
