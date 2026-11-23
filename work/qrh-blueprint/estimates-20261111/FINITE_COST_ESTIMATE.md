# Provisional finite binary and prime-chain cost estimate

2026-11-11. Requested Fermi estimate, using saved measurements and explicit engineering assumptions. No new prime search, sieve, certificate, build or timing experiment was run. Core-years below mean31,557,600 CPU seconds, or8766 core-hours. Warm inner-loop wall timings are converted to dedicated busy-core work only as a planning assumption. These are conditional scenarios, not confidence intervals or established upper bounds.

The finite branch is plausibly a tens-of-core-years job for an efficient Lean implementation at a much smaller binary cutoff. The current ordinary-PA byte-proof MM0 design has a larger provisional bill, dominated by the dense prime chain as well as binary coverage. This is a comparison of specified proposed implementations, not a language speed ratio. Neither complete finite implementation exists. In particular, the stock MM0 resource/serialization gates can make its conditional scenario inadmissible rather than merely slower.

## Planning totals and selected candidates

Use N0=9.89e26. Choose B=1e16 as the Lean planning candidate and B=2e16 as the ordinary-MM0 planning candidate. Both come from the existing finite frontier. They are not adopted mathematical inputs: a complete prime chain and binary certificate must exist and be checked. L=2^36 even targets per binary anchor block is a common layout candidate, with streamed source tiles. The raw shared odd-source bitmap is8,590,000,128 bytes, excluding proof data and temporaries.

| Candidate implementation | B | Low generation / checking | Central generation / checking | High generation / checking | Total low / central / high, core-years |
|---|---:|---:|---:|---:|---:|
| Lean kernel arithmetic, proposed complete block checker | 1e16 | 3.65 / 2.39 | 10.56 / 7.88 | 124 / 352 | **6 / 18 / 477** |
| Ordinary byte-PA MM0, conditional stock-fit model | 2e16 | 62.7 / 122.6 | 343 / 377 | 9092 / 4709 | **185 / 720 / 13800** |
| Engineered MM0 preserving the same PA rules | 2e16 | 33.6 / 74.1 | 152 / 273 | 3761 / 2844 | **108 / 425 / 6605** |

Generation includes native search, successful and unsuccessful candidate work, arithmetic witness/proof construction and in-memory emission. Checking includes the declared arithmetic and explicit completion reserves. Cold finite-library/decoder/range-assembly reserves are divided equally between those columns solely for accounting. Human proof development is excluded. Spectral work, principal certificates and the common analytic library are excluded so the coordinator can add them separately.

Rounded central planning figures are about160,000 core-hours for Lean,6.3million for the conditional ordinary-MM0 design, and3.7million for the engineered same-rule variant. Do not turn these into elapsed-time promises by dividing by a nominal thread count. Shard memory, source reuse, dependency paths, output bandwidth and complete proof composition constrain parallelism.

The high scenario is deliberately sensitive to failed special-prime windows and expensive general certificates. It is not a guaranteed ceiling. If an actual chain cannot fill every gap within the assumed search/fallback budget, the scenario fails; it does not prove the remaining primes exist. Enlarge B, pay a different verified fallback, or revise the estimate after actual evidence. No sampling rate closes an unfilled interval.

## Measurement ledger

All benchmark rows were saved on the AMD Ryzen9 8945HS host. They are not new runs.

| Calibration | Saved observation | Boundary |
|---|---|---|
| Lean4.35.0, commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc, Windows x64 release | 3.399653ms per262144-target packed arithmetic equality | Genuine kernel admission at trust0, warm prepared operands/imports,500 repeated checks. Prime/source interpretation and full coverage theorem absent. Inner elapsed time, not isolated CPU sampling. |
| Same Lean toolchain, Mathlib56a005855ea17e0b0958f73ec801ae140b0a1679 | 55.078125ms CPU per generic prime root in a32-root shared Lucas/Pratt closure | Genuine61/62-bit prime proofs, all250 prime nodes and1105 auxiliary declarations included. Warm support imports; proof construction and complete source generation separate. |
| Native SIMD mask selection | About1.30us per64-target word; about11.175 selected masks from a512-anchor pool | Actual limited prime fixtures with source slicing, not uniform coverage or whole-family statistics. Single-core elapsed-time extrapolation. |
| MM0 C, commit0d414c0bfdaaeb7fea571895127abc1fa5a3d956 | 0.822014460us checking and0.399599931us emission per selected64-bit mask update;150.01bytes/update | Parser enabled, Linux/WSL, Clang23 musl-O3, tmpfs, enlarged heap2^22/store2^30. Arithmetic tables/lifts/reset/final rule are schematic axioms; conclusion is `ok`. These timings are not a PA coverage proof. |
| Repository README at23b2d68ca344203d4384e0aff7affa4ec034bef9 | About15us native search plus55us Lean kernel checking per special ladder rung; about5 one-core hours for254638308 rungs | **Unreplicated source claim.** Uses its own wide fixed windows, base3,32-rung product batching and4096-rung literals. It does not calibrate our narrower adaptive windows or MM0. |

The Lean arithmetic benchmark reports only standard axioms, including propext; no native_decide result is imported. The generic prime fixture uses propext/Classical.choice/Quot.sound. The MM0 measurement proves the execution speed of a proof shape with enlarged capacities, not its missing PA derivations. The current paper library closes several algebraic interfaces, but no full compiled PA binary/ladder benchmark replaces that boundary.

The old FORECAST.md headlines of2000/20000 core-years at4e18 are not inputs to this estimate. Their small measured components are usable within the stated scope; their full-range multipliers are not calibration. The historical770-core-year empirical binary computation is also not used as a formal-checking rate.

## Complete finite coverage and count model

Let T=N0-1. A successful finite reduction requires every even integer4<=n<=B to be binary Goldbach, and a checked increasing odd-prime path

    3=p0<p1<...<pK<=T-4,
    p_i-p_(i-1)<=B-2,  pK+B>=T.

Each prime covers odd [p_i+4,p_i+B]. Inclusive endpoints and shard seams must be checked. The necessary number of new primes is Kmin=ceil((T-B-3)/(B-2)), giving98.9billion atB1e16 and49.45billion atB2e16. Model actual K as1.05/1.20/2.00 times Kmin for low/central/high. This is an explicit favorable/ordinary/stress path-deficit assumption, not a prime-distribution theorem. Existing fixed-window constructions can require more rungs; they are not silently assigned adaptive minimum counts.

For binary work, count all B/2-1 even targets, including the initial interval below2L and a short final block. Use ceil((B/2-1)/64) target words and ceil((B/2-1)/2^18) arithmetic tiles. The initial range has L-2 targets; outer block r has min(L,B/2-rL+1) targets, including one at the last block when L divides B/2. This prevents larger L from deleting the initial obligation.

The512-anchor reserve gives37,252,608 records atB1e16 or74,505,728 atB2e16. No theorem guarantees512 anchors cover a block. All positive source bits and selected anchors must be certified prime. A survivor sieve must also establish recursive base-list completeness through the square-root limit. The source/initial-range, failed pool searches, exceptions and full provenance costs below remain explicit. No useful common-clause/template compression or NTT speedup is assumed.

## Binary component assumptions

The following multipliers and reserves are judgments. They are deliberately exposed so a complete pilot can replace them. All source-table costs are charged once per full retained lifetime; re-sieving/rechecking after eviction increases them.

* Native mask-selection time is1.30us per word times1/2/5. This pays searches and source slicing within the fixture-like route; larger anchor pools and unresolved words also use the exception reserve.
* Lean arithmetic checking uses3.399653ms per tile times1/2/8 for changing source magnitude, halo/span, pool size, layout and sustained checking. The fixture's span was3789, much smaller than permitted D=2^19, so even the central2x factor is an assumption. Extra proof-expression/packing production is10%/50%/150% of that adjusted checker work.
* Stock-fit MM0 uses11.175 updates per word times the measured checker cost and completion factors1.2/2/5. Emission uses the measured emitter cost times1/2/5. These factors reserve PA table/lift implementation, meaningful full-mask closure, indexed source transport and sustained format overhead. They do not claim these costs were measured.
* Engineered same-rule MM0 keeps the same update count, uses0.60/0.822/1.50us per update before the same completion factors, and emitter multipliers0.75/1.25/3. This is a hypothetical memory/reference/streaming implementation, not free elimination of logical steps or an arithmetic oracle.
* Binary anchor generation costs2/20/200ms per reserved anchor, including failed proposals. Lean checking costs30/55.078125/250ms. Only the middle checking rate has a genuine generic-prime calibration; its width and sharing differ from the new anchors. MM0 anchor checking assumes0.1/1/10s each, with additional proof generation at0.5/1/2 times that checking work. This term has no matched prime benchmark and remains a sensitivity input.
* Binary source certification/factor-cache generation reserves are0.02/0.1/1 core-years for Lean and0.1/1/10 for MM0; checking reserves are0.02/0.2/2 and0.2/2/20 respectively. These pay the shared source and recursive prime provenance, rather than assuming a native bitmap is accepted. They are unmeasured fixed-L budgets.
* Separate binary exception reserves are0.05/0.5/5 core-years for generation and the same for checking, per B/1e16. If actual uncovered words, extra anchors or direct witnesses cost more, reject that scenario. They do not supply missing coverage.
* Cold finite libraries, source/position decoders, range/shard assembly and process overhead receive a further0.1/1/10 core-years in Lean and0.2/2/20 in MM0. Common analytic/spectral setup is excluded. These reserves are not human-development estimates or evidence of implemented composition.

No residual-word savings are credited beyond the measured selected-mask pattern. A compressed/source-tree/NTT route can replace this model only with a complete proved and priced implementation.

## Prime-chain generation and checking

Low/central/high special-format fallback fractions are10^-5,10^-3,10^-2. These are assumed budget cases, not observed frequencies. Ordinary-window native generation is15us times2/10/100 per selected rung. Add fallback generation of0.02/0.1/1s for each fallback, including failed earlier searches and witness discovery. Smooth-factor lanes may serve as fallbacks only with every required certificate; the model grants no probability of finding them. Arbitrary-prime certificates remain possible but must fit the chosen costs or trigger revision.

Lean special-rung checking is the unreplicated55us claim times1/3/30. Add fallback checking0.1/0.5/5s per fallback. The large factors allow for narrower windows, altered batching/base groups, decoder and primality costs, but they do not certify an implementation. This produces average checking times56us/665us/51.65ms per rung. The central B1e16 chain has118.68billion rungs and costs approximately0.94 generation plus2.50 checking core-years. The high fallback case dominates the high total.

MM0 is priced from a separate ordinary arithmetic schedule, not Lean's55us. A supplied-root Proth certificate requires44 modular squares at at most90 bits. At radix256, the retained conservative modular template has two S(12)=745 multiplication cores, A(24)=49 plus A(12)=25 addition cores, and one glue role per square. Thus a rung has

    P=65560 multiplication-template events,
    A=3256 addition-template events, plus44 glue roles.

These are not MMB dispatches. Using the companion MM0_CALIBRATION_AUDIT's provisional100/180/400 dispatches per P,80/160/320 per A, and100/180/400 per glue gives6.821m/12.330m/27.284m dispatches per rung. The model adds20% for per-root order/primality, bounds, decoding and path binding outside that modular subtotal. Exact positions and roots still need generation; no initial a^k relation is checked when the sufficient supplied-root criterion is used. Size-band savings, specialized squares, wider radices and product-modulus batching are not credited.

Stock-fit dispatch rates are200/100/25million per CPU second; engineered same-rule rates400/160/50million. The saved160–186million schematic rate supports a scale, not a calibrated PA throughput guarantee. MM0 fallback checking assumes0.1/1/10s each, added to the baseline. Proof generation costs0.5/1/2 times ladder checking in the stock-fit model, or0.3/0.6/1.5 in the engineered model, plus native prime search. These factors represent DAG construction, arithmetic witnesses and emission; none was benchmarked for this ladder.

For central B2e16, K=59.34billion. The stock-fit average checking cost is0.14895616s/rung, approximately280 checking plus281 generation core-years. The engineered case is0.0934726s/rung, approximately176 checking plus106 generation core-years. This explains why a smaller binary B is not automatically best for an explicit PA ladder.

## Central cutoff sensitivity

These recompute only the displayed Fermi formulas at existing candidate cutoffs; they are not a new inventory or prime scan.

| B | Lean total | Stock-fit MM0 total | Engineered same-rule MM0 total |
|---:|---:|---:|---:|
|1e16|18.4|1204|638|
|2e16|30.4|720|425|
|1e17|138.5|891|753|

Each row holds its central deficit/fallback/rate assumptions fixed across B, which actual data need not do. The table selects planning candidates only within these three scenarios. It is not an optimum theorem. The existing certified-pool frontier provides the correct later decision: check the actual maximum gap and terminal deficit, then choose a complete path and cutoff using complete costs. A sparse successful pool may force a larger B regardless of this table.

## Storage, stock admission and uncertainty

At the central MM0 cutoff the measured schematic150.01-byte/update pattern extrapolates to about262PB of binary proof stream before the missing PA completion. It is an emission/streaming workload, not a requirement to store one permanent file. Materializing and later reading it would add real I/O and storage expense. A single100GB/s aggregate pass over262PB is about30days, independent of CPU parallelism; two passes double that. The model's CPU emitter time came from tmpfs and does not pay a disk bandwidth wait.

The central ladder's12.33million proof-plus-header dispatches times K correspond to about2.2EB at an illustrative three bytes per dispatch. This is **logical instruction/header-access traffic**, not serialized proof size: theorem headers are reused rather than emitted per execution. Actual body bytes, header-cache behavior, reference encodings and peak live storage need a concrete emitter. A compact90-bit root payload alone is only about668GB at the central K; it does not represent the arithmetic proof volume.

The schematic MM0 timings already enlarged heap/store capacities. Default stock limits, theorem counts, p32 header placement, checked context across packs and final complete-range composition have not been demonstrated for this workload. If a legal stock schedule cannot meet them, the stock-fit row has no executable realization; do not interpret its high number as a guarantee. The engineered column permits wider/reclaiming storage and improved streaming while preserving ordinary PA rules and the actual external specification. It does not trust native modular arithmetic, import an unchecked run, skip proof commands or replace meaningful coverage with `ok`. Comparable foundation-preserving engineering is allowed for Lean too; no universal prover ranking follows.

Unsuccessful candidates, exceptional binary words and proof-layout limits can exceed the high reserves. Actual primes and complete source coverage remain the main feasibility gate. Development effort, hardware procurement, distributed scheduling and independent second replay are additional planning questions. A second full replay generally adds the corresponding checking bill, not the generation bill. There is no claim that parallel efficiency or failure recovery is free.

## Reproducible arithmetic and pins

The small scalar-only model is finite_cost_scenarios.py, SHA256 C842CFE3897E1A503781241DEFE0416260134E151ECF1B6CE6900DF49F13664B. Its first-run receipt finite_cost_scenarios.json has SHA256 48FC76488941526A4B2CA5B5198B06D6051DA67D78DFBA342C5F8B9374E9363B. It computes the stated counts/formulas from fixed parameters and does not load or generate any prime or function data.

Calibration support, relative to the workspace:

| Source | SHA256 |
|---|---|
| work/formal-goldbach-bench/lean/REPORT.md | 7572D5C748668EFC8E163822C0FDBBB4602A1A796E8B3FDA8412F53739FAAB7E |
| work/formal-goldbach-bench/mm0/REPORT.md | E78BFC3A070EE69BEE9DAA7E93376759E8938E379C067A24AFF910B4E609C02B |
| work/formal-goldbach-bench/prime-cert/REPORT.md | 4F806BD887B187043AAC4180DBF40E2C9C78AD023F8248311BBDC397D43C2ACB |
| work/formal-goldbach-bench/forecast_inputs.json | 9B974AD8F24D28E9B3017657519145752EE5DE008AED7E6F6E03D7129D9A9662 |
| work/ternary-goldbach/README.md at23b2d68ca344203d4384e0aff7affa4ec034bef9 | D884FCAD91275B30AED6A96223503EF1ED5E3B234B8FAFD85D095CDCE7C5C3D7 |
| work/qrh-blueprint/estimates-20261111/MM0_CALIBRATION_AUDIT.md | 4BFCDFC88F2ABA0D87D1AA705778D32D2482916E429932F96EF3D6D27A0D8792 |

The saved raw calibration identities are recorded in forecast_inputs.json: Lean LargeBench.strict73457904, prime results5652E63A, MM0 summary209361FF and SIMD summary03CBC764. Their timing definitions are retained above. Mathematical count interfaces are the accepted FINITE_GOLDBACH_GLOBAL_COST_FRONTIER, FINITE_COVERAGE_COST_FRONTIER_V2, BINARY_BLOCK_SCALING and supplied-root/size-band papers. Their exact complete-coverage obligations remain unchanged.

These figures replace neither the actual certificate work nor a measured pilot. They are a transparent provisional budget for the finite component to add to the separately estimated spectral and proof-library components.
