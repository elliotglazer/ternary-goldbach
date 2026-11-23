# Same-AST evaluator experiment: source handoff

2026-11-13. **Prepared and source-checked only. No SML compilation, HOL run, benchmark, or candidate theorem acceptance has occurred.** This extends `DESIGN.md` without changing its frozen prototype or any installed kernel file.

## Ready for root review

The new benchmark copy, `CompiledComputeBenchmark.sml`, preserves the pinned stock `exec`, primitives, parsers and original `term_compute`. It adds the same closure compiler as the earlier prototype plus `prepare_program`, which exposes the parsed code vector, request parser and value-to-term reconstruction function. This lets the harness time stages separately instead of charging them all to execution.

`CvBenchmarkConfig.sml` is copied from the actual pinned `cv_computeLib.sml` through the characteristic-equation definitions. It removes only the opaque structure boundary and replaces the theorem-producing cached entry point with a raw syntax configuration. It checks that the characteristic theorems have no hypotheses. The candidate parser performs the original characteristic-equation validation. Stock `cv_computeLib` remains the independent reference entry point.

The generated `compiled_dependent.sml` retains the original `dependent.sml` prefix through the definition of `acceptance`, including every scale/input/coefficient literal, every named definition, and the original `DependentBlockResults` theory name. It retains the four fixture declarations exactly, and the changed-data definitions and five corruption requests exactly. The new executable must therefore run **in this isolated directory**, where its own `.hol` output cannot overwrite the original theory artifacts. Do not run it in `hol4-setup` or point a later production `INCLUDES` path at this experiment.

The source-only checker verifies those claims by hashes and exact text comparison. It passed once using the existing Python interpreter; it did not parse or execute SML. Output:

```
4 pinned inputs; 3 generated outputs; 5 support sources
original interpreter/primitives/frontend preserved
original CV configuration preserved
4 exact positive fixture declarations
original changed data and 5 negative controls preserved
```

## Differential gates

`CompiledEvalChecks.sml` contains 259 planned assertions. A successful run must reach `COMPILED_SEMANTICS_PASS,259`. These include:

* Every expression constructor and all three unary/eight binary primitives, including a 5-value unary/binary input matrix with nested pairs.
* Explicit expected results for zero division/modulo, saturating subtraction, pair coercion, pair comparison, structural equality and projection of a nonpair.
* Empty/out-of-range environments, the stock negative-index behavior, and missing/negative function indices.
* Lazy zero/nonzero/pair conditions and an unused invalid call.
* Effect traces checking curried binary application before evaluation of the right operand, left-application exceptions, left-to-right argument evaluation, argument effects/errors before a missing-function error, and exactly-once `Let` evaluation.
* Bounded recursive sums, mutual parity recursion and nested compositions. No divergence test is passed by a timeout.

The test observer accepts only the explicitly expected HOL errors or test signals. An unexpected `Fail`, `Match`, `Subscript`, resource error or interruption is a failed/incomplete run. The suite tests operational behavior; it does not prove universal equivalence.

## Actual workload identity and checks

For each of the four original depths and five original corruption requests, `CompiledWorkload.run` uses the stock CV representation/discovery functions, applies `SPEC_ALL` exactly as `cv_computeLib.cv_compute` does, and rejects open code equations. It saves the actual ordered code-equation theorems and prints the actual CV request. It then constructs **one code vector and one request AST**, shared by the stock and compiled raw evaluators. Neither evaluator reparses a different request during timed execution.

Every returned raw value is compared by structural `cval` equality. Every reconstructed term is compared using `aconv`. An additional unchanged stock `cv_computeLib.cv_compute` call verifies the raw result against the actual kernel entry point and saves that stock theorem. The original high-level `check_true`/`check_false` functions independently validate the four positive propositions and five corruptions, including their original precondition handling. The candidate's raw result is never an input to a theorem constructor.

The exports are stock references and source equations. They are not proofs that the candidate implementation is universally correct, and no exported theorem is credited to the new evaluator. The stock entry point still has its original `Count.Compute` trusted boundary and imported theorem tags.

## Timing fields and interpretation

Each `COMPILED_TIME` row contains CPU seconds and wall seconds. The stages are separate:

| Field | Included work |
|---|---|
| `syntax_validation` | Original syntax/characteristic-equation validation; excludes fixture construction. |
| `discover` | Stock CV representation and code-equation discovery. |
| `parse_code`, `parse_request` | AST construction, without compiled closure construction. |
| `compile_code`, `compile_request` | Static closure construction and linkage only. |
| `stock_first_raw`, `compiled_first_raw` | First actual request execution after preparation. These are not cold-process measurements. |
| `stock_reconstruct`, `compiled_reconstruct` | `cv_to_term` on already computed equal values. |
| `stock_raw:rN`, `compiled_raw:rN` | Three retained raw executions per implementation. |
| `stock_total:rN`, `compiled_total:rN` | Three retained raw executions plus reconstruction; overlap the above categories conceptually and must not be summed as disjoint costs. |
| `fresh_compile_execute` | Fresh code/request closure construction plus execution on the already parsed same AST. Excludes parsing, data translation and reconstruction. |
| `stock_kernel_reference` | Original kernel conversion, outside candidate timings. |

The original fixture construction, named-data translation and high-level stock checks retain their `HOL4_TIME` rows. Process totals include these, semantic gates, logging, references and exports. Raw timing excludes comparison checks, printing and source-theorem recording. No synthetic tight inner loop or new numerical payload replaces the dependent workload.

`COMPILED_ORDER=stock-first` and `compiled-first` reverse paired execution and reconstruction order. The full runner uses three fresh processes per order, reversing which process order starts the second pair. There are three warm samples per request within each process. Retain every sample and report negative or zero improvement. Fresh-compilation timings and retained timings answer different questions; do not subtract the same setup savings twice or apply a raw evaluator ratio to the whole campaign.

## Commands for the root after review

The existing Linux execution environment and cached project theories are required. The runner mirrors the already reviewed prepared-eval runner: one process at a time, `Holmake --no_prereqs`, no dependency build, 4 GiB virtual-address cap, and a 600-second timeout per build/run. This is a virtual-memory cap, not a private-commit or RSS cap. `/usr/bin/time -v` records process CPU, elapsed time and peak RSS.

From this directory, through the existing Linux environment:

```
sh run_compiled.sh compiled01 build
sh run_compiled.sh compiled02 smoke
```

`build` only requests the local executable; source-loading/initialization behavior belongs to the existing HOL toolchain, so the build log must still be inspected. `smoke` runs one fresh process per order. Use a fresh label for each attempt; the runner refuses to overwrite log/receipt paths. `full` is optional only if the semantic gates pass and more timing evidence is warranted.

The runner records source, dependency, toolchain and executable hashes and verifies them afterward. It requires all four workload and five corruption pass markers plus overall completion; the reviewer must also verify the exact semantic count of 259. Failed build/run artifacts remain in place. There is no cleanup, automatic retry, permissive fallback, or dependency recompilation. Existing `.uo` dependencies and the installed kernel are never edited by these sources.

## Pins and unresolved checks

| File | SHA256 |
|---|---|
| `harness_source_binding.json` | `941EEC202243605BDC3ABC69A96A892F1BD3AA07FE02EB7490590B63E428424F` |
| `CompiledComputeBenchmark.sml` | `BCCAC8C9D9662A5F45366DBD74E73B32BECB33484974AC3DA87A0A77B0D8D508` |
| `CvBenchmarkConfig.sml` | `F5F285E8BF9C9D510E3ED43B7BD52B9883D41399F51EE10C9FB65041D5374AEF` |
| `compiled_dependent.sml` | `8D51A8D9A118FA608478EC77C2F0E6D605AE8131250FC367F204202E90A4C9B8` |
| `CompiledEvalChecks.sml` | `0048A1B2979BADFD1C1EAF6F72DA352EC97A65FECFD319AB011C793F00B37BF0` |
| `CompiledWorkload.sml` | `58F5DC21C3F33EFF1E58C8BA06015A40AC72CB875CEC34B87B3A59BF50A28ABA` |
| `prepare_harness.py` | `3CD71F94F911411B2F582CD4AE4BC381D7014821D1EAFC23CC81B138E28720A2` |
| `run_compiled.sh` | `1BE5D272248FE9471FE12602ACBC763616BF9E0BA0B1A09CE6D75C7E491B8AE5` |

The SML signatures, linkage and executable behavior remain untested. The first build may expose ordinary type/API mistakes, which must be repaired and repinned before drawing performance conclusions. Passing the planned suite would justify a bounded same-AST comparison, not a trusted-kernel replacement. The equivalence and implementation-audit obligations in `DESIGN.md` remain open.
