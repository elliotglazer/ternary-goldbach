# Prepared conversion: independent source review

Reviewed 2026-11-13. Verdict: **source-level PASS for a bounded smoke run of the repaired snapshot**, with the measurement qualifications below. This is not a compiled API verdict, an accepted new theorem, a timing result or approval to revise the campaign forecast. No build, HOL execution, native evaluation or benchmark was run by this reviewer. Only source reads, hashes and fixed textual comparisons were performed.

The earlier `EXPERIMENT_PLAN.md` is a design document. Its original adapter pin and “no runnable benchmark” status are superseded by the repaired sources and README pinned here. Its proposed semantic and measurement boundaries remain the review standard.

## Stock semantics and retained state

`PreparedEval.finish` follows `cv_transLib.sml:973–1002` exactly for the `cvEval EVAL` route: apply `cv_rep_eval`, apply the current from/to theorem, discharge representation premises around the stock conversion, then use a single `RAND_CONV EVAL` for decoding and discharge the remaining truth implication. The nested `RAND_CONV` applies to the CV evaluation step only. The imported signatures expose every called API.

`cv_computeLib.sml:132–141` already caches initialization of characteristic equations. The proposed change does not claim to remove that work anew. `Compute.sml:621–639` constructs the code-equation vector and translated expression bodies before returning a function; each application still parses the supplied term, calls `exec`, and reifies its result. `Thm.sml:1515–1561` checks that code equations have no hypotheses, combines their dependency tags, and returns an ordinary stock `Count.Compute` equality. Retaining this returned conversion retains validated code. It does not cache the final evaluation theorem or the final boolean answer. Existing small-numeral reification caches are stock behavior, not a new optimization.

Every application obtains the current input representation theorem, from/to theorem and ordered equation list. It requires an input without free variables and equation theorems without hypotheses. The retained path compares every ordered equation conclusion by `aconv` before applying the old conversion. Old theorem objects remain actual dependencies. Matching theorem conclusions is sufficient here because the old closed proofs remain valid; a different proof object or dependency tag is not silently substituted into them. A different ordering may cause a conservative miss. Printed IDs and hashes do not authorize computation.

The new `recorded` registry stores equation metadata, not answers. Its exported `prepared_equations_ID_INDEX` theorems and set/member/use records permit later inspection of exact ordered equations and their uses. Their construction, lookup, retention and export have costs. They must not be described as free or as measured compiler work.

## Exact driver and controls

Independent textual comparison with the pinned `dependent.sml` matched all 768 numeric strings in the original/changed input and coefficient arrays, all four complete fixture expressions, and all five complete corruption-call lines. The program still calls the same `block_accept` and `block_accept_sound` definitions. Only result-theory naming and the driver/instrumentation change.

For each depth 1, 8, 32 and 128, all three selected results must have exactly the requested LHS, RHS `T`, and no hypotheses. They are compared to a stock `cv_eval` reference run after those calls. The first selected result then supplies the unchanged soundness theorem, yielding an existential final vector with length, complete dependent local-residual relation, bound and checksum. The checksum is not an injective commitment and the final theorem is not an analytic transform statement. Changing the result theory name is not a change to the literal values or mathematical contract.

The five original changed claims are checked against stock `F` and the selected path's same exact false equation. Changed input or coefficient definitions can change the equation set. The retained route logs HIT/MISS and on MISS constructs and pays for a new compatible conversion. A cache exception does not count as a false mathematical proposition.

The requested repair is present: the driver applies an actual fixture-8 retained closure to `T`, after verifying that its equation set differs. Only `PreparedEval.CacheMismatch` makes this control pass; success, another exception or a resource failure aborts. This establishes the intended guard behavior if the run succeeds. It does not assert that `T` is false. The earlier empty-versus-nonempty predicate check remains an additional structural check.

The source audits the imported context against the four named stock HOL axioms and excludes oracle tags other than the existing `DISK_THM` import tag on exported results. A result audit must still inspect the actual logs, all expected roots and exported theory contents. This is the stock HOL saved-theory/compute assurance boundary, not a separately replayed elementary inference trace and not Lean's three-axiom boundary.

## Timing, resources and remaining run gates

The adapter now uses its own polymorphic timer and the driver uses the aligned prefix API. Each timer executes its callback once. Fresh and retained modes both perform discovery, evaluation, decoding and normalization on each call; retained mode additionally validates equation identity. Prebuild work is separately timed.

There is an important first-call qualification: stock/fresh `set_case` performs metadata discovery before the three timed evaluations; retained mode performs discovery and conversion prebuild. Thus the first selected call is **post-discovery**, not a pristine cold `cv_eval` call. The reference being after the selected calls avoids reference-evaluation warming, but does not undo metadata warming. Include metadata/setup in first-acceptance accounting. Previous depths also warm the same process. These are three fresh processes per mode in `full`, not one fresh process per depth or per call.

Equation recording is inside the fresh/retained call wrappers and changes their measured overhead relative to stock. Report its phase rather than silently subtracting it. Repeated phase labels such as `positive_discover` must be paired with the ordered enclosing depth/call records, not pooled across depths. A failed timed callback need not emit a completed phase line; missing lines are failures, not zero durations.

The runner uses a 4 GiB virtual-memory limit and 600-second per-phase timeout, sequential modes, and `Holmake --no_prereqs` with existing dependencies. Smoke runs one process per mode; full runs three per mode with different mode orders. It pins sources, cached project objects/data, toolchain and the built executable, and now rechecks the executable afterward as requested. It retains each exported `.dat` separately. Root must inspect actual build behavior to confirm no dependency rebuilding and distinguish a fresh owned build from an already up-to-date executable. Failed attempts stay in the engineering record.

The preliminary marker checks are not a result auditor. Before publishing numbers, require all expected cases, three calls per case, all five false controls, the actual incompatible-closure marker, equation-set records, allowed tags, successful unchanged-input checks, complete resource/exit records and corresponding exports. Confirm the exported equation theorem names/counts match their logged IDs. Preserve first calls and all raw observations. A later result audit must detect incomplete or failed processes. No current measurements exist in this source-review scope.

Whole-process cost contains imports, literal creation/translation, metadata, prebuild, repeated evaluations, stock references, controls, derivation and export. Nested phase timings are diagnostic subsets, not quantities to add to that process cost. An operational “first acceptance” reconstruction must include its source/setup, one evaluation, normalization, soundness and required export, while identifying audit-only references and controls separately. Do not call the full multi-call process exactly one production block, or call its warm per-call median full first acceptance.

## Native and campaign interpretation

The unchanged native program's timed `accept` copies inputs, computes the dependent block, checks bounds and checksum. Decimal input construction and its every-coordinate validation occur outside that timer. The HOL selected-call timer includes stock compute plus proof transport and normalization, while initial literal translation and generic imports are separate. A ratio of those two timers is a named boundary comparison, not a universal kernel penalty or a full native-versus-formal production ratio. Current hardware, process state and input/width identity must be stated before comparing to older observations. A fresh matched native measurement is needed for a contemporaneous timing claim.

The repeated positives use the same named payload. This design can test whether retaining a validated conversion is worthwhile for that fixed equation set. It cannot establish that new spectral inputs share the same equations, or that compiled code survives actual shard lifetimes. For legal reuse count q, let P be prebuild/setup, F the complete fresh per-call cost and R the complete retained per-call cost including identity/metadata overhead. The local decision is `P + q*R < q*F`. Source representation, cache eviction and export differences must be included when applying it. Neither q nor the sign of the saving is known before measurement.

| Campaign row | What this experiment could inform | What it cannot justify |
|---|---|---|
| Computational acceptance factors for repeated dependent blocks | A measured conversion-construction versus retained-call decomposition at this fixture and width | Multiplying every root product, small transform or Horner stage by one ratio; those use different equations, widths and call partitions |
| Scheduling/setup and compiled-code cache cost | One-process prebuild and identity-check overhead, with observed memory | A global cache lifetime, shard import reduction, parallel scaling or free reuse across distinct payloads |
| Literal representation / cache-input translation | No removal in this design: those operations remain | Deleting the model's roughly228-core-year representation row or refunding input/root construction |
| Sources, root/kernel enclosures, input regrids and output export | No analytic producer change | Any reduction in EM/raw-head mathematics, coefficient uncertainty, source-to-transform binding or exported payload requirements |
| Sign repair, principal/nonprincipal counting, finite binary/ladder and analytic library | No direct evidence | Success rates, termination, a smaller obligation domain, library-port completion or end-to-end hours |

Stock code retention could eventually reduce the preparation part embedded in a computational acceptance row. A measured saving must first be mapped to actual call counts and compatible equation-set lifetimes. Do not also remove that same preparation from a separate setup row. No campaign forecast changes follow from this source PASS.

## Frozen source pins

Files in this directory:

| File | SHA256 |
|---|---|
| PreparedEval.sml | 13A8941A49FA2CB238370008B10D13FC106C42B95353E18EB145683776D27807 |
| prepared_dependent.sml | 50077F647A0BC91B892FC6DBB3ABAC95D4B0B5084872A8BAAC2C0D6E35EDEEA4 |
| run_prepared.sh | 3B740086C559D504BBE511B539E5320672ED391ED428C6B6FF06A5D02072DFA2 |
| source_binding.json | C8AC01601409B2808CCC37765CFB16D2CCF555996F3405CA1A5106D7557218F2 |
| README.md | 52A6ADDF1E3B9B473493C236272C4C53133861F19969529B6F7C30DEF24A3162 |
| EXPERIMENT_PLAN.md | BAF941FEC493C45AC5EF4D0DAA9EBF4D02C06C58B2572848415A38F9A614B388 |
| Holmakefile | 7B26B317D9206D44FF0F047CEE729D31CE0820327C8186AC4E3E81A9CFE32E11 |

Under `../../hol4-setup/`:

| File | SHA256 |
|---|---|
| dependent.sml | ECB62C8C7B1F1AAAA8DF9617DAF4145D7FCADBEEDD9CF8579D3F57962C5E1AB1 |
| DependentBlockScript.sml | 1A57F4025ED1A7B9C5A823D5F6B73B2A7BE02B109F21AD13D24214EA52D9D665 |
| dependent_native.cpp | 69C79AE3FE466CCAB0B97914AFB8CC09A0BDAC8FB3BDAE94DF38D47FB6E99887 |

Under that directory's `HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/`:

| File | SHA256 |
|---|---|
| thm/Compute.sml | 7DAB9DD6E848FDFE2EB7869865031CFDADBA44A2FB3D7E74D98CEA77F712E059 |
| thm/Thm.sml | E0A9F3C274BAB9BE04922D83535A660833A6EF8409F9C02BA9610DDEDAE3FF45 |
| num/theories/cv_compute/cv_computeLib.sml | B66D57885CB0D2DCF49F5D5FEC665CB5FDCA4EDB9F726A2CED0AD579CDD08B6C |
| num/theories/cv_compute/automation/cv_transLib.sml | 182DABE3CDFD677E1EC8ED4DDD0E8EA3F6D6584D801CAE7F13EE01A203C5647F |

The imported API signatures were also inspected. No candidate source was edited by this reviewer. Only this review was written.
