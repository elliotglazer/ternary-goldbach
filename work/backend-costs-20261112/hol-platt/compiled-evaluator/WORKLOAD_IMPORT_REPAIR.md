# compiled03 workload import repair

2026-11-13. Source-only repair authorized by root; no SML execution or build here. `compiled03` remains the preserved failed runtime typecheck.

The complete log reports undeclared `SPEC_ALL`, `term_to_string`, `lhs` and `rhs` in `CompiledWorkload.sml`. The original `open HolKernel;` did not provide these names. The sole executable-source change is:

```sml
open HolKernel Parse boolSyntax Drule;
```

The actual pinned-tree signatures declare the APIs at `src/parse/Parse.sig:236` (`term_to_string`), `src/1/boolSyntax.sig:66–67` (`lhs`, `rhs`) and `src/1/Drule.sig:55` (`SPEC_ALL`). These are the intended stock parsing/equality/quantifier helpers already used by the harness. No formulas, calls, evaluator implementation, comparisons, test cases or timing boundaries changed. Explicit opens also expose the module dependencies to Holdep.

The pre-repair workload, manifest and strict checker are saved in `pre_workload_import_repair/`. The manifest updates only the workload support hash; the strict checker changes only its manifest pin. The generator already reads current support files, so it needs no modification. The source-only verification passes with the new pins. Runtime loading and all259 semantic/208 timing checks remain to be completed by the next root-run attempt.

| File | SHA256 |
|---|---|
| CompiledWorkload.sml | `A1EA06BFA873B372ED6FF485F03309EA42BB5F480822BF2B6D0E6AD086298909` |
| harness_source_binding.json | `7638FBAA14CBD4336EBAA7DE15FB72317625B5749347A96A2E3F606DCBB94F54` |
| audit_compiled_results.py | `091C50C8344819652C42C1F6862020BD842B12CCE13716FA2C035FCBCAC1B011` |

The typed-evaluator author was warned through root that its workload also uses `SPEC_ALL`, `lhs` and `rhs`; explicit `Drule`/`boolSyntax` imports avoid relying on incidental imported structure contents. No typed-evaluator file was changed by this repair.
