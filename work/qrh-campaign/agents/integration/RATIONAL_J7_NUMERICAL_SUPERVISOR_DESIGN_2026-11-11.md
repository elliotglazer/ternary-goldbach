# Rational j7 numerical supervisor adaptation

Status: design only, 2026-11-11. No runtime manifest, supervisor implementation, process fixture, evaluator import, numerical evaluation, or Lean build was made for this note. The current C8 capability result is FAIL. During preparation, the coordinator reported that the first authorized V4 attempt also failed its baseline singleton PID gate. Neither the static worker reviews nor this design authorizes a numerical run. The host capability gate, a separately reviewed numerical supervisor implementation, and coordinator runtime authorization remain prerequisites.

The new coordinator report gives complete PID snapshot `[30892,29984]`, a child self-identity matching the original handle, and a reopened PID 29984 identified as `C:\Windows\System32\conhost.exe` with creation time recorded and membership in the explicit inner job. No allocation, held or timeout phase occurred. This note does not independently certify that new receipt, whose review is pending. The observation supplies evidence of an associated queried console host; it does not permit excluding that process from the count or resource budget. Any proposed no-console launch change needs its own source review and capability test. The original singleton and lifetime-count gates remain unchanged.

This note specifies the missing adaptation of the existing C8 supervision design. It does not replace that design's Windows API and ownership analysis. The scientific target remains the 16 old j7 coefficient squares, old panel 7, and old endpoints 7 and 8. It proves no statement about the other seven centers, FFT records, zeros, or Goldbach. Even eventual successful execution would be external rational evidence, not a Lean proof.

## 1. Frozen inputs and reusable infrastructure

Paths below are relative to `work/qrh-campaign/agents/`. SHA256 pins are part of the proposed implementation review boundary.

| Artifact | SHA256 |
|---|---|
| `integration/rational_direct_g_j7_producer_20261111.py` | `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7` |
| `moebius/rational_direct_g_j7_independent_20261111.py` | `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC` |
| `integration/RATIONAL_DIRECT_G_J7_PREPARATION_2026-11-11.md` | `8DBFB1D85065A8341D3EB34C65D1103CA83C10F9FD38C3333D4033AFE17537DF` |
| `major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md` | `8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2` |
| `zero-sum/REVIEW_RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md` | `0ED13860F941BE3786D9EE780F71590581D2C658BF30B84A8CE79AF383ABE4ED` |
| `major-constants/REVIEW_RATIONAL_DIRECT_G_J7_ARITHMETIC_CODE_2026-11-11.md` | `CA2693F85775FEB9244F74AEE698000FFA57EF844EB613C982DCC8D436859AAD` |
| `prime-estimates/REVIEW_RATIONAL_DIRECT_G_J7_STRUCTURE_2026-11-11.md` | `479FC1667184AABD2271D48102A6E5E7D342EF8BB13B49B3486B74C33152A80B` |
| `integration/small_em_batch_candidate_20261111_01.json` | `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E` |
| `audit/C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md` | `EF2EF80F930AA029DE7418C9759A01465A867A40DFACAA0F9FE9B67ED8FC6B19` |
| `independent-feasibility/REVIEW_C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md` | `AEA656CCB32B74151CB570EDFA58A63104771AF7E764DE9B95789299856251DF` |
| `audit/C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V4_2026-11-11.md` | `0EAFC886790B7AF8B6C7DB0C7098343269EC5B4979AE07C92644494553446209` |
| `audit/c8_supervisor_capability_preflight_20261111_v4.py` | `08A6AB509952DC830002433B53892ED1E4B717B139611C45E5BF16E6FF6777AB` |
| `audit/coordinator_c8_capability_run_20261111_v4.py` | `07426FC9A9D1A0E51A2E4BD69930027FCCC8C7DE6F0047739273BBD9A32A68E1` |

The V4 sources are inspected infrastructure, not a passed numerical supervisor. Its older preparation records must not override the exact versions above. Future manifests must also bind the complete 12-entry worker `PINS` map, independent preparation and current static reviews, chosen interpreter and relevant runtime binaries, numerical supervisor sources, capability evidence, canonical inputs, output ownership, and this adaptation's review. A hash alone does not establish a review's conclusion.

## 2. Process roles, limits, and the exact V4 delta

Use one fresh phase for the producer and, only after its successful external seal, one fresh phase for the independent checker. Let W be the scientific worker, S its immediate external supervisor, and R the outer controller. The following observer constants are proposed implementation parameters, not measurements or revisions to the scientific limits.

| Limit | Producer phase | Independent phase |
|---|---:|---:|
| W launch-to-observed-exit deadline | 600 s | 900 s |
| W full-lifetime peak working set | 512 MiB | 512 MiB |
| Aggregate new retained phase files | 16 MiB | 16 MiB |
| S preparation before W creation | 30 s | 30 s |
| S post-W-exit validation/sealing window | 60 s | 60 s |
| R-observed S launch-to-exit deadline | 690 s | 990 s |
| S full-lifetime peak working set | 256 MiB | 256 MiB |
| R own observed peak through final publication | 128 MiB | 128 MiB |
| Host-observed R whole-phase deadline | 750 s | 1050 s |

R has at most 30 seconds before S creation and 30 seconds after S exit for its own finalization. S's 690/990 deadline starts before its creation, so interpreter startup is charged even if S's internal preparation timer starts later. The host must observe R's exit by 750/1050, including publication. These limits do not promise completion; an overrun produces INCOMPLETE. Any cleanup continuing after a deadline cannot restore success.

S creates W suspended, assigns it to a fresh inner job with active-process limit 1 and kill-on-close, verifies limits and membership, records actual handle/PID/creation time/image, then resumes it. R creates S with the corresponding suspension/assignment protocol in an outer job with active-process limit 2. W inherits that outer containment and also belongs to its inner job. No breakaway or numerical helper process is allowed. Native API calls, structure sizes, inheritance lists and return values require the existing source-level checks and new implementation review.

At the held-handle final checkpoints, inner lifetime `TotalProcesses` must equal 1 and `TotalTerminatedProcesses` 0; outer lifetime totals must equal 2 and 0. The outer 2 is S plus this phase's one W. V4's benign outer total 3 counts S plus two sequential fixture workers and cannot be copied. This is a different intended process graph, not permission to accept unexplained extra processes. Record raw accounting and PID-list observations before deciding. Do not require `ActiveProcesses == 0` while process references are retained. Microsoft documents both lifetime association counting and reference-dependent active counting in [JOBOBJECT_BASIC_ACCOUNTING_INFORMATION](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_basic_accounting_information).

S measures W's entire lifetime using its original creation handle. R similarly measures S after exit. R's own self-query is explicitly only a cumulative observed peak through its final check; it is not a full-postexit memory claim. Host observation supplies R's exit, deadline and final seal-hash binding, not an invented postexit memory measurement. Thus the 512 MiB claim concerns W, and observer costs are separately disclosed. If complete R lifetime memory certification is later required, an additional external measurement contract is needed. This design does not claim that contract is available.

V4's normal/timeout child handshake, known allocation, benign result schema and 30-second wrapper deadline do not apply to numerical W. Replace them with the two frozen worker interfaces below. Retain original-handle identity, deadlines, bounded pipes, job containment, raw accounting, failure latching and external sealing. Any unexplained process-count anomaly or unavailable API rejects the phase; the prior capability FAIL is not reinterpreted.

## 3. Launch and immutable input binding

Before creating W, S verifies all source/target hashes, approved versions, and complete worker manifest key sets. It creates only an exclusive, new phase namespace. All paths must resolve to the expected owned directory with no symlink/reparse alias or path traversal. Canonical paths, relative spelling, file identity, size and SHA256 are recorded. Pass the canonical spelling actually checked; do not validate a resolved alias and then execute an unchecked original spelling. Existing source and input files remain read-only. Recheck their identities and hashes after W exits and before sealing; pre/post equality assumes the stated non-adversarial local filesystem and is not an OS sandbox against transient hostile mutation.

Use the pinned base interpreter with explicit script and manifest arguments, isolated startup flags as reviewed, a fixed working directory, bounded inherited stdout/stderr handles, and no shell. Start the external monotonic timer before `CreateProcess`, not after resume. Bind the real S PID and W creation event to the manifest's `supervisor_pid`. The worker's positive integer field and `IsProcessInJob(..., None)` prove neither its parent nor membership in this particular controlled job. S/R must prove that through their own creation handles and explicit job membership/readback. Startup must already be contained before worker imports or manifest processing.

The producer's `main` at lines 676-700 creates `Monitor` before `manifest_check`. The independent's lines 907-947 hash and validate its manifest before `require_external_job`, and its final encoding/write follow its last local timing/memory check. External supervision therefore covers import, hashing, startup failure, all evaluation, serialization, stream flushing and process teardown. It cannot rely on the workers' narrower telemetry windows.

No numerical manifest is created by this note. A future runtime manifest must record actual reviewed supervisor identities and capability evidence; a fabricated positive PID or a Boolean authorization field is insufficient. Capability must cover the chosen executable/runtime, nested job arrangement, final peak-query availability and one-worker graph. A passed future benign test is necessary evidence, not permission to skip per-run checks.

## 4. Worker-specific publication and acceptance

The producer accepts only a plain `.json` basename and writes under its fixed `HERE`, the integration directory. Its five `output_family` paths at lines 626-629 are the candidate, `.pending`, `.attempt.json`, `.failure.json`, and `.completion.json`, using `with_suffix` replacement. All five must be absent before the attempt. The independent likewise writes a basename under its fixed moebius directory and owns its candidate and `.attempt.json`. The supervisor owns only explicitly listed new observer files. It never moves, overwrites or removes an unrelated file to make an attempt appear fresh.

The producer publication path at lines 640-657 writes a pending candidate, checks limits, renames it, writes a completion file, then runs a final guard. At lines 695-696 it prints the completion record before returning 0. Producer phase acceptance requires every item below:

1. W has signaled exit with code 0, with no latched deadline, resource, API, identity or job failure.
2. The final candidate is complete strict JSON, schema and exact target/recipe/pins match the frozen source, status is `CANDIDATE`, all 1025 leaf indices, 16 coefficients and three target images are present, and all required negative-control names/results are present. Reject duplicate keys, wrong numeric types, malformed canonical rational/dyadic encodings, missing/extra indexed records, and oversized data before allocating or shifting.
3. The file `.completion.json` and the single bounded stdout completion JSON agree exactly and bind the candidate's measured byte size and SHA256. Both retain external-seal and independent-acceptance requirements. A pre-exit completion line alone never accepts the phase.
4. Sources and target still match; the externally measured lifetime peak and final job counters pass; all phase files fit the aggregate cap.

The producer's caught-failure path at lines 660-674 can delete its own candidate, pending and completion files and retain its marker plus an INCOMPLETE failure record. The supervisor records this lifecycle without trying to undo it. An absent/deleted candidate, leftover pending file, malformed partial record, nonzero exit, or success-shaped file after timeout remains failure. Do not reconstruct a candidate from earlier stdout or delete failure evidence to satisfy a size test.

The independent manifest binds the sealed producer source and receipt separately. It must read the exact producer receipt hash that passed the preceding seal; no substitute candidate or mutable basename is allowed. Its final result must have schema `rational-direct-g-j7-independent-v1`, status `ARITHMETIC_CANDIDATE`, the expected source/input hashes, complete counts of 1025 producer logs/phases, 1025 independent logs/phases, 16 independent coefficients and three images, and every required negative control. Its code has no producer-style stdout completion protocol. Require exit 0 and a complete matching file, then external sealing. Requiring an invented console handshake would reject the frozen program for the wrong reason.

Independent `json.dumps(...).encode(...)` and final exclusive write at lines 943-946 are inside the external time/memory window even though they follow internal telemetry. The supervisor reopens, strictly parses and hashes the closed file after exit; checks recorded producer receipt/source identities against its own pins; and performs the bounded structural and saved-rational consistency checks specified in the reviewed implementation. It must not import either worker to validate a result. The independent worker's separately reviewed arithmetic implementation remains responsible for the full fresh computation and all claimed containments. Successful parsing is not a substitute for that computation.

## 5. Lifetime resource and failure protocol

Every wait, including one reporting signaled exit, is followed by a monotonic deadline check. A final peak query uses a newly initialized structure and the original handle after confirmed exit. Require API success, positive `PeakWorkingSetSize`, consistency with every live peak and the same query's current working set, and the exact cap. No last-live, private-commit, exit-code or process-object-lifetime substitute is permitted. [GetProcessMemoryInfo](https://learn.microsoft.com/en-us/windows/win32/api/psapi/nf-psapi-getprocessmemoryinfo) describes the query and success result; it does not supply the missing guarantee of success on every terminated process. [Process termination](https://learn.microsoft.com/en-us/windows/win32/procthread/terminating-a-process) explains the signaled state and retained object, which alone do not close this capability gap.

On any failed gate, latch INCOMPLETE, terminate only the owned job/processes as appropriate, and wait for termination under the observer deadline. Termination is asynchronous. Preserve handles long enough to collect available exit, peak and accounting evidence. Record unavailable data as unavailable. A cleanup timeout is failure; it is not a license to report that all owned processes have stopped. Kill-on-close provides containment when S exits unexpectedly, but R must still record what it actually observed. Closing handles or a later successful query cannot erase an earlier breach.

Count all newly retained phase output: worker candidate/pending/marker/failure/completion, supervisor manifests, stdout/stderr, partial diagnostics, S/R seals and the host completion record. Existing immutable source files, the old target, and the sealed producer receipt read by the independent phase are inputs, not charged again; a copied input is a new phase file and is charged. Each phase has its own 16 MiB cap. The aggregate accounting includes both worker directories and observer-owned paths, not merely one output folder.

Reserve 256 KiB of the phase budget for the combined observer/metadata margin: at most 64 KiB stdout plus stderr, 128 KiB ordinary new metadata, and 64 KiB failure/final-seal reserve. These are sublimits, not exemptions; count the worker's completion and marker in the appropriate metadata total. The producer already leaves a payload margin and the independent payload check is below 15 MiB. Reject a phase whose actual aggregate cannot fit, even if each individual writer accepted its file. Do not append an unbounded exception or duplicate the candidate into the seal.

Bound pipe draining in threads within S or R; no drain subprocesses. Polling and writer checkpoints cannot prevent every transient physical overshoot. The acceptance claim is that all observed limits and final retained sizes pass, with lifetime OS peak memory separately measured. Any observed overshoot fails immediately and irreversibly. If stronger continuous disk-write enforcement is required, it needs a separate mechanism; do not claim this polling design provides one.

## 6. Seals and phase isolation

S produces a provisional external record only after W exit, final memory/job checks, source revalidation, complete result validation and final aggregate accounting. It binds the launch command and identities, all inputs, raw final accounting, peak-query success/data, measured intervals, candidate/completion/log hashes, file inventory, worker exit and each gate. A failure record uses the same identities and records the first and subsequent failures, without a success seal.

R accepts that record only after S exits successfully, S's own final peak query passes, the outer total-2/terminated-0 accounting passes, all files still match, and its remaining publication window and aggregate budget pass. R's final record binds the S record rather than changing it. The host then records R exit, observed overall deadline, and final record hash in the reserved phase space. No process can self-certify its future exit or postexit peak; these roles must remain explicit. A later implementation must specify bounded atomic publication order and ensure no provisional success-shaped record can satisfy the consumer's final-status predicate.

The independent phase receives only a producer candidate accompanied by the completed producer external chain. It uses a fresh attempt namespace and fresh jobs; it cannot mutate the producer namespace. The producer and independent scientific workers never overlap. A failed producer prevents the independent run. A failed independent attempt preserves the producer's limited candidate status and creates no combined acceptance. Neither phase retries with higher precision, different roots, larger caps, a different interpreter or changed source under the same attempt identity.

## 7. Remaining implementation and review gates

The smallest new implementation is a reviewed numerical adapter over the inspected native process/job primitives: two fixed worker-schema adapters, canonical file binding, the deadline/observer constants above, complete bounded publication and aggregate accounting, and the external phase-chain validator. It must not reuse benign fixture success predicates or import numerical worker code. Static tests can exercise malformed JSON, wrong hashes/indices/status, missing completion, unexpected child accounting and expired deadlines without evaluating elementary functions; any execution still requires its separate authorization.

Before a numerical run, obtain a passed capability result for the actual arrangement, freeze and independently review the numerical adapter, its manifests/schema and failure tests, and establish the host-controller timing/seal contract. The current failed capability, including the newly reported V4 failure, leaves this gate open. Then one authorized producer attempt and one conditional independent attempt may test the scientific claims. No outcome, runtime or memory success is predicted here.
