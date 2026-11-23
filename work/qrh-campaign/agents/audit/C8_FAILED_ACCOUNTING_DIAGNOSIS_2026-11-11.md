# C8 failed accounting check: source diagnosis

2026-11-11. Saved evidence and primary-document review only. No API query, fixture rerun, evaluator import, code execution, or code modification was performed. The single authorized attempt remains **FAIL**. No retry is authorized by this note.

## Finding

The definite source defect is **loss of diagnostic evidence before rejection**, not an established wrong Windows enumeration or an established process-tree violation. The inner code obtains a basic-accounting structure, then combines two predicates in one `require`. The exception prevents the case object from being returned or appended to the receipt. Consequently the receipt cannot tell us whether `TotalProcesses != 1`, `TotalTerminatedProcesses != 0`, or both. It also loses the previously acquired child post-exit memory result, exit code, timing, and handle context.

The inspected Microsoft definitions agree with information class **1**, the four signed 64-bit time fields followed by four DWORD fields, and the 48-byte size used by the pinned 64-bit source. I found no source-supported basis to weaken the count check, substitute `ActiveProcesses`, or claim a particular missing counter value. Nested-job aggregation alone does not explain an ancestor's unrelated processes appearing in a fresh inner job.

## Evidence and source pins

All following paths are relative to this audit directory. The hashes below were read from the saved files, not inferred from the launch transcript.

| File | SHA256 |
| --- | --- |
| `c8_supervisor_capability_preflight_20261111_v2.py` | `9EF92537B8363B0B81314AFC8F7049406DD9D73FDB5C4BD48FCDDDCB55B8D86B` |
| `coordinator_c8_capability_run_20261111_v2.py` | `1DA760BF8FA8C32DD30DE7C4F37DDE4E43A54756FC71384082CD1074C1D609C5` |
| `coordinator_c8_capability_authorization_20261111_01.json` | `9B4CDC4E4C675FE0BC254D4C3C21AB5E71D857F231ACB8CBEFE1D6D16C5756EC` |
| `c8_benign_attempt_20261111_01/completion.json` | `2E98F8A15E6C9646538B9A5ECB7E870F8045CA2D505EA1E85FA1DD567B8D0384` |
| `c8_benign_attempt_20261111_01/normal.jsonl` | `8312387BE40C15890E87BE85E6FA7FB5C596419E208CD906A8B686F7E085D2A3` |
| `coordinator_c8_capability_20261111_01_v2.stdout` | `5988E50DC06C504C8088210339700BBA52E9EC18E51DB1B3C0116FCDD9E92320` |
| `coordinator_c8_capability_20261111_01_v2.json` | `92888F50181BF8C9E0E02B58658ED2A8ACA690B83266658B276E8B53E98B7D79` |

The inner receipt reports `RuntimeError: unexpected process tree/limit violation` and `tests: []`. The normal log contains baseline, held-16-MiB, released, and finished-32-MiB stages; both acknowledgments exist. The NULL-query control is retained: native failure, error 6, zero counters and semantic rejection. The final console reports FAIL and no conservative per-child peak sums.

The outer record reports observed supervisor exit, return code 1, empty stderr, successful job-termination request, and no remaining associated descendants. Its failure is `supervisor nonzero exit`. This is consistent with rejecting the inner attempt; it is not a second failed fixture. The timeout fixture was not reached. The parent's tool record additionally reports outer exit 1 and wall time 1.4256369 seconds; that tool timing is separate from the pinned JSON's own timestamps.

The pinned source establishes the following control-flow inference: the normal case passed its original-handle signaled-exit, post-exit memory validation, observer-sum check, exit-code-zero check, and process-times check before reaching the accounting assertion. This is evidence about which statements executed. **It does not reconstruct the missing counter values or turn the incomplete receipt into accepted capability evidence.**

## Exact API and nested-job meaning

[QueryInformationJobObject](https://learn.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-queryinformationjobobject) identifies basic accounting as class 1, process-ID list as class 3, and extended limits as class 9. Its final argument may receive the written byte count; the current code passes NULL. A nonzero return is success. The source uses an explicit job handle, so the special NULL-handle rule selecting the caller's immediate job is inapplicable.

[JOBOBJECT_BASIC_ACCOUNTING_INFORMATION](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_basic_accounting_information) has four LARGE_INTEGER times, then `TotalPageFaultCount`, `TotalProcesses`, `ActiveProcesses`, and `TotalTerminatedProcesses`. `TotalProcesses` counts lifetime associations, including terminated processes and some failed limit-violating associations. `TotalTerminatedProcesses` counts terminations caused by limit violations. `ActiveProcesses` is different; retaining references can delay its decrement. None of these definitions identifies the two values lost here.

[Nested Jobs](https://learn.microsoft.com/en-us/windows/win32/procthread/nested-jobs) states that a job's accounting includes its own processes and processes in descendant jobs. A child job contains a subset of its parent job's processes; this is not symmetric aggregation from parent into child. A process created by a job-associated parent inherits the chain absent permitted breakaway. Therefore the outer job legitimately covers the supervisor and its children, while the freshly created inner job is intended to cover its single associated child. This is the source rationale for the two different count expectations, not proof of their actual runtime values.

[AssignProcessToJobObject](https://learn.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-assignprocesstojobobject) permits assignment into an empty job to form a valid nested hierarchy and describes accounting propagation upward. Active-limit association failure terminates the attempted process. The recorded execution passed explicit assignment and membership checks and later reached normal-exit validation. It would be unsupported to diagnose this event as an assignment failure solely from the later combined count assertion.

The [basic-limit documentation](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_basic_limit_information) distinguishes active-process limits and their delayed release behavior from lifetime totals. The [process-ID-list documentation](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_basic_process_id_list) includes descendant jobs and requires checking returned versus required list length. Neither supplies missing historical accounting values. No new assertion about undocumented nested-counter behavior is introduced here.

## Source locations and the concrete failure of evidence retention

In [the inner supervisor](c8_supervisor_capability_preflight_20261111_v2.py), lines 94–101 define and size-check the accounting layout. Line 209 queries class 1; line 210 immediately checks the conjunction. The result dictionary is constructed only at lines 221–227. Line 280 appends `run_case(...)` only after that function returns successfully. Thus any late case failure erases the case's intermediate observations from the final receipt. This is why `tests: []` does not mean no child ran.

The [outer runner](coordinator_c8_capability_run_20261111_v2.py) has a related diagnostic ordering: line 163 rejects nonzero supervisor exit before line 164 queries outer accounting. Consequently outer accounting was not retained either. The successful cleanup list is useful for cleanup status, but cannot replace the missing lifetime totals.

The existing static size check is not a recorded runtime ABI snapshot. It supports source consistency, but it does not let an auditor inspect native returned bytes, field offsets, return length or actual job-handle identity after the fact. No concrete ABI fault was found, and one should not be invented to explain absent data.

## Minimal versioned diagnostic design (not implemented or authorized)

Keep all existing source files and failed artifacts immutable. A later reviewed version should retain the same scientific-free fixture, caps, outer inherited-job protection, no-breakaway policy and one-attempt semantics. It should not relax the acceptance predicate merely to make a diagnostic run pass.

1. Create and append a mutable **case record before launching the child**, initially `INCOMPLETE`. Update it at each completed stage. Its `finally` path must retain failure status, the exact failed predicate, and cleanup outcome rather than relying on a successful return value to expose the case.
2. At each native query, capture Boolean success, error value only on failure, requested class, buffer length, returned length, logical job identity, handle value for correlation, timestamp, every decoded field, and the bounded raw buffer bytes. Save this snapshot **before** semantic assertions. Use named numeric constants for classes 1/3/9 and record the actual field offsets and structure sizes once. A success call's stale last-error value must not be treated as a failure reason.
3. For the same inner job, retain small snapshots after creation, after child assignment but before resume, and after observed child exit before handle closure. Include membership, read-back limits and complete bounded process-ID lists as corroboration. These are diagnostics, not replacements for the historical totals. Save the preceding memory/exit/timing observations independently of whether the account check succeeds.
4. Split the assertion into explicit predicates such as `total_processes_equals_one` and `limit_terminations_equals_zero`, and preserve both their values before rejection. Keep any unexpected result FAIL. If raw evidence later demonstrates a mismatch between the intended contract and documented/runtime accounting, review the contract separately rather than silently changing the expected integer.
5. Query and retain outer-job accounting after supervisor exit **before** checking whether that exit code is zero. Preserve outer cleanup separately. An outer FAIL must still contain all available accounting and child-stage evidence.
6. Use a fixed small diagnostic schema and bounded owned checkpoint/seal. Flush the updated partial record before rejection so both handled exceptions and later abrupt interruption leave useful evidence. Count any new snapshot file within the unchanged aggregate output cap; avoid duplicating full logs. Partial snapshots remain incomplete and cannot satisfy the final exit/hash seal.

This is a preparation proposal, not code or a new run request. The minimum next design gate is independent review of persistence ordering and exact native-field capture. Only a later separately authorized attempt could determine the missing runtime values. The present failure does not justify either a positive capability conclusion or a claim that post-exit memory querying failed.
