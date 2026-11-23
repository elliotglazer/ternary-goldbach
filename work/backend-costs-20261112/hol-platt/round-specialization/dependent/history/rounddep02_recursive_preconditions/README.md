# Matched dependent-block rounding experiment

Status: source-only and unbuilt. No HOL evaluation, compilation, or benchmark was run for this packet. The small Python preparation only checked hashes and copied/transformed source text. It did not recompute any numeric fixture or output.

`RoundDependentScript.sml` copies only layer, run, and acceptance definitions, using the new butterfly. It reuses the exact original rotation, bounds, checksum, layer/block contracts, and proves positive-scale equality with the original layer/run/accept functions. Its soundness theorem has the original `block_accept_sound` consequent. There is no new analytic interpretation of the arbitrary coefficient fixture and no claim that checksum equality uniquely identifies a vector.

## Prepared comparison

`round_dependent.sml` is the existing prepared-conversion driver with a separately selected `ROUND_IMPL=old|one`. `PREPARED_MODE=stock|retained` selects ordinary cv_eval or the existing retained-conversion adapter. Fresh conversion mode is preserved for an optional separately authorized diagnostic, but the runner does not schedule it.

The runner uses four fresh processes per sample: old/stock, one/stock, old/retained, one/retained. Smoke selects one sample; full selects three samples in the recorded alternate orders. Every process constructs/translates its own identical named literals, tests all four depths 1, 8, 32, 128, and performs three fresh evaluations per positive case. It additionally executes the predecessor's stock-reference checks, five false controls, incompatible-equation-closure control, theorem derivations, and export. Those operations have separate log labels and are not folded into the twelve primary evaluation times.

There is no final-result memoization. Retained mode reuses only the checked CV conversion; every call rediscovers the actual equation closure, verifies exact equation identity, evaluates and transports. The old implementation also closes its original positive-scale CV precondition; the total new implementation has no generated CV precondition. A changed control closure prepares a new conversion instead of accepting a mismatched cache. The adapter source is imported from `prepared-eval` unchanged. Kernel, CV library, and original project theories remain unchanged.

Both implementations derive the same original theorem: for the one-quotient path the driver first rewrites the successful acceptance fact using the proved function equality and positive scale, checks that its head is the original `block_accept`, then applies the original `block_accept_sound`. This transport/derivation is outside the primary evaluation timer and separately charged. No generic theorem substitutes for evaluation of the selected path.

The exact 788 quoted decimal strings of `hol4-setup/dependent.sml` survive in the same order, including scale, inputs, coefficients, expected checksums, bounds and corruption data. `source_binding.json` records that textual check and source pins. The generator does not use the original Python arithmetic generator or run any numeric transform.

## Running later

Core `RoundSpecialization` and `RoundSpecializationCV` must have compiled successfully first. The parent must review the new theory and driver before invoking `sh run_round_dependent.sh <fresh_label> smoke`. The runner then builds only this new theory and executable with `--no_prereqs`, using existing cached dependencies. It keeps the predecessor's 4 GiB address-space ceiling and 600-second per-phase timeout. Existing labels are refused; failure leaves its log and artifacts for inspection. No retry or result cleanup is automatic.

This is a hypothesis test, not a performance result. Compare old versus one within a fixed evaluator mode to isolate the rounding change. Compare stock versus retained within a fixed rounding implementation to study conversion reuse. Report literal/setup, prebuild, primary evaluation, stock-reference validation, false controls, derivation/export, and whole-process time separately. Do not combine validation calls with the primary evaluation denominator or infer a kernel arithmetic penalty from whole-process ratios.

The imported `PreparedEval` must still be inspected with the generated equation sets to confirm that the new executable branch contains a single natural DIV and no MOD/signed integer division. A lower source operation count does not establish a lower elapsed time.

## Files

- `RoundDependentScript.sml`: new definitions and ordinary equality/contract proofs, plus total CV translations.
- `round_dependent.sml`: literal-identical matched driver, generated once.
- `prepare_driver.py`: pinned, exclusive-output text preparation; do not rerun over existing outputs.
- `source_binding.json`: source/fixture identity receipt.
- `run_round_dependent.sh`: bounded later runner; not executed by the author.
- `Holmakefile`: disjoint build targets and imports.

The two files currently/previously compiled by round01 were not edited during its run. After root reported its terminal proof failure, the separate core repair archived the old source byte-for-byte and changed only its final residual proof plus its already-compiled DependentBlock import. That repair is outside these experiment files.

## round02 translation repair

Root compiled the repaired core successfully. The first CV translation failed only because natural DIV is total and cv_trans_pre generated no precondition. The successor uses cv_trans for all three scalar/butterfly definitions and all three dependent definitions. The driver retains positive_scale in both modes, and closes block_accept_pre only for the original mode. No replacement always-true predicate was invented. All old changed files are preserved in ../history/round02_total_translation; source_binding.json is regenerated against the current local source hashes. The new source and driver require a review update and a successful build before execution.
