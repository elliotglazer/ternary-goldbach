# Raw-head CPU replay protocol audit

Verdict: PASS at read-only source/protocol scope for the final file-handshake implementation and two pinned single-phase wrappers below. Compilation and successful validated measurements remain separate gates. No performance result or theorem-source correctness is established by this review.

## Correction of the preceding audit

The preceding audit, SHA256 `2A0F972F3A5FFA397D68807DAC0ED5E8B0B313873269F46A638AC49D38FC9313`, approved the abstract pipe-handshake ordering but missed Lean command stream isolation. Its operational transport PASS was too strong and is superseded here. The earlier predecessor was `F6B6C26D399AAFD992128263DCC37569F6B4B8D2281C40072660E6106CE63ACF`. This same-file update was explicitly requested by the coordinator; it does not erase the failed attempt or turn its total-process CPU into a successful replay timing.

Installed Lean 4.35 `Lean/Elab/Command.lean:494` runs the command action through `IO.FS.withIsolatedStreams`. Its implementation at `Init/System/IO.lean:1799` installs empty stdin and buffered stdout/stderr. Flushing that stdout does not publish the marker to the parent while the command is waiting. The original child read an empty acknowledgement and failed; only afterward did the captured START become visible.

The preserved `cpu_logs64_01` receipt has child exit 1, no COVER rows and no phase CPU values. Its 21.859375 seconds total process CPU is failed-attempt cost, not measured replay throughput. The failed run did fail closed. No accepted phase timing was lost or inferred.

| Evidence | SHA256 |
|---|---|
| installed `Lean/Elab/Command.lean` | `829047D7681916F3BB3D8688C05910051EADA45816E79E816A5E4C7646B12F1E` |
| installed `Init/System/IO.lean` | `409886EE25DD6EE5455DBB83269EDBEF98012DD22C5B6C45198B47514AEACA25` |
| `raw-head/cpu_logs64_01.log` | `8DECA85D26AEAA5AAF69848A05AC80A37569F6FCE39F8CE3238B6A5EDE5BDF45` |
| `raw-head/cpu_logs64_01.json` | `B8E2C7BF07AAD3EE3855ED13431054D96D892E8B9A38510AC04A7FEDBC87B7CB` |

## Final source binding and review method

Paths beginning `raw-head/` below are relative to `work/lean-pilots/`.

| File | SHA256 |
|---|---|
| `raw-head/RawReplay.lean` | `3C2BFF76BB762B21A5ED86D02946B4592D5741D843E46AA0A37734B57005E943` |
| `raw-head/run_replay.py` | `AEA4F1DB24BC2298EE562332B3B106C92F70F04FE4A1119F1464AF3A4D6C745C` |
| `work/backend-costs-20261112/finite-lean/FiniteReplay.lean` | `6F9BC9ECB3CB1000F975B30DB43174D6C2D2A3859B4699857C50AF9E389319C0` |
| `raw-head/CpuRawLogs64.lean` | `033872EE0509050E13A95911D06E56C015762858403DFED15D146CDA577C08AC` |
| `raw-head/CpuRawInverseRoots64.lean` | `661595CA11540F221B4CD871073D6497D8AF3C978E9419E59D798D1A5A183E84` |

This re-review read the final source and the actual failed-run evidence. It parsed the final Python AST without importing or executing the runner, and evaluated only its validation expression on sixteen synthetic cases: one accepted valid case and fifteen rejected malformed cases. Nine fixed marker-set checks covered the exact four-file set and extra/missing files. These are expression checks, not filesystem race tests or an end-to-end execution. No build, child process, replay, certificate evaluation or benchmark was launched. Only this audit file was written.

## File-handshake ordering

The parent exclusively creates a fresh per-run directory, supplies its absolute path in `RAW_REPLAY_HANDSHAKE`, and launches the child with stdin disabled and stdout/stderr directed to the log. It no longer depends on observing elaborator output during execution.

After pool construction and one successful warmup, the child writes `START.label.temporary`, closes it, and renames it to `START.label.request`. It rejects an already existing request or acknowledgement. The parent validates the request name and exact content `ready\n`, samples child process CPU, then writes `go\n` to an exclusively created temporary acknowledgement and renames it to `.ack`. The child waits using two-millisecond sleeps and checks exact acknowledgement content before starting its loop. Thus the start CPU sample precedes the loop.

After all synchronous repeated checks and the elapsed end timestamp, the child publishes the analogous STOP request and waits again. The parent samples CPU before publishing its STOP acknowledgement. Thus all completed replay work precedes the end CPU sample, and result printing cannot occur before that sample. Atomic publication prevents the receiver from accepting a partially written marker. Ordinary closed-file visibility on the local filesystem is sufficient; crash-durable storage is not claimed.

The parent handles markers serially in its monitoring loop, validates START-before-STOP and duplicate phase state, and polls about every five milliseconds. A delayed poll can add waiting and polling overhead but cannot omit the synchronous replay work. The child's wait has no independent timeout: the parent enforces the overall 600-second cap and kills the child. This is a supervised protocol, not a claim that an orphaned child autonomously stops after parent failure.

The pinned labels contain only safe filename characters; the parent checks marker names. The Lean helper is not a general untrusted-label/path API. Fresh exclusive directories, frozen wrappers and serialized operation are part of this scoped use. No adversarial filesystem writer or authentication claim is assumed.

## CPU meaning and overhead

`GetProcessTimes` supplies child-process kernel plus user counters, summed in seconds from FILETIME units. The phase delta includes child CPU across its threads. It is direct process CPU, not elapsed time renamed as busy-core work. Parent Python polling, hashing and marker-writing CPU is excluded.

The delta includes child acknowledgement reading/return, timestamp and loop bookkeeping, STOP-file creation, and filesystem existence polling until the end sample. Any concurrent child runtime work is also included. Sleeping mostly increases elapsed time, but polling and file operations still consume CPU. No overhead bound, subtraction or negligible-overhead assumption is established. Effective counter granularity matters for short phases.

The child elapsed timestamps surround only the repeated check loop, whereas the CPU bracket is wider. Their ratio need not be one, and neither equals pure kernel CPU. Whole-process CPU includes imports, pool generation, warmup, result handling and other work outside the phase.

## Acceptance and failure handling

A valid receipt requires nonempty COVER rows, no handshake errors or policy stop, zero child exit, unchanged wrapper and local dependency snapshots, unique variants, exact equality of START/STOP/COVER label sets, positive repetitions/declaration counts, present nonnegative CPU deltas, and exactly `LIMITS,trust=0,heartbeats=0,recdepth=65536`.

The final revision also compares the entire final directory inventory with exactly START and STOP request/ack files for the COVER variants, and checks every file's exact content. Leftover temporary files, unknown files, extra requests arriving near exit, missing markers and malformed acknowledgement contents cannot produce a valid receipt. This closes the final-inventory gap in the intermediate file transport. A marker parsing/CPU API error records a failure and kills the child. An exception while reading final evidence may prevent a JSON receipt; it does not constitute acceptance.

Consumers must require successful runner status and `protocol_valid=true`, not just a zero child exit, JSON existence or an old `.olean`. The implementation uses Python assertions for several checks, including API success, so it must run without optimization that removes assertions. No untrusted free-form log stream is authenticated: pinned source and wrapper binding still establish the workload.

Local snapshot construction recursively follows the current plain import syntax under raw-head and finite-lean, recording local sources, imported objects and the runner before launch and after completion. Missing imported objects fail before launch. The wrapper output object is intentionally excluded. Equal snapshots detect accidental mutation; they do not prove each object was built from the adjacent source, defeat mutate-and-restore behavior, or cover all external libraries. Matching build receipts, frozen inputs and external toolchain/library provenance remain required. The scanner is sufficient for the pinned imports, not a general Lean parser.

## Strict replay and imported boundary

`RawReplay.measure` requires trust zero, positive repetitions and a root under the selected prefix. `FiniteReplay.collect` traverses theorem constants in both types and values under that prefix. `pool` renames all selected theorem names and references to fresh `FiniteTrial` names and rejects any leftover original-prefix reference. `checkBundle` adds every renamed declaration through `Kernel.Environment.addDeclCore`, throwing on rejection. Each repetition starts from the same imported base, rather than reusing declarations checked by an earlier repetition.

Original certificate theorems still exist in the imported environment, but the replayed expressions cannot directly call the removed prefix. Generic lemmas, datatypes, literal data definitions and other namespaces remain imported. A concrete proof hidden in another namespace or definition would require a separate semantic dependency audit; the prefix check is not a complete transitive theorem-source audit. The logged width is caller metadata and must be bound separately to the actual source theorem.

The two wrappers select `RawLogCases64.all_logs` with 50 repetitions and `RawLogCases64.all_inverse_roots` with 1000, both prefix `RawLogCases64.`, width 64. Each has one replay command and exactly the expected options. The older elapsed-only wrappers are unused by this transport and cannot have their timings relabelled as phase CPU.

## Repetitions, limits and conclusion

One successful run performs one untimed warmup and r measured fresh-base kernel checks. Phase CPU is total over r, not already divided by r. There is no automatic retry. Logs and receipts are exclusively created under run labels, and the handshake directory is likewise new. Failed attempts and any new-label retries remain separate cost records; no success frequency or amortization is assumed.

The command uses stock Lean `-t0 -j1 -M4096`. Wrappers explicitly set unlimited heartbeats and recursion depth 65536; these are not default-limit timings. The parent has a 600-second wall cap and sampled 4-GiB private-memory cap. Sampling cannot guarantee that no transient memory excess occurred. No dependency build is invoked by this runner.

The final file transport is compatible with the inspected elaborator context and supports the stated CPU bracket, subject to successful compilation and validated runs. This verdict does not independently establish the mathematical source of the theorem, complete concrete coverage, imported-library soundness, first proof-construction cost, throughput, a speedup, or any full raw-head performance forecast.
