# mellin strip — 2026-11-13

## 05:58:13 UTC · Final

Last task: independently review the uniform finite-U scalar budget. Completed.

Saved `mellin/REVIEW_FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md`, SHA `2D8AA8B58F64AC7DCF82887F6EECAF973F06EC0DD12EC68592F9DD243314C7CF`.

All bounds passed 76 exact checks; review records one harmless strict-endpoint wording correction. Nothing is currently active.

## 06:18:36 UTC · Final

The QRH provider’s visible statement and several proof components have been reviewed, but **its complete elaborated proof and standard-axiom closure have not been validated**.

- **Exact consumed theorem:** `OAI.DirichletCharacter.LFunction_ne_zero_of_seven_eighths_lt_re`, in [Nonvanishing.lean:19](../../../work/openai-math/lean/OAI/NumberTheory/DirichletL/Nonvanishing.lean:19), from `openai/math` commit `4eaee87548250b2682affda7d05d947c05554bae`. It quantifies over `{q : ℕ} [NeZero q]`, every character χ and complex s, assumes `7/8 < s.re` and `¬(χ=1 ∧ s=1)`, and concludes nonvanishing of the explicitly rooted **actual Mathlib** `DirichletCharacter.LFunction`. No height, conductor or primitivity restriction appears.

- **Statement/source audit performed:** [PROVIDER_COMPATIBILITY_CUT](../../../work/qrh-campaign/agents/integration/PROVIDER_COMPATIBILITY_CUT_2026-11-11.md) checks that source meaning and the relevant old/new Mathlib definitions. [QRH_PROVIDER_STATIC_TRUST_REVIEW](../../../work/qrh-campaign/agents/audit/QRH_PROVIDER_STATIC_TRUST_REVIEW_2026-11-11.md), SHA `90E6426099124B1E446E48AF7DB0A099256CAD39FD4F87517ABA16DFE76B9560`, independently checks the source inventory and visible premise discharge. It explicitly does **not** establish elaboration, mathematical proof validity, or transitive axiom closure.

- **Minimal selected interface:** [GLOBAL_PROVIDER_NEXT_PROOF_OBLIGATIONS](../../../work/qrh-campaign/agents/integration/GLOBAL_PROVIDER_NEXT_PROOF_OBLIGATIONS_2026-11-11.md) consumes that Dirichlet export alone, obtaining the zeta case through modulus one. This avoids relying on the separate zeta export’s pointwise convention at \(s=1\). Reflection and actual-carrier/order adapters are established on paper but still need implementation.

- **Still conditional:** compatible full-provider elaboration; expanded type/name-resolution checks; transitive axioms restricted to `propext`, `Classical.choice`, `Quot.sound`; and the required consumer adapters. The comparator configuration is not a completed run and has `enable_nanoda=false`. The 24 prerequisite build receipts do not validate this provider. Later bounded mathematical audits advance individual proof components, but the [current checkpoint](../../../work/qrh-blueprint/RESEARCH_CHECKPOINT_2026-11-11.md) continues to mark full provider validation open.

No audit, build, proof or forecast was rerun.

## 06:21:54 UTC · Final

The smallest next provider step is **one isolated elaboration of the original `OAI.NumberTheory.DirichletL.Arithmetic.EisensteinCoordinates`**. It is the first entry in the saved QRH order and has no project-owned dependencies. No provider success receipt exists.

Existing preparation:

- Original OAI source: [work/openai-math/lean](../../../work/openai-math/lean).
- Patched external checkouts and provenance: [work/qrh-dependencies/README.md](../../../work/qrh-dependencies/README.md) and `patched-module-closure.json`. These contain the upstream **4.34.1** patches; they are not a completed 4.35 port.
- Saved first-module order: [qrh-modules.json](../../../work/qrh-campaign/agents/integration/qrh-modules.json).
- Provider driver: [build_qrh.py](../../../work/qrh-build/build_qrh.py), SHA `F58B855CA9C176C8BAF7AA8EB99F577313F6AE2404CFA249CAE10B5AF2285CBE`. That directory currently contains only this script.

**Do not use that provider driver for reusable publication yet.** It checks dependency timestamps and writes directly to final artifact paths. The existing ledger explicitly requires adapting the reviewed staging/receipt protocol first. Its reference is [build_project.py](../../../work/qrh-campaign/agents/integration/build_project.py), unchanged SHA `D70B96192B3CCCD9FB6E43095082CD35AFF8F0CE1F4F16915A730D9304F23704`.

The bounded diagnostic command, **not executed**, is:

Run from the OAI source root. Set `LEAN_PATH` to the fresh staging directory, then the existing Mathlib artifact directory and other package artifact directories under:

Capture the exit, log, source/compiler hashes, options and resulting artifact inventory. Keep outputs quarantined until the receipt protocol validates them. No Lake invocation or dependency rebuilding is needed for this first leaf.

**The 24 receipts are separate Goldbach prerequisites**, in [integration/logs](../../../work/qrh-campaign/agents/integration/logs), with artifacts beside them under `integration/artifacts`. They end at `Explicit.ZetaDatum`. `ZetaExplicit` has no success receipt and an empty log; the ledger records deliberate interruption, not a diagnosed Lean error. [RESUME_PROVIDER](../../../work/qrh-campaign/agents/integration/RESUME_PROVIDER_2026-11-11.md) records their previous hash validation.

No known provider compilation failure is recorded. The concrete risks are untested 4.34→4.35 compatibility and the unready provider publication driver. A successful first leaf would resolve only that leaf’s elaboration, not the seven-eighths theorem or its axiom closure.

## 06:28:17 UTC · Final

Prepared [probe_first_leaf.py](../../../work/qrh-build/probe_first_leaf.py), SHA256 `0EC010CD14621CC3E19C3456A72D81F3B358B2D56F674C5B209BDF12105C94BE`.

It requires `--run`, uses one Lean worker, stops at observed 4 GiB private memory or 600 seconds, and preserves logs, telemetry and outputs in fresh quarantine. Nothing is published or marked as provider validation.

**Not executed or syntax-tested.** Ready for root review.

## 06:43:15 UTC · Final

Saved [FIRST_LEAF_MEMORY_ANALYSIS.md](../../../work/qrh-build/FIRST_LEAF_MEMORY_ANALYSIS.md), SHA256 `475EA94FAE8DC58C63E7DD0DB984848097383B62DB40393581A2DC886E4E476C`.

Three controls are staged under `work/qrh-build/memory-probe`: original imports only, narrowed imports only, and narrowed imports with byte-identical full body.

Key finding: 4.448 GB was private committed memory; peak resident working set was about 207 MiB. The empty log does not establish whether imports caused the stop. Existing narrowing removes only 196 of 4,023 reachable names.

Recommended first diagnostic: original-header-only control under unchanged monitored limits. No Lean ran; originals and dependencies remain unchanged.

## 06:46:54 UTC · Final

Prepared [probe_leaf_imports.py](../../../work/qrh-build/probe_leaf_imports.py).

SHA256: `6692BDC8AB6DE8C4D04868B1F8C79EDD5FEDE08B8008D46624ABE737672D1404`

It pins the monitor and inputs, preserves the 4 GiB/600-second limits, reads package metadata from the original provider, and isolates every attempt. Supports all three variants with explicit `--run`.

AST syntax check passed. No import, Lean launch, or existing-file change occurred.

## 06:54:21 UTC · Final

Prepared [probe_leaf_mapping.py](../../../work/qrh-build/probe_leaf_mapping.py), SHA256 `7957C844561C77DFF93F24348C07930AD670779392A49ADDC7A08B15F91BF0F1`.

It preserves the pinned runners and limits, adds bounded mapping observations and system-memory snapshots, and records incomplete scans explicitly. No mapping scan delays termination once the 4 GiB threshold is observed.

AST check passed; no import or launch occurred. Updated analysis and post-stop snapshot are saved.

## 07:35:41 UTC · Final

Saved [HISTORICAL_EVIDENCE_AVAILABILITY.md](../../../work/backend-costs-20261112/HISTORICAL_EVIDENCE_AVAILABILITY.md).

- Platt’s public code survives, including interval-output and Turing-check routines.
- LMFDB provides documented zeta ordinates and count metadata; its inspected format does not contain full sign/Turing calculation transcripts.
- No complete public certificate archive for the full 2013 Dirichlet computation was located.
- Binary Goldbach statistics and demonstration sieve code survive; complete witness availability remains unknown.
- Ladder witness deletion is explicitly documented and must not be generalized to the other computations.

SHA256: `E5B01079F3C8CD79E189E1C3AA5C7C4339780102C0DD6AD8EA176BEEDB2A09E4`.

## 08:26:47 UTC · Final

Prepared [design and correctness obligations](../../../work/backend-costs-20261112/hol-platt/compiled-evaluator/DESIGN.md) and an isolated same-AST prototype.

Key finding: stock arithmetic already uses SML function closures. The proposed change removes repeated expression-tree dispatch, while retaining native Arbnum operations and recursive semantics.

Design SHA256: `B06A8D094212627C6AE635ACAB356E304473971E0B8B8C93C4089DE51B0E11D6`.

No SML execution, benchmarks, kernel changes, or equivalence claims. The next gate is isolated typechecking and differential testing.

## 08:32:47 UTC · Final

Prepared the [runnable harness handoff](../../../work/backend-costs-20261112/hol-platt/compiled-evaluator/HARNESS_HANDOFF.md).

It includes 259 planned semantic checks, the exact four dependent-workload fixtures and five corruption controls, shared-AST comparisons, and separate compilation/evaluation/reconstruction timings.

Source checks passed. No SML build or execution occurred; the kernel remains unchanged.

Handoff SHA256: `EE984CF627D67C461803222CB1E5F0D4BDA1F1F9A2D3914146A58772EA3FDF99`.

## 08:39:53 UTC · Final

The experiment is ready for a **diagnostic build and bounded smoke run**, not yet a trusted evaluator replacement.

Current source review is PASS: [REVIEW.md](../../../work/backend-costs-20261112/hol-platt/compiled-evaluator/REVIEW.md), SHA256 `04585762F957E620831B952A2109D62FF89C04DE3C40F49530627EF5CDA029B9`. The nine required `StageCheck`, `BlockRound`, and `DependentBlock` `.uo/.ui/.dat` files are present. No candidate executable or local build outputs were present in my inspection.

Minimal sequence after the current jobs finish:

1. On Windows, run `verify_harness_sources.py` with the existing `interval-env` Python. Its manifest contains absolute Windows paths, so do not invoke that checker unchanged inside Linux.
2. In the existing Linux environment, from `work/backend-costs-20261112/hol-platt/compiled-evaluator`:

3. Inspect the build log. If successful and correctly bound to the reviewed sources:

This repeats only the cached build invocation, then runs one fresh process per evaluation order. No full repetition is needed initially.

The runner uses `--no_prereqs`, sequential processes, a **4-GiB virtual-address limit**, and **600 seconds per phase**. Keep exports confined to this directory: it deliberately retains the original `DependentBlockResults` theory name.

Before accepting measurements, require per process:

- Exactly one `COMPILED_SEMANTICS_PASS,259`.
- Nine workload passes and five original corruption rejections.
- Exactly 208 `COMPILED_TIME` rows with the expected labels.
- Completion, successful exits, matching source/executable hashes, and unchanged dependency snapshots.

The runner checks marker prefixes and hashes current files; it does **not** enforce all these result conditions or independently enforce the frozen review pins. The manifest pin remains `941EEC202243605BDC3ABC69A96A892F1BD3AA07FE02EB7490590B63E428424F`.

The experiment can produce a meaningful **engineering measurement**: both paths perform the same bigint arithmetic on the same AST, so a gain would measure reduced interpreter overhead rather than substituted numerical work. But the compiled branch currently returns untrusted raw values. Every exported result still comes through stock HOL, which reevaluates it; therefore this experiment itself yields **no proof-producing speedup**.

A future trusted implementation could realize the measured gain only after the equivalence/implementation audit. Its campaign benefit would then depend on the affected fraction:
\[
T_{\rm new}=T_{\rm unaffected}+T_{\rm compilation}+T_{\rm affected}/r.
\]
Neither that fraction nor a corresponding Platt-hours reduction is established. Arithmetic kernels, input translation, spectral algorithms, completeness checks and proof authority remain separate. I ran no build or benchmark.

## 08:51:44 UTC · Final

Found and repaired a loading dependency: the build produced a launcher, not an SML typecheck, and omitted `CompiledComputeBenchmark` from both caller recipes.

The original files and `compiled01` receipts are preserved. The repair adds only an immutable `cv_zero` reference; no arithmetic runs.

- [Repair note](../../../work/backend-costs-20261112/hol-platt/compiled-evaluator/DEPENDENCY_REPAIR.md)
- Strict result checker prepared for 259 semantic checks and 208 timing rows per process.
- Source checks pass; no build or benchmark run by me.

New manifest: `BCBB1017B6AFF35EF7E16E31F4DC4FFD61D0038EDCE64F112815472DC935057C`.

## 08:58:31 UTC · Final

Repair finalized for `compiled03`.

- Uses supported HOL error accessors and preserves exact error checks.
- Original files archived; `compiled02` receipts untouched.
- Source checks pass; no build or benchmark run.

[Repair note](../../../work/backend-costs-20261112/hol-platt/compiled-evaluator/ERROR_API_REPAIR.md)

Manifest: `16121C4FAEEE89B7CDF0982B5226BD885A887BA619EC21CB1E8BD3235CE34E7F`.

## 09:00:39 UTC · Final

No result cache or repeated-call shortcut appears in the source.

Each timed callback invokes `entry []` again. Stored first results serve only as comparison targets; the retained table contains functions, not computed values. Function calls reevaluate their arguments and arithmetic.

A semantics-preserving optimizer cannot generally collapse these calls because stored functions may have effects and recursive dispatch reads a reference. Constant sharing remains possible and legitimate. This is source-level evidence, not machine-code inspection.

No changes needed. Ready to audit `compiled03` against the 259-check/208-row requirements.

## 09:04:30 UTC · Final

Added the missing explicit imports: `Parse`, `boolSyntax`, and `Drule`.

Source checks pass. Originals are archived, `compiled03` is preserved, and the manifest/result-checker pins are updated. No builds or runs occurred.

[Repair note](../../../work/backend-costs-20261112/hol-platt/compiled-evaluator/WORKLOAD_IMPORT_REPAIR.md)

New manifest: `7638FBAA14CBD4336EBAA7DE15FB72317625B5749347A96A2E3F606DCBB94F54`.

## 09:07:52 UTC · Final

**The measured typed implementation needs a trusted-backend extension if its result is to be accepted directly.** Proved HOL definitions alone cannot make unchanged `Thm.compute` execute that SML worker.

Stock `Compute.sml` has only `Num Arbnum` and `Pair` values, fixed natural arithmetic/pair operations, and interpreted function calls. Its configuration supplies checked HOL terms and characteristic equations—not arbitrary native callbacks. It cannot expose signed `IntInf` values or mutable arrays through a different configuration.

Some improvements remain possible without changing that trusted implementation:

- **Proved offset encoding:** for positive scale \(s\), choose an integer bias \(L\) with \(R=r+sL\ge0\). Then
  \[
  \operatorname{round}(r)+L=(2R+s)\operatorname{DIV}(2s).
  \]
  This removes signed rounding dispatch. It requires proved bounds and biases throughout the butterfly, plus safe natural subtraction. It still runs through the stock AST and value representation.
- **Packed natural vectors:** stock operations could extract lanes using DIV/MOD by powers of a base. But the current butterfly uses differing coefficients, permutations and individual rounding. A packed multiplication produces cross terms, so this is not an immediate bulk replacement. Carry/borrow separation and extraction would require a concrete new algorithm and proof.

Neither route has evidence of matching the reported typed gain. The typed measurement combines signed arithmetic, less representation overhead, and two reusable arrays; it does not isolate their contributions.

- **Use the measured worker directly:** audit and extend the trusted implementation.
- **Keep stock trust unchanged:** recheck its output, supply independently checked execution evidence, or develop and measure a proved stock-executable lowering.

A similar numerical speedup is not logically impossible with unchanged `Thm.compute`, but we currently have no demonstrated route to it. No source changes or runs were made.

## 09:10:48 UTC · Final

Audit is ready against manifest `7638FBAA…94F54`.

For each execution order, I’ll require all 259 semantic checks, exactly 208 valid timing rows, nine workload results, five controls, successful exit, and matching source/artifact bindings.

I also reconfirmed that samples recompute results and only stock HOL creates reference theorems. No sources changed or evaluations launched. Ready for the completion notification.

## 09:15:36 UTC · Final

**PASS for the bounded experiment.** Both orders passed all 259 semantic checks, 208 timing rows, nine workloads and five controls.

At depth128, compiled raw evaluation was about **16% faster** by median in both orders. This is an engineering result, not a proof-producing speedup: all reference theorems still came from stock HOL.

[Full result review](../../../work/backend-costs-20261112/hol-platt/compiled-evaluator/RESULT_REVIEW.md)

SHA256: `A78606676819FFF88C6962282809BC11BF3BF4BA0FB1E960A0A6C292236F00EC`.

## 09:21:17 UTC · Final

Prepared [C10004TensorProjectionScript.sml](../../../work/backend-costs-20261112/hol-platt/c10004-transform/C10004TensorProjectionScript.sml) with complete proof attempts for the three stage invariants and requested outer equality.

The proof uses arbitrary values/cache entries and no numerical fixtures or added assumptions. **It remains unbuilt**, so no theorem is claimed proved.

[Handoff and remaining checks](../../../work/backend-costs-20261112/hol-platt/c10004-transform/TENSOR_PROJECTION_HANDOFF.md)

Source SHA256: `DB765F90DAE3000E6B46F23564632FA9CA070B04095258D44FC7A60D45042509`.
