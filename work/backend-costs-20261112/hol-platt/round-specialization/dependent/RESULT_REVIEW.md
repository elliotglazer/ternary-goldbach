# rounddep03 matched dependent-block result review

2026-11-13. **PASS for the recorded four-cell smoke experiment**, within source/receipt review scope. I ran no HOL process, build or benchmark. Read-only Python checks independently reconstructed hashes, counts, medians, source literal identity and export-name presence. This is not a second decoding or kernel replay of the exported theorem bodies.

The replacement preserves the original checked contract and passes the controls. The timing evidence is modest: at depth128 the new path's median is 3.64% lower in stock mode and 16.41% lower with retained conversion. Neither comparison establishes a stable production speedup, and whole-process CPU did not improve.

## Provenance and completed proof/translation gates

All recorded snapshots match the current files and all corresponding exact postcheck lines: 13 source entries, 11 dependency entries, 3 toolchain entries, and 3 new-object entries. The source manifest includes the mathematical/CV core, unchanged PreparedEval adapter, original data driver and actual local driver. No named dependency drift occurred during the run. These are named-file snapshots, not a complete transitive HOL-library audit.

The theory invocation and executable preparation both record exit0. Unlike executable preparation alone, the theory log explicitly reports construction of `RoundDependentTheory`, and its detailed log saves the three correctness/soundness theorems, both generated recursive-precondition theorems and the final CV acceptance theorem before export/completion. The warnings that recursive translations generate preconditions are followed by saved `round_block_layer_pre_ok` and `round_block_run_pre_ok`; they are not unresolved proof obligations in this recorded build.

The actual source proves those generated predicates universally by list/depth induction and registers them with `cv_pre`. The nonrecursive acceptance wrapper is then translated without a residual caller precondition. This does not erase mathematical positivity: both arms prove `0 < block_scale` by the same stock integer reduction; all four logs contain `HOL4_POSITIVE_SCALE_RAW,⊢ 0 < block_scale ⇔ T`. Only the old arm needs the original `block_accept_pre_ok` assumption discharged from that fact. The new arithmetic's equality to old arithmetic is used only with positive scale.

Both arms derive the original contract after evaluation. `derive_original` rewrites the actual accepted proposition using `round_block_accept_correct` and the proved positivity, checks that its head is the original `block_accept`, then applies `block_accept_sound`. This step is outside the primary evaluation timer. The returned contract still refers to the original rotation, bounds and checksum, not to a new easier predicate.

The 788 quoted decimal strings in the local driver exactly equal the original `hol4-setup/dependent.sml` sequence. No fixture output was regenerated during this review.

## Runtime checks and equation binding

All four fresh processes (`old_stock`, `one_stock`, `old_retained`, `one_retained`) record exit0, their expected implementation/mode selectors and exactly one final completion marker. Each has all twelve primary depth/repeat measurements, the four original-contract conclusions, all five corruption rejections, the incompatible-conversion rejection and the equation-identity-control completion marker.

Each process records exactly nine expected theorem-tag lines, each `oracles=DISK_THM,axioms=`. The context contains exactly the four printed upstream bool axioms: SELECT, INFINITY, ETA and BOOL_CASES. This is the stock HOL foundation/import boundary, not a claim of no axioms or an independently checked inference trace. The source checks empty theorem hypotheses; the saved positive and negative result names occur in every export.

Equation registries have sizes `[21,21,0]` in each stock process, and `[21,21,0,21,21]` in each retained process. All member indices are contiguous, every use refers to a recorded set with its exact size, and every member theorem name occurs in the corresponding export. The two 21-equation sets are not assumed equal merely from their size; the source adapter uses ordered theorem-conclusion `aconv` comparisons.

Both retained processes report HIT for checksum, bound and depth changes; MISS for input and coefficient changes; and the explicit incompatible-closure rejection. The changed payloads therefore pay for new compatible conversion construction rather than silently reusing the old one. No final theorem/value cache replaces evaluation.

As an additional coarse binding check, both old exports contain the original `cv_block_accept`/`cv_int_div` names and not `cv_round_block_accept`, `cv_round_block_layer` or `cv_positive_den_div_one`; both new exports contain the latter names and not the former. This is byte-level symbol presence, not independent theorem-body interpretation. The pinned source's implementation selector and actual saved equation sets are the stronger runtime binding mechanism. The already completed `../cv-inspection/RESULT_AUDIT.md` separately inspected actual generated definitions and confirmed two natural DIV operations and no MOD on the well-formed positive-scale replacement butterfly path. This review does not infer a per-call operation count merely by counting names in the exported whole closure.

## Primary evaluation measurements

CPU seconds; each entry is the median of three calls within **one process**, not three independent process medians.

| Depth | Old stock | New stock | Old retained | New retained |
|---|---:|---:|---:|---:|
|1|0.035049|0.037541|0.060904|0.013856|
|8|0.037729|0.036132|0.023884|0.015753|
|32|0.045927|0.043974|0.043138|0.021576|
|128|0.068204|0.065719|0.055250|0.046183|

Depth128 samples are:

* Old stock: 0.063671, 0.087731, 0.068204.
* New stock: 0.098888, 0.065719, 0.061982.
* Old retained: 0.054018, 0.086469, 0.055250.
* New retained: 0.046183, 0.053639, 0.044410.

The stock ranges overlap substantially, and new stock's first sample is slower. The retained samples in this run are lower for the new path, but small-depth nonmonotonicity, one process per cell, fixed cell order, allocation/GC and warm-up effects prevent a reliable throughput law. The new implementation is not uniformly faster at every depth/mode. The primary timer includes CV conversion/normalization work appropriate to its mode, not just natural division. This experiment does not isolate the cost of MOD elimination from all surrounding representation and precondition differences.

Compare old/new **within a mode**. Comparing old stock with new retained combines rounding specialization and conversion reuse and must not be presented as the rounding improvement.

## Setup, export and whole process

| Cell | Process CPU | Wall seconds | Peak RSS KiB | Initial literal translation CPU | Export CPU | Export bytes |
|---|---:|---:|---:|---:|---:|---:|
|Old stock|20.35|29.45|1,497,624|4.667825|1.430549|2,474,375|
|New stock|21.63|32.93|1,404,484|4.132284|1.814965|2,474,113|
|Old retained|20.16|31.71|1,491,924|3.989413|1.625660|3,291,780|
|New retained|20.27|30.97|1,364,648|3.341490|1.995084|3,291,300|

Initial translation sums scale, original inputs and original coefficients; they exclude later changed-data translation. Depth128 retained prebuild CPU is 0.028006 old and 0.022891 new. Those prebuilds are outside the primary evaluation samples. Whole processes include all depths, reference evaluations, false controls, changed-data construction/translation, metadata, derivations and exports. They are not the cost of a single production block. The runner's 4-GiB virtual-address cap is distinct from measured RSS.

New stock process CPU is higher by 1.28 seconds; new retained is higher by 0.11 seconds. Those totals do not support a whole-process speedup. The lower literal-translation times in later cells are not caused by the one-DIV formula—the literal payload is identical—and illustrate why fixed-order process totals need cautious interpretation.

Theory construction took 13.20 process CPU seconds and 55.23 wall seconds, peak RSS431,048 KiB. Its inner HOL theory timer reported 0.56026 seconds, a different and narrower interval. Executable preparation took 2.84 CPU seconds and23.87 wall seconds, peak RSS31,168 KiB. The `.exe` is the normal shell launcher/load-recipe path; executable preparation alone is not SML typechecking. Here the subsequent four completed runs provide the actual successful source loading/execution evidence. These build costs use existing dependencies, not a clean HOL rebuild.

## Scope and decision

Keep the replacement as a semantically successful bounded implementation experiment. It provides an actual stock-HOL proof-producing route for the tested finite propositions, unlike an unchecked host arithmetic result. It does not establish the spectral-source interpretation, full Platt computation, campaign scaling or a large arithmetic speedup. The present 3.64% stock depth128 median reduction should not materially revise a campaign estimate. No further run is required merely to make this percentage look stronger; an expanded timing study would need a specific decision to resolve and balanced independent process repetitions.

No defect requiring source changes was found in this result review. All prior failed attempts and the repaired source remain preserved. No new build or arithmetic evaluation occurred.

## Evidence pins

| File | SHA256 |
|---|---|
| source_binding.json | `7765A77215C4ABC754C82B77B82E384745F749C3F9CF6FBD311065047F179B89` |
| RoundDependentScript.sml | `E72B4A1A5E4E0A82E0AC854FB87B576E80E3A1B4545FF7D146338DDBB89F733C` |
| rounddep03_sources.sha256 | `EC1CBE1A001984B4B2119E5D8F18B37CD92D1E8EE3F7B5D73664C26B9ECD009E` |
| rounddep03_dependencies.sha256 | `6641761CE7605A767AE2898DB84A8B436AFE15C41DEEAD5D1E23FCAA3747D7D9` |
| rounddep03_toolchain.sha256 | `F3E37EF6CB76AD38D2000B2A2DF578134E0CE5FE1D02092A8B27371DE24128F5` |
| rounddep03_newobjects.sha256 | `E96A0BFC211E22F4DEBE5D6E19696174597EF266287389EB3513DE3C3EC560DB` |
| round_dependent.exe | `0AB76FAA16A790980FEC1F40213708EE11BC1AD9296F36C48C76A5165BAA1006` |
| RoundDependentTheory.dat | `8244816B76EB06391E1070030DA11FA932DC6B2D2A849EE36591A5CDCFC8F71C` |
| old stock export | `30BB833DB621746D083CFBD02F31173B2B655CD179DFD23E9ACE9AD1AEBBAAB9` |
| new stock export | `5CA75585969AA3CB03D611BE0F2CC1C494481DBBD323D5899ACB3364C9004484` |
| old retained export | `2EF9C6537F8C10A1DFDF3934B43389ADBFEFAB098AE5194FECE4DEFB008A999A` |
| new retained export | `EB5DB00F9EA1C31CF63FBDA58E8F4C6B916B44C89C8AAB69BD1C87A6B0F11D22` |
| ../cv-inspection/RESULT_AUDIT.md | `2FCF7ABA93932D8E45E43BD4EBD2096C7F62EDBDB7F3130E4293BE74B3975968` |
