# Independent review of the failed C8 V3 diagnostic

Verdict: **the saved evidence is internally consistent with FAIL.** V3 successfully retained the accounting data lost by V2. The inner total-process predicate is false, and the outer total-process predicate is also false. Neither the normal case nor the complete capability test receives PASS. No retry or API query was performed for this review.

## Evidence binding

Paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `audit/coordinator_c8_capability_20261111_v3.json` | `727E556E3EDCCD293CAD453087A9CADEB243351C0D28B267306966BAC574DF8C` |
| `audit/c8_benign_attempt_20261111_v3/completion.json` | `66268C3710419CE4FC20B5DB42D5B77150AB4EC8C0AA337BF05A8707B17C83C8` |
| `audit/coordinator_c8_capability_authorization_20261111_v3.json` | `75B92D613496C52029A35C373545E59320BA81532E48A5054E19281EF6CC5C07` |
| `audit/coordinator_c8_capability_20261111_v3.stdout` | `E02FA1FB555767B3A1724C960F5A25D663F0CE1E01424D9C1E9A17126C45BA92` |
| `audit/c8_benign_attempt_20261111_v3/normal.jsonl` | `C57938E8EE05032598600534CC4A392C3C70C82DA25C9DEC3BE3F15D614019CB` |
| Independent receipt `independent-feasibility/c8_diagnostic_v3_saved_data_audit_20261111.json` | `267CC0C8AECAC22E70ACEAAD9D5375251C5B37CF3241F45728A985B56AF25F6A` |

The independent replay parsed saved JSON with duplicate-key rejection, decoded all accounting bytes independently, and checked source, manifest, console, file-size, prefix and acknowledgement bindings. It did not import either evaluator or query Windows. Source pins remain those accepted by `REVIEW_C8_DIAGNOSTIC_V3_2026-11-11.md`, hash `D13EA2C67610B8429C67375EBC03A876538838B67A2A3D6448646A0D7574E075`: inner `4488B65F…337BA7C0`, outer `299953B9…5F9EAF32`, child `4DC12576…58241BE`.

The coordinator reports tool chunk `258852`, exit 1, wall time 1.4777509 seconds. That tool observation is supplied by the coordinator; the retained program records independently supply the shorter intervals below.

## Raw accounting and failure path

All six queries report native success, `decoded_valid=true`, returned length 48 and no failure error. I independently decoded each 48-byte buffer as four little-endian signed 64-bit fields followed by four unsigned 32-bit fields. Every decoded value equals the receipt. The offsets are 0, 8, 16, 24, 32, 36, 40 and 44; in particular, TotalProcesses is at 36, ActiveProcesses at 40, and TotalTerminatedProcesses at 44.

| Job / stage | TotalProcesses | ActiveProcesses | TotalTerminatedProcesses |
|---|---:|---:|---:|
| Inner normal, fresh | 0 | 0 | 0 |
| Inner normal, assigned before resume | 1 | 1 | 0 |
| Inner normal, after original-handle exit | 2 | 1 | 0 |
| Outer, fresh | 0 | 0 | 0 |
| Outer, assigned before resume | 1 | 1 | 0 |
| Outer, after supervisor exit | 4 | 0 | 0 |

The snapshot timestamps increase within each job. The inner post-exit snapshot follows its observed original-handle exit; the outer final snapshot follows supervisor exit. The exact inner first error is `RuntimeError: total_processes_equals_one`. Its retained predicate map records total-equals-one false, terminations-equal-zero true, expected normal exit true, timeout-control condition true for the normal case, and process-times-valid true. That normal-case timeout condition means no timeout request was expected; it does **not** mean the timeout fixture ran.

The outer first error is `RuntimeError: supervisor nonzero exit`. Before rejecting exit 1 it retained total-equals-three false and terminations-equal-zero true. The outer total predicate is a failed recorded condition, not its first thrown error.

These are actual retained counter observations, not guessed values reconstructed from control flow. They do not identify another process, establish a parent-child relationship, explain Windows accounting semantics in this environment, or establish that a particular additional process was alive at the snapshot. Known retained PIDs are the original normal handle's 2304 and supervisor's 18120. No identity for the unexplained count increments is recorded.

## Partial capability evidence

The normal fixture has four saved, correctly bound log records: baseline, held 16 MiB, released, and finished with late 32 MiB. Both acknowledgements equal the authorized token. The final prefix digest matches the preceding raw log bytes. These checks were performed independently here: the producer's count failure occurs before its later log-validation block, so a complete producer normal-case PASS must not be inferred from the log's existence.

The retained original-handle exit query succeeded with code zero. Its launch-to-observed-exit interval is 314,823,300 ns. The post-exit memory query succeeded with PeakWorkingSetSize 50,102,272 bytes and WorkingSetSize 32,768 bytes. The largest saved live peak was 33,325,056 bytes; the post-exit peak is exactly 16,777,216 bytes higher. Thus this attempt supplies positive evidence that the retained handle yielded a usable post-exit peak for this normal process, including a larger value than the live samples captured. It is not a universal post-exit API guarantee.

The post-exit observer peak is 24,666,112 bytes; the final console observer peak is 24,678,400. The final conservative sum for that observer and the retained child is 74,780,672 bytes, below 256 MiB. With the process-count discrepancy unresolved, this pairwise sum must not be promoted to complete process-tree memory coverage.

The invalid-NULL-handle control reports failure/error 6 and rejection. There is only one partial test record and no timeout log: the timeout fixture did not run. The outer observed supervisor exit 1 after 765,392,700 ns, requested job termination successfully, and recorded an empty remaining-associated-descendants list. This supports the reviewed cleanup path for this failed run; it supplies no missing timeout-case result.

The independently listed manifest, outer record/marker/streams and attempt files total 15,646 bytes. This is a specified-file subtotal, not a measurement of every coordinator/tool artifact. The inner console's 10,847-byte figure exactly matches its manifest-plus-attempt-files accounting. No timing or size observation changes the failed capability verdict.

## What remains necessary

The evidence-loss defect is resolved for this failure. The accounting interpretation is not. Before replacing the count guards, obtain a justified mapping from the relevant Windows job counters to the intended process restriction, or identity-bound lifecycle/membership evidence sufficient to explain these increments. A future diagnostic design could retain creation/assignment/exit identities and job membership, but designing or running it requires a separate decision. Merely changing expected totals to 2 and 4 would fit this sample without proving the intended restriction.

Full capability acceptance still needs the normal process restriction resolved, complete memory coverage for the accepted process set, and a separately authorized successful timeout fixture with its original-handle exit and final telemetry. This review supplies no new authorization, no repeat attempt, no mathematical computation, and no Lean proof. Both V2 attempt 01 and this V3 attempt remain FAIL.
