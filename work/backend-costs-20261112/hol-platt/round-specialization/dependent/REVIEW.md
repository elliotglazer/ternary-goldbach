# One-division rounding: independent source preflight

Reviewed 2026-11-13. **PASS at source level for the proposed matched experiment**, conditional on successful compilation and source/object binding of the repaired core and CV theories before the dependent runner starts. No compiler, evaluator, generator or benchmark was run by this reviewer. This review does not assert that the repaired scripts elaborate or that the replacement is faster.

## Mathematical contract

The negative quotient identity is correct for positive natural denominator d. If `a=q*d+t`, with `0<=t<d`, then

```
-(a+1) = (-q-1)*d + (d-1-t),    0<=d-1-t<d.
```

This is precisely the positive-denominator branch of `INT_DIV_UNIQUE`. Applying it to positive magnitude a gives `(-a)/d = -((a-1) DIV d)-1`. The executable replacement uses this branch only when n<0, so natural subtraction of1 from `Num(-n)` does not truncate a negative quantity. Zero uses the nonnegative branch. Exact negative multiples are covered without a remainder test.

`round_scaled_one` supplies numerator `2*r+s` and denominator `Num(2*s)`. The positive-scale theorem proves the denominator positive and its integer embedding equal to `2*s`; no zero-denominator extension is being claimed. The sign branch tests `2*r+s`, not r. Consequently the original floor-after-half-offset convention and residual interval `-s <= 2*(r-q*s) < s` are preserved, including negative half-ties.

The three products, presums and four output sums of `rounded_butterfly_one` match `BlockRound` exactly. Equality of the rounded coordinates implies equality of the whole butterfly. The repaired final residual proof correctly imports `DependentBlock` and invokes the arbitrary-pair theorem `rounded_butterfly_residual_pairs`, together with butterfly equality. The historical round01 failure occurred at this final residual proof after earlier statements had been saved in the running session. It was a failed theory build, not a completed accepted dependency. The new source and successful export must be bound separately.

`RoundDependentScript.sml` copies only layer/run/acceptance definitions, replacing the butterfly call. Rotation, bound, checksum and original residual/block contracts are reused. Its positive-scale layer equality extends inductively to the full run and acceptance predicate. The acceptance soundness statement has the original existential-vector consequent; it does not weaken the result to a new predicate or checksum alone.

## Actual driver binding

Independent read-only comparison found all **788 quoted numeric strings** identical and in the same order as the original `dependent.sml`. All four fixture-call lines and five corruption-call lines match exactly. This includes scale, input/coefficient arrays, modified arrays, bounds and expected checksums. No arithmetic fixture was recomputed for this audit.

The driver selects `block_accept` or `round_block_accept`, proves the actual scale positive and discharges the corresponding translated precondition. It evaluates that selected term and checks its exact LHS, boolean result and absence of hypotheses. Its post-evaluation `derive_original` then rewrites the new acceptance theorem using `round_block_accept_correct` and the positive-scale proof, checks that the result has original head `block_accept`, and applies the **original** `block_accept_sound`. The equality rewrite preserves all arguments. The correctness theorem is used for transport after evaluation, not as a substitute for running the new implementation.

Stock-reference checks use the same selected predicate as the timed call. This is appropriate for checking the evaluator; the generic equality proof supplies the cross-implementation mathematical comparison. In the one path the exported false-control equations name the new predicate, which is equivalent to the original at the proved scale. They are not literally the same predicate expression, and need not be described as such.

The reused prepared adapter remains the reviewed source `13A8941A…27807`. It retains validated CV code, not final results. Every call rediscovers and checks the current equation set, evaluates the current input and transports its result. The actual incompatible-closure control, ordered equation-theorem records and the five stock-certified false controls remain present. Input/coefficient cache misses must remain misses with paid reconstruction, not exceptions counted as mathematical rejection.

## What must be checked after compilation

The source executable definition has one natural DIV in either chosen sign branch and no MOD. The pinned stock `cv_int_div_def` has a DIV plus explicit MOD test for a negative numerator with positive denominator. This establishes the proposed change in source operations, not yet the executed call graph or a time saving.

Before interpreting a runtime result as a one-DIV experiment, inspect the generated reachable CV equations: the replacement's active rounding path must use the natural quotient and must not fall back to `cv_int_div`/`cv_mod`. The use of MOD in the mathematical proof is harmless; proof construction is not the translated runtime definition. Count or otherwise document the actual negative-rounding regime before claiming a per-negative-division benefit. Extra magnitude extraction, predecessor subtraction, sign construction, changed code size and allocation remain costs. No denominator/presum hoisting or different multiplication method is included.

Successful repaired `RoundSpecialization` and `RoundSpecializationCV` build receipts are prerequisites. Existence of `.uo`/`.dat` files and unchanged hashes during a run do not alone show that they were built from the current sources. Bind them to successful receipts, then allow the runner to build only the new dependent theory and driver. All generic and final exported results still require the ordinary axiom/tag and exact-conclusion audit. Source-level absence of a defect is not compiled acceptance.

## Matched timing and runner

The four scheduled cells are old/stock, one/stock, old/retained and one/retained. Compare old versus one at fixed evaluator mode to measure this arithmetic change. Compare stock versus retained at fixed arithmetic implementation to measure code preparation. Do not compare only old/stock to one/retained and attribute the combined difference to division.

Each cell constructs/translates the same literal data in its own process and runs the same four depths and three calls per depth. Both implementations import the new generic theory, so its import cost is common in this experiment. The new theory's construction remains a separate development/first-adoption cost. New-to-original theorem transport is outside the primary call timer and separately charged. Stock references, negative controls, equation metadata, export and imports remain outside or alongside primary calls; whole-process totals include them. The metadata discovery preceding the first selected call still prevents calling it a pristine cold `cv_eval` measurement.

The runner uses the same4GiB virtual-memory cap and600-second per-phase timeout as the predecessor, with sequential fresh processes and alternate cell orders in full mode. Smoke has one process per cell; full has three. It snapshots source, existing dependency, toolchain and newly built executable/theory objects and rechecks them after the run. Separate exported theories are retained per cell. Marker checks are preliminary: a result audit must validate every expected cell/call/control, actual equations and tags, complete exits, hashes, resource observations and exports. No automatic retries or dependency builds are authorized by this review.

This is still the arbitrary-coefficient dependent block, not an actual FFT or spectral source-to-sign theorem. Native timing boundaries remain those of the earlier matched accept loop, with decimal input loading and full-coordinate validation outside its timer. A new result cannot remove representation, source/coefficients, analytic-error, repair/counting or finite-coverage costs. It can inform a rounding component only after actual workload widths, sign regimes and code/cache lifetimes are matched. No runtime ratio is predicted here.

## Frozen input pins

Within this directory:

| File | SHA256 |
|---|---|
|RoundDependentScript.sml|708DE0B68A0B6F97C110F3221F4C331D7B149B4DA7BD06466A428AA13007D2D3|
|round_dependent.sml|01B1CEF0D2A09D6D3CBD50B10BBE7F12E1054FB38337D3EDF8E43BEEBD0D01E9|
|prepare_driver.py|84E012F9F28EE3EFD0EB17C78EB6256044C1D0BA6F54D9682261C5826B0F8E5E|
|source_binding.json|8E7C9CDAD1032A979D8D18EA0CD68212835C32FC2B269DB8E4D3D4E24ED4C34A|
|run_round_dependent.sh|428538F936BA2D9FED80DDBE20DC74B160DCFAEED93504C4AA85A53E462B6590|
|Holmakefile|4048DB6D1132604E172C5899A29409B034642FF701F6ACF4FE3ACD9BA408D5BB|
|README.md|0B065EB3531B4CF7B30BE8D64A3DD3036BE7976D7AB92E339A7E78FC50A90248|

Other source pins, relative to this directory:

| File | SHA256 |
|---|---|
|../RoundSpecializationScript.sml|37CB4079D95F48B1F1FF9974525C909DDA21F829FD39FB341027EB9CD5380DAF|
|../RoundSpecializationCVScript.sml|BF23B50BF027BF3DCDC142D9BE144A4124D6A252A8D492AA22FEF7247EEEE519|
|../../prepared-eval/PreparedEval.sml|13A8941A49FA2CB238370008B10D13FC106C42B95353E18EB145683776D27807|
|../../../hol4-setup/dependent.sml|ECB62C8C7B1F1AAAA8DF9617DAF4145D7FCADBEEDD9CF8579D3F57962C5E1AB1|
|../../../hol4-setup/BlockRoundScript.sml|FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143|
|../../../hol4-setup/DependentBlockScript.sml|1A57F4025ED1A7B9C5A823D5F6B73B2A7BE02B109F21AD13D24214EA52D9D665|

The actual pinned HOL checkout is `1de64f8521b4758508bd875fbaf11d1768261b92`. Its `src/integer/integerScript.sml` is `C35C81AF62A41E7AECD2CA571A97275F130EE8BD1D70A041BCB7651CB72C7D8C`, and `src/num/theories/cv_compute/automation/cv_primScript.sml` is `344DCC0FFB7071270819E366D027ADA5B449615EBE31A23B7CF7C6DC0CD8F28A`. The preceding prepared-evaluator source and runtime reviews retain the stock compute/transport source pins and their narrower evidence boundaries.

Only this review was written. No proposed source was edited or executed.
