# Rational j7 external host H: preparation and receipt contract

2026-11-11. Source preparation only. No runtime request or authorization, native import/API call, process launch, numerical evaluation or Lean build was performed. This document and `rational_j7_host_20261111.py` supply the missing H implementation; they do not authorize running the S/R/worker chain.

## Exact scope and dependencies

The scientific target and worker bytes are unchanged. The governing design is `integration/RATIONAL_J7_NUMERICAL_SUPERVISOR_DESIGN_2026-11-11.md`, SHA256 `E3FF0DD6DB600A42496767254CFE44322F1E92F5CE564EB97DC95150B6E60150`; its independent review is `moebius/REVIEW_RATIONAL_J7_NUMERICAL_SUPERVISOR_DESIGN_2026-11-11.md`, SHA256 `DC0A0E113DE9FF002C4710EB15865F7067DBAD2D5C7C902BBE81AA60DF769CA0`.

H pins these infrastructure files, all under `integration/`:

| File | SHA256 |
|---|---|
| `rational_j7_supervision_20261111_common.py` | `0BB49255BCF82307BACFB3BA353A3D83217C2023D37DCCDAFE6DDE98623CF154` |
| `rational_j7_supervision_20261111_managed.py` | `F90F2DCC39A2659C2AF372EFEC19CCA73A3E679CE2AFDDAC12DABC0E209423C9` |
| `rational_j7_supervision_20261111_native.py` | `CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13` |
| `rational_j7_supervision_20261111_run.py` | `755300B91BA4780D5713DEC6C192E6F60AF50ABE6330F1C258F95C59DD28486C` |

The common source supplies the exact authorization and final-host schemas, canonical path checks, fixed worker/runtime pins, immutable target checks, aggregate inventory, and complete S/R chain validation. H imports only these hash-checked infrastructure modules at runtime, never either scientific worker. Bytecode-cache writing is disabled before imports. Source preparation parses text only.

## Roles, new containment and the remaining capability gate

H creates R suspended and assigns it to a new job before resuming it. That job has active limit 3, kill-on-close and no breakaway. R creates S in its existing active-limit-2 job; S creates W in its existing active-limit-1 job. Thus H's job contains R/S/W, while H itself is outside it. This closes the gap if R is terminated while its newly created S has not yet been assigned to R's own job: S already inherits H's job. A failure before R's first assignment is handled through R's retained original handle.

The extra enclosing job is **not** the topology exercised by V5. The separate authorization field `host_capability` must reference both evidence and its independent review. The shared validator requires evidence schema `rational-j7-host-containment-capability-1`, status `PASS`, topology `[H,R,S,W]`, active limits `[3,2,1]`, and true detached/suspended-assignment fields. Those fields alone do not prove the capability; the root must read and accept the linked observations and review. The smallest missing evidence is a bounded benign three-managed-process chain checking inherited H membership through the two assignment windows and ordinary close/termination under this exact nesting. No numerical computation is needed for that evidence. No such experiment, evidence packet or new campaign is supplied here.

Per-phase startup still reads back the H limits, checks explicit R membership and original-handle identity, and validates raw accounting/PID lists at empty, assigned-before-resume and postexit stages. The H lifetime total must be exactly 3 and limit terminations exactly 0; the existing R/S totals remain 2/1. No conhost, helper, unexpected association or unobserved identity receives an exemption. A startup compatibility failure rejects the attempt even if earlier capability evidence passed.

## Request and source binding without a hash cycle

A later root invocation would provide a single `--request-json` argument of at most 24,000 UTF-8 bytes. This is a bounded JSON object with exactly the shared authorization fields **except** `host_start_ns`. It includes the exact four infrastructure pins, the exact H source reference/hash, this contract reference/hash, the independent H review reference, accepted capability references, phase, unique token, fixed output basename, worker review/preparation, and the prior completed producer chain for an independent phase. Duplicate keys and nonfinite JSON values reject. No request file is required or created.

H records `HOST_START_NS` before its other imports/argument processing, then inserts that value into the authorization. It exclusively writes `integration/rational_j7_authorization_<token>.json` and fsyncs it. The fixed phase directory and worker-output family must not exist. The shared full validator then checks the authorization and all references before any native API is called. A malformed authorization may leave a failed owned authorization, but cannot launch R. Existing output or a reused token is never repaired or retried.

The request binds already frozen H source and contract hashes; H does not embed its own hash or review hash. H embeds the independent infrastructure pins. The authorization therefore has ordinary forward byte references, not mutually embedded file hashes. H creates no runtime request or authorization during preparation. Any future coordinator retaining a separate copy of a request or auxiliary log must charge that additional copy in its own overall accounting; the specified H path retains only the authorization, whose bytes are already charged by `Ownership`.

## Original handles, output and deadlines

The native launch is the pinned base Python, `-I -S -B`, the pinned `_run.py`, `--role R`, and the canonical authorization path, with cwd `integration`. Flags are `0x0008000C`: detached, suspended and extended startup info. The explicit inherited handle list contains only NUL stdin and the stdout/stderr pipe writers; job and process handles are not inherited. After assignment/readback and a fresh deadline check, H resumes the original thread once.

H retains the original R process handle until it has observed exit, obtained the actual exit code and postexit identity, and checked its equality to the pre-resume identity. It hashes/validates R's seal only after exit. This is not a PID reopen and not a claim that R can certify its own eventual exit. H does not add a full-lifetime R-memory theorem: the design's R observed-self-peak scope remains unchanged. W's 512-MiB and S's 256-MiB postexit checks stay in S and R respectively; R's 128-MiB self guard remains unchanged.

The same early monotonic start drives the 750-second producer or 1050-second independent whole-phase limit. It includes authorization serialization and R creation, execution and H final validation/publication. A 30-second prelaunch limit applies through R resume. Every polling iteration and a signaled exit are followed by a deadline check. The serialized elapsed field is the time through prepublication host-record assembly; it bounds the observed R exit interval, while later guard calls enforce final validation/publication before the same deadline. A supervising coordinator must still observe H's actual exit zero: H cannot self-certify its own future shutdown or interpreter bootstrap before its first timestamp.

R stdout/stderr are buffered to at most 16 KiB each. An overrun increments the seen counter and rejects; only the bounded retained prefix is kept. No truncation creates a passing stream. Success requires both streams empty, matching the frozen R program. They are published as `host.stdout` and `host.stderr` only after R exits or failure cleanup runs; R remains the normal owner of phase-directory creation. If R fails before creating it, H exclusively creates that directory solely to retain failure evidence. No source/input file is overwritten.

## Exact host receipt and failure behavior

The successful `host.json` schema is exactly the common validator's `rational-j7-host-1` schema. It contains authorization and R-seal references, H source/contract bindings, retained pre/post R identities, observed exit flag/code/time, the exact launch tuple, capability references, H job limits and all three raw accounting/PID observations, both stream hashes/sizes, elapsed time and aggregate bytes. Its status is `HOST_OBSERVED_COMPLETE`; it makes no standalone mathematical claim.

H stabilizes `aggregate_bytes` against the actual encoded host-record length, publishes through the existing exclusive pending-file protocol, and runs `validate_host_chain` against the resulting file. This validates every S/R seal, observed process relation, mandatory output structure and fixed target, source/candidate hash, stream and owned inventory. It requires the actual postpublication byte count to equal the host field and checks the complete chain for failure/pending files. The 16-MiB phase cap and shared stream/metadata sublimits apply throughout. No second copy of a candidate is made.

Any failure latches nonzero H exit. Before releasing handles, H terminates the owned job and, if necessary, the original R handle to cover failed initial assignment. Under one bounded two-second cleanup interval it waits for R and queries a bounded job PID list; later opened candidate handles are checked for membership and used only to observe exit, never for PID-based termination. At most eight lists with eight entries are recorded. Failure to enumerate, open or establish membership/exit is inconclusive, not evidence of an empty job. Handles are then released; kill-on-close is a backstop, not an observed-exit claim.

H attempts to retain bounded streams, raw process/accounting observations, elapsed time, actual inventory and the first failure in `host_failure.json`. A failure after writing `host.json` leaves that success-shaped file invalid because actual H exit is nonzero and any failure file also invalidates the common consumer. Oversized/incomplete failure publication may leave only partial evidence; H never deletes output to manufacture compliance. A missing final record is failure. Before ownership is acquired, an invalid request simply returns nonzero without creating unrelated files. H emits no console output, avoiding an uncharged host traceback stream.

## Preparation result and acceptance boundary

The companion AST receipt records syntax-only validation and source hashes. No evaluator or native module is imported by that check. Exact target/worker coverage is delegated to the pinned, separately reviewed common/S/R implementation; H neither replaces its arithmetic checks nor asserts that successful external checking is a Lean proof.

Remaining gates are independent static review of this H source and its exact interface, the additional nesting capability evidence/review, a root runtime decision and fresh request, successful phase execution and actual H exit, then independent-phase acceptance. All source files, old capability attempts and scientific packets remain unchanged by this preparation.
