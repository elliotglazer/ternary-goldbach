# Independent review of the completed C8 detached V5 capability test

Verdict: **PASS for the one fixed benign capability test.** The complete saved evidence satisfies the unchanged normal, timeout, identity, accounting, telemetry and completion conditions. This is a bounded host/launch-protocol observation, conditional on the reviewed code and native API semantics. It is not a numerical-evaluator run, a universal API guarantee, or authorization for a subsequent run.

## Frozen evidence and method

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `audit/coordinator_c8_capability_20261111_v5.json` | `9B6F43898F34A97B974767FB1602F7F71B3DFCDEDC2DADE75B44E3694439416A` |
| `audit/c8_benign_attempt_20261111_v5/completion.json` | `86EA85EEE007381124664995342E86896E64C5378C1835E054E7129284858CA5` |
| `audit/coordinator_c8_capability_authorization_20261111_v5.json` | `9B09FE9BC15B3783F6CFFCB595D71097ECC3B5A9282745B87DA040ECBC313DE2` |
| `audit/coordinator_c8_capability_observed_result_20261111_v5.json` | `CDF1E06C9DEC5324CABCA91929162FC9DCA7B3926F3BF2F33BA674B712CDC407` |
| Independent receipt `independent-feasibility/c8_detached_v5_saved_data_audit_20261111.json` | `04B04A7C6455BB3A404E8343B7DAE974315F9A18EAA5D5562A8D20D42CEB9F2F` |

I independently parsed the saved JSON with duplicate-key rejection; decoded every raw accounting/PID buffer; checked all named predicates, identities, logs, acknowledgements, memory values, elapsed intervals and final seals; and verified the inventory hashes. The current executable/source/spec bytes match the manifest, including the unchanged V4 child. The manifest binds the accepted static V5 review `E810BC4F…FEAECD1D`. No source module was imported, process queried, fixture rerun, or numerical function evaluated.

The coordinator observation retains its historical `PROGRAM_PASS_PENDING_INDEPENDENT_RESULT_REVIEW` status. This separate review completes that gate without editing the observation.

## Coverage, identities and accounting

The completion contains exactly two ordered successful cases, normal then timeout. Every expected named predicate is present and true. The invalid-NULL-handle control reports native failure, error 6, and rejection; no particular error number was required by the protocol.

All **11** class-1 buffers decode exactly under the 48-byte layout: four little-endian signed 64-bit fields followed by four unsigned 32-bit fields. Returned lengths, field offsets, success indicators and decoded records agree. Each child job progresses through total-process counts 0, 1, 1 at fresh, assigned, and post-exit stages, with zero limit terminations. Both normal-handshake accounting observations report one process. The outer job reports 0, 1, 3 with zero limit terminations. Final active counts are zero. Reuse of a numeric job-handle value between the sequential cases is not treated as identity of their job objects.

Both normal PID snapshots are complete successful queries: a 72-byte allocated buffer, 16 returned bytes, assigned/listed counts 1, and sole PID 6536. Independent decoding agrees with the saved entries and the singleton rule. Each entry uses the retained original handle, confirms explicit-job membership, and matches PID, creation FILETIME and native image spelling. No later-opened candidate is needed in this run.

The normal self record agrees with the original handle at PID **6536**, creation FILETIME **134389005451255486**. The supervisor startup record agrees with its original handle at PID **18756**, creation FILETIME **134389005448272064**. The timeout original handle is PID **38344**, creation FILETIME **134389005454635726**. Successful process-time records agree with these original identities. Native Python image paths and self module paths agree; this remains separate from the manifest's file-byte hash checks.

## Fixtures and post-exit measurements

The normal raw log contains exactly baseline, held, released and finished. Both acknowledgements equal the manifest token. All source hashes/tokens match, the held allocation is 16 MiB, the late allocation is 32 MiB, and the final prefix hash equals the exact preceding log bytes. The normal exit code is zero and the recorded outcome is NORMAL_EXIT.

The timeout raw log contains exactly idle. Its recorded outcome is EXPECTED_TIMEOUT, with original-handle exit code **51441 = 0xC8F1**. The source's timeout-control predicate is true. The launch-to-observed-exit interval is approximately 1.009 seconds, consistent with deadline-triggered termination followed by an observed wait; it is not a claim of instantaneous termination at exactly one second.

| Case | Largest saved live peak | Successful post-exit peak | Post-exit current working set |
|---|---:|---:|---:|
| Normal | 35,516,416 | 52,293,632 | 32,768 |
| Timeout | 17,092,608 | 17,092,608 | 32,768 |

All saved memory queries satisfy positivity, current-set/peak ordering and their recorded monotonic-peak requirements. Each saved child/observer live pair satisfies the current-set sum and cumulative-peak sum limits. The normal final peak exceeds the saved live maximum by exactly **16,777,216 bytes**. This demonstrates why replacing the final query with sampled peaks would have lost information in this run.

The final observer query, after receipt serialization, reports peak **25,337,856 bytes**. Recomputing its sums with the two child post-exit peaks gives **77,631,488** and **42,430,464 bytes**, both below 268,435,456. The later observer value also dominates the earlier post-exit observer values, so the first child's final sum is rechecked against later observer growth.

These are cumulative individual-peak sums under the API's semantics, not an atomic simultaneous tree-peak measurement. The observer was alive at its final query; this is not post-exit telemetry for that observer or coverage of unobserved later shutdown. The test's process restriction is supported by its complete required counts and snapshots, but it is not an independently instrumented history of every host process.

## Time, output, cleanup and completion

The normal launch-to-exit interval is **296,327,500 ns** and case total **330,456,300 ns**. Timeout launch-to-exit is **1,008,584,100 ns** and case total **1,044,547,700 ns**. Normal exit precedes timeout launch. Both original handles have observed exits and cleanup wait state zero.

The inner final console elapsed value is **1,634,948,800 ns**. Outer launch-to-observed-supervisor-exit is **1,717,314,200 ns**, and elapsed through outer finalization is **1,757,209,100 ns**. The coordinator separately records tool chunk `022fd8`, outer exit zero and tool wall time **2.3537338 seconds**. These distinct scopes are all below the 30-second acceptance limit. Normal and timeout/cleanup case conditions also hold.

The outer reports no need for a failure-termination request and no remaining associated descendants. It verifies a single final JSON line, empty stderr, the inner receipt hash, source and manifest bindings, expected case coverage, successful exit and final peak sums. Those values independently match the retained bytes; this review does not rely only on the string PASS.

All **12** coordinator inventory entries match their hashes and lengths. Their subtotal is **31,954 bytes**; the **5,611-byte** coordinator observation raises the known total to **37,565 bytes**. With the reserved **65,536 bytes**, accounting totals **103,101 bytes**, below 4 MiB. The inner console's narrower manifest-plus-attempt subtotal independently matches **24,457 bytes**.

## What this resolves

For the exact pinned interpreter, detached launch arrangement and fixed benign fixtures, the required normal/timeout post-exit queries, singleton/accounting checks, identity bindings and final completion protocol all passed once. The V5 capability gate may be accepted at that scope.

Earlier failed versions remain failed. This result does not retrospectively identify their processes or prove detached startup will always prevent auxiliary processes. A real numerical evaluator still needs its own reviewed supervisor integration, exact source/manifest binding, separate execution authorization, and complete per-run time/output/memory and mathematical acceptance checks. No production runtime estimate, numerical certificate, spectral coverage or Lean proof follows from this capability test.
