# Independent review of C8 external supervision

2026-11-11. Verdict: PASS as a conditional paper execution design. No amendment to the frozen design is required. This is not a finding that post-exit telemetry works on this host, an implementation approval or permission to run either evaluator.

Reviewed audit/C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md, SHA256 EF2EF80F930AA029DE7418C9759A01465A867A40DFACAA0F9FE9B67ED8FC6B19, against zero-sum/NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md, SHA256 3B4B21946F89CA503F03A2BBC030B73F556B31254BA643C427AFB1B39CA5A43B, and its moebius review 0046FAEEC56248F33F5AB9CD80E8C8675631FBF77679FE54CE436DD9A56FCFA3. All three hashes match. I read the complete supervision note and the scientific specification, including its resource and acceptance sections. The scientific mathematics is not re-reviewed here.

Only source reads, hashes and official-document browsing were performed. No supervisor or evaluator was imported or executed, no child-process test was run, and no code or frozen artifact was modified.

## Memory claim and its remaining condition

The decisive distinction is correct. Microsoft documents GetProcessMemoryInfo success separately from its output structure, whose PeakWorkingSetSize field denotes peak working-set bytes. The function documentation does not promise that a query will succeed after termination. The object-lifetime documentation preserves the process object while another process holds a handle; that is not a promise that all memory information remains queryable. See [GetProcessMemoryInfo](https://learn.microsoft.com/en-us/windows/win32/api/psapi/nf-psapi-getprocessmemoryinfo), [PROCESS_MEMORY_COUNTERS](https://learn.microsoft.com/en-us/windows/win32/api/psapi/ns-psapi-process_memory_counters) and [process termination](https://learn.microsoft.com/en-us/windows/win32/procthread/terminating-a-process).

The proposed acceptance is therefore conditional on applying the documented successful-query field semantics to the retained terminated-process object. That condition is stated explicitly, rather than inferred from object survival or a successful numerical calculation. A benign capability test may provide host-specific operational evidence; it cannot prove universal availability or OS implementation correctness. None has happened under this review.

The required fresh post-signaled-exit query uses the original handle and a newly initialized buffer. API failure, zero peak, malformed layout, regression below earlier peak observations or a value below simultaneous current working set prevents acceptance. So does a peak above 536,870,912 bytes. A maximum of live polls is explicitly insufficient. These plausibility checks supplement the API contract; they do not prove it independently. A host on which the final query is unavailable produces INCOMPLETE_TELEMETRY under the unchanged specification.

The memory metric is also preserved. PeakPagefileUsage is commit accounting, and the job memory limits concern committed virtual memory. These cannot be substituted for the selected working-set measure. The [job extended-limit documentation](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_extended_limit_information) supplies the relevant context. The note makes no claim of physically preventing every transient working-set overshoot.

## Local Python and Windows implementation boundary

I independently read local Python 3.14.7 sources without importing them:

* C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/Lib/subprocess.py, SHA256 A7B6BDF4657B018E4E76F22EBBB975A5FA6F0501088177FE950DF1E20C18B209.
* C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/Lib/ctypes/wintypes.py, SHA256 22948FD71CFF56589E80EBA0C9E41E34B21A341920E261E3BBF2839FE6C1F1FE.

The first retains Popen._handle around line 1574 and uses it in _wait at lines 1595–1609. It closes the primary thread handle after creation. Thus normal Popen plus CREATE_SUSPENDED does not itself supply a public retained-thread resume interface. The design correctly requires a separately reviewed native creation path or equivalent mechanism. The private process handle is a pinned implementation fact, not a public Python guarantee or evidence of memory-query availability.

The x64 base PROCESS_MEMORY_COUNTERS layout has two DWORDs and eight SIZE_T fields, hence 72 bytes with the Windows ABI. The local wintypes definitions use a pointer-sized HANDLE. Explicit native signatures, structure size, last-error handling, handle ownership and cleanup remain checks for the future implementation. Merely matching the Python field names is insufficient.

## Identity, child exclusion and time

The specification permits no evaluator subprocesses. Suspended creation followed by assignment to a fresh no-breakaway job before resumption removes the ordinary launch-before-assignment race. The design rejects incompatible job setup and does not silently enable breakaway. It still requires a source audit for delegation and explicitly excludes an adversarial same-user sandbox claim. This matches the job association and child-inheritance rules in [AssignProcessToJobObject](https://learn.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-assignprocesstojobobject).

Normal completion requires TotalProcesses=1 and no limit-terminated processes. Retaining a process reference can delay ActiveProcesses decrement, so requiring ActiveProcesses=0 at that point would be an incorrect gate. Microsoft documents that accounting behavior in [basic job accounting](https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-jobobject_basic_accounting_information). Subject to the reviewed single-process premise, the evaluator process's peak supplies the specified process-tree metric. The separate observer is not an additional numerical worker.

The independent monotonic timer starts before native creation and ends at observed signaled exit. This includes suspended setup, imports, calculation, evaluator serialization, flushing and shutdown. Producer and independent limits remain 180 and 300 seconds. A late observation rejects conservatively, even if the process may actually have finished earlier. The finite post-exit observer hashing/sealing is separate work, not a continuation of evaluator execution; it must still be bounded and counted in retained output.

Short waits are not the acceptance clock. Windows 8 and later exclude low-power time from native wait timeouts, while Python's monotonic/performance clock supplies the intended elapsed measurement. The design rechecks the absolute deadline after every wait, including a signaled return. See [WaitForSingleObject](https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject) and [Python time](https://docs.python.org/3.14/library/time.html). Creation delay and asynchronous termination are reported honestly: a kill request is not completion, and any detected breach stays failed. [TerminateProcess](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-terminateprocess) explicitly requires a subsequent wait when termination must be established. No hard-real-time stop guarantee is inferred.

## Output and completion

The 64 MiB limit applies to aggregate retained output, including partial files, logs, metadata and the reserved completion/failure record. It is not a separate 64 MiB allowance per file. Exclusive attempt/output ownership, no overwrite or retry, bounded pipe draining and physical-byte accounting are retained. The later implementation must include the seal's actual final byte length in this accounting, as required by the design; pre-reserving room does not alone establish the final size.

An evaluator PASS is only candidate completion. Acceptance needs observed exit zero, no earlier failure, complete final telemetry, process accounting, final file sizes, exact payload hashes and the matching final message. The separate supervisor seal must be bound by its final console/external handoff, since a record cannot naively contain its own finished hash. The design makes that distinction and rejects unknown writers or mutation. Normal exit and valid hashes establish lifecycle binding, not mathematical truth; full scientific validation remains separate.

## Remaining gates

There is no required repair to this paper protocol. The unperformed steps are narrow and explicit: implementation and static review of the native API bindings and ownership/serialization paths; separately authorized capability testing of the exact host telemetry path; and only afterward an independently authorized numerical attempt. No benign test or numerical run is authorized by this verdict.

If complete post-exit peak telemetry cannot be supported, the present specification yields INCOMPLETE. The proposed alternative handshake would measure a shorter interval and needs an explicit specification amendment; it is not approved here. No committed-memory substitution, sampled-peak fallback, weaker lifetime claim or scientific enclosure claim follows from this review.
