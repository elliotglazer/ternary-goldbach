# Explicit candidate-module dependency repair

2026-11-13. Applied at root's instruction after the `compiled01` load-recipe review. No build, SML execution or numerical evaluation was performed.

Both `CompiledEvalChecks.sml` and `CompiledWorkload.sml` now include, immediately before their existing `structure C` alias:

```sml
(* Explicit qualified read for Holdep; cv_zero is an immutable existing value. *)
val _ = CompiledComputeBenchmark.cv_zero;
```

The candidate's preserved stock definition is `val cv_zero = Num zero` inside `local open Arbnum`. At module initialization this is a constructor applied to the existing zero value. The added references merely read that already defined immutable value and discard it. They do not call `exec`, `prepare_closures`, arithmetic, a theorem constructor or any benchmark function. Their purpose is to make the module dependency explicit to Holdep's qualified-identifier scan. The next actual build must confirm the resulting dependency edges; this note does not claim the scan has run.

The original two modules, old manifest and old result checker are preserved byte-for-byte in `pre_dependency_repair/`. All `compiled01` receipts and recipes remain unchanged. The manifest updates only the two support-source hashes. `prepare_harness.py` already reads and hashes the current support files dynamically, so no generator change is needed. Its generated Compute copy, CV configuration and exact dependent fixture remain unchanged.

The strict result checker now pins the repaired manifest. The original source-comparison checker passes against that manifest. This checks text and hashes only. The built `.exe` is a shell launcher, and the `.uo` files are load recipes; **build exit0 does not establish successful SML typechecking**. Runtime source loading is the next diagnostic gate.

Before accepting `compiled02`, inspect the new recipes: `CompiledComputeBenchmark.uo` must exist, and both caller recipes must name it as a dependency. The unchanged `run_compiled.sh` will invoke the local build again before running its two smoke processes. It retains the 4-GiB virtual-address limit and 600-second per-phase timeout. If runtime typechecking or any semantic check fails, preserve that attempt and do not interpret partial timing output as a result.

After successful completion, run the read-only checker:

```
python audit_compiled_results.py compiled02
```

Use the existing Windows Python when auditing Windows-path snapshots. It requires both orders, exactly259 semantic checks, exactly208 timing rows per process, all nine requests and five corruptions, successful exits, source/executable postchecks, contiguous code-equation indices and exported stock-reference names. It does not independently decode or replay those exported theorems. The parent should also inspect log ordering, loading behavior and timing interpretation.

| Repaired file | SHA256 |
|---|---|
| `CompiledEvalChecks.sml` | `83C68CD8BD12054A86D445AD9171073643F55704BF86AEEE8ABC6D5A45D33CDF` |
| `CompiledWorkload.sml` | `F49207126EA59AD3B5022972D9CC3E6C0513AE57B124A034B30B9CD93422B804` |
| `harness_source_binding.json` | `BCBB1017B6AFF35EF7E16E31F4DC4FFD61D0038EDCE64F112815472DC935057C` |
| `audit_compiled_results.py` | `0434B6D49909B0E8EB223CDAA8631BB7F5B13E6E14A71C3B4943155AF1D5FCFA` |

Earlier frozen design/handoff/review reports are not rewritten. Their old support-file pins are superseded only by this explicit two-reference repair. The translation itself is unchanged; all proof-authority and performance limitations remain.
