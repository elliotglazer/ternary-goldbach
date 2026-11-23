# Conditional end-to-end TG compute model

Prepared 13 November 2026 UTC from the current backend reports. This is a forecast of proposed implementations, with explicit unmeasured transfers. It is not evidence that the full numerical or analytic proof exists. No benchmark, build, function evaluation or inventory was run for this note. The companion Python file performs only small scalar arithmetic on saved counts.

The current evidence supports a different conclusion from the old explicit-certificate forecast. A compact computed-block design in HOL4 or Candle could plausibly reduce the compute bill by orders of magnitude, but input representation and analytic completion can erase much of the arithmetic gain. Unchanged Lean's measured dependent evaluator is substantially slower on the tested implementation. Ordinary PA MM0's current scalar proof producer is much more expensive still. None of these observations establishes an optimized lower bound, a universal system ranking, or a cross-foundation translation.

## Scenario totals and their meaning

The following totals charge numerical preparation, first formal acceptance, source and elementary setup, principal and nonprincipal closure, finite coverage and ladder, representation, serialization and a library CPU reserve. An optional second complete replay is excluded. One core-year is 31,557,600 CPU seconds. Lean's kernel anchor is elapsed time treated as busy-core time for this forecast; it is not a CPU measurement.

| Proposed complete implementation | Favorable | Planning | Stress |
|---|---:|---:|---:|
| Unchanged Lean with the measured list/Int dependent evaluator and assumed production adapters | 15,949 core-years | 77,805 core-years | 3,089,386 core-years |
| HOL4 computed-block route with a completed analytic library | 81 core-years | 523 core-years | 66,578 core-years |
| Candle computed-block route with a completed analytic library and output contract | 162 core-years | 784 core-years | 75,015 core-years |

These are deliberately broad scenarios, not confidence intervals or bounds. In particular, the favorable HOL/Candle cases assume substantial source-internal execution and representation reuse that the current fixtures do not implement. Their mathematical libraries and whole-family success conditions are still required. The stress case is not a guaranteed ceiling: unresolved signs, zeros or prime gaps can make the chosen plan fail altogether.

The same model gives approximately 56 million / 544 million / 27 billion core-years for a hypothetical full implementation built around the *currently measured four-bit PA scalar proof producer*. This separate sensitivity includes its measured frontend generation cost and independent checking, with unmeasured width and signed-composition factors. It is a warning about that implementation, not a forecast for the best ordinary MM0 design. Faster direct MMB emission, larger proved digit rules, improved multiplication and same-rule streaming remain possible. No measured signed dependent MM0 network or MM0 analytic translation exists here.

The former estimates' `P/5000 + A/500` conversion and guessed backend dispatch rates are not inputs. Nor are the approximately 180-fold Lean/HOL dependent-block ratio or HOL's 138-fold primality improvement applied to a previous grand total.

## Measured anchors retained

| Evidence | Measured boundary | What remains outside |
|---|---|---|
| 8,192 dependent butterflies, HOL4 | 0.073960 CPU seconds; input translation 4.269485 seconds per fresh payload | Actual roots, source values, spectral indexing, propagated analytic error and zero counts |
| Same network, Candle | 0.158679 CPU seconds; input setup 4.186 seconds | Same spectral gaps; final export and cold libraries are separate |
| Same network, Lean | 13.464615 seconds median strict kernel replay; one proof build 16.8125 CPU seconds | Data loading and generic library are separate; production bridge absent |
| Same network, native GMP | 0.003747830 CPU seconds | No proof authority; initial decimal parsing excluded |
| Ordinary PA MM0, 64 scalar products | 0.220877 seconds independent check; 79.08 + 6.86 CPU seconds frontend/conjunction production; 52,088,360-byte certificate | Signed rounding, complete network, analysis, finite coverage |
| Complete Lean finite interval | 9.452 seconds median full renamed kernel closure; 547.234 CPU seconds project construction | Full finite range, source reuse at scale and dense ladder |
| Complete HOL batched interval | 0.064050 seconds primality; 6.006 seconds median phase total; 13.09 seconds whole process | Production-scale source reuse, packed wide blocks and ladder |
| Actual chi4 positive-height sign | 51.733959 seconds strict full-source construction, 63.031250 CPU seconds | Large transforms and high-height numerical production throughput |

The dependent network is a rounded rotate-and-pair computation, not an FFT. Its checksum is an output statistic, not a commitment. Its measured local residual contract does not supply roots, actual L-values or a zero count. The chi4 sample does supply an actual analytic sign without assumptions, but uses eight direct terms and exact rational Taylor intermediates. Dividing its build time by eight would not price the production source.

The current complete finite HOL result checks the same 1,537-node Lucas graph and 393 requested primes as Lean. Improving the HOL primality phase about 138 times improves its whole process only about 1.40 times. Representation and export remain material. The completed `finite-lean/BATCH_REPORT.md` now reports three newer Lean batched-closure replays with median18.516 seconds versus the old9.452-second median, despite reducing the closure from8650 to265 declarations. Its incremental construction costs209.5 CPU seconds with common support already built; the old547.234 seconds also included the common bitmap bridge. Slower optional replay does not imply a slower primary first-admission build. Both acceptance boundaries remain visible, and neither result discounts the forecast's unimplemented production tile or ladder. No HOL batch saving transfers to Lean.

## Workload and price interface

Retain the original finite-RH route at R132900, principal height 10^8, N0=9.89e26 and the large-family +41 interpolation guard. The exact comparison baseline is combined8828 precision with full P20/b94 output, not an unpriced mean186/runtime692 successor or a shorter-output hybrid. The main scenario uses the exact e=0 plus41 counts. Planning and stress multiply computational counts by 1.02 and 1.10 respectively as explicit allowances for auxiliary schedules. Those multipliers are not exact e=167/e=640 folds and do not establish completeness success.

`WIDTH_RESOLVED_LEDGER.json` provides the current semantic extraction. Main large counts are 920,122,241,148,146 root products, 89,017,934,196,032 kernel products, 2,090,319,798,067,922 complex additions and 92,576,511,158,537 quarter turns. Runtime normalized scales are zero by the selected circuit. Root-product fractional precision is 80..105 with natural data capacity 99..154 bits and root capacity 81..106 bits. Kernel products have p=87..105, data capacity 107..137 and coefficient capacity 87..105. Pre-adds, signed bits, raw products and rounding witnesses require their own wider capacities.

The model does not infer a precise multiplication rate from those capacities. It assigns the following fractions of each backend's own measured 343-bit butterfly time. These are unmeasured transfer assumptions, including the operation's rounding, not empirical width laws. Standalone additions are charged separately where the saved circuit has them.

| Semantic operation | Favorable factor | Planning factor | Stress factor |
|---|---:|---:|---:|
| Large unit-root complex product | .08 | .25 | 1 |
| Large cached-kernel complex product | .10 | .35 | 1.5 |
| Large complex addition | .005 | .02 | .10 |
| One residue Horner stage, real scale and complex addition | .02 | .06 | .25 |
| Raw head complex product and assembly | .08 | .25 | 1 |
| Small character/time butterfly | .5 | 1 | 3 |
| Small general complex point product | .3 | .65 | 2 |
| Small real radial/prefactor product | .1 | .3 | 1 |
| Large completion/coarse-sign bundle | .1 | .4 | 2 |

The small branch retains 128,941,391,789,290 character butterflies and 89,858,217,607,168 full time butterflies, plus all point products, Gaussian gates, bucket additions, prefactors and internal scales. Raw-time fractions are241..343, with signed real capacity up to413 after magnitude growth. Character fractions are279..411; ancillary seed/sigma/radial/setup/Gauss fractions reach404/484/523/527/534. The343-bit fixture therefore does not cover every source or setup operand. The elementary reserve and type factors explicitly cover uncalibrated larger operands. The half-time circuit is a real candidate for later replacement, but its product-count reduction is not silently credited as an equal runtime reduction. The JSON lists every remaining semantic row and its independent factors.

For backend b, operation j and scenario i, the computational acceptance contribution is

    count_j * type_width_factor_j,i * measured_butterfly_time_b
      * auxiliary_allowance_i * retained_refinement_factor_i.

This is a declared implementation model, not a count of interchangeable butterflies. Actual per-width, per-operation microbenchmarks should replace each factor. Numerical search/preparation is charged once using the native anchor and the same typed factors, with generation retry factors 1/1.25/3. Acceptance refinement factors are 1/1.1/2. This budgets an external numerical pass followed by checked execution; if a future design generates a source only inside acceptance, remove only the duplicated demonstrated work.

Lean additionally receives frontend/proof-construction overhead of .25/1/4 times its modeled computational acceptance before refinement. This is not measured production elaboration. HOL and Candle's timed calls already execute and derive their mathematical conclusion, so they receive no duplicate generic proof-generation multiplier. Input construction, library work and export remain separate for all three.

## Full obligation partition

| Required component | What is charged and what would replace the assumption |
|---|---|
| Hurwitz/EM source | 10,969,166,595,220 internal head scales, 11,386,294,892,080 additions, Bernoulli/correction/E stages, 417,288,057,616 fine-state updates, 417,295,106,833 state copies/conversions, 150,847,656,960 shift updates, endpoint slots and final scales/rounds. Shared source coefficient conversion costs28,734,393,000 coordinate conversions. Complete source20 delivery remains. Actual source block measurements replace typed factors. |
| Raw residue heads | 60,254,515,577,760 products and exact assemblies, distinct from EM's head. Shared integer-state recurrence is charged over 265800*89600; conductor-factor caches use the exact main count1,528,006,797. The raw-head130-by121 magnitude products differ from recurrence121-by123 and narrow Horner18-by-state/20-by-quotient products. |
| Elementary and root producers | Explicit rows price the saved small root/cis, outer exponential, cutoff division, seed-unit, phase/root/division, Gauss and kernel setup counts; EM initial/step/log and Bernoulli work; raw integer-source starts; and large cold kernel/chirp/pre-sum work. Their unmeasured complete-enclosure factors are specified below. No arbitrary30-core-year setup reserve remains. |
| Residue contractions and transforms | All full20 Horner stages, transforms, cheap signs/rotations, regrids and small-branch scalar operations are explicit rows. Root uncertainty belongs inside the proved transform error contract, not a second independently added source error. |
| Errors and canonical outputs | Arithmetic is included in typed bundles and source production. Global generic error/identity proofs belong to library engineering. Large conductor/phase/completion products and small sign checks are per-output rows. No assumed sign margin closes a theorem. |
| Off-grid signs and repairs | Large83-term and small220-term average local stencils at .1%/3%/100% of coarse sites. The small220 is a model within the admitted variable-stencil range, not a new exact query inventory. Full negative-guard transport superset is separately charged. Kernel setup and actual query union remain unmeasured. |
| Nonprincipal completeness | All 4,351,723,951 primitive labels receive .001/.1/10 seconds of additional closure work, about .14/13.79/1379 core-years. This is a positive allowance for count integrals, endpoint/central handling, surplus, exceptional work and final binding, not a measured per-label theorem. Auxiliary sample arithmetic remains in its own rows. |
| Principal | A proposed 250000001 samples times4095 terms, each priced .5/5/50 measured-butterfly units, is a complete producer/search/first-acceptance allowance including phase, correction, sign and global count work. The separate native-discovery row excludes principal, so its producer is paid here once. Both this evaluator and these counts are planning assumptions. No unnecessary new reciprocal-head obligation is imposed, but actual retained head consumers must be proved. |
| Finite binary and dense ladder | Separate formulas below; no arithmetic-network ratio applies. Every source/anchor prime and complete path must be checked. |
| Analytic library, decoders and joins | Explicit module-build/rebuild workload below, separate from human engineering. This is not evidence of implemented analytic translation. |
| Scheduling and process setup | Retained notional blocks are grouped into shards of1000000/10000/100, each charged5/20/100 CPU seconds of imports/startup/dispatch. This yields about.024/10.66/10450 core-years, rather than a generic unexplained reserve. |

The elementary mechanism uses10,070,764,730 small root/cis upper keys at10/1000/100000 butterfly units per complete enclosure, 2,605,203,866 outer complex exponentials at100/10000/1000000 units, and the same count of cutoff divisions at5/500/50000 units. EM's three initial/step/grid object roles each use the7,049,217 argument union; the model conservatively assigns the same100/10000/1000000 units to each role, even though a grid conversion may be much cheaper. Raw-source starts, phase roots, log-anchor stages and other saved setup counts are separate rows. These prices explicitly allow ancillary precision through534; no elementary-function benchmark establishes them. At planning prices, HOL's small outer exponentials cost about8.36 core-years and small root/cis production about3.23, which can now be challenged by a concrete producer.

Large nonchirp radix/CT roots have their own count assumption of1,000,000/100,000,000/106,105,233,600 keys at10/1000/100000 butterfly units per complete enclosure. The stress count is a padded design allowance8*49899*265800, using eight angle slots per maximum-length position in every old full node/precision state; it is not a new exact root inventory or a proof of sufficient producer coverage. It does not replace the separately charged150,746,135 chirp enclosures. All363,202,368 scaled-cache rounds are explicit. This root producer is assumed to execute inside acceptance; no second external root-generation pass is charged for it. Cache translation covers the separate imported cache objects, with reload factors1/3/10. The runtime payload model conservatively retains full192-object fixture translation even when coefficients could share existing cache definitions; this is an implementation weakness, not an efficiency lower bound.

All1,202,846,693,883 frequency conjugate copies and18,477,108 zero-imaginary projections have explicit cheap rows. EM's2,210,506 shared R steps are explicit. Grid94-to100 exact exports, top copies, per-residue coefficient lookup and their binding are included in the Horner-stage bundle; full20 source delivery and original-operand shared conversion remain separate. No role becomes free merely because it has no general multiplication.

The library CPU mechanism assumes1000/5000/20000 newly owned proof modules,60/600/3600 CPU seconds per build, and2/10/50 build/check rounds during development. HOL/Candle use module-count multipliers2/4/8 for missing analytic ports. This gives Lean.0038/.951/114.08 and HOL/Candle.0076/3.80/912.62 core-years. Counts, build costs and rounds are assumptions, not measurements of the future library. The final production build is one of those rounds; a further independent replay is not hidden in the total. Per-shard imported-library loading belongs to process setup and is not another full source rebuild. Human development is separate below.

The allocation cannot make an unfinished theorem true. The fixed error floor can defeat a sign even after arbitrarily precise arithmetic; multiple zeros or unmet count conditions may force a different analytic plan. Failed candidates and abandoned refinement paths can exceed every stress allowance.

## Representation, export and I/O

The largest measured setup warning is the fresh input translation. For sensitivity, define 149,894,993,255 notional 8192-operation blocks from the large complex-product count plus small butterflies. This is an accounting assumption, not a proved partition of the actual dependency graph. Assume one fixture-sized fresh payload translation per 10000/100/1 such blocks. HOL uses its measured4.269485 seconds, Candle4.186, and Lean uses the broader7.734375-second data-file CPU cost as a deliberately qualified proxy. That Lean file also contains control data and is not a matched original-only setup measurement.

The notional block count is multiplied by the scenario's geometry and retained-refinement factors before charging translation and output bytes. At planning reuse100 this costs about228 HOL core-years or223 Candle core-years. The stress factors increase the base count by2.2, yielding about44,615 or43,743 core-years at reuse1. Reducing this requires a proved internally generated source or a real persistent-data lifetime; renaming a constant or importing a hash cannot discharge source semantics. Cache admission/reload and chunk-boundary identity must be included in the replacement. Failed numerical search is assumed to remain in memory and produce no retained proof payload; its native CPU and process reserve remain charged.

Assume8KiB/64KiB/1MiB incremental serialized evidence per retained notional block. These are speculative compact-output sizes, not measured byte rates. Add an uncompressed pass over the illustrative small raw-array payload of9237783904256*52 bytes, large kernel payload363202368*28 bytes and binary source8,590,000,128 bytes, also conservatively multiplied by geometry and retained refinements. Streaming can reduce retained/live bytes but does not automatically erase production, reads or proof acceptance. The resulting traffic is about1.71/11.56/346.84 PB. Compression is not credited.

Serialization/root-assembly CPU is charged at500/100/20 MB per CPU-second. At10/1/.1 GB/s aggregate physical I/O, one pass alone takes about.0054/.366/109.91 years. These are explicit hardware assumptions. A second pass, replication and failed-shard recovery add traffic. The model's CPU totals and this bandwidth lower bound must not be added as if independent sequential wall time; pipelined elapsed time is at least the maximum of CPU-work/effective cores, critical path and I/O time.

Candle's349.5MB fixture export includes shared context, and its4.4MB compressed size is not a per-block rate. HOL's saved theory is not an independent inference trace. Neither size is extrapolated here. Stock Lean artifacts, HOL saved-context loading, Candle's output channel and ordinary MM0 certificate checking retain distinct assurance boundaries.

## Finite coverage and ladder, priced separately

Use the conditional layout B=10^16 and L=2^36. There are19,073,486,329 proposed2^18-target tiles and37,252,608 reserved binary anchor records. Native mask search costs1.3/2.6/6.5 microseconds per64-target word. It is only a proposal-generation price, not a complete coverage proof.

The ladder has approximately98.9 billion necessary new primes. Model path deficit factors1.05/1.2/2, giving103.845/118.68/197.8 billion rungs. Every maximum gap, initial point, shard seam and final reach must actually pass. The historical15-microsecond search/55-microsecond special-rung claim used different wide fixed windows and batching. It is not a measurement for these denser adaptive windows.

| Assumed full production-plus-first-acceptance price | Favorable | Planning | Stress |
|---|---:|---:|---:|
| Lean complete coverage tile | 3.4 ms | 6.8 ms | 27.2 ms |
| HOL complete coverage tile | 1 ms | 10 ms | 100 ms |
| Candle complete coverage tile | 2 ms | 20 ms | 200 ms |
| Lean/HOL complete ladder rung | .1 ms | 1 ms | 100 ms |
| Candle complete ladder rung | .2 ms | 2 ms | 200 ms |

These are proposed production prices, not measured complete large tiles or ladder certificates. A tile consumes the separately established source/anchor prime theorems; its price covers proposal-to-theorem coverage work, not re-proving those primes. The source/anchor rows therefore are not duplicated inside each tile. The Lean tile's scale starts near the earlier isolated packed-equality measurement but must also pay its missing full-scale interpretation. The current1024-target complete theorem must not be linearly multiplied per target. Source and recursive-factor sharing change its cost structure.

Anchor checking assumptions are Lean30/55/250ms, HOL2/5/50ms and Candle4/10/100ms, plus generation2/20/200ms. HOL's measured prime-role subtotal1.810812s/393 is a local support for the5ms planning choice, not proof that the larger anchor population has the same cost. Source certification, initial range, exceptions, finite-specific imports/decoders/export receive1/10/100 additional core-years. This gives finite subtotals Lean6.64/24.40/759.85, HOL5.16/26.27/803.62 and Candle6.09/36.08/1490.91 core-years. No system inherits another's measured speedup.

For perspective, at the planning rung count each extra1ms of complete ladder cost adds3.76 core-years. Each extra10ms per tile adds6.04 core-years. At L=2^36, even eliminating all old anchor checking changes the prior Lean finite estimate by less than1%; dense ladder, mask search, full coverage and representation are more consequential.

## Ordinary PA MM0 sensitivity

The separate model counts real products from the semantic operation schedule, uses the measured343-bit scalar product generation and checking prices, then applies unmeasured width factors.1/.3/1 and nonproduct/signed-range/composition factors2/5/20. It adds a distinct90-bit ladder model with88 product roles per44-square rung, width factors.02/.1/.3 and the same composition factors. Source, analytic library, completeness and finite non-ladder work receive separate positive reserves. The JSON states these factors; no product is replaced by a custom arithmetic axiom.

The giant totals are dominated by approximately1.34 CPU seconds of current frontend/conjunction production per reference product, not its3.45ms checker time. The additional0.85-second Python proposal-generation elapsed observation per64 products is conservatively treated as busy CPU in the model. Frontend production already includes serialization to the measured memory-backed files; no second serialization CPU multiplier is added. Physical stream transfer is separate and unmeasured. Proof bytes use the measured aggregate52,088,360/64 reference bytes per product under the same hypothetical width/composition and retained-refinement factors. That stream can dominate elapsed time even with streaming. Same-rule wider references, reclamation and direct emitters are admissible engineering alternatives, but receive no invented measured speedup. A verified native arithmetic acceptance extension is a different deliverable.

PA arithmetic alone does not provide complex analysis. No general conservativity theorem or completed Lean-to-MM0 analytic export is assumed. The ordinary-MM0 full scenario is conditional on an independently established analytic foundation/translation and exact root assembly. If that route cannot be completed, its finite number is not a completion estimate.

## Engineering and next evidence

Human effort is separate from CPU. To prevent treating libraries and acceptance bridges as free, the scenario sheet explicitly budgets Lean2/10/50 engineer-years and HOL/Candle10/50/200 engineer-years; PA10/100/500. These are planning judgments, not measured productivity or promises of feasibility. They cover source producers, analytic bridges, executable checker soundness, full count closure, frontend/serialization, deployment validation and release. No arithmetic benchmark calibrates them. A team must revise them after a scoped implementation plan.

The strongest next evidence is a complete actual production block, not another isolated multiplication ratio: selected large conductor10004, two dependent coarse height steps, actual source and roots, its saved ordered CT plan, actual output radii and strict or explicitly inconclusive signs. The newly pinned c10004 row has phi4800,2301 primitive outputs, axes2/40/60 and combined precision81; it has no Bluestein leaf. A separate visiting plan is required to calibrate Blue caches. Charge the complete initialization needed by those steps. Separately test a true wide small-family time block. A high-height restart needs a proved source initializer, not an imported assumed state. These experiments would replace the type/width factors and payload-reuse assumptions that dominate this model.

The existing chi4 certificate is a completed semantic example. It cannot supply these throughput prices or a repair-success distribution. The finite interval proves actual coverage with no primality premises but does not fill every future source bitmap or prime-chain gap. Until the missing production and analytic bridges close, all totals above remain conditional forecasts of specified proposed implementations.

## Reproducibility and snapshot

`end_to_end_model.py` contains the semantic rows, all scenario factors and phase formulas. `end_to_end_model.json` records category totals, finite subtotals, generation, acceptance, representation, I/O and the hashes of current backend reports/results. No old aggregate timing forecast is used. Preparation changed the initial common finite reserve to the explicit backend-specific formulas above after the independent finite audit; no frozen earlier forecast was edited.

The exact large extraction is `WIDTH_RESOLVED_LEDGER.json`, SHA256 `9FF298322516D178D4401DA23C779EEDD6F9E387934EF55BEEB037C250D0459B`. Its full width classes and source provenance remain the next input for measured per-class prices. `SPECTRAL_COST_ESTIMATE.md` is retained only as a typed obligation ledger and historical assumption record. Newer dedicated dependent and finite-batch reports take precedence over stale checkpoint paragraphs in the top-level backend summary.
