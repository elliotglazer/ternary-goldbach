# C8 diagnostic V3 accounting analysis

2026-11-11. Saved-data, source and primary-document review only. No process query, API invocation, fixture rerun, evaluator execution, or code change was performed. **The V3 attempt remains FAIL. No further run is authorized.**

## What the new evidence establishes

V3 resolves which predicate and value failed in V3: the normal inner job fails `total_processes_equals_one`; its `limit_terminations_equals_zero` predicate is true. The original V2 attempt01 counters remain unknown; V3 does not reconstruct them. V3's reported extra lifetime associations are not a missing-field or combined-error ambiguity. They still do not identify another executable, PID, or cause.

| Job and stage | TotalProcesses | ActiveProcesses | TotalTerminatedProcesses |
| --- | ---: | ---: | ---: |
| Inner fresh | 0 | 0 | 0 |
| Inner assigned, before resume | 1 | 1 | 0 |
| Inner after original child exit | 2 | 1 | 0 |
| Outer fresh | 0 | 0 | 0 |
| Outer assigned, before resume | 1 | 1 | 0 |
| Outer after supervisor exit | 4 | 0 | 0 |

Every saved accounting query reports success, class1, requested size48 and returned length48. The recorded layout places the four final DWORDs at offsets32,36,40,44. The final inner raw suffix is `25490000 02000000 01000000 00000000`, agreeing with page-fault count18725 and the three displayed counters. The outer suffix is `646a0000 04000000 00000000 00000000`, agreeing with27236 and its counters. Thus the decoded values agree with the saved little-endian bytes; this is not merely a prose summary.

The original child handle identifies PID2304 in the producer record. Its exit query succeeds with code0. Its post-exit memory query succeeds with peak50,102,272 bytes and current working set32,768 bytes. The contemporaneous observer peak is24,666,112 bytes, giving a conservative sum74,768,384 bytes, below256MiB. Those are genuine retained observations for the original handle in this run. They do not establish absence of another process or full process-tree memory compliance. The timeout fixture was never reached.

The outer record identifies supervisor PID18120, observes its exit1, reports an empty remaining associated-descendant list, and requests successful outer-job termination. Its first failure remains `supervisor nonzero exit`. The outer total-processes predicate was also recorded false, but the nominal expected count3 describes a completed two-fixture run; this run stopped after the normal fixture. Consequently outer4 should be analyzed as an observed value, not used to infer exactly one extra process by subtracting the full-run target3.

## Pinned evidence

Paths are relative to this audit directory.

| File | SHA256 |
| --- | --- |
| `c8_benign_attempt_20261111_v3/completion.json` | `66268C3710419CE4FC20B5DB42D5B77150AB4EC8C0AA337BF05A8707B17C83C8` |
| `coordinator_c8_capability_20261111_v3.json` | `727E556E3EDCCD293CAD453087A9CADEB243351C0D28B267306966BAC574DF8C` |
| `c8_benign_attempt_20261111_v3/normal.jsonl` | `C57938E8EE05032598600534CC4A392C3C70C82DA25C9DEC3BE3F15D614019CB` |
| `coordinator_c8_capability_authorization_20261111_v3.json` | `75B92D613496C52029A35C373545E59320BA81532E48A5054E19281EF6CC5C07` |
| `c8_supervisor_capability_preflight_20261111_v3.py` | `4488B65FB487CDF22E6B924410AA61032C20B423C88491C4E4984038337BA7C0` |
| `coordinator_c8_capability_run_20261111_v3.py` | `299953B969E49E9E329BCC9DD790336D913AF1B4FAE0637330F8F9E55F9EAF32` |

The unchanged child source is pinned in the receipts as `4DC1257673F86240255F1B5331DA20BEAABE1B5DEFF85FF5E80D0A0EF58241BE`. It logs the four expected stages and source hash, but **does not log its own PID or executable image identity**. That omission matters when distinguishing the process returned by creation from the process actually interpreting the child script.

## Source interpretation and limits

Microsoft defines `TotalProcesses` as lifetime associations including terminated processes and certain failed associations, while `TotalTerminatedProcesses` is specifically about limit violations. `ActiveProcesses` may remain elevated while references to an exited process remain. Therefore inner active1 with the retained original handle is not itself evidence of a still-running helper. Conversely, active0 after outer exit does not erase historical associations. [Basic accounting definition](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_basic_accounting_information).

Job accounting includes descendant jobs; a parent aggregates child-job accounting. The documented hierarchy is directional, not an assertion that a child job includes all its ancestors. The selected inner/outer handles are explicit and their fresh/pre-resume snapshots are coherent. The inspected sources do not document a universal rule that would justify changing this test to expect2/4, or dividing every total by two. [Job objects](https://learn.microsoft.com/en-us/windows/win32/procthread/job-objects).

No additional Python-level launch call appears in the frozen benign child. This is weaker than proving that the interpreter, loaded native components, OS integration, or the complete process history created no other associated process. The root's static executable metadata—106208bytes, descriptionPython, original filenamepython.exe—does not identify the runtime process that executed the script or prove whether that binary launches another image. Neither a Python-launcher explanation, a console-helper explanation, nor undocumented duplicate accounting is established here.

No new enum/layout error is apparent from the saved native bytes and source. The meaningful unresolved alternative is: **an additional process/association occurred, or the simple lifetime-count interpretation does not match the actual observed nested setup**. A PID-resolved history is needed to discriminate them. A new count threshold alone would conceal that question.

## Smallest useful identity evidence

This is a proposed diagnostic design, not authorization to implement or run it.

At the child's existing baseline handshake, a versioned child could record its current PID, current executable image path, source hash and the existing nonce. Do the same in the supervisor before it creates the normal child. Compare these self-identities to the original creation handles' PIDs and creation times. `GetProcessId` binds a PID to a handle; current-process `GetModuleFileNameW(NULL,...)` identifies its executable path, with truncation rejected. [GetProcessId](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getprocessid), [GetModuleFileNameW](https://learn.microsoft.com/en-us/windows/win32/api/libloaderapi/nf-libloaderapi-getmodulefilenamew).

An auditor of a retained handle can obtain its image through `QueryFullProcessImageNameW`, using bounded buffers and rejecting failure/truncation. The existing source/executable hashes remain required; a path string by itself is not binary identity. [QueryFullProcessImageNameW](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-queryfullprocessimagenamew).

A mismatch between script self-PID and the corresponding original creation-handle PID is decisive positive evidence that another process executed the script. A match only proves that script's location; it does not exclude a short-lived helper. Complete bounded job PID lists at the already synchronized baseline/held stages, paired with raw accounting, can identify an additional still-associated process without introducing another fixture. Every opened PID must be checked against the owned job, creation time and retained handle to avoid reuse ambiguity. Failure to find another process is not a complete historical audit.

## Completion-port option: useful positive evidence, not a completeness oracle

Microsoft recommends associating the port while the job is inactive. `NEW_PROCESS` reports a job addition, `EXIT_PROCESS` an exit, and notification PID values can already be recycled unless a handle was retained. Crucially, delivery of these process notifications is **not guaranteed**; the documented guarantee for notification-limit messages does not extend to process additions/exits. Nested events can reach ancestor ports. Thus a missing event cannot prove absence, and a notification count is not a distinct-process count. [Completion-port association](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_associate_completion_port).

If later selected, a bounded implementation could attach a port to each fresh job before assignment, use distinct receiving-job keys, and drain a fixed number of messages during the existing polling loop. No worker thread or extra process is intrinsically necessary. Association uses information class7. A zero-time dequeue is available, but its timeout is not proof that no relevant event ever occurred. [SetInformationJobObject](https://learn.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-setinformationjobobject), [GetQueuedCompletionStatus](https://learn.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-getqueuedcompletionstatus).

For each positive addition record, try to retain a query/synchronization handle and record PID, creation time, job membership and image before exit. Do not count copies delivered through nested jobs as separate processes. A distinct live handle/image outside the two intended instances is decisive positive evidence. A duplicate notification for the same retained instance suggests repeated event delivery/association but does not itself explain the lifetime counter. Failed opens, exhausted event bounds or missing identifiers leave the diagnosis incomplete.

This option adds port lifecycle, pointer-sized key/PID decoding, bounded queue draining, handle retention and accounting perturbations. It is a larger diagnostic than self-identity plus synchronized PID lists. It could identify a cause, but the official guarantees do not promise that one bounded run must do so. A complete negative claim would need an independently justified complete process-history mechanism or a source-supported accounting contract, not just an empty notification queue.

## Decision boundary

Preserve V3 and its FAIL verdict. Recognize the narrower successful original-handle post-exit memory observation, without upgrading it to full no-descendant or lifetime-tree acceptance. The smallest next preparation would add self-identity and PID-resolved snapshots; completion ports are an optional positive-evidence extension with the stated limits. No change to expected counts, extra run, capability acceptance, or numerical-pilot authorization follows from this analysis.
