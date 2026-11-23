# Independent source review: compiled HOL compute experiment

2026-11-13. **PASS at isolated experimental source-review scope.** No blocking semantic defect was found in the proposed translation or same-AST harness. This is not an equivalence theorem, a successful SML typecheck, a passed differential run, a speedup result, or approval to replace HOL's trusted evaluator. The reviewer performed source reads and small text/hash checks only; no build, HOL execution, benchmark, or installed-source edit occurred.

## Translation and stock semantics

The current stock `Compute.sml` interpreter, primitive definitions and original `term_compute` frontend are preserved in the differently named copies. An independent text comparison checked the complete stock prefix (apart from the structure rename), the original frontend, the inserted compiler fragment, and the characteristic-configuration prefix. Stock `Monop` and `Binop` already carry SML functions: this experiment removes expression-tree dispatch, not an additional arithmetic-opcode interpreter.

The compiler cases preserve the following source behavior:

- Constants remain `Num` values; variables call the original `env_lookup`, including negative-index and empty-environment behavior.
- Unary operations invoke the same stored function. Binary operations first evaluate the left expression and apply the curried first stage, then evaluate the right expression and apply the second stage. This preserves the important exception/effect order in `b (exec x) (exec y)`.
- `Let` evaluates its bound expression once and prepends it to the same list environment. `If` evaluates one condition; only a nonzero `Num` selects the first branch, while zero and pairs select the second. Compiling an unused branch does not execute it.
- Application evaluates arguments left-to-right and reverses the accumulator once, then performs the original indexed code lookup. The replacement therefore retains argument exceptions/effects before missing-code errors. Recursive calls are not unfolded or memoized.

The optional-vector reference used for recursive linkage is allocated privately, captured by compiled bodies, and filled before the entry compiler is returned. `compile_expr` never invokes this lookup during construction. No published runner can reach the `NONE` branch through this construction; no subsequent write or reference export appears. Function indices and code order are unchanged. These observations support the design but are not a formal simulation proof, particularly for divergence and resource failures. Eager traversal of otherwise unused branches changes allocation/stack-exhaustion opportunities; the report correctly excludes equal resource behavior.

The primitive arithmetic, coercion of pairs to zero in arithmetic, structural equality, restricted numeric comparison, saturating subtraction, and zero-divisor behavior all remain the original functions. Host arbitrary-precision arithmetic is still used. No lookup of previously computed arithmetic results or hidden memoized result table appears.

## Actual workload and theorem boundary

The generated driver retains the exact original `dependent.sml` prefix through the fixture setup, all four positive fixture declarations (depths 1, 8, 32, 128), and all five original changed-data/control requests. Independent text comparison recovered the original entire control suffix after deleting only the new raw-comparison calls and restoring the final marker. Thus this is the original finite dependent-butterfly workload, not a substitute arithmetic example. This identity does not promote that workload to a full spectral-source theorem.

For each request, `CompiledWorkload.run` obtains the actual CV representation and ordered source equations through the stock discovery functions, applies `SPEC_ALL`, and rejects hypotheses. `prepare_program` preserves the original configuration checks and parser; its only relevant return change exposes the code vector, request parser and reconstruction function. One code vector and one parsed request AST are then supplied to both `C.exec code [] ce` and the compiled entry. Retained samples call these functions again; the first result is retained only for comparison, not returned in lieu of evaluation. Fresh compilation constructs a new code closure table and request closure from the same already parsed AST.

Raw returned values are compared structurally. Reconstructed terms are compared with `aconv`. The separate unchanged stock `cv_computeLib.cv_compute` result must have no hypotheses and exactly the same input/result terms. High-level positive and negative checks continue through the original stock path and its proved preconditions. Saved candidate-related theorems are original source equations or stock reference theorems; no candidate raw output feeds `make_thm`, a conversion theorem constructor, or an oracle.

In particular, stock `Thm.compute` still calls the original `Compute.term_compute`, checks code-equation hypotheses, merges tags and checks the result type before `make_thm Count.Compute`. This remains a trusted stock evaluator boundary; it is not a replay of every arithmetic operation as ordinary inferences. The allowed `DISK_THM` tags reflect imported material, not an oracle-free fresh proof of upstream libraries. The driver's context-axiom check is retained, and the experiment does not claim Lean's axiom convention for HOL.

The driver deliberately retains the existing `DependentBlockResults` theory name. Running only in this isolated directory is essential: local theory exports must never overwrite or become production imports of the original fixture. The preparation scripts use exclusive local outputs and checked source pins. No installed-kernel edit appears in the scripts or harness. This source conclusion does not audit every possible side effect of the existing build toolchain.

## Planned semantic gates

The planned count is independently reconstructed as `13 + 15 + 200 + 7 + 7 + 6 + 7 + 4 = 259`: basic constructor/error cases, unary matrix, binary matrix, explicit primitive edge cases, effect/order cases, recursive sums, mutual recursion, and nested compositions. The observer catches only expected `HOL_ERR` and the explicitly introduced test signal; unexpected exceptions do not count as equal successful results. The primitive matrix uses the original primitive itself as an oracle, which is appropriate for translation preservation but not an independent proof of arithmetic correctness. Explicit edge expectations and stock-kernel reference checks add distinct checks.

These are source-defined tests only. The first typecheck may expose API or linkage errors, and all semantic assertions must actually execute before any timing sample is used. Tests cannot establish universal equivalence or justify trusted replacement.

## Timing and result-audit obligations

The timed thunks have intelligible boundaries: discovery/parsing, closure compilation, raw evaluation, reconstruction, combined evaluation/reconstruction, and stock reference conversion are separate. `Timer` CPU time is reported separately from `Time.now` elapsed time. The first raw measurement is after shared preparation, so it is not cold-process execution. Fresh compile/execute excludes parsing and reconstruction. Combined and separate rows overlap conceptually and must not be added as disjoint costs.

The harness preserves the first results and ASTs for checks, runs the stock reference before retained samples, and alternates paired implementation order by process. Allocation, collection, retained objects and preceding work can affect later samples. No per-phase GC isolation is present; `/usr/bin/time -v` supplies process-level statistics. Three retained samples per request are not by themselves a stable throughput estimate. These limits require reporting observations, not extrapolating a raw ratio to whole-proof cost.

The shell runner uses sequential processes, `--no_prereqs`, a 600-second external timeout and a 4-GiB virtual-address limit. The latter is not an RSS/private-commit limit. A fresh label, no-clobber redirections, exit checking and pre/post source/dependency/tool/executable hashes preserve useful evidence. Build actions and existing local object freshness still require inspection; a successful build invocation alone is not proof that every intended local module was rebuilt from the pinned source. The snapshots cover named dependencies, not a complete transitive imported-library manifest.

The runner intentionally ends with `REQUIRES_RESULT_AUDIT`. Its marker checks are only preliminary: it accepts a semantic-marker prefix rather than enforcing exactly 259, and it does not check exact timing-row counts, duplicates, finite/nonnegative times, or a complete label bijection. A result audit must require exactly one `COMPILED_SEMANTICS_PASS,259`, nine workload labels, five rejection labels, the expected order and completion marker, and all requested timing rows without unexplained duplication. From this source the expected `COMPILED_TIME` count is 208 per completed process: one syntax-validation row plus 23 rows for each of nine requests. Source and executable bindings must also match the reviewed version. Hashing current files before/after detects drift during the run; it does not itself enforce the frozen review/manifest hashes. No result should be accepted merely because the shell exits zero.

These are retained interpretation and acceptance limits, not a request to modify the frozen experiment. No measurements exist in the reviewed packet. Both faster and slower outcomes remain possible.

## Pins

All names below are relative to this directory unless noted. Every entry of the harness manifest was checked: four input entries, three generated-output entries and five support entries (12 entries in total). Additional review and preparation files are pinned separately below. Pin counts are provenance bookkeeping, not proof coverage.

| File | SHA256 |
|---|---|
| `DESIGN.md` | `B06A8D094212627C6AE635ACAB356E304473971E0B8B8C93C4089DE51B0E11D6` |
| `HARNESS_HANDOFF.md` | `EE984CF627D67C461803222CB1E5F0D4BDA1F1F9A2D3914146A58772EA3FDF99` |
| `ClosureCompiler.sml.inc` | `08BC1B75AD3AB92D0B51DEF4A1787A3A106D18919F6786D0FBBFA38CB94D2015` |
| `CompiledComputeExperiment.sml` | `F4CA87E8DAD81EBE6096051215286A16C3B9826F789995BAB916BB65F63A4915` |
| `CompiledComputeBenchmark.sml` | `BCCAC8C9D9662A5F45366DBD74E73B32BECB33484974AC3DA87A0A77B0D8D508` |
| `CvBenchmarkConfig.sml` | `F5F285E8BF9C9D510E3ED43B7BD52B9883D41399F51EE10C9FB65041D5374AEF` |
| `CompiledEvalChecks.sml` | `0048A1B2979BADFD1C1EAF6F72DA352EC97A65FECFD319AB011C793F00B37BF0` |
| `CompiledWorkload.sml` | `58F5DC21C3F33EFF1E58C8BA06015A40AC72CB875CEC34B87B3A59BF50A28ABA` |
| `compiled_dependent.sml` | `8D51A8D9A118FA608478EC77C2F0E6D605AE8131250FC367F204202E90A4C9B8` |
| `prepare_prototype.py` | `6FE40ADF30E7433D0C2D6767F1DBC0AEE157B738B7DFEFB95F015E7982C16452` |
| `prepare_harness.py` | `3CD71F94F911411B2F582CD4AE4BC381D7014821D1EAFC23CC81B138E28720A2` |
| `verify_harness_sources.py` | `2F39FAB616C8F8D66CE7A53FCCD4E60CF2E71307E4BFC4F12847FDD97BF74464` |
| `source_binding.json` | `A59E9D70A7FEEB93EF623C2DB662D12B20A56BFB60E8E69F4015850C3E9128A7` |
| `harness_source_binding.json` | `941EEC202243605BDC3ABC69A96A892F1BD3AA07FE02EB7490590B63E428424F` |
| `Holmakefile` | `7572D06333300C9546D69775464EF562E5CEE3AB932847AC57A24BBEE2DB46B3` |
| `run_compiled.sh` | `1BE5D272248FE9471FE12602ACBC763616BF9E0BA0B1A09CE6D75C7E491B8AE5` |
| `stock Compute.sml` | `7DAB9DD6E848FDFE2EB7869865031CFDADBA44A2FB3D7E74D98CEA77F712E059` |
| `stock Thm.sml` | `E0A9F3C274BAB9BE04922D83535A660833A6EF8409F9C02BA9610DDEDAE3FF45` |
| `stock cv_computeLib.sml` | `B66D57885CB0D2DCF49F5D5FEC665CB5FDCA4EDB9F726A2CED0AD579CDD08B6C` |
| `original dependent.sml` | `ECB62C8C7B1F1AAAA8DF9617DAF4145D7FCADBEEDD9CF8579D3F57962C5E1AB1` |
| `existing run.sh` | `BD06330A16C06F8FF7D43401F545988EF1ED357FCD2248B53CA2BDBC89D8FF0C` |

The next permitted conclusion, if a separately authorized build and run succeed, is a bounded empirical same-AST comparison. Trusted evaluator replacement still requires the unresolved semantic/implementation assurance described in DESIGN. This review authorizes no such replacement and claims no speedup.
