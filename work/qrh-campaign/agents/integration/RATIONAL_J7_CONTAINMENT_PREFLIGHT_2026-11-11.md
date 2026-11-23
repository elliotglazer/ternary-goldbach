# Benign H/R/S/W containment source preparation

Status: UNAPPROVED SOURCE PREPARATION, 2026-11-11. No runtime manifest, native probe, process fixture, numerical evaluation or Lean build has been produced or run. This specification and `rational_j7_containment_20261111.py` address only the extra containment prerequisite of the frozen numerical H contract. The external timeout/termination endpoint remains unresolved, so this source is not eligible for execution. No extra recursive supervisor is supplied.

The governing H contract is `../audit/RATIONAL_J7_HOST_PREPARATION_2026-11-11.md`, SHA256 `37A792EC451CB94D61EED6F7565F6E8160158861657681501A2FABCE7A0EF9E3`. The compatible common validator is `rational_j7_supervision_20261111_common.py`, SHA256 `0BB49255BCF82307BACFB3BA353A3D83217C2023D37DCCDAFE6DDE98623CF154`. Its acceptance of the capability header and linked review does not validate the experiment by itself. The full observations and independent review are mandatory.

## Narrow target and three fresh cases

H is the test observer. It creates R suspended, assigns R to H's new active-limit-3 job, verifies the assigned singleton, then resumes R. R creates S suspended; S must already belong to H's job before R assigns it to a new active-limit-2 job. S similarly creates W suspended; W must already belong to H's and R's jobs before assignment to a new active-limit-1 job. Every job has limit flags `0x2008`, read back exactly. No breakaway flag is used. The only child work is bounded JSON/file synchronization, identity/accounting queries and waiting.

The attempt comprises exactly these cases, in this order, each with fresh jobs and processes:

| Case | Tested window and action | Final H-job lifetime total | Other final lifetime totals | Required exits |
|---|---|---:|---|---|
| `normal` | Observe both windows, acknowledge assignments, resume W and release it | 3 | R-job 2, S-job 1 | R/S/W all 0 |
| `gap_s` | Keep S suspended before R-job assignment; terminate R, verify S remains alive, explicitly terminate H's job | 2 | R-job 0; no S-job exists | R/S `0xC8F6` |
| `gap_w` | Assign/resume S; keep W suspended before S-job assignment; terminate S, verify W remains alive, explicitly terminate H's job | 3 | R-job 2, S-job 0 | R/S/W `0xC8F6` |

All jobs require zero limit-triggered terminations. Explicit `TerminateProcess`/`TerminateJobObject` calls are distinguished from limit termination accounting. Counts are not pooled across cases. A helper or console-host association is a failure, not an exemption. No postexit-empty PID-list requirement is imposed while object handles are retained.

R in forced cases waits for H's termination rather than returning normally after S exits. Therefore the forced exit-code expectations are exact. S is never resumed in `gap_s`; W is never resumed in `gap_w`. These cases do not claim any work by the unresumed process.

## Original-object observations without inherited job handles

Only a NUL standard-I/O handle is inherited. The launch uses the pinned base interpreter, `-I -S -B`, explicit script/role/case arguments and creation flags `0x8000C`. The pipe-capture machinery and numerical computation are not retested here. The native declarations come from the unchanged `rational_j7_supervision_20261111_native.py`, SHA256 `CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13`, imported only after source/manifest checks. No scientific worker, common numerical adapter or numerical H module is imported.

Each creator retains its original process/thread handles. R and S use `DuplicateHandle` to give H handles to the same created child process object and their own narrow job. They open H using its recorded PID, verify native PID plus creation FILETIME before duplication, and close that transfer handle. H correlates each transferred child handle's native identity with the creator's recorded original identity, exact command, executable path and manifest token. Resumed children also write self identities and the exact source hash/token. H acknowledges each window only after checking it, while the creator still retains its originals.

The extra duplicated narrow-job handles deliberately keep those job objects alive in H. Consequently this test is not evidence that killing R or S triggers the same kill-on-close timing as the numerical program. The affected suspended child is not yet a member of that narrow job anyway. The tested repair is inherited membership in H's job, followed by H's explicit termination of that enclosing job and observed exits through the retained process objects. No equivalence of close-trigger timing is asserted.

If a creator fails after duplication but before publishing a handle packet, H may not know the new numeric handle. The attempt must fail; process termination releases any such unreported duplicate. This is bounded by the fixed number of transfers, not an unbounded producer. It is not labeled observed per-handle closure.

## Exact observations and rejection rules

Every raw accounting record contains the native 48-byte buffer, decoded fields, returned length, query success/error and layout. It also contains a raw 72-byte bounded PID buffer, assigned/listed counts, returned length and decoded PIDs. Records are retained before the predicates run. Required PID returned length is at least `8+8*listed` and at most 72; assigned equals listed and is at most 8. PIDs must be positive and unique. Immediately after every fresh-job assignment and before resume, total is 1, limit terminations 0 and the PID list is exactly the original child PID.

At each creation window H checks successful explicit `IsProcessInJob` results, not the weaker any-job test. S must be in H's job and outside R's new job. W must be in H's and R's jobs and outside S's new job. The created process must still be unsignaled. The source's suspended creation flag and absence of a prior resume establish the suspended checkpoint. All membership observations are retained, including false/failed results.

Every expected exit requires a signaled wait, an actual successful exit-code query, the exact normal/forced code, correlated postexit native identity, and a fresh successful memory query on the same retained process object. Failed exit, identity or peak data is retained before rejecting. Existing positive V5 evidence does not guarantee that these queries will succeed in this new attempt.

Ordinary subordinate exceptions attempt to save `R.failure.json`, `S.failure.json` or `W.failure.json` with that process's own raw accounting/events. H's globals cannot substitute for another process's logs. Expected abrupt forced kills need not produce those late failure files. Cleanup records attempted job/process termination, the actual wait status and whether exit was observed. Closing a handle is never used as evidence that its process stopped. Persistence is bounded and best-effort on an already failed attempt; failure to save diagnostics cannot turn it into PASS.

## Fixed bounds and the unresolved external endpoint

The source enforces a 45-second H interval from its first monotonic timestamp, a 12-second bound per case, a 3-second cleanup interval, at most 128 MiB peak working set per process, a conservative at-most-512-MiB sum for H and the three process peaks, 2 MiB of retained output including the authorization, at most 128 filesystem entries, 64 raw accounting records and 256 event records per process. It performs no explicit bulk memory allocation. These are acceptance limits, not a prediction that a native operation cannot block or that all limits will pass.

The final result is at most 512 KiB. Ordinary records are at most 128 KiB. Failures may retain a bounded last portion of diagnostics with an explicit truncation marker; a truncated failure is never a successful certificate. The root directory, case directories and records use fresh names derived from one 32-hex token; no overwrite, resume, retuning or retry is allowed. Sources and old artifacts are unchanged.

An external observer must impose a finite launch-to-exit timeout and observe H's real exit and final file hash. H's own 45-second guard cannot interrupt a blocked native call. Merely terminating H can leave a suspended R created before H assigned it to its job. Thus a later launch plan must establish a safe external termination endpoint for that first creation gap, rather than recursively adding ordinary create-then-assign supervisors. An independently reviewed atomic creation/containment arrangement or an already established external containment guarantee may supply that endpoint; neither is implemented or claimed here. Until then the preflight is unapproved and no runtime authorization should be issued.

## Future authorization and evidence schema

No authorization file accompanies this source. A later manifest must have exactly `schema`, `authorize`, `token`, `pins`, `static_review`, and `caps`. The schema is `rational-j7-containment-preflight-1`; the authorization string is `RUN_ONE_BENIGN_CONTAINMENT_ATTEMPT`. Pins cover the exact source, this specification, native module, base interpreter and H contract. The static review reference must bind the final source and the eventual external launch prerequisite. Caps must equal the source constants with integer types. A manifest alone never supplies the missing external launch guarantee.

The future `result.json` has schema `rational-j7-host-containment-capability-1`; header fields `topology=[H,R,S,W]`, `active_limits=[3,2,1]`, `detached=true`, and `suspended_assignment=true`; exact pins and manifest hash; three ordered case records; H's raw accounting/event arrays; elapsed time; and status PASS or FAIL. Each passing case has the complete window records, resumed-role self identities, assignment records, all required exits, final lifetime accounting and conservative peak sum. The assigned-before-resume snapshots are required even though the compatible common header checker does not inspect them. An independent reviewer must reconstruct all count, identity, window, exit and resource predicates from the full evidence, and check all retained file/source hashes. A header alone is insufficient.

A success-shaped result followed by failed final guard or nonzero H exit is not accepted. Successful evidence requires the externally observed exit 0, externally bounded whole launch interval, unchanged source/manifest pins, complete output within cap, all three passing cases, and independent review. The extra containment capability remains absent until that process completes. This note creates no numerical or mathematical result.
