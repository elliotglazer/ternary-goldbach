# Rational j7 containment preflight: independent static review

2026-11-11. **Working review; final source/specification freeze pending. No execution acceptance.** No inspected module was imported or executed; no process/API probe, runtime manifest or numerical evaluation was made.

## Exact consumer and required scope

Read and hash-verified `audit/RATIONAL_J7_HOST_PREPARATION_2026-11-11.md`, SHA256 `37A792EC451CB94D61EED6F7565F6E8160158861657681501A2FABCE7A0EF9E3`, and `integration/rational_j7_supervision_20261111_common.py`, SHA256 `0BB49255BCF82307BACFB3BA353A3D83217C2023D37DCCDAFE6DDE98623CF154`.

The common capability gate checks the referenced evidence/review and the header schema/status/topology/limit/flag fields. It does not independently reconstruct process observations. Acceptance therefore requires a separately reviewed actual run, including external observed H exit and the complete receipt; constructing a PASS-shaped JSON header cannot satisfy the intended evidence obligation.

## Reviewed topology

The proposed three cases use fresh jobs: normal completion, R termination while S is suspended before R-job assignment, and S termination while W is suspended before S-job assignment. Expected lifetime counts are respectively H/R/S = 3/2/1, H/R = 2/0, and H/R/S = 3/2/0. These are different deliberately exercised graphs, not relaxed counts on a common graph. The ordinary numerical graph still requires 3/2/1.

The actual inherited membership checks must establish S in H's job before joining R's narrow job, and W in both H's and R's jobs before joining S's narrow job. Every normal assignment must additionally establish a singleton PID list and total one before resuming its child. The suspended condition follows from the reviewed CreateProcess/ResumeThread ordering, not merely an unsignaled process wait.

`DuplicateHandle` can preserve identity of the actual original process/job object across processes; its numeric result is meaningful in the target process, not globally. The target H PID/creation time must be verified before transfer. [Microsoft DuplicateHandle](https://learn.microsoft.com/en-us/windows/win32/api/handleapi/nf-handleapi-duplicatehandle).

Keeping duplicate narrow-job handles in H changes job close-trigger timing. These fixtures can establish inherited membership and explicit outer-job termination, not timing equivalence with numerical code that does not retain those duplicates. The documented implicit inheritance through an existing job chain supports the tested topology but does not replace observed membership. [Microsoft Job Objects](https://learn.microsoft.com/en-us/windows/win32/procthread/job-objects), [Nested Jobs](https://learn.microsoft.com/en-us/windows/win32/procthread/nested-jobs).

## Findings sent to the author

1. The initial draft discarded failed accounting/PID queries before returning them. Raw bytes, lengths, decoded fields and success/failure status must be retained before predicates. The draft now adds raw accounting arrays and the missing `8+8*listed <= returned_length <= 72` check; final persistence remains to be checked.
2. Initial assignment only checked membership. The updated draft adds total-one/zero-limit-terminations and exact original-PID singleton checks before resume.
3. Initial self/window records ignored source hash/nonce and compared only part of the native identity. Updated source adds source/nonce, exact command and image checks. Final linkage will be checked against frozen bytes.
4. Failed `wait_exit` results initially vanished before rejection. The updated draft stores raw exit/memory/identity events first. R/S diagnostic globals are process-local and require their own bounded failure publication; H cannot retain them automatically.
5. Early create/assignment cleanup must record termination and observed-wait outcomes before closing the only retained handle, particularly initial R before H-job assignment. Mere handle closure is not observed cleanup.
6. Internal 45-second checks are not external enforcement across a blocked native call or bootstrap. The specification must retain a separately observed H launch-to-exit deadline and safe forced-termination design before any runtime authorization. A PASS-looking receipt after abnormal H termination is insufficient.

The author is repairing these points. The eventual frozen review must also check bounded output including failure paths, complete process-memory scope, final serialized receipt bytes, unchanged numerical worker sources, and absence of a new runtime authorization. This working document intentionally does not claim static PASS, capability PASS or readiness to run.

## Bounded handoff status

The last inspected draft `integration/rational_j7_containment_20261111.py` has SHA256 `DCA470A09E93B9A1EED0079FD41325CB8D3AFA51870B378C1601A49A15A07AA7`. At handoff, the author had not supplied frozen replacement pins and `integration/RATIONAL_J7_CONTAINMENT_PREFLIGHT_2026-11-11.md` was absent. Agent coordination reported the author halted by the session usage limit. Therefore this review stops at the documented source findings; it must resume against a completed, frozen source/specification packet. No additional implementation or runtime activity was substituted for the missing author handoff.
