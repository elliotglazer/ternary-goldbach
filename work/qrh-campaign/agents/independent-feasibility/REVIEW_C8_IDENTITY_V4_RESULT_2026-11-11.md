# Independent review of the C8 V4 identity result

Verdict: **saved evidence checks pass; the capability attempt remains FAIL.** V4 supplies positive identity evidence beyond V3: the normal script identifies the same instance as its original creation handle, while a later handle query for another listed PID reports `C:\Windows\System32\conhost.exe` and membership in the explicit inner job. This does not establish complete historical process coverage or retrospectively identify V3's processes.

## Frozen evidence

Paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `audit/coordinator_c8_capability_20261111_v4.json` | `4864924FF2AA06B3C4D9D67E17FEFF1FC649C8E14C518EC3AEEBC797E5611F2C` |
| `audit/c8_benign_attempt_20261111_v4/completion.json` | `B22FBDCDAFC7BCF837CEDC478FC7296BF59111E62F5A6AB2257EB25C8BEB3E45` |
| `audit/coordinator_c8_capability_authorization_20261111_v4.json` | `EF123EB21A68E262A5C62DA9889B41D69DFB62D1AE1DFC5DB4DFF54DD7666509` |
| `audit/coordinator_c8_capability_observed_result_20261111_v4.json` | `E6B1332CA7AB5F3D97DC2578C21B237A3550141A6F62DB54FEF338F0C05B1AF2` |
| `audit/c8_benign_attempt_20261111_v4/normal.jsonl` | `F37CDCB353FCA10CE948F122D30EE1341F8BCAA3FED8CEBB043EE11AEDD9DCF8` |
| Independent receipt `independent-feasibility/c8_identity_v4_saved_data_audit_20261111.json` | `0C03FD3317389A02F552D36CB4B7C65153E205E459CD3F9826A712544F042F14` |

I verified the source/manifest/static-review bindings, copied manifest, inner file inventory, console hashes and normal log. The exact source pins remain those in the accepted V4 static review `76FEAAC3…752C599B`. The independent computation reads saved bytes only; it imports no evaluator, calls no Windows API and performs no fixture rerun.

## Raw decoding and identity

All six class-1 accounting buffers independently decode as four little-endian signed 64-bit fields followed by four unsigned 32-bit fields. All field values, offsets, sizes, success flags and 48-byte returned lengths agree with the receipts. The inner sequence is fresh `(0,0,0)`, assigned `(1,1,0)`, and baseline `(2,2,0)` for `(TotalProcesses,ActiveProcesses,TotalTerminatedProcesses)`. There is no inner post-exit accounting snapshot. Outer values are `(0,0,0)`, `(1,1,0)`, `(4,0,0)`.

The class-3 raw buffer independently decodes as two DWORD counts followed by eight 64-bit PID slots. Assigned and listed counts both equal 2; returned length is 24 bytes, inside the allocated 72 bytes. The returned entries are exactly `[30892,29984]`; unused allocated slots are zero. Thus the retained `complete=true` is justified. `valid=false` is also correct: the acceptance rule requires the singleton original PID, not merely complete enumeration.

The child self record, pre-resume original-handle record and repeated original-handle query agree on:

- PID `30892`;
- creation FILETIME `134389003674607903`;
- native image spelling `C:\Users\glaze\AppData\Local\Python\pythoncore-3.14-64\python.exe`.

Their success/completeness flags and image lengths agree. The child current-module spelling matches its queried image. The supervisor startup record similarly matches its original creation handle at PID `41472`, creation FILETIME `134389003670930997`, with the same Python path. Source hashes and nonce bind these self reports to this attempt under the reviewed benign-source assumptions.

The second entry records a successful later open of PID `29984`, creation FILETIME `134389003674807365`, image spelling `C:\Windows\System32\conhost.exe`, and successful membership in the explicitly supplied inner job. This is positive evidence of a distinct member instance when queried. It is expressly labeled `later_opened_candidate_only`: the PID-list query and later open are not atomic, so this does not prove uninterrupted identity between those observations. A path string is not verification of loaded file bytes or a signature. Neither parentage nor the complete explanation of outer total 4 is recorded.

## Failure, stage coverage and cleanup

The exact first inner error is `RuntimeError: handshake_baseline_pid_identity_valid`. Before rejection it retained `child_self_matches_original=true`, `original_identity_valid=true` and successful baseline accounting. This is failure of the singleton PID rule, not failed self-identification or truncated enumeration. The outer first error is supervisor exit 1; its separately recorded total-equals-three predicate is also false, while limit-terminations-zero is true.

Only the baseline line exists in the normal log. It exactly matches the retained handshake row, nonce, source hash and self-identity record. No baseline acknowledgement was written. Under the pinned child source, allocation follows that acknowledgement; therefore the held, released and finished allocation stages were not reached. No timeout fixture ran. The receipt contains neither a child post-exit memory result nor a normal exit-code query, and the final conservative child-peak list is empty. The final observer-only peak is not a substitute for either missing measurement.

The retained cleanup wait state is zero, consistent with the source's successful original-handle wait during failure cleanup; it does not signify normal completion of the fixture. The outer record observes supervisor exit 1, reports a successful job-termination request and records no remaining associated descendants. These checks do not transform the failed fixture into a successful capability test.

## Time, output and limits

The coordinator observation records tool chunk `1a2c3a`, exit 1 and wall time 1.3188213 seconds. The program's separate outer launch-to-observed-exit interval is 636,242,400 ns. These are different timing scopes, not conflicting measurements or evaluator benchmarks.

I independently verified all nine entries in the coordinator inventory. They total 20,159 bytes; its own 7,000-byte observation record gives 27,159 bytes. Adding the reserved 65,536 bytes gives **92,695 bytes**, below 4 MiB. The inner console's narrower 13,200-byte manifest-plus-attempt subtotal also matches exactly. No recorded time/output breach explains this failure.

V4 narrows the next research question to the additional observed member and the launch/job/console behavior that produces it. It does not justify ignoring that member, increasing expected totals to fit the data, assuming V2/V3 had the same identities, or excluding its resources from a future full-coverage claim. Any proposed launch change or revised resource contract needs its own source justification and review. No further diagnostic or numerical execution is authorized by this result review. All three attempted capability versions remain FAIL.
