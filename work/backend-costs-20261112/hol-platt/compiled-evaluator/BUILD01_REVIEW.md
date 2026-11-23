# compiled01 build receipt review

2026-11-13. Read-only review of the recorded build, plus a new strict receipt checker. No HOL/SML process, build or benchmark was run by this reviewer. **The source bindings pass, but the produced launcher has an unresolved loading dependency. Do not interpret exit0 as an SML typecheck or begin the smoke run unchanged.**

## What the build actually did

`compiled01_build.time` records exit0, 0.96 user plus 2.78 system CPU seconds, 38.77 seconds elapsed and 25,304 KiB maximum RSS. The command is the expected `timeout 600 .../Holmake --no_prereqs compiled_dependent.exe`. The build log contains directory scanning only, no semantic/workload/timing markers.

The output `compiled_dependent.exe` is a shell script invoking the stock `hol --gcthreads=1 run --holstate=.../hol.state compiled_dependent`. Its SHA256 is `33B6A809D004869B00D4890137645F7874FA6E257216322A95234E819CB459B8`. It is not a native binary containing compiled candidate functions. Its `.uo` files are text containing dependency module paths and a final `.sml` path; `.ui` files are empty. There is no generated `DependentBlockResultsTheory.dat` in this attempt.

This is consistent with the actual local `tools/Holmake/poly/BuildCommand.sml`, SML branch around lines193–213: it writes the dependency list and source filename into the `.uo`, then creates an empty `.ui` where appropriate. No evaluator invocation occurs in that branch. The evidence supports launcher/load-recipe preparation, with no hidden numerical workload executed by this build. It does not establish that subsequent SML compilation will succeed.

## Binding checks and blocker

The new read-only checker rehashed every recorded item and matched every exact postcheck line: 15 source entries, 6 dependency entries, 3 toolchain entries and 1 executable entry. The reviewed manifest and key source pins remain unchanged. These snapshots bind the named files; they are not a full transitive library audit.

The current load graph is incomplete:

* `.hol/objs/CompiledEvalChecks.uo` lists `CompiledEvalChecks`, `Arbnum`, `Overlay` and its source, but **not** `CompiledComputeBenchmark`.
* `.hol/objs/CompiledWorkload.uo` lists `CompiledEvalChecks`, `CompiledWorkload`, `CvBenchmarkConfig`, the stock libraries and its source, but **not** `CompiledComputeBenchmark`.
* No `.hol/objs/CompiledComputeBenchmark.uo` exists, although its `.sml.d` scan file does.
* Both callers use a bare alias declaration `structure C = CompiledComputeBenchmark`; the dependency scanner did not turn it into a required module edge. The local `Holdep_tokens.sml` handles qualified identifiers/open lists; the observed recipes establish the missing edge without needing to speculate about runtime behavior.

The smallest proposed source repair is a qualified reference before the alias in each caller:

```sml
val _ = CompiledComputeBenchmark.cv_zero;
structure C = CompiledComputeBenchmark;
```

This reads the existing immutable value and makes the dependency explicit to the scanner. It is not applied by this review. The author/root should review and repin the two sources and manifest, preserve `compiled01`, and rebuild local recipes under a fresh label. Verify that the new recipes explicitly name the candidate module and that its `.uo` is present before executing the launcher. An explicit `open` could also expose the dependency but imports names unnecessarily. Do not change the installed scanner or treat a manual unrecorded preload as a completed repair.

## Strict result checker prepared

`audit_compiled_results.py` reads files only. It requires the frozen manifest, all source/support pins, recorded snapshots and exact successful postcheck lines. For each of the two process orders it checks successful exit, exact argv, exactly one semantic marker with count259, the ordered nine workload passes, ordered five corruption rejections, completion, exactly208 finite nonnegative timing rows with the expected unique labels, request/AST metadata, contiguous equation indices and exported stock-reference name presence.

This is a receipt-consistency checker, not an independent decoder/replay of theorem exports. It does not certify universal equivalence, arbitrary unrecorded process behavior, or every transitive library. A result review must still examine the logs and interpret the timings. In particular, the .exe hash binds a launcher, while the candidate functions are compiled from source at runtime.

The checker currently pins the pre-repair manifest and deliberately rejects a changed one. After the loading repair receives independent source review, update that pin as an explicit reviewed change; never silently accept the current file's hash. No result audit was attempted, since no smoke results yet exist. The checker source was loaded by Python solely to check the already completed build snapshots/exit; no SML was launched.

Pins:

* checker: `6B37BA204C06FA698448799F8313E86BCBFC2C661E4A45DE214E2ECAE3DDFC1D`
* build log: `CD046BDB2C2A805F6A277703A00DFC016BC3E6BF51A585387B26D4AA180A1583`
* build time: `5DC028F20315C022EE1E8E2F0515B641DB83C80BCB2B9EA25401851D3CBFDB3F`
* reviewed manifest: `941EEC202243605BDC3ABC69A96A892F1BD3AA07FE02EB7490590B63E428424F`

The source-only equivalence review remains valid at its stated scope. The concrete build has exposed a loading integration defect, not a counterexample to the closure translation. All speed and proof-authority conclusions remain open.
