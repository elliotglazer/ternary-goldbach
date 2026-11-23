# Review of the failed C8 capability attempt

2026-11-11. Verdict: the one authorized attempt failed. The saved evidence and source control flow are consistent with that status. They do not establish a successful full supervisor capability test, a specific job-counter value, or permission to retry.

This review used only saved files, source reads, hashes and exact JSON/byte comparisons. No Windows API query, process probe, fixture, evaluator import or replay was performed. The numerical C8 pilot was not part of this attempt.

## Frozen evidence

Paths are relative to work/qrh-campaign/agents/audit.

| Artifact | SHA256 |
|---|---|
| coordinator_c8_capability_authorization_20261111_01.json | 9B4CDC4E4C675FE0BC254D4C3C21AB5E71D857F231ACB8CBEFE1D6D16C5756EC |
| coordinator_c8_capability_run_20261111_v2.py | 1DA760BF8FA8C32DD30DE7C4F37DDE4E43A54756FC71384082CD1074C1D609C5 |
| c8_supervisor_capability_preflight_20261111_v2.py | 9EF92537B8363B0B81314AFC8F7049406DD9D73FDB5C4BD48FCDDDCB55B8D86B |
| c8_supervisor_benign_child_20261111.py | 4DC1257673F86240255F1B5331DA20BEAABE1B5DEFF85FF5E80D0A0EF58241BE |
| coordinator_c8_capability_20261111_01_v2.json | 92888F50181BF8C9E0E02B58658ED2A8ACA690B83266658B276E8B53E98B7D79 |
| coordinator_c8_capability_20261111_01_v2.stdout | 5988E50DC06C504C8088210339700BBA52E9EC18E51DB1B3C0116FCDD9E92320 |
| coordinator_c8_capability_20261111_01_v2.stderr | E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855 |
| c8_benign_attempt_20261111_01/completion.json | 2E98F8A15E6C9646538B9A5ECB7E870F8045CA2D505EA1E85FA1DD567B8D0384 |
| c8_benign_attempt_20261111_01/normal.jsonl | 8312387BE40C15890E87BE85E6FA7FB5C596419E208CD906A8B686F7E085D2A3 |

The source files still match their accepted pins. The outer exclusive marker is 7FB752CE4FA72AFCABFB5A615BEF4359429FBCA07026D41B07B55D8445BAECF3. Both acknowledgment files hash to 4C2C1B65799767F168C24B48D2465C298B83E97E8C75BACD7E81B94CE6F8EC66 and contain exactly the authorized token.

## What was actually retained

The outer record reports supervisor PID 15864, observed exit code 1, status FAIL and error `RuntimeError: supervisor nonzero exit`. Its stdout contains one complete FAIL console object, whose receipt, source and manifest hashes match the saved inputs. Stderr is empty. The inner completion has status FAIL, error `RuntimeError: unexpected process tree/limit violation` and an empty tests array.

The invalid-handle control is retained: success=false, error=6, peak=0, working_set=0 and rejected=true. This supports the narrow statement that this control rejected a failed query. It does not validate every malformed telemetry case.

The normal child log contains exactly baseline, held, released and finished. The held and finished allocation fields are respectively 16,777,216 and 33,554,432 bytes. I independently checked every record's token and child-source hash, both acknowledgment payloads, and the finished record's hash of all preceding raw log bytes. The prefix hash is 1C572D825B4278D90C1FB7CBF0C7C823E20F3BFD19F01A111F50B87CB1D271C5. These are valid fixture log records under the pinned source. The code's post-accounting log validations were never reached; this saved-byte review supplies those limited checks separately.

There is no timeout.jsonl. The source loop attempts normal before timeout, and appends a test only after run_case returns. Normal raised before return, so no normal test object was retained and the timeout case was not started. Empty tests does not mean that no child work occurred.

Two observer values are saved: the inner receipt's last guarded supervisor peak is 24,096,768 bytes, and the final console's fresh observer query reports success with peak and current working set both 24,113,152 bytes. Those are observer values, not the normal child's peak. The console's conservative_peak_sums array is empty because there was no completed test record. An empty array is not evidence that aggregate memory checks were completed for both fixtures.

## Exact failure point and inference limit

In the pinned supervisor, lines 209–210 first call QueryInformationJobObject for basic accounting and check native success, then require

    account.TotalProcesses == 1 and account.TotalTerminatedProcesses == 0.

The recorded error string is the latter requirement's unique message. Under the pinned execution, at least one of those comparisons failed. The raw structure was not serialized. It is therefore unjustified to assert TotalProcesses=0, TotalProcesses=2, a nonzero termination count, or any other numerical value. The error label itself is not proof that a real extra process or limit violation occurred. A counter-interpretation issue, implementation issue or unexpected runtime result cannot be distinguished by these saved artifacts.

Source ordering supplies a narrower conditional inference: the normal case had reached observed signaled exit and passed its preceding final-memory validator, observer aggregate guard, zero exit-code requirement and process-time check before failing this accounting condition. These are control-flow inferences from the frozen code and error, not independently retained native telemetry. In particular, the normal child's final raw memory result, PID, FILETIMEs, live observations, observer pair and account counters were locals waiting to be included in the never-returned test object. Their values cannot be reconstructed from the normal log or observer peak.

Thus the failure does not demonstrate that post-exit GetProcessMemoryInfo was unavailable. Equally, it does not supply the complete raw, independently reviewable two-case evidence required to accept the capability protocol. The normal case is incomplete/failed and the timeout case is untested.

## Outer cleanup, timing and retained size

The outer record reports a successful TerminateJobObject request after the supervisor's nonzero exit, supervisor_observed_exit=true, remaining_associated_descendants=[] and no cleanup error. Descendant_cleanup is empty. In the source, that means the bounded job-list check found no other associated process to record as an individually waited descendant. It does not mean that the outer runner separately observed a normal-child process handle exit, nor does a successful termination request alone prove one.

The recorded start and observed-exit values differ by 727,644,600 ns. Elapsed time through the outer finalization sample is 736,479,000 ns. The coordinator separately reported tool exit 1 and wall time 1.4256369 seconds for chunk d340b9. These are different timing scopes; none is a numerical-evaluator benchmark. The failure was the accounting guard, not a recorded time or output overrun.

Exact current sizes reproduce the inner console's 5,049-byte aggregate, including the 1,371-byte authorization manifest. Adding the outer marker, captured stdout/stderr and final 999-byte outer record gives 6,768 bytes for those listed artifacts. The record's retained_bytes_before_final_record=5,793 includes its earlier 24-byte incomplete placeholder, which was replaced by the 999-byte final record: 5,793-24+999=6,768. Tool-visible summary and any additional coordinator capture are separate retained bytes, so 6,768 is not claimed to inventory every host log. There is ample room in the recorded reserve, but this does not repair the failed capability conditions.

The later coordinator observation/inventory record, audit/coordinator_c8_capability_observed_result_20261111_01.json, has SHA256 480467F1BCBF10ABBBD76E76D348C8070DAB77558F5EADA46CC1AE2F5123D0E9. I checked all eleven listed file sizes and hashes. It adds the execution-decision record, giving 7,996 bytes before the observation record itself; that record is 4,175 bytes, so the known total is 12,171 bytes. Including its 65,536-byte tool-output reserve gives 77,707 bytes, below 4 MiB. This corroborates the bounded retained-output accounting and the coordinator's reported exit/time, without supplying missing native counters or changing FAIL.
## Diagnostic consequence

Do not change a job-counter acceptance predicate based on guessed values. A future separately authorized version would need to retain the raw basic-accounting fields and already-obtained final telemetry before evaluating the predicate, ideally in a bounded partial case record. That is a diagnostic requirement, not a proposed retry or an approval of different semantics. All current files and the failed one-attempt marker should remain unchanged.

The defensible result is one failed benign capability attempt with a verified normal-stage log, a retained failed-query rejection, a specific unrecorded-counter predicate failure and recorded outer cleanup. Full capability acceptance, timeout-control evidence and the mathematical C8 experiment remain open.
