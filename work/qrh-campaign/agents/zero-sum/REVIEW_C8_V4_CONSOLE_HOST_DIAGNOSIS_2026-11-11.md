# Review of the V4 console-host diagnosis

2026-11-11. **PASS as a saved-evidence diagnosis and next-design comparison.** No author correction is required. This verdict does not establish a successful launch repair or authorize code, a manifest, a probe or another run.

The reviewed author note is `audit/C8_V4_CONSOLE_HOST_DIAGNOSIS_2026-11-11.md`, SHA256 `C6F4480EE44A8E970E1B81E1B3EF5C5E624EF2611B91F765BBACE2A45B51A78B`. The coordinator observation is `audit/coordinator_c8_capability_observed_result_20261111_v4.json`, SHA256 `E6B1332CA7AB5F3D97DC2578C21B237A3550141A6F62DB54FEF338F0C05B1AF2`. I read their contents, the relevant frozen source and saved inner record, and primary Microsoft/Python documentation. No inspected program, process query, executable probe, numerical evaluation or build was run.

## Saved evidence

All six hashes in the author's local-input table match. The inner completion is `B22FBDCDAFC7BCF837CEDC478FC7296BF59111E62F5A6AB2257EB25C8BEB3E45`; the outer result is `4864924FF2AA06B3C4D9D67E17FEFF1FC649C8E14C518EC3AEEBC797E5611F2C`. The supervisor, outer runner and child hashes are respectively `08A6AB509952DC830002433B53892ED1E4B717B139611C45E5BF16E6FF6777AB`, `07426FC9A9D1A0E51A2E4BD69930027FCCC8C7DE6F0047739273BBD9A32A68E1` and `B0E008A7344824D1651D5F86B8232171508CCCF6016CB4A74DEB32F4F97A455D`.

The baseline self PID, creation time and image path agree with the retained original child instance, PID 30892. The saved PID-list query is complete at that query: assigned and listed counts are both two, the 24-byte returned prefix holds the two pointer-sized identifiers, and the identifiers are distinct. The later query of candidate 29984 reports `C:\Windows\System32\conhost.exe`, a different creation time, successful identity queries and membership in the explicit inner job.

The list-to-open interval is not atomic; the record correctly labels that candidate `later_opened_candidate_only`. Even without claiming uninterrupted historical identity, its successful later membership query identifies an observed additional instance distinct from the retained original. The path is an API report, not authentication of that process's loaded bytes. The observations neither identify the exact creation mechanism nor prove the same explanation for V3 or the unknown V2 counters.

The first rejected condition is singleton PID-list validity, not a failed self-identity comparison. `child_self_matches_original` is true. Source order rejects the snapshot before writing the baseline acknowledgment, and the child allocates only after receiving that acknowledgment. The only child log row is baseline. The claim that controlled allocations, timeout testing and accepted post-exit memory testing were not reached is therefore supported. Cleanup and an observed failed supervisor exit do not replace those missing capability obligations.

Microsoft identifies `conhost.exe` as the console API server and traditional console user interface. This makes console infrastructure a supported interpretation of the reported name, while leaving creation parentage and the counter/limit interaction unresolved. [Console definitions](https://learn.microsoft.com/en-us/windows/console/definitions).

## Launch alternatives

The existing inner call uses `0x08000004`, and the outer call uses `0x08080004`: both already request CREATE_NO_WINDOW and suspended creation; the latter also selects extended startup information. Thus the diagnosis must not propose simply adding NO_WINDOW as an untried repair.

Microsoft documents NO_WINDOW in terms of a console application's window and console handle, not an absence-of-helper-process guarantee. DETACHED_PROCESS is a distinct initial-console choice; it prevents inheritance of the parent's console. NO_WINDOW is ignored when combined with DETACHED_PROCESS or CREATE_NEW_CONSOLE, and DETACHED_PROCESS cannot be combined with CREATE_NEW_CONSOLE. Replacing the startup choice is clearer than claiming that stacking these flags strengthens it. [Process creation flags](https://learn.microsoft.com/en-us/windows/win32/procthread/process-creation-flags).

The separate console documentation says detached console processes and GUI processes begin unattached. They can subsequently allocate a console. Consequently detached startup is a source-supported candidate, not proof that this interpreter and environment will remain singleton for their lifetime. It is reasonable to rank the same pinned executable first because this avoids changing two independent inputs at once. [Console creation](https://learn.microsoft.com/en-us/windows/console/creation-of-a-console).

The proposed change preserves the managed supervisor and child's suspended creation, assignment to their owned jobs before resume, and retained-handle observation. It concerns those two launch boundaries, not the already running outer coordinator. A later static review must bind the precise flag words and reject accidental NEW_CONSOLE, breakaway or fallback-console paths. No count predicate should be adjusted merely because a newly selected flag is expected to work.

## Output and containment requirements

The outer supervisor's standard streams are part of the completion protocol. Its NUL input and bounded output/error pipes must survive the startup change, with valid inheritable handles and STARTF_USESTDHANDLES. Windows does not validate the supplied standard handles for the caller. [Startup standard handles](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/ns-processthreadsapi-startupinfow), [CreateProcessW](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessw).

The explicit handle list must continue to restrict inheritance to the intended real handles; that mechanism requires bInheritHandles=TRUE and cannot contain pseudo handles. Job/process handles must not leak through a broader inheritance policy. [Handle-list attribute](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-updateprocthreadattribute).

The inner child's explicit file log and acknowledgment channel do not require a console stream. The author correctly leaves the precise no-standard-stream versus explicit-NUL choice to a frozen next design, rather than authorizing interchangeable fallback paths. Missing handles can be NULL, while redirected handles can designate files or pipes. None of this is a guarantee about all interpreter startup behavior. [GetStdHandle](https://learn.microsoft.com/en-us/windows/console/getstdhandle).

Using a GUI Python frontend is a separate alternative requiring a new executable pin and source review. Python documents that its standard streams can be None in GUI/pythonw scenarios. The supervisor's final authenticated output therefore cannot be assumed to survive a binary substitution without a reviewed stream arrangement. No pythonw binary was evaluated here. [Python standard streams](https://docs.python.org/3.14/library/sys.html#sys.__stdout__).

The author retains the decisive operational requirements: strict singleton checks and lifetime counters, raw evidence before rejection, no exclusion of conhost from accounting, bounded cleanup, complete normal/timeout coverage, positive original-handle post-exit queries, and the existing receipt/output/time/memory conditions. Freeing a console after startup cannot erase a prior lifetime association. A failed next attempt must remain failed, not trigger an automatic alternative.

## Verdict boundary

The diagnosis supports preparing one precisely specified detached-startup design for separate review. It does not show that the design will pass, that the active-limit behavior is explained, or that complete capability evidence already exists. V4 remains FAIL. No V5 source, manifest, execution authorization, numerical result, runtime forecast or formal proof is created by this review.
