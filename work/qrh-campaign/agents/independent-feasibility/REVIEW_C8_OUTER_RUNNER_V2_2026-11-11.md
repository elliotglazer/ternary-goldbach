# Independent static review of the C8 outer runner v2

2026-11-11. PASS for source preparation of version 2. This review does not execute or authorize the capability attempt. Version 1 remains rejected. No imported runner/supervisor module, Windows API, child process or numerical evaluator was executed during this review.

## Frozen inputs and checks

Paths are relative to work/qrh-campaign/agents.

| Artifact | SHA256 |
|---|---|
| audit/coordinator_c8_capability_run_20261111_v2.py | 1DA760BF8FA8C32DD30DE7C4F37DDE4E43A54756FC71384082CD1074C1D609C5 |
| audit/C8_OUTER_RUNNER_V2_PREPARATION_2026-11-11.md | 089F1E7188CC72A0661B44DC4F3607BF20512AEF2CB200CDD596F0C013F2101C |
| audit/coordinator_c8_capability_run_20261111_v2_preparation.json | 8F34FF7AA22BDCCBAA40B526DA738205B7F7D68ADA54286FFF0BC2E25AB37ABF |
| audit/coordinator_c8_capability_authorization_20261111_01.json | 9B4CDC4E4C675FE0BC254D4C3C21AB5E71D857F231ACB8CBEFE1D6D16C5756EC |
| audit/c8_supervisor_capability_preflight_20261111_v2.py | 9EF92537B8363B0B81314AFC8F7049406DD9D73FDB5C4BD48FCDDDCB55B8D86B |

Independent source-hash/AST receipt: independent-feasibility/c8_outer_runner_v2_static_review_20261111.json, SHA256 A34B15AB33A17A339C47043A1F8EB9925E81FDF308156188BF510A79463F8F17. Parsing and compile-on-text passed; the resulting code objects were not executed. I read the complete frozen runner and preparation note, compared the repaired sections with the rejected draft, and rechecked the unchanged manifest and supervisor pins.

The inner capability preparation remains accepted by REVIEW_C8_SUPERVISOR_CAPABILITY_PREFLIGHT_2026-11-11.md, SHA256 75B7F2AD00F48F72851E80C7476A3809698C468E8C0B7E4316C2B7B0FDDCE91B. Its host-specific post-exit telemetry question is still untested.

## Original blocker and repaired process ownership

Version 1 killed only the supervisor on timeout. If that happened between inner child creation and inner job assignment, a suspended child could remain outside its cleanup job. Version 2 first creates the supervisor suspended, assigns it to the outer job, verifies membership, checks the deadline and only then resumes the retained primary thread. The supervisor's descendants inherit the outer job even before their inner-job assignments.

The outer job is fresh and unnamed, with active-process limit two, kill-on-close and no breakaway flags. Two permits the supervisor and one sequential child. Nested-job incompatibility fails rather than enabling escape or retry. A failure after process creation but before successful assignment is covered by direct termination of that original supervisor handle; it has not been resumed, so it cannot have created children.

All descendant failure termination uses the owned outer job. The direct process termination fallback uses only the original created supervisor handle. There is no PID-based killing or broad process enumeration. The implementation retains native thread/process handles, uses the reviewed pointer-sized API declarations and keeps the extended startup structures alive through creation.

The STARTUPINFOEX handle list contains only NUL input and the two pipe writers. Pipe readers have inheritance disabled; the outer job handle is not inherited. Thus supervisor termination cannot leave an inherited job handle defeating the cleanup policy. The job-inheritance reasoning remains conditional on the documented Windows APIs, as in the accepted supervision design; this static review does not establish that this host accepts the nested setup.

## Cleanup is checked, not inferred

Caught failures request TerminateJobObject. The runner waits for the original supervisor and records whether exit was observed. It separately retrieves the complete job process-ID list, rejects count mismatch/truncation/invalid IDs, and checks remaining descendants through synchronization/query handles whose outer-job membership is verified. Open failures, ambiguous membership or persistent references produce incomplete cleanup. A supervisor exit by itself never proves descendant exit.

One absolute two-second deadline bounds the descendant inspection loop, with short per-handle waits. There is no fresh multi-second allowance for each PID. Recorded exited descendant IDs are deduplicated and capped at eight. The final list must contain no remaining descendant ID. The job-close backstop remains termination machinery, not independent evidence that exit was observed. Scheduling or API stalls are not claimed to obey a hard real-time stop guarantee.

The attribute list is deleted only after successful initialization. This repairs a draft path that could attempt deletion of an uninitialized buffer. Other cleanup closes only handles allocated by this attempt.

## Time, output and publication

The outer acceptance clock starts immediately before native supervisor creation. It includes creation, assignment, suspended setup, complete supervisor/child execution, observation and subsequent validation/finalization. The added pre-resume deadline check prevents late creation from resuming work after the deadline. Final late completion is rejected. The coordinator must still bind the outer summary to observed outer exit zero and its own timing; the runner cannot certify the future completion of its final print.

Pipe reads are at most 4,096 bytes per stream per poll. Each stream retains at most 65,536 bytes; overflow fails instead of reading an unbounded communicate buffer. The counters identify bytes actually read and retained, not total bytes an aborted process might have attempted to write. EOF and exactly one final supervisor console line are required for success.

The aggregate inventory includes the unchanged authorization manifest, all inner attempt files and outer marker/log/record files. Reservations cover the final record and summary. Both successful and failed paths perform final accounting; no failed overrun is relabeled compliant. Unexpected already-written oversized candidate data are preserved as failed evidence rather than truncated to hide the breach. This is bounded wrapper capture plus breach detection, not physical prevention of every write by a faulty source.

Output names are new and reserved exclusively. The only overwrite replaces this runner's own initially incomplete record. Existing attempt directories prevent retry. The immutable manifest is unchanged; the new wrapper is not a second execution of an old completed attempt.

Runtime loading of the pinned supervisor is explicitly deferred until input hashes are validated. The runner sets dont_write_bytecode before that load, avoiding an uncounted source-cache write. The coordinator should invoke the outer script with Python -B as well, so its earlier standard-library imports cannot create bytecode caches. The source import reuses the reviewed native binding definitions and manifest checker; it does not run the supervisor main function in the outer process.

## Completion binding and scope

Success requires supervisor exit zero, empty stderr, normal/timeout case coverage, exact source/manifest/receipt hash agreement, the full completion pin dictionary, inner time compliance, matching retained-byte count and recomputed observer-plus-child peak sums. The outer job must report three total processes and no job-limit terminations. The final outer summary hashes the completed outer record. A PASS-shaped inner or outer file without the matching final summary and observed exit is not accepted.

The 256 MiB checks retain the inner protocol's precise scope: conservative observer-plus-each-child peak sums through the final observer query. The outer wrapper adds containment and lifecycle evidence; it does not turn that measure into post-exit memory telemetry for every observer process. No simultaneous whole-tree peak is claimed.

No further source repair is required for this frozen preparation. Actual native setup, API availability, normal allocation control, intentional timeout and complete post-exit memory queries remain to be tested only after the coordinator's separate execution decision. A future failure is one failed/incomplete attempt, not permission to retry. A future success would be bounded host-capability evidence, not a mathematical certificate, numerical pilot approval, spectral result or performance forecast.
