# Independent static review of the C8 supervisor capability preflight

2026-11-11. PASS for the version-2 preparation, subject to the explicit outer coordinator completion requirements below. No capability result has been established. This review does not authorize execution or a numerical follow-on.

I read the complete supervisor, child and specification, inspected their native declarations and failure paths, verified their hashes and independently parsed/compiled the source text without importing or executing it. No Windows API, child fixture, evaluator or numerical model was run. The only Python work for this review was standard-library source parsing, hashing and writing the owned static receipt.

## Frozen inputs

All paths are relative to work/qrh-campaign/agents.

| Input | SHA256 |
|---|---|
| audit/c8_supervisor_capability_preflight_20261111_v2.py | 9EF92537B8363B0B81314AFC8F7049406DD9D73FDB5C4BD48FCDDDCB55B8D86B |
| audit/c8_supervisor_benign_child_20261111.py | 4DC1257673F86240255F1B5331DA20BEAABE1B5DEFF85FF5E80D0A0EF58241BE |
| audit/C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V2_2026-11-11.md | CB5B40F0A480122879408DF2C1D11F837EE888A66989836924381DE68C2CF587 |
| audit/c8_supervisor_capability_preparation_20261111_v2.json | 6AFE2A5E47BF08DA3D6CE24C26791651B3339E741053E7CBDA48DD6AE9EEF380 |

The base interpreter bytes independently match 4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9 at C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe. The accepted protocol EF2EF80F930AA029DE7418C9759A01465A867A40DFACAA0F9FE9B67ED8FC6B19 and its independent review AEA656CCB32B74151CB570EDFA58A63104771AF7E764DE9B95789299856251DF remain the source for the conditional memory semantics.

Independent AST receipt: independent-feasibility/c8_supervisor_capability_static_review_20261111_v2.json, SHA256 5F86A33C67DFEB68D49486ACD63C859F0D61827CACCE60F7A76F2180F7B91710. It records source sizes, imports, native process-call locations and file-open modes. AST acceptance establishes syntax, not native ABI success or runtime behavior.

## Corrections resolved before acceptance

The early draft reused a generic memory sample taken before reading a new child stage. That sample could predate the held allocation. The accepted code takes another memory query after validating each new baseline/held stage and before creating its acknowledgment, records that sample and updates the cumulative peak.

The initially frozen version capped observer and child separately. The coordinator clarified that 256 MiB must cover them together. Version 2 adds an aggregate cap, checks each child/observer pair, rechecks previous completed children whenever a newer observer peak is obtained, and publishes a final observer query and the updated per-child peak sums in the hash-bound console. Version 1 remains unchanged and is not the accepted execution target. Its separate static receipt is historical inspection evidence only.

## Native bindings and ownership

The declared 64-bit structures agree with the selected Windows ABI: PROCESS_MEMORY_COUNTERS 72 bytes, extended job limits 144, basic accounting 48, STARTUPINFO 104 and PROCESS_INFORMATION 24. HANDLE and SIZE_T are pointer-sized, DWORD/BOOL are Windows-width types, and all called native functions have explicit argument and return declarations. GetProcessMemoryInfo receives a fresh zeroed structure with cb initialized and last-error handling enabled. The runtime size assertions are necessary checks, not evidence they have already passed.

The sole process creation call names the pinned base executable directly, uses list2cmdline only for argument quoting, supplies no shell, requests CREATE_SUSPENDED|CREATE_NO_WINDOW and disables handle inheritance. Its command is the frozen child with -I -S, a fixed case, an exclusively owned directory and a token. The child imports no evaluator, networking or special-function library.

Each case creates a fresh unnamed job, sets and reads back flags 0x2008 and active-process limit one, assigns the original process handle to that job and verifies membership before resuming its retained primary thread. ResumeThread must report previous suspend count one. The handles returned by creation are used for waiting, memory queries, exit code, process times and termination; there is no PID-based reopening or global process search.

Termination targets only the process just created. Finally closes only its own thread/process/job handles. A failed case with a still-running process requests termination, waits at most two seconds and rejects unobserved termination. Job close provides a cleanup backstop, not an assertion that exit was observed. The normal path requires TotalProcesses=1 and no job-limit terminations. ActiveProcesses is recorded rather than incorrectly required to reach zero while the process reference is retained.

These decisions match the native contracts reviewed in [GetProcessMemoryInfo](https://learn.microsoft.com/en-us/windows/win32/api/psapi/nf-psapi-getprocessmemoryinfo), [AssignProcessToJobObject](https://learn.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-assignprocesstojobobject) and [TerminateProcess](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-terminateprocess). Native success, job compatibility and post-exit query availability remain runtime questions.

## Fixed controls and memory interpretation

The failed-query control supplies a NULL handle and requires both native failure and rejection by the same memory validator used for real cases. The validator also rejects zero peaks, regressions below prior cumulative peaks, peaks below the simultaneous current-working-set field, and peaks above the limit. The code contains these guards; this small fixture does not dynamically inject every malformed-counter case.

The normal child allocates and page-touches 16 MiB, releases it, then allocates and page-touches 32 MiB and retains that second allocation through its final log write and interpreter shutdown. Cumulative explicit allocation is 48 MiB, below 64 MiB, with at most 32 MiB explicitly retained at one time. Interpreter and allocator overhead are not excluded from OS memory checks. Exact stage order, token, child source hash, allocation sizes, acknowledgments and the prefix hash are checked. Requiring final peak at least 32 MiB is a plausibility check, not an independent theorem about physical allocation.

The timeout child only emits its idle record and sleeps. It must be stopped by the supervisor's deliberate one-second case deadline, yield the selected exit code and become signaled. A natural early exit or merely sending a termination request does not pass. Expected timeout is a distinct case outcome; it is not reported as normal completion.

Every successful child sample is followed by a fresh observer query. The two current-working-set values are sequential samples, not an atomic measurement. Their sum is checked, as is the sum of their OS cumulative peaks. After each child has exited, its fresh final peak is retained; later observer peaks are checked against it. The post-serialization observer query rechecks both children in the final console. Each sum must be at most 268,435,456 bytes. The two child peaks are not added together because the children execute sequentially.

The sum of individual cumulative peaks is a conservative bound on overlapping usage over the covered lifetimes, conditional on their OS meaning. It is not a measured simultaneous tree peak. The observer is still alive at its last query, so no claim covers its own unobserved later shutdown with post-exit telemetry. The specification states this limit. Child post-exit telemetry remains mandatory, with no sampled-maximum or committed-memory fallback. If this Windows/Python combination cannot return it, the capability attempt fails or remains incomplete.

## Time, output and completion binding

The inner clock begins at the first module-level monotonic call, before later imports and parsing. It does not include interpreter bootstrap or prove the eventual end of its own process. Therefore acceptance also requires a coordinator clock from before supervisor creation to observed supervisor exit, with a total limit of 30 seconds. The 15-second normal case, one-second timeout and two-second bounded cleanup are subordinate limits, not additional whole-attempt allowances. A failure or cap does not permit automatic retry.

All owned writes are confined to the new attempt directory and its explicit six-name whitelist. mkdir with exist_ok=False and exclusive file creation prevent reuse. The only truncating writes replace the supervisor's own exclusively created completion.json. No recursive deletion, unrelated move or process termination occurs. The threat model is the frozen benign code and ordinary exclusive ownership, not malicious same-user filesystem mutation.

The manifest, duplicate copied manifest, child logs, acknowledgments, completion record and final console count against the 4 MiB aggregate limit. Logs have 16 KiB read caps, the seal has a 64 KiB reserve, and the final line is checked by encoded byte size with CRLF allowance. Coordinator logs, traceback capture and the outer completion record must also be included by the coordinator; the script cannot account for files it does not own. A completed record remains invalid if that outer aggregate exceeds the cap.

A PASS-looking completion file can remain after interruption during finalization. The accepted protocol explicitly requires the matching final console hash binding and observed supervisor exit zero within the outer deadline. A failure of the final memory, byte or time check prevents that completion combination. The outer record must preserve the console's final observer query and both peak sums, since they postdate the receipt's earlier sample. Neither a file alone nor a console line without observed exit is sufficient.

The manifest checks fixed authorization text, exact source/specification/executable pins, bounded token/name and the hash of an owned review path. It verifies review bytes, not the review's meaning. The coordinator must read and accept this review before issuing the manifest; this is not automated approval by any matching Markdown file.

## Verdict and remaining boundary

Version 2 is suitable for the separately authorized bounded capability attempt under the stated coordinator requirements. No further source correction is requested. Successful parsing does not establish that Windows accepts the structures, that nested job assignment works here, or that memory counters survive exit. Those are exactly the limited questions the proposed test would address.

Even a successful future run establishes host-specific operational evidence for these two benign fixtures only. It neither proves universal API availability nor authorizes or validates the conductor-eight evaluator, its coefficients, any spectral claim, a Lean proof or a performance forecast. No execution was performed in this review.
