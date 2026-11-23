# Review: rational j7 numerical supervision design

2026-11-11. **PASS as a conditional paper/source design.** No substantive correction is required. This verdict does not establish host capability, approve a supervisor implementation, authorize a numerical run, or certify any arithmetic output. The unresolved capability gate remains a prerequisite.

Reviewed author: `integration/RATIONAL_J7_NUMERICAL_SUPERVISOR_DESIGN_2026-11-11.md`, SHA256 `E3FF0DD6DB600A42496767254CFE44322F1E92F5CE564EB97DC95150B6E60150`.

All thirteen file pins in its table were independently rehashed and matched. In particular, the frozen producer is `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7`, and the independent checker is `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC`. The worker entry, manifest, publication and failure functions were reread. Existing C8 design/V4 sources and the relevant Microsoft documentation were inspected. No worker or supervisor was imported or executed, no process was probed, and no fixture or build was run for this review.

## 1. Actual worker interfaces

The adaptation agrees with the frozen programs rather than treating them as generic subprocesses.

* The producer's `manifest_check`, `output_family`, `publish`, `save_failure` and `main` begin at lines 607, 626, 640, 660 and 676. Its outputs are in the integration directory; the five sibling names use suffix replacement. The final JSON, `.completion.json` and bounded stdout completion must agree. Its final worker guard occurs before the printed completion and process exit, so neither the printed line nor an earlier file can supply complete lifetime evidence.
* The independent checker's `authorized_manifest` and `main` begin at lines 872 and 907. Its result is in the moebius directory. Success is `ARITHMETIC_CANDIDATE`, with exit zero; it has no producer-style completion line. Its final encoding and write occur after its own local peak/time observation. The proposed external observation correctly includes these operations and shutdown.
* Both input contracts require the exact pins and fixed scientific target. Neither a positive `supervisor_pid` field nor membership in some job authenticates the intended supervisor/job. The design therefore requires S/R to bind their actual creation handles, PID/creation identity, explicit job membership and read-back policy.
* The independent phase starts only after the producer's complete external chain accepts. It binds the already sealed producer receipt by hash and cannot silently substitute or modify it. Separate worker code, fresh output names and fresh jobs are retained. An independent failure does not turn a producer candidate into combined acceptance.

The source identities and arithmetic reviews are inputs to the design; this review does not repeat their mathematical audits or assume their programs have run successfully.

## 2. Time and memory scope

The scientific worker W retains the original 600-second producer / 900-second independent deadline, 512 MiB full-lifetime peak working-set cap and 16 MiB aggregate new-output cap. The monitor begins before native creation and checks the deadline after every wait, including a signaled return. Thus interpreter startup, suspended setup, import/manifest work, computation, serialization and teardown cannot be omitted by starting from a worker timestamp.

The observer budgets are separately identified: S has at most 30 seconds before W creation, 60 seconds after W exit, an R-observed total of 690/990 seconds and a 256 MiB full-lifetime peak. R has 30 seconds before S creation and 30 seconds after S exit; the host observes its full 750/1050-second phase deadline. These are consistent nested upper limits. Bootstrap or scheduling overhead can cause a conservative failure; the arithmetic sum does not grant an uncharged interval.

R's own 128 MiB observation is only through its final publication check, exactly as stated. The design does not mislabel it as a post-exit lifetime measurement. Observer limits do not enlarge W's scientific cap. Since no worker descendants are permitted, a successfully checked singleton W job is the intended worker tree; an additional process invalidates that interpretation rather than receiving an unmeasured allowance.

Original-handle post-exit queries are essential. Microsoft's [process termination description](https://learn.microsoft.com/en-us/windows/win32/procthread/terminating-a-process) supports signaled termination and the continued existence of an object retained by another handle. It does not promise that every query remains available. [GetProcessMemoryInfo](https://learn.microsoft.com/en-us/windows/win32/api/psapi/nf-psapi-getprocessmemoryinfo) and [PROCESS_MEMORY_COUNTERS](https://learn.microsoft.com/en-us/windows/win32/api/psapi/ns-psapi-process_memory_counters) distinguish successful peak-working-set results from other memory counters. The design correctly requires a fresh successful, positive, nonregressing final peak, consistent with the same query's current working set, and never substitutes commit usage or the last live sample. R must apply the same post-exit discipline to S.

[TerminateProcess](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-terminateprocess) is asynchronous when called externally. The design latches failure before cleanup and requires observed termination; it does not turn a termination request or job-handle close into evidence that all processes exited. The [wait documentation](https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject) also makes clear why one native timeout is not a replacement for repeated absolute monotonic deadline checks.

## 3. Process graph and unresolved capability

The numerical phase has an intended outer graph containing S and one W. Therefore its outer lifetime total of **2**, with zero limit terminations, is the correct adaptation of the benign fixture's total **3** for S plus two sequential fixture workers. This is not acceptance of an unexplained extra process. The W inner job still requires lifetime total **1** and zero limit terminations. Both jobs preserve active limits, kill-on-close and no-breakaway policy, with suspension/assignment before resume. Nested-job incompatibility fails rather than triggering an uncontained fallback. These constraints are consistent with [AssignProcessToJobObject](https://learn.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-assignprocesstojobobject).

The author correctly avoids requiring `ActiveProcesses=0` while retained process references may remain. The lifetime counters remain mandatory: [basic job accounting](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_basic_accounting_information) includes terminated processes and failed associations caused by a limit. PID snapshots can add identity information but cannot prove the complete historical inventory by themselves.

The opening discussion of a newly reported V4 console-host observation is explicitly attributed to the coordinator and pending its own review. This review does not independently establish those runtime observations. Whether that report is later accepted or not, the design keeps the failed singleton/capability gate open. It neither removes a console host from the count nor permits its memory to be ignored. The earlier static interpreter diagnosis likewise does not establish a helper-free runtime.

## 4. Output budget, dependencies and sealing

The 16 MiB budget is per numerical phase and covers all newly retained worker and observer files across both relevant directories: candidate/pending/markers/failures/completion, manifests, logs, diagnostics, S/R seals and the host completion record. An old immutable input, including the producer receipt read by the independent phase, is not newly produced output; a copied input is charged. There is no per-file 16 MiB reset.

The proposed 256 KiB reserve has explicit 64/128/64 KiB sublimits for streams, ordinary metadata and failure/final sealing. These must be enforced by the later implementation as a shared budget. In particular, pending/final publication must not retain duplicate large payloads, and a writer cannot consume another writer's reserve. Current/final filesystem sizes and an observed-overrun latch are required; this design does not promise instantaneous physical prevention of an unseen transient overshoot. The future implementation review must establish its actual writer/ownership invariant, not merely repeat the budget table.

The phase chain is coherent: S seals only after W exit, resource/count checks, revalidation and parsing; R validates only after S exit and its final peak/count checks; the host then binds R's final record to R's observed exit/deadline. Each layer binds the preceding record instead of asking a record to contain its own final hash. Missing final links reject provisional success-shaped files. A mathematical candidate cannot override a resource failure, and lifecycle success cannot override missing arithmetic verification.

The design deliberately leaves the atomic publication format, bounded stream handling, exact schema adapters, failure-test implementation and host controller as implementation obligations. Those are required before a run, not assumptions discharged by this paper PASS. The filesystem integrity argument remains the stated reviewed-code/non-adversarial local model; pre/post hashes do not establish protection against transient hostile mutation.

## 5. Verdict and next gate

The proposed adapter preserves the scientific target and all worker limits, fills the actual programs' external-lifetime gaps, and keeps observer scope explicit. No design correction is required.

The next admissible gates remain: accepted capability evidence for the exact interpreter/runtime and nested-job arrangement; a frozen, independently reviewed numerical supervisor/host implementation with schemas and bounded failure handling; and separate coordinator runtime authorization. None is supplied by this review. No numerical launch, new process probe, weakened counter or fallback telemetry is authorized.
