# Step-divisor parser repair

The source01 build stopped at the `source_mul` definition because HOL parsed `T` as Boolean truth before applying the `:num` constraint. Definitions through `source_em_initial` were processed, but no completed SourceArithmetic theory was accepted. This was a parser/type-analysis failure, not a failed mathematical claim.

Before editing, the exact source, audit and input manifest were copied to `history/source01_reserved_T/`, together with the complete `source01_run` directory, including logs, time, command, exit status and hash checks. The original source01 run directory remains unchanged. Every copied run file was hash-compared against its original.

The successor replaces the whole identifier `T` by `step_scale` in `SourceArithmeticScript.sml` and `source_audit.sml`. This changes the divisor binder and its uses in `source_mul`, `source_state`, `source_pool_tick`, their theorem statements, and the audit's expected quotations. It also updates the one explanatory comment. A byte-level text comparison checked that this substitution is the entire change in both files. No constants, operation order, domains, proof tactics or declared theorem names changed. The intended conclusions are alpha-equivalent to those reviewed previously; the old unbuildable source is not being claimed as an accepted theorem.

`source_run_inputs.sha256` was regenerated. Exactly its two source/audit entries changed; the other fourteen entries matched the archived manifest. `run_source.sh` remains byte-identical. No build, numerical evaluation or dependency mutation was performed for this repair.

| Successor | SHA256 |
|---|---|
| SourceArithmeticScript.sml | E19880C6CE9FC570D110264F3CBAC878A805FF7F56521B26089CD1C0FB97A862 |
| source_audit.sml | 80AE010F898FBA176BE5F652E3152220D3DE75A807A1B9C4DCE161979EF2CEE0 |
| source_run_inputs.sha256 | 6352E2633B8D23629E37ADE86A5C4EEA19003602E613E85FD9ADA1C7EC526705 |
| unchanged run_source.sh | 8DC83615B71E5BA7B505A93753973E33875728855831F0AEC3C1F0159548F041 |

Root may review this successor before using a fresh `source02` label. The mathematical scope and open analytic obligations in `SOURCE_REVIEW.md` are unchanged.
