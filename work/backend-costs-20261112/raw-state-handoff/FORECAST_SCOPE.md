# Forecast scope of the raw-state experiments

Static source and saved-number analysis only. Neither model writer nor state reporter was executed. No build, benchmark, new inventory or measurement publication occurred. The six Lean state replays remain outside this note's measurement claims.

## Maximum effect of deleting one model row

The frozen HOL4 planning scenario totals **522.5677489460336 core-years**. Its `literal_representation` row is **227.5367281304526 core-years**. Deleting precisely that row, without changing anything else, leaves **295.031020815581 core-years**: a **43.542053368079294%** reduction, or a total-cost ratio of about **1.7712298439040486** before/after. These are arithmetic sensitivities of a conditional model, not an achievable saving or a lower bound on an optimized implementation.

The exact row inputs in `end_to_end_model.py:119–122` are:

- One core-year: 31,557,600 CPU seconds.
- Notional block count: `ceil((920122241148146 + 89017934196032 + 218799609396458)/8192) = 149894993255`.
- Planning geometry factor 1.02 and accepted-refinement factor 1.1, giving **168182182433** retained notional blocks after the ceiling.
- Measured translation anchor **4.269485 seconds**, with assumed reuse **100**.

Thus the row is `168182182433 * 4.269485 / 100 / 31557600`, exactly `143610261032991401 / 631152000000000` core-years before the model's binary-floating representation. The anchor is the median sum of `translate_block_inputs` and `translate_block_coefficients` in the older HOL dependent-block experiment (`summarize_dependent.py:111–113`). It excludes separately measured literal construction. The reuse count and notional block partition are assumptions, not actual spectral dependency/lifetime counts.

Even making that entire row free leaves principal, finite coverage, analytic production, arithmetic acceptance, closure and other representation costs. For orientation, unchanged planning rows include `cache_input_translation` **0.8199040519335279**, `serialization_and_root_assembly` **3.6634528038839256**, `process_distribution_setup` **10.658744010951404**, `principal` **1.6108666775328497**, `nonprincipal_closure` **13.789781070170102**, and `finite_coverage_and_ladder` **26.270919793964055** core-years. No automatic refund applies to any of them.

If only fraction `f` of the literal row is legitimately removed and new work costs `D` core-years, with all other rows held fixed, the conditional replacement is

`522.5677489460336 - f * 227.5367281304526 + D`.

It improves this scenario only when `D < f * 227.5367281304526`. The present experiment determines neither the global fraction `f` nor the complete replacement cost `D`.

## What the HOL handoff could inform

The prepared integer experiment compares materialized and fused producer-to-consumer boundaries for the same eight 129-state traces and same final 516 integer head pairs. Its full-shape guard retains all eight traces. It does not benchmark the old 192-object input/coefficient payload or the same spectral operation partition.

| Model row and planning value (core-years) | Information a successful matched experiment could provide | Missing transfer |
|---|---|---|
| `literal_representation`: 227.5367281304526 | Cost of decoding, constructing, binding and translating this intermediate state array versus retaining it inside checked evaluation | Actual spectral partitions; fraction of boundaries eligible; sizes/widths; repeated-consumer and process lifetimes; unchanged final-output obligation |
| `raw_integer_state_update`: 0.0019111679054728496 | Checked four-product grid120/grid122 recurrence cost for 1,024 updates | Count 265800×89600 and planning factor0.25 remain scenario inputs; initial/source costs and different sharing patterns need measurement |
| `raw_head_product_assembly`: 4.835322624927308 | Exact integer conjugate-product and grid100 rounding for this 516-output consumer | Population 60254515577760, actual conductor/operand widths, prior cached conductor factor, and complete analytic/output joins |
| `raw_conductor_cache`: 0.00003923838479214726 | At most evidence relevant to a future cache implementation | Current consumer multiplies by61 directly per output; it does not separately benchmark one shared `c*conj(B_c)` cache per conductor/height |
| `serialization_and_root_assembly`: 3.6634528038839256 | Actual bytes and export work for the two resulting contexts | Exports also contain controls; full workload serialization volume, theorem partitioning and retained representations differ |

The handoff does **not** measure `input_regrid` (**0.34710287417304836**): its final raw-head grid100 rounding is not the later transform-input precision conversion. It does not measure `raw_log_inverse_root_step_enclosures` (**0.002559599873401138**) because its initial/step integers are supplied inputs whose HOL analytic source meaning remains open. Nor does it measure EM finite-head work (`em_head_scale` **0.3521028019618899**) or EM state evolution (`em_fine_state_update` **0.033486658497796605**); those are different producers. No cache translation, coefficient generation, native discovery, library compilation, principal or completeness discount follows merely from fusion.

A concrete local decision should compare complete costs for the same final theorem: eliminated intermediate decode/literal/translation/binding versus added fused execution, setup, final binding and export. The sum of instrumented primary phases is not whole first acceptance. Whole-process measurements include imports, gaps, controls and export; these must remain separately identified rather than added again to the phase sum. Export bytes include the full saved context. Fresh processes prevent inherited HOL value caches, but do not by themselves make OS caches cold or prove a reused `Holmake` target was freshly compiled.

## What the Lean state reporter can say

The unchanged `report_state_measurements.py` validates six runs with width1,024 updates and100 repetitions, the exact matched full-output-plus-analytic-enclosure roots, standard-only axiom evidence, and equal generic/data/setup pins. Its ratios compare renamed-kernel replay of explicit operation certificates against computed certificates for that fixed contract. It separately reports successful module construction, selected shared setup, native fixture proposal observations and source/object bytes.

The reporter does not rerun source producers on every replay: their facts, data definitions and generic theory remain imported. Pool renaming is not proof generation. Split explicit construction and packed computed construction incur different module/import overhead. The failed monolith and interrupted attempt are engineering evidence, not silently added to successful construction or discarded as if they never occurred. Optional replay must not be counted as mandatory first acceptance. No result from this Lean experiment establishes a HOL fusion ratio or permits removing HOL's literal-representation row.

## Remaining acceptance obligations

HOL still needs actual source logarithm/inverse-root/step enclosures, recurrence and head-error transport, exact cache bindings and lifetimes, and the downstream input/coefficient/transform/completion joins. Lean's compiled source/state theorems do not transfer across foundations by a filename or hash. Neither handoff nor state replay proves real sign success, interpolation/count completeness, the full principal family, or finite Goldbach coverage. The model's success assumptions and all unmeasured width/production transfers therefore remain intact.

The useful result of the current experiments is a matched implementation choice at a documented boundary. Any forecast revision must first map that choice to actual workload boundaries and charge its complete replacement. This note makes no such revision.

## Pins

SHA256 of the inputs read; paths below the repository root.

| Input | SHA256 |
|---|---|
| `work/backend-costs-20261112/forecast-audit-20261113/END_TO_END_MODEL.md` | `37D11CA50EFD9259021C2B6422C662D476FE683C6C5E1AA3B97C19288AEDE3FA` |
| `work/backend-costs-20261112/forecast-audit-20261113/end_to_end_model.py` | `4E35DBD5C8162B1989F54610431B5311AB9CF5AA403CEAF42E9F7C7A77E2D028` |
| `work/backend-costs-20261112/forecast-audit-20261113/end_to_end_model.json` | `C4B06CCA6CE42BEBC1152DD471E4C2668F21CF4804785D929586E3308DEF98D8` |
| `work/lean-pilots/raw-head/report_state_measurements.py` | `329C9C32EF1AFE159C79E8B78CE37B30A80FC4F1C06C35BF47F0C90F5F481034` |
| `work/lean-pilots/raw-head/CHECKED_PAYLOAD_HANDOFF_EXPERIMENT.md` | `1E813E9054F1BDA29A9B96964F15F2F4358D2D74A4F5BCE033ECFD1893FE7857` |
| `work/backend-costs-20261112/raw-state-handoff/RawStateHandoffScript.sml` | `792B077315D3FC933C5683B1A2D1FB004EA43B463E6D553F8149B852EDB44A30` |
