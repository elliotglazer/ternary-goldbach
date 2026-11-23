# C8 outer runner version 2: static preparation

2026-11-11. Source preparation only. No module import, Windows call, benign fixture, or evaluator run has been performed. Version 1 is preserved and must not be used for execution. Its ordinary parent launch could leave a suspended inner child orphaned if the supervisor died between creating that child and assigning its inner job.

The replacement is `coordinator_c8_capability_run_20261111_v2.py`. It keeps the existing unrun authorization manifest `coordinator_c8_capability_authorization_20261111_01.json`, SHA256 `9B4CDC4E4C675FE0BC254D4C3C21AB5E71D857F231ACB8CBEFE1D6D16C5756EC`, and its unchanged attempt name. It uses new outer marker, record and log filenames ending in `_v2`; none may exist before launch. This is not a retry of a completed attempt. The supervisor is pinned to `9EF92537B8363B0B81314AFC8F7049406DD9D73FDB5C4BD48FCDDDCB55B8D86B`. No child fixture or scientific scope changed.

## Ownership and process ordering

At separately authorized runtime, the wrapper checks manifest and supervisor hashes before loading the supervisor module's definitions. Its `load_manifest` rechecks all frozen source/interpreter/spec/review inputs. Only then does it instantiate the pinned native `Win` binding class. No import or Windows call is part of the preparation check.

The outer runner creates a non-inherited unnamed job with active-process limit two, kill-on-last-handle-close and no breakaway flags. Two permits the supervisor and exactly one of its sequential children. The job is read back. It creates the supervisor with `CREATE_SUSPENDED | CREATE_NO_WINDOW | EXTENDED_STARTUPINFO_PRESENT`, retains both native handles, assigns the process to the outer job, verifies membership, and resumes the primary thread exactly once. An assignment failure never resumes the supervisor and explicitly terminates it by its original handle.

The supervisor's existing one-child inner jobs are nested under the outer job. Every child it creates is already in the outer job before any user code or inner-job assignment. Thus terminating the outer runner closes its sole outer-job handle and requests termination of the supervisor and any in-flight inner child, including a suspended child in the former gap. This depends on normal Windows job inheritance/nesting and the unchanged reviewed no-breakaway sources; incompatibility fails closed rather than enabling breakaway.

The inherited standard handles are explicit. Two anonymous pipes are created; parent read handles have inheritance disabled. NUL input and the two pipe write handles are the **only** handles in `PROC_THREAD_ATTRIBUTE_HANDLE_LIST`. The outer job is not inherited. `STARTUPINFOEX` and its attribute list remain alive through process creation; parent write handles close immediately afterward. The implementation uses `subprocess.list2cmdline` only for quoting, never `Popen` or `communicate`.

## Bounded output and deadlines

Each monitor poll reads at most 4096 bytes from each pipe, after checking availability. At most 65,536 bytes per stream are retained in exclusively created files. A stream overflow fails the attempt; its seen and retained byte counts distinguish captured data from unread/discarded output. No exception path reads an unbounded pipe into memory. Pipe buffers also prevent unbounded in-memory parent capture if a child misbehaves.

The monotonic acceptance clock begins immediately before native supervisor creation. It includes suspended setup, the full supervisor/child work, observed exit, validation and finalization. The accepted limit remains 30 seconds. Short polling does not promise hard physical prevention of a transient overrun, and native creation/termination may take time. A final late completion is FAIL. The coordinator must still bind actual outer exit and final summary; a record is not accepted merely because a PASS-shaped file exists.

Every monitor iteration counts the authorization manifest, attempt-directory files and all outer files. The wrapper reserves space for its bounded final record and final summary. Final accounting is performed on both PASS and FAIL paths. The total remains 4 MiB; the two retained stream limits are part of that total, not extra allowances. Source files are dependencies rather than attempt output.

The unchanged fixture has bounded known writers. Nevertheless, an unexpected attempt-directory overrun is preserved and reported as a **failed output cap**, not hidden by truncating candidate evidence. Sampled overrun detection cannot promise physical prevention of every last write. Only the wrapper's own capture is bounded before retention. An inaccessible/irregular inventory also precludes a compliance claim. The final tool-visible summary is covered by a 64 KiB reserve; the execution coordinator must include its own retained completion evidence in its accounting.

## Failure cleanup and exit evidence

Every caught failure requests `TerminateJobObject` on the owned outer job. The runner waits on the original supervisor process handle. If outer assignment failed, it also terminates that suspended process directly by the original handle. Cleanup waits are bounded; failure to observe termination remains `INCOMPLETE_*`/FAIL. Closing the job remains a final kill-on-close backstop, not proof that termination was observed.

Supervisor exit is not treated as evidence that every descendant exited. The runner retrieves a complete `JobObjectBasicProcessIdList`, rejects truncation/count mismatch/duplicate or zero IDs, excludes only the known retained supervisor PID, and inspects any remaining IDs. For each it opens synchronization/query access, verifies membership in the owned outer job and waits for a signaled process handle. It never kills by a queried PID. A failed open, membership mismatch, failed wait or cleanup deadline makes the result incomplete. A subsequent list with no remaining descendant IDs is recorded. The list/wait loop has one two-second absolute deadline, not a fresh allowance per process. This is a conservative cleanup check; races may produce failure rather than guessed success.

For ordinary success the outer job must report exactly three associated processes overall—the supervisor and two sequential fixtures—and no job-limit terminations. `ActiveProcesses=0` is not required while intentionally retaining process handles. Inner fixture results, normal and expected-timeout exit codes and final memory queries remain those checked by the unchanged supervisor.

## Final binding and scope

The outer result requires empty stderr and exactly one complete supervisor console line. It verifies the console's receipt/source/manifest hashes, the receipt's complete pin dictionary, ordered normal/timeout cases, inner time, the fresh observer-memory record and both exact conservative peak sums, plus the inner retained-byte count. It records its own source hash, native PID, launch/observed-exit timestamps, stream hashes/sizes, outer process accounting, cleanup results and actual output inventory.

The final outer summary hashes this record and binds the manifest and runner hashes. Acceptance additionally requires actual outer exit zero and the observed overall deadline. An abrupt kill, serialization failure, incomplete pipe close, failed descendant cleanup or late finalization cannot be accepted from the inner receipt alone. No retry is authorized.

The new source addresses cleanup ownership and bounded capture. It does not establish the host's post-exit memory-query capability before the still-unrun benign test. It does not authorize a numerical pilot, prove Windows implementation correctness, or change the scientific source/axiom obligations.

## Preparation receipt

`coordinator_c8_capability_run_20261111_v2_preparation.json` records hashes and AST/compile-on-text checks. These checks neither import the prepared module nor execute its body. A separately frozen independent static review is required before root authorizes the one run.
