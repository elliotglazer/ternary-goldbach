# C8 benign capability preflight V5: detached startup

2026-11-11. **Source preparation only. No target module import, Windows API query, fixture launch, new runtime manifest, numerical evaluation or Lean build.** V4 remains FAIL. This version is not a capability result and permits no retry by itself.

## Scope and governing contract

V5 preserves the complete V4 fixture, native identity, containment, output, cleanup and acceptance contract, with only the explicit substitutions below. The governing V4 specification is `C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V4_2026-11-11.md`, SHA256 `0EAFC886790B7AF8B6C7DB0C7098343269EC5B4979AE07C92644494553446209`. Its historical preparation statements refer to V4's preparation, not its subsequent failed run. If a V4 path/schema conflicts with this version's table, the V5 table applies; no acceptance predicate changes.

The source diagnosis is `C8_V4_CONSOLE_HOST_DIAGNOSIS_2026-11-11.md`, SHA256 `C6F4480EE44A8E970E1B81E1B3EF5C5E624EF2611B91F765BBACE2A45B51A78B`. Parent selected detached startup subject to its independent review. That review and a new V5 code review must be accepted before a separate execution decision. Detached startup has not been demonstrated to remove all additional job members; every singleton and lifetime-count requirement remains mandatory.

Microsoft documents initially unattached console processes with [DETACHED_PROCESS](https://learn.microsoft.com/en-us/windows/console/creation-of-a-console). [Creation flags](https://learn.microsoft.com/en-us/windows/win32/procthread/process-creation-flags) distinguish it from CREATE_NO_WINDOW and permit later console allocation by the application. This packet changes startup policy, not the interpretation of a failed count.

## Exact source substitutions

| Input/output role | V5 selection |
|---|---|
| Inner source | `c8_supervisor_capability_preflight_20261111_v5.py` |
| Outer source | `coordinator_c8_capability_run_20261111_v5.py` |
| Child, unchanged | `c8_supervisor_benign_child_20261111_v4.py` |
| Specification | This file |
| Runtime manifest, not created | `coordinator_c8_capability_authorization_20261111_v5.json` |
| Outer output prefix | `coordinator_c8_capability_20261111_v5` |
| Manifest schema | `c8-benign-preflight-v5` |
| Exact authorization token | `RUN_ONE_C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V5` |
| Inner completion schema | `c8-benign-completion-v5` |
| Outer completion schema | `coordinator-c8-capability-v5` |

The manifest has the same exact key set and validation as V4, with these substituted values and fresh exact source/spec/review hashes. The attempt name retains the existing bounded syntax and must designate a nonexistent exclusively owned directory; existing directories, including all earlier attempts, are rejected. Outer files must also be absent. No manifest or attempt directory is created in preparation.

The inner CreateProcessW flags change from `0x08000004` to `0x0000000C`: CREATE_SUSPENDED plus DETACHED_PROCESS. `bInheritHandles=False` remains exact; STARTUPINFO gains no standard handles. The child continues to communicate only through the same explicit file log/ack protocol. No console allocation/attachment or stream-repair fallback is introduced.

The outer CreateProcessW flags change from `0x08080004` to `0x0008000C`: those two flags plus EXTENDED_STARTUPINFO_PRESENT. Its STARTF_USESTDHANDLES, explicit inherited NUL stdin and bounded stdout/stderr pipes, handle allowlist and `bInheritHandles=True` remain byte-for-byte unchanged. Job/process handles remain outside that allowlist. The supervisor's final console JSON must still arrive through the existing pipe; absent or invalid output fails. The original process/thread handles still supply identity, wait, termination and memory evidence. No shell or alternate frontend is selected.

Other source changes are only versioned paths/schema/token literals and the outer's literal hash of the new inner source. The preparation receipt asserts exact full-text derivation from pinned V4 sources, not merely matching these descriptions. The V4 child source is reused without editing or copying it to a misleading new version.

## Unchanged mandatory gates

The same pinned base interpreter is used: `C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe`, SHA256 `4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9`, with `-I -S`. Child SHA256 remains `B0E008A7344824D1651D5F86B8232171508CCCF6016CB4A74DEB32F4F97A455D`.

The NULL-handle negative control, normal baseline/held/released/finished sequence, 16-MiB held allocation followed by 32-MiB late allocation, exact prefix hash, and one-second timeout fixture remain unchanged. No retries, alternate fixtures, tuning or child grandchildren are introduced. Identity at startup/baseline, complete bounded PID lists, later-candidate caveats, and raw accounting persistence all remain. Inner total processes must equal one with zero limit terminations; successful outer total must equal three with zero limit terminations. A complete handshake list must contain exactly the original child. Conhost receives no exemption.

Inner one-process and outer two-active-process jobs retain kill-on-close, no breakaway, suspended assignment before resume and existing failure cleanup. The total acceptance deadline remains 30 seconds, including both sequential children and finalization, with external launch-to-observed-exit enforcement. The normal case remains 15 seconds, timeout one second, cleanup at most two seconds. No claim of instantaneous hard physical prevention is added.

Observed current-working-set pairs and conservative individual cumulative-peak sums remain bounded by 256 MiB. These are not atomic simultaneous tree measurements. Original-handle post-exit child memory must succeed and remain positive/consistent; final observer evidence covers only through its last query. No sampled maximum, commit counter or guessed peak substitutes for the required query. Aggregate retained output remains 4 MiB including the manifest, logs, completion and outer captures/record. All existing bounded reads, record limits, reserves and failure accounting remain.

Raw observations are persisted before semantic rejection where V4 does so; checkpoints remain conditional on successful writes and are not crash-atomic. Failed or truncated evidence does not mean absence. A PASS-shaped receipt alone is insufficient: the final hash-bound console, observed expected exits, timing/resource checks and complete outer seal are still necessary.

## Preparation receipt and later review

`c8_supervisor_capability_preparation_20261111_v5.json` records source hashes, AST parsing and compile-on-text syntax checks without importing/executing any target file. It checks the new sources against exact transformations of pinned V4 bytes/text and verifies unchanged child/V4 source/spec hashes. It also records absence of the new runtime manifest and outer output files. These static results are not evidence about OS process behavior.

Preparation does not supply a runtime manifest or authorize a process launch. Independent static review of the frozen V5 sources, acceptance of the diagnosis review, and a separate parent execution decision remain required. All prior versions and failed attempt artifacts are preserved.
