# C8 V4 console-host diagnosis

2026-11-11. Saved evidence and primary documentation only. No process launch, process API query, PE experiment, source modification, new manifest or retry was performed. V4 remains FAIL; this note proposes a next design, not a demonstrated repair.

## Finding and evidence limits

V4 establishes more than an unexplained accounting increment: a later opened process with PID 29984 reports image `C:\Windows\System32\conhost.exe`, creation FILETIME `134389003674807365`, and membership in the explicit inner normal-case job. The original child is PID 30892, creation FILETIME `134389003674607903`; its baseline self report matches the retained creation handle. The complete bounded job list at the baseline contains `[30892,29984]`. The adjacent accounting observation has TotalProcesses=2, ActiveProcesses=2, TotalTerminatedProcesses=0.

The unknown entry is correctly labeled `later_opened_candidate_only`. A PID list followed by OpenProcess does not by itself prove uninterrupted identity through a possible PID reuse. Nevertheless, the later handle's successful image, creation-time and explicit-job-membership observations positively establish an additional observed job member. No historical-instance assumption is needed to reject singleton membership at that later observation. A native image path is the API-reported executable path, not a new signature or file-byte authentication.

The recorded first failure is `handshake_baseline_pid_identity_valid`; `child_self_matches_original` is true. The normal child stops at its baseline handshake, before the controlled allocation sequence. V4 has no successful normal/timeout pair or accepted post-exit memory result. The outer cleanup records observed supervisor exit and no remaining associated descendants, but that does not turn the failed fixture into a capability pass.

The observed conhost is consistent with console infrastructure, but neither these observations nor the documentation identify the exact internal creation call or its parentage. They do not identify the additional outer accounting entry, explain why the active-limit setting permitted the observed membership, recover missing V2 counters, or prove that the unidentified V3 entries were conhost processes. Those claims remain unsupported.

## Exact local inputs

All paths below are relative to `work/qrh-campaign/agents/` in this workspace; hashes are SHA256. The two saved-record hashes were independently recomputed for this note.

| Input | Hash |
|---|---|
| `audit/c8_benign_attempt_20261111_v4/completion.json` | `B22FBDCDAFC7BCF837CEDC478FC7296BF59111E62F5A6AB2257EB25C8BEB3E45` |
| `audit/coordinator_c8_capability_20261111_v4.json` | `4864924FF2AA06B3C4D9D67E17FEFF1FC649C8E14C518EC3AEEBC797E5611F2C` |
| V4 supervisor source, `audit/c8_supervisor_capability_preflight_20261111_v4.py` | `08A6AB509952DC830002433B53892ED1E4B717B139611C45E5BF16E6FF6777AB` |
| V4 outer source, `audit/coordinator_c8_capability_run_20261111_v4.py` | `07426FC9A9D1A0E51A2E4BD69930027FCCC8C7DE6F0047739273BBD9A32A68E1` |
| V4 child source, `audit/c8_supervisor_benign_child_20261111_v4.py` | `B0E008A7344824D1651D5F86B8232171508CCCF6016CB4A74DEB32F4F97A455D` |
| Prior source investigation, `integration/C8_INTERPRETER_SOURCE_DIAGNOSIS_2026-11-11.md` | `BFFBCC6136F99EBB953E8622FC65C7746AA86A1989C9590584D8C419A82B26E2` |

The V4 supervisor at line 251 launches the pinned console `python.exe` using `CREATE_NO_WINDOW | CREATE_SUSPENDED` (`0x08000004`), without inherited standard handles. The outer at line 136 uses those flags plus extended startup information (`0x08080004`), with explicitly inherited NUL stdin and bounded stdout/stderr pipes. The prior interpreter investigation supports an ordinary CPython console frontend, not a venv redirector. Its older statement that no extra process image had been established applies to that earlier evidence, not to V4.

## What the primary documentation supports

Microsoft describes `CREATE_NO_WINDOW` as running a console application without a console window and without setting its console handle. It does not promise that no console-host process exists. `DETACHED_PROCESS` instead prevents inheritance of the parent's console; `CREATE_NEW_CONSOLE` is incompatible with it, and `CREATE_NO_WINDOW` is ignored when combined with it. Therefore use a replacement flag, not an accumulation of both. [Process Creation Flags](https://learn.microsoft.com/en-us/windows/win32/procthread/process-creation-flags).

Microsoft separately states that GUI processes begin unattached, and console processes created with `DETACHED_PROCESS` begin unattached. Either may subsequently call `AllocConsole`. This provides a documented reason to try detached startup while retaining the same interpreter; it is not a universal guarantee that the running application or a dependency will never allocate a console or create another process. [Creation of a Console](https://learn.microsoft.com/en-us/windows/console/creation-of-a-console).

Standard-stream redirection does not require an interactive console. `STARTF_USESTDHANDLES` selects the supplied handles; those handles must be inheritable and CreateProcess must use `bInheritHandles=TRUE`. [STARTUPINFOW](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/ns-processthreadsapi-startupinfow). The extended handle list restricts inheritance to explicitly listed real inheritable handles; pseudo handles are excluded. [UpdateProcThreadAttribute](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-updateprocthreadattribute). Missing standard handles can be NULL, whereas redirected handles can refer to ordinary files or pipes. [GetStdHandle](https://learn.microsoft.com/en-us/windows/console/getstdhandle).

These documented choices are compatible with preserving suspended creation, pre-resume job assignment, retained process/thread handles, and file-based fixture handshakes. No shell, process replacement, console-control event or new helper is required by the proposed arrangement.

## Ranked next design, subject to separate authorization

1. **Same pinned interpreter, detached at both creation boundaries.** Replace NO_WINDOW with DETACHED_PROCESS for the outer-created supervisor and the supervisor-created fixture. Retain suspended native creation and both existing job assignments before ResumeThread. Retain the outer's explicit NUL/pipe handles and handle allowlist. For the inner child, the smallest change leaves its explicit file-based log/ack protocol and no standard-stream dependency intact. If deterministic standard handles are required, supply NUL handles through a narrowly reviewed extended handle list; do not broaden inheritance to job or process handles. Explicit handles do not mean inheriting a console. Never fall back to AllocConsole/AttachConsole when a stream is absent.

   This is the preferred design because it changes startup policy without changing interpreter bytes or the child computation. A future version must specify the inner-stream choice exactly before review. It must retain all identity snapshots and strict count predicates: neither documentation nor current data establishes that detached startup will satisfy them on this host. The outer runner itself is already running; the proposal concerns its two managed launch boundaries, not an assumption that its own parent environment has changed.

2. **Pinned windowless Python frontend as an alternative.** A genuinely GUI-subsystem frontend has documented unattached startup, but selecting `pythonw.exe` changes the executable/source-binding input. It needs its own pin and source review. Python documents that standard streams can be `None` for GUI applications and pythonw; do not assume the supervisor's final print/hash seal survives unchanged. Preserve explicit redirected streams or deliberately specify an equivalent authenticated file channel before using this alternative. [Python standard streams](https://docs.python.org/3.14/library/sys.html#sys.__stdout__). No pythonw binary was examined or executed for this note.

Neither option justifies changing the singleton requirement. Calling FreeConsole after startup is not a repair for a lifetime-association predicate: an already recorded association is not erased. Excluding conhost from resource accounting, allowing a second process, or deleting observations would change the accepted contract rather than test the same one.

## Required evidence for any later acceptance

A separately reviewed and authorized version would still need the same one-attempt ownership, 30-second total deadline, 256-MiB conservative observer/child peak acceptance, 4-MiB aggregate retained-output cap, bounded cleanup, and unchanged fixture order and allocations. Retain raw accounting and complete bounded PID snapshots before rejection; a failed or incomplete identity query is not proof of absence. Keep original-handle telemetry and positive post-exit memory validation, rather than reopening a process by PID for memory evidence. Require normal process completion plus the bound receipt/console hashes; startup changes do not replace those gates.

The current conclusion is thus precise: V4 supplies positive evidence of an additional conhost-named inner-job member; NO_WINDOW never supplied a documented no-host guarantee; detached startup is the smallest source-supported next candidate. Its actual success, and the full capability result, remain unestablished. No new run is authorized by this report.
