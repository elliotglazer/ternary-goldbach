# Independent static review of C8 detached-startup V5

Verdict: **PASS for the bounded source preparation.** The exact changes are the two requested startup flags, versioned bindings and the outer source's new inner-source hash. No execution, process query or target import was performed. This review does not predict success, authorize a run, or change V2/V3/V4's failed status.

## Frozen inputs

Paths below are relative to `work/qrh-campaign/agents/`.

| File | SHA256 |
|---|---|
| `audit/c8_supervisor_capability_preflight_20261111_v5.py` | `882762361FC9E3AE2AF876CB604E6EA8CCDA2E6C2251872DD79B2593F0953A85` |
| `audit/coordinator_c8_capability_run_20261111_v5.py` | `00B5503D4C6E1B085A5B417AD432F985DFC60A4ADEEE318F133FB8DC437D2EA9` |
| `audit/C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V5_2026-11-11.md` | `BCA052F8F4533927679F5CC1C20944781D2C0A419DFF2C9AE08353C3B31301A4` |
| `audit/c8_supervisor_capability_preparation_20261111_v5.json` | `D0C76A0413A2FE76CB5CB1A79886AF8FBBE36D0AFD1DAF2B26E83BA4BF219CCF` |
| Unchanged `audit/c8_supervisor_benign_child_20261111_v4.py` | `B0E008A7344824D1651D5F86B8232171508CCCF6016CB4A74DEB32F4F97A455D` |

Independent source/AST receipt: `independent-feasibility/c8_detached_v5_static_review_20261111.json`, SHA256 `1456AAB7C8C1FBB33D17EF80F7DF51245CAEFF4D7A3B98732090114E2A99D24D`. It verifies these pins, the frozen V4 source/spec pins, exact text transformations, syntax, both launch-call argument lists and absence of the V5 manifest/outer outputs.

I read the complete new specification and code diffs. The unchanged mechanisms retain the V4 static review `76FEAAC3…752C599B`. I also read the independently reviewed console-host diagnosis: `zero-sum/REVIEW_C8_V4_CONSOLE_HOST_DIAGNOSIS_2026-11-11.md`, SHA256 `D6307EDD6ABBEC16C39FA418B2EE1C59E768A8448B8CBC9329405FDB3887E13C`. That paper review establishes the documented startup-policy distinction, not the outcome of this proposed run.

## Exact change and preserved behavior

The inner call changes `0x08000004` to `0x0000000C`: CREATE_SUSPENDED and DETACHED_PROCESS, with CREATE_NO_WINDOW removed. The outer changes `0x08080004` to `0x0008000C`, additionally retaining EXTENDED_STARTUPINFO_PRESENT. Neither call introduces CREATE_NEW_CONSOLE or breakaway. There remains exactly one CreateProcessW call in each source.

The inner call still passes `bInheritHandles=False`; its STARTUPINFO has no new standard-handle configuration. The unchanged child communicates through its explicitly opened files and acknowledgements. No console allocation, attachment, fallback launch or stream-repair path was added.

The outer retains `bInheritHandles=True`, STARTF_USESTDHANDLES, NUL input, bounded output/error pipes, and the exact handle allowlist. Only those intended stream handles are inherited; job and process handles are not added. Missing or broken supervisor output remains failure. Detached startup does not justify assuming the final JSON will arrive.

The full-text comparison verifies that identity/PID observations, raw evidence ordering, singleton checks, lifetime counts, memory validation, timers, output limits, marker reservation and cleanup code are otherwise unchanged. Suspended creation, job assignment before resume, original-handle waits/termination and bounded descendant cleanup remain. Normal/timeout/invalid-handle fixtures and their allocations are unchanged because the child is the same frozen V4 file.

## Acceptance and limits

The specification incorporates the exact V4 contract with explicit V5 substitutions. It does not exempt conhost, replace expected totals with observed values, drop timeout coverage, substitute live samples for post-exit memory, or remove incomplete-data rejection. The 30-second, 256-MiB conservative peak and 4-MiB aggregate-output limits remain. A separately bound future attempt must still satisfy every condition.

The V5 schema/token, manifest path and output prefix differ from V4. The outer pins the new inner source; the later manifest must bind the exact outer source, specification, executable, child and accepted review. No such manifest existed at this review. Prior output directories and markers cannot be reused by this source preparation.

The documented purpose of DETACHED_PROCESS supports changing initial console attachment. It is not a guarantee that the interpreter or environment cannot later create a console or another process. Nor does it explain the exact historical mechanism behind V4's additional observed member. Any new failure remains failure; there is no automatic alternate launch or retry.

All checks here were source reads, hashes, AST inspection and compile-on-text syntax checks. There were no Windows API calls, executable probes, fixture runs or mathematical evaluations. A coordinator must separately decide whether to authorize one bounded V5 diagnostic. No complete supervision capability, numerical result or Lean theorem follows from this static verdict.
