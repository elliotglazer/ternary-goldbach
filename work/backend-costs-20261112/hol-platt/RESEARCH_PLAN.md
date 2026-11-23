# HOL4 cost research against the historical Platt computation

User objective, 12 November 2026 America/Los_Angeles: research the HOL4 strategy until there is evidence for confidence that its cost roughly resembles Platt's historical hour count.

The comparison reference is approximately 400,000 historical core-hours for the full published finite-GRH computation, with 160,000 as Helfgott's retrospective allocation to his required subset. Neither is a current-hardware benchmark of our smaller R132900 profile. The end-to-end TG finite binary coverage and prime ladder remain separate obligations and must not disappear into this comparison.

The current conditional HOL model has 4,350,538 core-hours excluding its 230,291-hour finite-coverage/ladder row. Its remaining rows group into 1,994,587 hours of literal representation, 1,957,129 hours of arithmetic including principal work, and 398,822 hours of discovery, closure, process/library and other representation work. These groupings include shared work and do not constitute an isolated measured PlattGRH checker. The frozen model remains unchanged.

The proposed 20,000/200,000/180,000-hour allocation is an engineering target only. Reaching those values by assuming speedup factors is not evidence of feasibility. Report model assumptions, observed rates and true mathematical completion separately.

For the primary research comparison, use a factor-of-two band around 400,000 core-hours (200,000 to 800,000), while continuing to report the central estimate and its uncertainty rather than classifying this band as a proved bound. A result below that band also meets the compute objective if supported. The historical 160,000-hour subset remains a separate, harder comparison. This operational interpretation does not change the mathematical domain or permit omitting expensive obligations. Confidence in a cost projection does not require completing the whole TG formalization first, but each material projection must be supported by a correct algorithm, representative acceptance measurements, and explicit remaining engineering risks.

## Current concrete sequence

1. Run the reviewed integer-only materialized/fused raw-state handoff comparison. Both paths must produce the same full 516-pair result and validate all eight 129-state traces. Preserve build failures and distinguish first construction from cached runs. This diagnoses one representation boundary, not the complete spectral computation.
2. Establish the actual source/analytic interfaces required for a representative c10004 block. Use the saved p81 baseline, complete 4800 input/2301 primitive-output domain, and the requested two positive heights with a justified zero-height initializer. Do not substitute a small unrelated sign for this workload.
3. Measure a complete source/transform/sign block against an equivalent native implementation. Account for source production, roots, all arithmetic, numerical error, final binding and output. Add representative high-height, small-family and Bluestein cases before extrapolating the full weighted workload.
4. Implement and price the zero-count and family-coverage joins, including exceptional or inconclusive numerical cases. A successful sign block is not a complete finite-RH certificate.
5. Revise the cost model only where actual workload mapping and measurements justify replacements. Separate construction, first acceptance, optional replay, physical I/O and human engineering. Retain genuine incomplete or unpriced obligations.

Root runs builds serially. Existing libraries and their compiled artifacts remain read-only. Agents may review sources or prepare disjoint implementations; no parallel benchmarks. The earlier Lean and MM0 campaigns are not being resumed as the priority of this objective.

## Handoff launch history

- handoff01: stopped before theory construction because the same Holmake executable was named through a noncanonical `/../` path. The runner is archived in `../raw-state-handoff/history/run_handoff.handoff01.sh`. Only the new experiment's empty build metadata was corrected; upstream metadata/artifacts were not changed.
- handoff02: generic theory construction reached `raw_pipeline_join` and failed to discharge an implication after substitution. No accepted runtime measurement resulted. The generic proof is being repaired without changing its statement or numerical definitions.
- handoff03: the first revised join proof still failed. Its source and failed build output were retained.
- handoff04: the join proof passed after explicit substitutions. The build then failed at `raw_mul_pre_ok`, because pair case analysis was applied before introducing its universally quantified arguments.
- handoff05: explicit argument introduction fixed both multiplication and head precondition proofs. All those preconditions and the list-processing preconditions passed. Translation then stopped at the nested `EVERY` in `raw_shape`; this is a missing evaluator translation, not a failed numerical claim. The process exited with status 1. There is still no accepted handoff timing.

## Resumption, 13 November 2026

The preceding goal turn made progress: it produced an evaluator-source audit, a runnable but unbuilt prepared-conversion experiment, and successful checked join/precondition proofs before the next translation failure. It did not establish a numerical speedup. The user paused and then reactivated the goal. On resumption, the root re-read the current sources and terminal handoff05 log; no benchmark is being treated as still running. Work continues with the shape-translation repair and independent review of the prepared-conversion driver. The fixed-payload code-cache experiment cannot establish arbitrary fresh-payload reuse or remove source semantics.

### Measured code-reuse result

The `prepared-eval/prepared01` bounded smoke run completed with exit status 0. The independent `prepared-eval/RESULT_REVIEW.md` records source/runtime audit PASS, not an independent kernel replay. It checks all three modes, four depths, three calls per depth, all five false-claim controls, the incompatible-conversion guard, recorded equation identities, and unchanged source/dependency/executable checks.

For the largest 8192-butterfly case, the three-call CPU medians were 0.080017 seconds for stock, 0.084220 for fresh instrumented conversion, and 0.065880 for retained instrumented conversion. These are one-process-per-mode observations, with setup and metadata warming as documented in the review. Retained prebuild cost 0.029331 seconds. Changed input/coefficient payloads caused cache misses; changes to the checked checksum, bound and depth did not. Initial literal translation still cost roughly 4 to 4.8 seconds per process. These observations support a modest local benefit from code retention, not the required several-fold campaign reduction. No global model row is changed.

The next priority remains internal data handoff and arithmetic cost. The new `PRECISION_RESEARCH.md` also identifies that much of the small-family precision is inherited from a uniform absolute-output budget; a complete-radius adaptive sign contract is a candidate, not a demonstrated lower-width computation.

### Further handoff repair

`handoff06` passed the nested `EVERY` translation using the stock proved higher-order specializer. It then stopped because the script requested a precondition for an already unconditional consumer translation. The consumer/pipeline registrations were changed to plain `cv_trans`, and obsolete precondition-list entries were removed. Original definitions and numerical claims were preserved. Old generated files are retained in `../raw-state-handoff/history/handoff06-fixtures`; regenerated wrappers differ only by those obsolete list entries, and the comparison wrapper is byte-identical. `handoff07` has now built `RawStateHandoffTheory` successfully; its runtime phases are still pending and provide no handoff timing yet.

Subsequent results supersede that last runtime status. `handoff07` proved the materialized primary result, then failed because Boolean simplification changed a false equation into a negation. `handoff08` added exact Boolean normalization and passed all nine false controls, but stopped at the final direct `round_scaled` tie check. `ties01` exposed its unresolved `round_scaled_pre 2` premises. This is not a false tie claim: the small diagnostic is testing the missing positive-denominator proof and a method that discharges hypotheses while preserving the evaluated equation. No complete materialized/fused handoff result has been accepted yet. The materialized primary phase of `handoff08` spent 7.158615 CPU seconds translating its intermediate array; this is a diagnostic observation from an incomplete full run, not a campaign saving.

### Other concrete work and one failed preflight

- `round-specialization/round02` successfully built the complete core equality and residual theory. Its CV phase then stopped because the new natural-division program is total and needs plain translation, not generated preconditions. The revised CV and matched four-way dependent benchmark sources are awaiting the next build/review. No arithmetic speed measurement exists yet.
- `c10004-map/` now contains independently reviewed, unrun finite checks for the actual 4800-unit CRT map, 2301 retained coordinate labels and inversion. These will discharge finite domain data only; character and transform semantics are still required.
- `SMALL_FAMILY_PILOT.md` fixes an actual conductor-10000 inverse-character-pair pilot with a full 524288-point time transform. Its source producer and complete numerical radii are not yet implemented.
- `raw-analytic/dependency-build-win01` contains 45 staged upstream source files and the generic complex rounding helper. The attempted graph-only command mistakenly used `--json` with an explicit target. In this pinned Holmake source, the explicit-target branch bypasses `dispatch_built_graph` and therefore its `show_json` check. The command actually built four local theories before its 180-second timeout. The root confirmed no matching processes survived. `PREFLIGHT_FAILURE_ROOT_CAUSE.md` records the exact control-flow cause, unchanged original inputs, and preserved local outputs. A separate no-explicit-target recovery graph command is prepared but unrun. Do not describe the original attempt as graph-only or reuse its explicit-target command as a dry run.
- `compiled-evaluator/` contains an unrun isolated closure-compiler prototype and design. It is not proof acceptance or a kernel change. Stock arithmetic operators already use SML functions; the proposed experiment concerns repeated expression-tree dispatch only. No speed credit is assigned.

No global saving or completed PlattGRH proof is established by this plan.

## Latest measured state, 13 November 2026

The goal remains active. No supported end-to-end forecast near the historical target exists yet. The following completed experiments change implementation choices, not the frozen model's totals.

### Completed results

- `prepared-eval/prepared01`: retained conversion gave a depth-128 three-call median of 0.065880 CPU seconds versus stock 0.080017. Input/coefficient changes still require a new equation set. Initial literal translation remains expensive.
- `../raw-state-handoff/handoff10` plus `compare-recovery/readback03`: both numerical arms passed their controls; readback proved identical complete 516-pair conclusions. Primary instrumented CPU was 8.752890 materialized versus 0.657195 fused. Whole numerical processes were 77.84 versus 61.59 CPU seconds, including controls, imports and export. The original compare and two failed readback attempts are preserved. The recovery-aware independent review is `../raw-state-handoff/RESULT_REVIEW.md`.
- `round-specialization/round03` and `cv-inspection/inspect01`: scalar equivalence and residual proofs compile. Actual generated code uses two natural quotients and no remainders per valid positive-scale butterfly, versus two quotients and up to two remainders in stock.
- `round-specialization/dependent/rounddep03`: after explicit ancestor and recursive-precondition repairs, all four old/new by stock/retained cells passed. Depth-128 three-call CPU medians were 0.068204 old versus 0.065719 new for stock, and 0.055250 versus 0.046183 for retained conversion. Whole-process CPU did not improve: 20.35 versus 21.63 stock, 20.16 versus 20.27 retained. See its independent `RESULT_REVIEW.md`; these small samples justify no universal factor.
- `../raw-state-compact/compact02`: generic sign-packing proofs, runtime controls and comparison against the old full-output theorem passed. The new contract preserves 1032 coordinate signs in four base-nine masks, not integer magnitudes. Primary instrumented CPU was 0.053642 versus the old full-output fused 0.657195; final decoding was 0.001258 versus 0.543517. The complete new process was 13.32 CPU seconds including old-result validation and controls. Independent `RESULT_REVIEW.md` binds the result. `compact01` stopped before building because of CRLF in its predecessor manifest; only those 13 line endings were normalized and the old file is archived.
- `typed-evaluator/typed01`: both execution orders completed with 22 edge checks, nine full-array/Boolean workload comparisons and 213 timing rows per order. Source/dependency/toolchain checks and the independent `RESULT_REVIEW.md` passed. In stock-first order, depth-128 median raw array CPU was 0.033812 stock versus 0.010714 typed; raw acceptance was 0.031197 versus 0.011216. Initial input decoding, stock theorem references and export are separate. The typed worker has no theorem authority; using its result directly would require an explicitly audited trusted-backend extension or independent checked execution evidence.

### Active and pending work

- `native-sign-screen/screen04` is terminal. Its worker exited 0 after all eight exact native margin comparisons passed. The independent `RESULT_REVIEW.md` verifies the exact thresholds and a separate rectangle-norm check; the smallest margin ratio exceeds 11597. Worker CPU was 260.15625 seconds and total job CPU 260.265625 seconds. The runner exited 1 and its receipt remains unsuccessful: after both job processes exited, the final role check reported an original-Python identity mismatch. Missing final query details prevent assigning that failure to a specific Windows API. The preserved numerical evidence is conditional native interval evidence, not a successful supervision receipt or a transform/sign/count proof. Peak memory was not recorded. The previous screen01/02/03 failures are also preserved. No numerical rerun is needed merely to erase a supervision failure.
- `compiled-evaluator/compiled04` completed both orders and passed its strict and independent audits: 259 semantic checks, 208 timing rows, nine workload predicates and five controls per order. At depth128, median raw execution was 0.030605 versus 0.025481 seconds in stock-first order and 0.032292 versus 0.027079 in compiled-first order, approximately 16 percent lower time. These workloads return acceptance predicates, not complete arrays. Both whole processes execute both implementations and obtain all theorems from stock HOL; no proof-producing speedup is established. The earlier dependency, error-API and import failures remain preserved. See `compiled-evaluator/RESULT_REVIEW.md`.
- The typed worker is about three times faster than raw stock execution on the completed small experiment, not three times faster than the complete formal pipeline. The much smaller same-representation closure gain makes the data representation and signed-arithmetic path the next relevant backend question. A source-only natural-offset arithmetic candidate is being developed to seek improvements through unchanged stock proof authority; no speed claim or acceptance result exists yet.
- `../raw-state-compact/REPRESENTATION_BOUNDARY_MAP.md` shows that the roughly 1.995 million-hour model row prices fresh input/coefficient translation. Compact02 mainly improves output decoding, so its measured ratio directly refunds none of that row. `C10004_LIVE_DATA_SCHEDULE.md` now specifies the actual source pools, streamed jets, 4800-to-2301 transform buffers and internal completion/radius work. Its independent `C10004_LIVE_DATA_REVIEW.md` accepts the conditional design and its enumerated 9,076,011 packed bytes, with elementary, completion, repair, scalar and HOL object memory still unbounded by that figure. Existing map order differs from tensor order and requires an explicit permutation. `C10004_IMPLEMENTATION_ENTRY.md` fixes that adapter and the next actual retained-transform implementation. These are implementation targets, not forecast credits.
- The finite map checker has now reached automatic translation. `map01` failed at ambiguous Boolean-definition syntax; `map02` required a proved numerical identity inline rule; `map03` then failed at automatic termination of a specialized quicksort. Those attempts and the statement-preserving repairs are archived. An explicit proved sorting adapter is in preparation. There is still no accepted finite-map result.
- `c10004-layout/` has an unbuilt permutation/fine-cell extension. `c10004-transform/` now has an actual full/pruned integer CT reference and a separate unbuilt outer-tensor projection proof candidate. Its synthetic diagnostics do not supply real L-function inputs. The reference uses costly linked-list indexing; `FAST_TENSOR_TRAVERSAL_PLAN.md` specifies the sequential traversal and refinement needed before production timing. A numerical identity inline fix is also required before the first reference build.
- `source-producer/SourceArithmeticScript.sml` contains an unbuilt port of numerical source kernels, with raw and rational EM precisions kept separate. Analytic source correctness, the selected anchored-log producer and the full EM/Horner/completion integration remain open. The isolated real/complex dependency stage has a validated 777-node selected graph with 605 already-built external nodes; its actual cached-stage build remains unrun.
- `ADAPTIVE_SMALL_FAMILY_ENTRY.md` turns the eight-point screen into a full-transform experiment specification. The fine source coefficients stay unchanged, including fine first-stage additions before rounding. It does not assume a repair rate, lower the Gaussian/source tolerances or claim proportional whole-family savings.

The next measurements must retain actual source, transform and zero-count obligations. Native interval samples and raw typed timings are research evidence, not completed formal acceptance or PlattGRH removal. The binary finite-coverage/prime-ladder row remains separate from this Platt comparison.

## Continued construction, 13 November 2026

The ratio-report turn made no implementation progress. The following continuation resumed construction from the actual saved state; the research goal remains active and the frozen forecast is unchanged.

- `source-producer/source04_run` is accepted for its limited generic scope. Source03 constructed the theory, then source04 built and ran the audit after an executable-rule repair. The three exact theorem conclusions, empty hypotheses, standard HOL ancestry and imported tags passed. A coordinator recheck matched all 16 input pins, three output pins and the manifest pin. `source-producer/RESULT_REVIEW.md` records construction versus cached/reload times. Analytic source enclosures and the complete producer remain open; no throughput credit follows from these results.
- The map's fuel-sort equivalence was closed in a saved-state diagnostic and then passed in the complete map06 theory construction. Map06 advanced to translating the finite predicate, where missing standard list translations caused failure. Map07 imported the existing `cv_std` theory but exposed rational-default parsing in unconstrained numerals. The successor explicitly restores natural-number parsing. Definitions and finite assertions retain their intended natural-number meaning.
- Map08 was interrupted during dependency scanning. Its time receipt is empty, and the inner log remained from map07. A fresh process inventory showed a restarted Linux environment and no surviving proof process. Map09 also ended before a complete dependency manifest or theory phase; its initiating cause is not established. The dependency read at which its manifest stopped subsequently succeeded in isolation. The unchanged source is being retried under map10. Neither interrupted attempt is counted as a mathematical failure or successful check.
- The transform reference, diagnostics and runner were re-read. Its current source includes the independently requested numerical-identity rule. Construction is next after the map attempt, with builds kept serial. Linked-list reference timing will not be extrapolated as production throughput. The separate sequential-traversal candidate still needs its refinement proof.
- Existing agent status shows usage-limit errors or completed source handoffs. Root continues locally; no new agent output is assumed. The natural-offset CV candidate exists but remains unbuilt and requires review and explicit theorem auditing before acceptance.

### Stable execution and full finite evaluation

Docker's backend log establishes that idle mode terminated the managed Linux distribution during map08. Direct WSL workloads did not keep the Docker engine active. `CONTAINER_EXECUTION.md` records the evidence and the replacement runner, which executes the actual workload inside a pinned, already-installed container without changing Docker settings. Map11 exposed a default-container-user permission mismatch; map12 used the matching container UID and proceeded normally.

Map12 passed the full `finite_checks` evaluation and constructed `finite_map_checked`, `map_sorted_units` and `map_permutation`. It then spent excessive time in a generic distinctness proof whose general simplifier can expand the literal 10004-element list. Root stopped the verified owned container, preserving its partial receipts, and replaced two list-consequence proof bodies with symbolic rewrites. The definitions and theorem statements are unchanged. Map13 is the next bounded construction and reload-audit attempt; the full map result is not yet accepted. See `c10004-map/MAP13_SYMBOLIC_LIST_PROOFS.md`.

### Ratio sensitivity, not a revised forecast

The user's 1:2 question uses Platt's 400000-hour baseline, so the target is 800000 hours. Holding the other rows fixed, a hypothetical tenfold reduction of the 1957129-hour arithmetic group and a hundredfold reduction of the 1994587-hour input-representation group gives about 614480 non-finite hours or 844771 full-proof hours. Raising the arithmetic improvement to about thirteenfold would bring the latter to about 800000. These factors are targets, not measured production improvements. Even removing both groups entirely leaves about 629112 full-proof hours from the remaining rows and finite coverage; reaching 400000 also requires reducing those costs. This is only a floor under fixed-row assumptions, not a mathematical lower bound.

## Accepted map and integer transform, later 13 November

The intervening goal turns made progress. The user briefly paused and resumed; the goal is active again. On resumption the previous run was confirmed terminal and no task proof container remained live.

- Map15 passed the complete six-root reload audit. The coordinator matched all five source, eight dependency and three output pins. `c10004-map/RESULT_REVIEW.md` records the exact scope and 20.45 CPU seconds across construction, audit executable construction and audit execution. It proves the full finite unit map and retained labels, not characters or analysis.
- Transform tx05 constructed the generic reference, all eight exact fixed-depth staging equalities, the translations and ten small controls. Tx08 completed all sixteen full controls, including both entire tensor comparisons, two public checked calls, all impulse outputs and rejection of a changed output. The two checked-entry observations were 2.029 and 2.113 CPU seconds on distinct fixed synthetic inputs. `c10004-transform/RESULT_REVIEW.md` binds the successful receipts, failures and semantic limits. The reference's linked-list traversal is not the production schedule, and no forecast credit follows.
- Tx06's command-line mode was lost by the generated launcher; its control-count gate correctly failed. The runner now supplies an explicit, validated environment variable. Tx07 reached fourteen full controls before the expected impulse GENLIST lacked a translation. Tx08 translated the same expected list and passed. Both failures remain preserved.
- The layout adapter is repinned to the accepted map and has a coordinator readiness review. Layout01 evaluated the complete layout predicate to true, then failed at two unopened `I_THM` proof references. Layout02 qualifies them as `combinTheory.I_THM`; its full eight-root export and reload audit are next. No layout acceptance is claimed yet.
- A source check of `src/thm/Compute.sml`, `src/portableML/Arbnum.sml` and `poly/Arbnumcore.sml` found that the current CV instruction set exposes division and no native shift primitive. Division passes through Arbnum to IntInf division. Runtime-internal power-of-two optimization was not established. A HOL term rewrite alone does not establish a new native shift path, so the suggested shift optimization receives no saving and no benchmark is launched on that assumption.

The next performance work remains the sequential traversal refinement and actual internally generated source/transform/sign blocks. Universal outer tensor projection, analytic source correctness and the other required strata remain open. The full and non-finite forecasts are unchanged.


## Ratio targets and projection continuation

The user's renewed 1:2 question does not change the forecast. With the approximately 400000-hour historical reference, 800000 hours is the target. Holding the current other rows fixed and hypothetically reducing fresh-input translation by 100 times, the non-finite subtotal requires arithmetic improvement of 5.134 times, whereas the full subtotal requires 12.967 times. At 5.2 times the totals are approximately 795139 non-finite and 1025429 full hours. At 13 times they are approximately 569316 and 799607 hours. These are scalar sensitivities using rounded group values, not measured improvements, likelihood estimates or revised planning totals. The baseline differs in hardware and numerical scope; it is not a same-workload formal/native overhead ratio.

Layout02 is accepted for its finite scope, with all eight roots, input/output pins and receipts checked in c10004-layout/RESULT_REVIEW.md. It connects all 4800 old and tensor positions and proves the integer source-cell inequalities. Analytic radius and source consumption remain open.

The isolated C10004Projection module preserves the original generic candidate and proves the same universal retained-output equality. Projection03 terminated with exit 1 at stage40 after passing stage2 and line40. Projection04 changed only the final stage rewrite sets to preserve explicit quotient/remainder forms; stage40 and line60 then passed. It stopped at nested beta applications in selected_expand. Both expansion proofs now explicitly beta-reduce, with all failed sources and receipts archived. Projection05 is launched as the next bounded full construction and audit attempt; it is not yet an accepted result. No task process from projection03 or projection04 remains running.

There is still no complete source-to-transform-to-sign/count production benchmark. No aggregate speed credit has been assigned.


Projection05 is now terminal with theory and container exit 1. Explicit beta conversion reduced the selected_expand goal to a printed reflexive equality but did not discharge it. The next tactic repair is explicit reflexivity after conversion in both expansion lemmas. No process from this turn remains live, and no projection result or changed forecast is claimed.


## Universal projection accepted

Projection07 now proves the unconditional equality between the pruned tensor and projection of the full integer tensor for all cache and input values. The complete five-root reload audit and all source/dependency/output pins passed. c10004-projection/RESULT_REVIEW.md records the precise scope and 18.45 CPU seconds across the three full phases. No analytic or throughput conclusion follows.

An isolated c10004-traversal base module is prepared from the existing sequential candidate. It preserves the actual program apart from renaming a chunk-count binder to avoid an imported constant. Seven universal list contracts and their exact-conclusion reload audit are next. The final tensor/checked-entry refinements and CV translation are still required before matched timing. The full goal and frozen model are unchanged.


## Sequential list contracts accepted

Traversal11 passed all seven exact-conclusion reload checks and all source/dependency/output hashes. Its ten function bodies match the preserved candidate after the documented chunk-count binder rename. c10004-traversal/RESULT_REVIEW.md records the generic scope and 19.55 total phase CPU seconds. The transpose and chunk/concat identities are universal, not fixed input tests.

The separate c10004-traversal-refinement candidate now contains the complete intended tensor and public-entry refinements, supported by generic shape/index lemmas. It is repinned to the accepted base and projection artifacts and has a six-root exact audit. The matched benchmark protocol is written before observing any sequential timings. Its first build is next; no complete traversal refinement, CV execution or throughput result is claimed yet. The end-to-end forecast and full research objective remain unchanged.

## Sequential traversal refinement accepted

The preceding continuation made mathematical progress. Refinement06 is now terminal and accepted after checking its six exact reload roots, all seven expected-source pins, five run-source pins, eleven dependency/tool pins, three output pins, phase exits and container exit. The public equality holds for all roots and inputs with no added premise. c10004-traversal-refinement/RESULT_REVIEW.md records the scope and 19.67 CPU seconds across the three successful phases. This is a recorded-result review, not a fresh independent kernel replay. No task process from refinement06 remains running.

The integrated repairs address concrete type annotations in separately parsed length arguments, beta reduction before inner list extensionality and separate outer/inner column extensionality. The final tensor and checked-entry refinements passed. Stock CV translation and the matched numerical benchmark are next; program equivalence supplies no measured speedup.

The prebenchmark arithmetic price interface counts 24720 general root products, 37821 complex additions/subtractions and 219 quarter turns for the selected transform. These roles receive approximately 0.062634 seconds under the frozen planning factors, excluding the other call costs. The count is source-traced, not a proved cost theorem. The approximately two-second reference public call has a broader boundary. A large improvement against that slow reference cannot automatically be credited against an already optimistic model price.

The user's renewed ratio question leaves the planning forecast unchanged at approximately 4.351 million nonfinite hours and 4.581 million full hours. The existing favorable scenario is approximately 712920 full hours, about 1:1.78 against the historical 400000-hour reference. It assumes favorable representation, arithmetic, repair and other costs simultaneously and is not a confidence interval or an observed achievable total. No complete actual source-to-transform-to-sign/count production block has yet been accepted. The research objective remains active.


## Matched sequential traversal executed and accepted

This continuation made progress. CV01 passed the stock translations, seven controls and both independent execution-order processes. All current input/dependency/output pins, exact Boolean results, tags, markers and exits match. The separate inspect01 audit confirms that the two timed predicates execute their different programs and that all thirteen new translations are unconditional closed equalities. c10004-traversal-cv/RESULT_REVIEW.md records the scope and individual observations.

The four matched warm-median ratios are 6.233, 5.685, 5.875 and 5.700, with sequential medians from 0.369218 to 0.393946 CPU seconds. This is a verified improvement over the indexed reference only. It does not improve the frozen model by those factors; the model already assumes efficient adapters and prices only this transform's arithmetic roles at about 0.062634 seconds. The observed calls also generate synthetic inputs and caches and perform guards. No source, sign, count or literal-input-admission price is supplied by this result.

CV01 and inspect01 are terminal with exit zero. The benchmark consumed 88.17 phase CPU seconds and 210.109 container wall seconds, excluding prior dependencies and the separate inspection. The next essential work is the analytic source/error join and actual source-to-sign/count blocks, rather than extrapolating this local speed ratio. The full research goal and end-to-end model remain unchanged.


## Arithmetic-to-complex dependency build resumed in a container

The next action revalidated the existing raw-analytic dependency stage and launched build_existing_container.py. It preserves the original WSL runner, original sources and accepted graph evidence. The new launcher uses the pinned offline image, one CPU, four GiB, a read-only workspace, and only the staged dependency directory and fresh build-container01 receipt directory writable. The local helper target is unchanged. It has a 1800-second build limit and no automatic retry.

The old forty-object starting set and all original/staged source bindings passed before launch. The current build began the sixteen missing local theories and exported realTheory. It is not yet a completed bridge. The authoritative process handle at this checkpoint is unified session 17426 and the named container is tg-hol-raw-analytic-build-container01. Inspect its live handle and terminal receipt before retrying or editing the staged source. The exact seven-root helper audit has been prepared separately in raw-pair-round-audit but is unbuilt. This work supplies no numerical throughput credit.


## Analysis libraries completed; first bridge proof repaired

The raw-analytic build-container01 process is terminal with exit 1 after all fifteen missing standard theories built. The helper stopped at an unopened realTheory name before proving its first lemma. All 142 library object inventory pins match and source/log preservation passed. raw-analytic/DEPENDENCY_RESULT_REVIEW.md records 234.62 CPU seconds and the limited accepted dependency scope. Session17426 is no longer running.

The isolated raw-pair-round-proof copy adds real as a direct ancestor, already present transitively. Pair01 then stopped because Holmake needed to refresh dependency metadata in the read-only library stage. A private metadata-only mount resolved that issue without making sources or proof objects writable. Pair02 reached the first lemma and failed in its broad simplifier. Residualdiag01 identified loss of the transported real inequalities; residualdiag02 proved the exact closed theorem using only the explicit cast rewrite rules. Pair03 integrates that one proof-body change and is the current bounded build, unified session54321 and container tg-hol-inspection-pair03. Inspect its actual handle and receipts before any retry.

The separate raw-pair-round-audit directory contains all seven exact expected conclusions and a runner, but its source/output pins and execution await the completed helper. No helper-wide acceptance, analytic source, production throughput or aggregate forecast improvement is claimed yet. The goal remains active.


## Rounding-to-complex bridge accepted

This continuation made progress. The fifteen missing standard analysis theories built, followed by the repaired seven-lemma RawPairRound helper. Pair05 and rawaudit03 are accepted for the exact generic local-error scope after all source/dependency/output pins, expected conclusions, empty hypotheses, allowed import tags and standard HOL ancestry checks passed. Both program definitions and all seven theorem statements match the original candidate exactly. raw-pair-round-proof/RESULT_REVIEW.md is the authoritative acceptance record.

The integer four-product/two-rounding program now has a proved Euclidean complex error bound of one output grid step and coordinate half-step bounds for arbitrary signed numerators and distinct positive scales. The final successful construction and audit phases consumed 30.29 CPU seconds, separate from 234.62 CPU seconds for the new dependency build and all preserved failed/diagnostic work. No numerical throughput price follows.

The saved-state repairs preserved transported real inequalities and made absolute-division/positive-grid identities explicit. Pair04 proved the first four lemmas before a pair-theorem namespace fix; pair05 proved all seven. Audit metadata overlays keep imported sources and proof objects read-only. The audit uses PRE_INCLUDES for the completed helper because the preserved failed candidate shares its theory name. Its dependency record and compiled module were checked to bind the corrected path.

All processes from pair03, pair04, pair05 and rawaudit01..03 are terminal. No proof process from this continuation remains running. The next necessary connection is SourceArithmetic.source_mul to the accepted helper, followed by the actual persistent recurrence and certified initial/step producers. The genuine complex modulus triangle inequality must be proved or found; similarly named complexTheory results are not that inequality. Actual complete source/sign/count blocks and the other campaign strata remain open. The frozen forecast is unchanged and the full goal remains active.


## Actual source-state recurrence accepted

This continuation made progress. State03 proves the actual stored recurrence's all-index error envelope and passed all eight fixed exact-conclusion reload roots, the standard HOL ancestry/tag checks, nine expected-source pins, six run-source pins, forty-seven dependency pins and three output pins. The original eleven theorem statements and two definitions are unchanged. source-state-error/RESULT_REVIEW.md records the conditional scope and 30.77 successful phase CPU seconds. The run is terminal.

The repairs use transitivity for the triangle cross term and explicit complex types in separately parsed product instantiations. Typed diagnostics exposed scalar multiplication with different real free variables in the unsuccessful tactic; no theorem statement or producer premise changed. Initial accuracy, step accuracy and the analytic target identity remain required. The next source-state-bounds candidate gives a finite-prefix linear bootstrap and the actual raw state's 90000-step, 2^-96 bound under those producer premises, avoiding expansion of all updates. No complete source/sign/count block or forecast saving is claimed. The full goal remains active.


## Uniform 90000-step error bound accepted

Bounds01 passed all three original exact roots and all input/dependency/output checks on its first build. source-state-bounds/RESULT_REVIEW.md records 32.80 phase CPU seconds and the conditional scope. The actual raw source_state has error strictly below 2^-96 through 90000 updates if the declared initializer, step and exact target contracts hold. The linear bootstrap keeps the cross term and avoids evaluating a 90000th geometric power or unfolding the updates. The generic analytic bound is checked once.

This closes the persistent-error transport component. It does not discharge the initial inverse-root, logarithm, exponential or analytic target premises, and does not supply an actual complete source/sign/count block. The next available work is the existing ROOT-based initializer's adjacent-square certificate and real approximation theorem. Both state03 and bounds01 are terminal. The forecast and full objective remain unchanged.


## Actual integer inverse-root accuracy accepted

Inverse03 passed all four exact roots, standard HOL ancestry/tag checks and all nine expected-source, six run-source, forty-seven dependency and three output bindings. source-inverse-root/RESULT_REVIEW.md records 18.08 successful phase CPU seconds and the scope. The executable ROOT-based rational initializer now has its adjacent-square enclosure and strict real accuracy abs(r/S - sqrt(D/A)) < 1/S under positive A,S, without an externally assumed root witness.

The proof fixes a reserved local S binder and lexical spacing around casts. The source statements and fixed audit retain their original mathematical content; the audit change is only the required whitespace. The next precise contract is source_initial A D amplitude_bits state_bits = SOME initial implying the actual complex grid value's error and the exact amplitude's norm. NEXT_INITIALIZER_CONNECTION.md records that contract, raw/EM parameters and the separate unproved EM recurrence specialization. Logarithm/exponential step production and exact analytic source joins remain open. State03, bounds01 and inverse03 are all terminal. There is still no complete actual source-to-sign/count production benchmark, and no aggregate speed credit has been assigned. The full goal remains active.


## Initializer representation error found; dependency repair in progress

The SourceInitial integration exposed an actual type mismatch: SourceArithmetic.source_initial and both wrappers returned (rat # int) option, whereas source_state requires int # int. The first coordinate lacked a type annotation and an imported rational overload captured it. The earlier three source roots did not cover the initializer. Typed evidence is retained in source-initial/initialtypes02_run.

The producer now explicitly uses (int # int) option and an integer first-coordinate cast. Its mathematical algorithm is unchanged. The strengthened audit adds seven program-type checks and the exact initializer definition. Before editing, the accepted source and dependent theory artifacts were archived under each history/before_integer_initializer directory. Their current reviews are marked pending revalidation. Rebuild SourceArithmetic, SourceStateError, SourceInverseRoot and SourceStateBounds before resuming SourceInitial. This does not alter the full objective or forecast.


## Corrected integer dependency chain accepted

Sourceint01 passed the exact initializer-definition root, the original three generic theorem roots, seven explicit program-type checks and all source/dependency/output pins. Both source_raw_initial and source_em_initial now return integer pairs. The only producer changes are explicit initializer result/cast types; the guard, root expression, exact shift and other definitions are unchanged.

Stateint01, inverseint01 and boundsint01 then rebuilt and passed their original eight, four and three exact audit roots against that corrected producer. Each module's source and audit are byte-identical to its archived pre-correction version. Their RESULT_REVIEW.md files now contain current accepted bindings and timings. These three runs are terminal; the temporary pending notices are superseded.

SourceInitial initial03 is now the bounded active build using that accepted chain. The earlier initializer candidate's standalone grid-factor helper required one explicit natural-base annotation, documented in source-initial/STATEMENT_CORRECTION.md. Its final accuracy contract is unchanged. Separately, source-log-real/DERIVATIVE_PLAN.md records a route to the logarithm tail bound using existing HOL differentiation and mean-value theorems, with no imported Lean theorem or new analytic assumption. There is still no complete production source/sign/count block and no aggregate forecast discount.


## Actual complex initializer accepted

Initial03 now proves the actual guarded initializer's complex accuracy and exact amplitude norm from only its successful option result. All seven exact roots passed the fixed audit, standard HOL ancestry/tag checks, fifteen expected-source pins, six run-source pins, fifty-one dependency pins and three output pins. Corrected parent manifests were rechecked. source-initial/RESULT_REVIEW.md records 32.22 successful phase CPU seconds and scope. No initial-value identity or initial-error premise is assumed.

The complete current chain uses the corrected integer source_initial codomain. The standalone grid-factor helper's explicit natural annotation is the only statement correction inside SourceInitial; the final contract and other six statements are unchanged. Sourceint01, stateint01, inverseint01, boundsint01 and initial03 are all terminal and accepted. The next open producer component is the actual logarithm/exponential phase step. source-log-real/DERIVATIVE_PLAN.md specifies the logarithm tail route against existing HOL APIs. Complete source-to-transform-to-sign/count blocks and the other campaign strata remain open, so the forecast and full goal remain unchanged.


## Analytic logarithm tail accepted

This continuation made progress. Logtail05 built and exported SourceLogTail, then passed all twelve exact expected conclusions, empty-hypothesis and standard HOL ancestry/tag checks. Five expected-source, six run-source, forty-one dependency and three output hashes match. source-log-real/RESULT_REVIEW.md and review_result.json record the accepted bindings. Successful construction/audit phases consumed 34.89 CPU seconds and 163.363 elapsed seconds. Recorded experiment phases including all retained failed and diagnostic runs total 156.65 CPU seconds, excluding untimed orchestration and file handling. No production-throughput price follows.

The module proves the exact remainder derivative and mean-value bound for the explicitly defined finite logarithm polynomial, uniformly for 0 <= v <= 1/3. Forty-five terms give error at most 2^-135, including ln(2). The original twelve theorem statements and two definitions are unchanged. The induction repair uses explicit denominator cancellation and distributivity; the endpoint proof states positivity explicitly and avoids destructing an existential witness already introduced by the by tactic.

The original audit generator accidentally retained an unrelated SourceInitial ancestry/root block after the intended logarithm roots. Logtail04 therefore failed before any root audit could be accepted. A fresh-state diagnostic matched all twelve actual logarithm statements, and the foreign block was removed without changing their expected terms or validation loop. The final review verifies that exact audit-source correction. Original candidates and failed runs are preserved; none receives speed or theorem credit. This is recorded-result review/reload, not independent whole-kernel replay. All runs from this continuation are terminal.

The next required proof is the actual source_log_horner refinement and rounding bound, followed by source_log_center and range-reduced source_raw_log129. source-log-real/NEXT_INTEGER_CONNECTION.md gives the exact contraction argument and source contracts. The analytic tail does not certify those executable producers. Exponential production, source-to-transform-to-sign/count blocks and the remaining campaign strata are still open. The frozen forecast hash is unchanged; no aggregate discount has been assigned and the full goal remains active.


## Actual integer logarithm Horner refinement accepted

This continuation made progress. Horner02 built and exported SourceLogHorner and passed all thirteen original exact conclusions, three exact program types, empty-hypothesis and standard HOL ancestry/tag checks. Seventeen expected-source, six run-source, forty-nine dependency and three output bindings match. The original theorem statements, ideal recurrence definition, fixed audit and parent artifacts are unchanged. source-log-horner/RESULT_REVIEW.md and review_result.json record the accepted evidence. The accepted SourceLogTail bindings were separately rechecked.

The actual source_log_horner recurrence differs from grid times its ideal real recurrence by at most one integer unit, for any term count and starting index, when B > 0 and 3*A <= B. The polynomial identity is proved. The actual source_log_center, including its final rounding, has normalized polynomial error at most 7/(4*grid). Its 45-term reduced-logarithm error is therefore at most 7/(4*grid) + 2^-135, including the actual computed ln(2) center. No externally assumed log value or rounding accuracy is used.

The successful build/audit phases consumed 67.96 CPU seconds and 215.221 container elapsed seconds. Recorded experiment phases including failed and timed-out diagnostics total 350.94 CPU seconds, excluding untimed orchestration and file handling. These are generic proof-development timings, not numerical production prices. The repairs replace an incorrectly directed cast rewrite, use the proved rational-square equality, replace broad square simplification by direct cast theorems, normalize scalar error hypotheses, and avoid a looping symmetric absolute-value rewrite. BUILD_NOTES.md and preserved candidates record the failures. All runs from this continuation are terminal.

The next required join is source_log_domain, the exact range-reduction identities and final raw-log regrid. source-log-horner/NEXT_RANGE_CONNECTION.md specifies the actual source_raw_log129 target and its exact numerical error budget. The exponential phase and complete source/sign/count blocks remain open. This is recorded-result review/reload, not independent whole-kernel replay. The frozen forecast hash is unchanged, no aggregate speed credit is assigned, and the full goal remains active.


## Actual range-reduced raw logarithm accepted

The preceding ratio-answer turn made no implementation progress. This continuation
made progress: range03 built SourceLogRange and executed its fixed audit. All
eleven exact closed conclusions, four exact program types, standard HOL ancestry
and permitted import-tag checks passed. Twenty-one expected-source, six run-source,
fifty-one dependency and three output bindings match. All original theorem
statements, both definitions and the fixed audit are unchanged. The accepted
Horner parent bindings were separately rechecked. source-log-range/RESULT_REVIEW.md
and review_result.json are authoritative for this component.

The final theorem proves accuracy of the actual source_raw_log129 k x, normalized
by 2^129, within 2^-128 under source_log_domain x 1 k and k<=18. It uses the actual
computed ln(2), actual reduced center and actual final rounding. No supplied
logarithm approximation or rounding premise is assumed. The intermediate
numerator bound is (k+1)*(7/(4*grid)+2^-135); final rounding adds at most 2^-130.
The exact range identities, positive-input logarithm decomposition and final
numerical budget are proved. Concrete source inputs must still establish the
domain and exponent gate.

Successful construction/audit phases consumed 55.57 CPU seconds and 190.566
container elapsed seconds. All recorded experiment phases total 152.33 CPU
seconds, including retained failed construction and diagnostics, excluding
untimed orchestration and file handling. No production-throughput saving follows.
BUILD_NOTES.md records the local-name collision, natural product association,
variable-power positivity, cast spacing, division theorem name and final grid
normalization repairs. No precision or term schedule changed. Every run from
this continuation is terminal.

The next phase producer target and inspected HOL APIs are recorded in
source-log-range/NEXT_PHASE_CONNECTION.md. Existing EXP_IMAGINARY, MODU_UNIT,
COMPLEX_MUL_ARG, COMPLEX_EXP_ADD and MCLAURIN_ALL_LE support a real-component
route. A loose phase bound of 2 permits a proposed unscaled Horner rounding
bound of 9 with the existing 72 updates. The proposed total budget is strictly
below 2^-120 by a separate exact-rational calculation, but the producer
refinement, Taylor specialization, phase range and Lipschitz proofs remain open.
The EM phase has separate period-reduction and pi requirements.

This is recorded-result review/reload, not independent whole-kernel replay.
Complete source-to-transform-to-sign/count blocks and the other campaign strata
remain required. The forecast hash is unchanged and the full goal remains active.

## 20 November 2026 measurements

The [new cost comparison](price-check-20261120/README.md) records actual large-family transform and sign-margin HOL checks at conductor 10,004, two high-height native reference nodes, the band-1 P27-to-P20 source, and an independent native wide Bluestein slice at conductor 10,000. The same comparison includes native small-character zero counts and the principal reciprocal head through height 1,500. Each measurement states which analytic obligations and data costs are still open.

The first measured fused sign check used 39.91 CPU seconds for two heights versus 37.94 for explicit spectrum output. The next implementation aims to admit the character phase cache once for many heights. Character projection removes about 106,000 hours from two small-family rows if the frozen unit prices hold. Measurements across the remaining workload are still needed to narrow the 4.35 million-hour planning estimate.

The shared phase cache and packed input experiments now have measured results. A complete integer P20 and raw-head to sign calculation at conductor 10,004 and height 5/64 used 0.961 kernel CPU seconds. The two intermediate arrays passed a separate full equality check. A p307 length-500 HOL transform took 0.131–0.142 kernel CPU seconds using balanced exact integer convolution. On a repeated three-product test the arithmetic alone took 3.55 ms versus 2.71 ms in native FLINT. [Updated comparison and outstanding costs](price-check-20261120/README.md)

The new band-1 budget test prices the proposed large-character transform and the small-time multiplications at their native estimates. Even under that assumption, staying inside 400,000 hours requires at most 15.39–18.33 microseconds per remaining band-1 residue if it receives every unassigned hour. Actual low and high band-1 scalar HOL pilots measured 49.51 and 83.67 microseconds per residue. This comparison supports further experiments on batched source certificates, formal tile throughput and production input reuse. It does not establish a global runtime or charge the remaining count and repair work. [Budget calculation](price-check-20261120/remaining_budget.json)
