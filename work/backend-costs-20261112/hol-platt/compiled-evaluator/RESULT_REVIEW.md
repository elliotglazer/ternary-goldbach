# compiled04 same-AST result review

2026-11-13. **PASS for the recorded bounded differential experiment.** Both orders complete all259 semantic checks, nine actual workload cases, five corruption controls and208 timing rows. The closure evaluator has an approximately1.2x raw median speed ratio at depth128 in this smoke sample. This is not a proved compiler-equivalence result or a proof-producing speedup. I ran read-only receipt/source checks, not HOL, SML, builds or benchmarks.

## Source, execution and result binding

The independently rerun strict checker passes both process receipts. It rehashes15 source entries,6 dependency entries,3 toolchain entries and1 executable entry and checks the exact postcheck lines. The separate source checker verifies all4 input pins,3 generated outputs and5 support pins against manifest `7638FBAA14CBD4336EBAA7DE15FB72317625B5749347A96A2E3F606DCBB94F54`. It confirms preservation of the original interpreter/primitives/frontend, original characteristic configuration, exact four dependent-workload fixture declarations, changed data and five corruption requests. No original kernel or project dependency was changed.

The executable remains a shell launcher, and local `.uo` objects are source-loading recipes. Both callers now explicitly depend on `CompiledComputeBenchmark`, whose recipe is present. Build exit0 alone does not establish a typecheck; the two completed runtime logs now provide the successful source-loading/evaluation evidence missing from earlier attempts. The dependency, HOL-error API and import repairs are explicitly documented in their separate notes; compiled01–03 remain preserved failures/diagnostics.

Both runtime argv records select the expected order and executable, and both external time receipts record exit0. I independently checked exact timing order within every case, beyond the checker's label-multiset test. Stock-first actually executes stock then compiled in each timed pair; compiled-first reverses it. Each log has exactly one `COMPILED_SEMANTICS_PASS,259`, exactly one completion marker, the nine ordered workload results, and the five original ordered corruption rejections. All208 timing values per process are finite and nonnegative, with no duplicated or missing labels.

Every case records21 code equations and a total static code AST size1506. Request AST size is11 except depth32, which is10. All189 equation indices per process are contiguous within their cases, and every corresponding exported equation name is present. The saved stock reference names, four full positive-reference names and five rejected-proposition names are also present. The exports are byte-identical across the two orders, each5,369,222 bytes, SHA256 `7BEC93B4A818BABB7BC60CF2C8E5288290D27DD82377C91FD3F4484A18179E3B`. This audit checks file identity and exported-name presence; it does not independently decode or kernel-replay their theorem bodies.

Both logs contain the expected four upstream bool context axioms: SELECT, INFINITY, ETA and BOOL_CASES. Their nine printed high-level theorem tags all have `oracles=DISK_THM,axioms=`. The source requires empty hypotheses and exact input/output conclusions for stock reference conversions. These observations retain the stock HOL foundation/import boundary; they do not assert absence of logical axioms or an independently checked inference trace.

## What the differential success means

The259 tests cover all expression constructors and primitive matrices, explicit division/modulo-zero and coercion cases, variable/function lookup errors, branch laziness, curried application/argument order, exactly-once Let evaluation, and bounded self/mutual recursion. The observer accepts only the precise expected HOL errors or test signals; unexpected exceptions cannot pass merely because both sides fail. The compiler's private table contains executable closures, not previously computed values.

For each actual request, one parsed code vector and one parsed request AST feed both implementations. All returned raw values are compared structurally, reconstructed terms by `aconv`, and the result against an unchanged stock `cv_computeLib.cv_compute` reference. Samples call `exec` or `entry` again; retained first results are comparison targets only. No result cache or alternative numeric fixture substitutes for execution.

An important scope limit: these nine actual requests are **acceptance predicates**, and each returns one CV node. They execute the dependent block internally but do not independently expose and compare all intermediate/final block coordinates. The separate typed-evaluator experiment has a full-array comparison; this experiment must not borrow that stronger output claim. Likewise, the semantic tests and predicate comparisons do not establish equivalence on all programs, divergence or resource failures.

All theorem construction remains stock. Experimental raw values are not supplied to `make_thm` or an oracle. The exports contain original code equations and stock reference/positive/negative theorems. Running those references still incurs the stock evaluation cost. Thus this completed experiment demonstrates an engineering optimization candidate, not an accepted optimized kernel or a reduction in proof production time.

## Raw timings

CPU seconds, medians of three retained calls within each single process. Ratio means stock divided by compiled; larger than1 favors compiled. There is only one process per order.

| Depth | Stock-first: stock | Stock-first: compiled | Ratio | Compiled-first: stock | Compiled-first: compiled | Ratio |
|---|---:|---:|---:|---:|---:|---:|
|1|.001808|.001820|.993|.000482|.000436|1.106|
|8|.003698|.002757|1.341|.001986|.001853|1.072|
|32|.007995|.007908|1.011|.007737|.007476|1.035|
|128|.030605|.025481|1.201|.032292|.027079|1.193|

Depth128 raw samples are:

* Stock-first process: stock .028294/.032198/.030605; compiled .027948/.025089/.025481.
* Compiled-first process: stock .030291/.032292/.033005; compiled .039308/.026829/.027079.

The depth128 medians correspond to approximately16.7% and16.1% lower time, respectively. One compiled-first raw sample is slower than all three stock samples. The small-depth variation between processes, overlaps and outliers prevent treating this as a stable per-operation law. Three within-process calls are not three independent process observations, and no confidence interval is claimed.

Combined raw-plus-reconstruction depth128 medians are .031289 stock versus .030313 compiled in stock-first, and .029870 versus .027425 in compiled-first. In stock-first, one compiled combined sample is .057011 despite a .025–.028 range for its separate raw samples. The combined and separate rows are different executions and must not be subtracted to infer precise reconstruction overhead or summed as disjoint work.

## Preparation and other costs

Depth128 CPU stage measurements:

| Stage | Stock-first process | Compiled-first process |
|---|---:|---:|
|Discovery|.020921|.016096|
|Parse code|.051451|.012978|
|Parse request|.000149|.000169|
|Compile code closures|.000031|.000131|
|Compile request closure|.000010|.000016|
|First stock raw|.029920|.033185|
|First compiled raw|.025520|.026057|
|Stock reconstruction only|.000007|.000006|
|Compiled reconstruction only|.000005|.000009|
|Stock kernel reference|.050174|.049338|
|Fresh closure compilation plus raw execution|.026568|.027405|

The tiny closure-construction times are plausible for the1506-node static program, but remain timer observations, not a forecast for larger programs. Fresh-compile execution reuses the parsed AST and excludes parsing, numeral preparation and reconstruction. First raw execution occurs after preparation, semantic tests and earlier workload cases; it is not cold-process execution. Reconstruction is tiny here because the result is an acceptance Boolean, not the complete block vector.

| Process order | CPU total | Wall seconds | Peak RSS KiB | Initial literal translation CPU | Export CPU |
|---|---:|---:|---:|---:|---:|
|Stock-first|24.00|36.10|1,508,748|4.470499|2.839202|
|Compiled-first|23.77|34.68|1,476,400|3.950472|2.849488|

Initial literal translation sums scale, original inputs and coefficients; changed-input/coefficient translation adds further work. Both processes run **both** evaluators, all controls, stock references and exports. Their whole-process times compare evaluation order, not a stock-only versus compiled-only implementation. Peak RSS includes HOL/runtime state and retained audit data; it cannot isolate closure-table memory. The runner's4-GiB virtual-address cap is a different metric.

The recorded build/launcher-preparation invocation costs3.38 CPU seconds and33.82 wall seconds, with32,020 KiB peak RSS. It reuses dependencies. Its source-loading/launcher character means it must not be described as compilation of a self-contained native evaluator binary.

## Decision and remaining authority gap

Retain this as a successful bounded same-AST mechanism test. It supports the claim that removing repeated expression-constructor dispatch can reduce some raw interpreter overhead while retaining the same natural-number/Pair representation. Stock Monop/Binop already contain function closures, so this did not eliminate a second arithmetic-opcode interpreter or change bigint arithmetic.

The approximately1.2x depth128 raw ratio is materially smaller than the separate typed representation experiment, and it does not justify multiplying a Platt-hours estimate by that ratio. Representation work, input/term preparation, certified analytic algorithms, full output coverage, proof authority and aggregate workloads remain separate. To accept candidate results directly would require the outstanding semantic/implementation audit of a deliberately changed trusted evaluator. The unchanged-kernel alternative is checked execution evidence or stock reevaluation, whose cost this experiment has not removed.

No further run is needed merely to seek a more favorable sample. A later repetition should answer an explicit engineering question, use balanced independent processes and retain unfavorable outcomes. No source or dependency modification was made by this result review.

## Pins

| Artifact | SHA256 |
|---|---|
| Current source manifest | `7638FBAA14CBD4336EBAA7DE15FB72317625B5749347A96A2E3F606DCBB94F54` |
| Strict receipt checker | `091C50C8344819652C42C1F6862020BD842B12CCE13716FA2C035FCBCAC1B011` |
| compiled04_sources.sha256 | `5EC0A02D023CBA22DDD23A4EC2994F76E2AA3BAB2E9F4FA14682B866EF3711B4` |
| compiled04_dependencies.sha256 | `F301270460F2554404779C7FBA2B0C5EDAADC94278C02CF738FF77010850B5C6` |
| compiled04_toolchain.sha256 | `F3E37EF6CB76AD38D2000B2A2DF578134E0CE5FE1D02092A8B27371DE24128F5` |
| compiled04_executable.sha256 | `FA096B1736BC95F2F1C69C3FBA9BB8BCD6739EF4D6C9393DF7D03AAA1B65B0DB` |
| Stock-first log | `16A61243DEBCCFAF120397A6FA2239CB2759442CE222900AC087099D30F6510A` |
| Compiled-first log | `609FD41E0743A2DE4998830305D013FD44D240F724E4466B9E8F6AEE2EE093D3` |
| Either export | `7BEC93B4A818BABB7BC60CF2C8E5288290D27DD82377C91FD3F4484A18179E3B` |
