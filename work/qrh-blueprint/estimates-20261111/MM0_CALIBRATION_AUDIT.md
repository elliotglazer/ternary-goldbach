# MM0 calibration audit for the provisional end-to-end estimate

2026-11-11. Saved-measurement and source audit, with explicit planning scenarios. No new verifier run, proof generation, build, inventory fold or arithmetic-library construction was performed. The new signed product-round schedule is a paper specification, not a completed PA implementation.

**Use the saved measurements to calibrate interpreter dispatch, not mathematical arithmetic events.** The usable measured range is about 160–186 million combined proof/unifier dispatches per CPU second on the saved host. Those runs use schematic arithmetic axioms and enlarged memory limits. For an eventual ordinary-PA workload, this note recommends the provisional cost-low/central/high checking rates **200/100/25 million dispatches per second for the stock-format route**, and **400/160/50 million for an engineered same-rules route**. These are transfer assumptions, not measured PA rates. Proof expansion, generation, source binding, library completion and analytic translation remain separate costs.

## 1. What was actually measured

The saved `work/formal-goldbach-bench/mm0/summary.json`, report and raw actual-trace results agree on the following incremental quantities. Timing is CPU time, not process wall time.

| Saved case | Proof commands/update | Unifier commands/update | Checker microseconds/update | Combined dispatches/second | Emission microseconds/update |
|---|---:|---:|---:|---:|---:|
| Actual selected masks, OR | 58.619625 | 94.504804 | 0.822014460 | 186,279,484 | 0.399599931 |
| Sparse OR with resets | 58.437486 | 94.062466 | 0.913392856 | 166,959,869 | 0.430843468 |
| Sparse slice/OR with resets | 75.437486 | 134.062466 | 1.305776142 | 160,440,940 | 0.574561664 |

The actual trace has 462720 updates, formed by repeating 2892 updates over 256 distinct words 160 times. Its matched checker medians are 0.036340351 seconds for bootstrap and 0.416702882 seconds for workload. Its producer medians are 0.001913473 and 0.186816353 seconds. Net emission is 150.010300 bytes/update and about 375.4 MB/s; the other native emitters achieve about 328.5 and 341.9 MB/s. These are decimal MB and RAM-file output, not disk throughput.

The instrumented binary counts one `run_proof` or `run_unify` loop iteration, including terminators. It does not separately count theorem-argument loops, dependency checks, all memory traffic or CPU instructions. Timings use a separate uninstrumented path. A count of 153.124429 dispatches divided by 0.822014460 microseconds is a measured *mixed-workload effective rate*, not an independently measured cost for every opcode.

The host is an AMD Ryzen 9 8945HS, 8 physical cores/16 logical processors, approximately 32 GiB RAM. Execution is single-threaded WSL Linux, Clang23.1.0 `-O3 -static`, musl, files on Linux tmpfs. Parser checking is enabled. Timing starts after initial mapping setup and excludes process/WSL startup. The reported net rate subtracts repeated bootstrap; a complete deployment must add its actual bootstrap/import/chunk work. Gross actual-trace checking is about 0.90055 microseconds/update.

`build.py` changes heap capacity from 65536 to 2^22 entries and expression store from 2^26 to 2^30 bytes, adds timing, and replaces the diagnostic failure path while preserving rejection. The separately profiled source adds loop counters. Thus this is evidence for the ordinary instruction semantics with capacity engineering, **not an unchanged-stock-memory benchmark**. The actual trace used 1,032,193 heap entries and 77,404,708 store bytes, exceeding stock limits. It cannot simply be replayed as one unchanged-stock theorem.

All byte-table facts, lift/reset rules and the finish rule in these specifications are axioms. The final theorem is `ok`. The fixture's Python checks of source masks and all-ones coverage are not part of that theorem. Corrupted-reference rejection establishes useful binding behavior, not PA derivation of those axioms, prime provenance or Goldbach. The source listing found no ready ordinary-PA signed product-round fixture to rerun. Therefore no new benchmark was launched under the optional-run permission.

## 2. Transfer scenarios, with units fixed

The measurements do not identify separate proof and header speeds. For example, one equation

    58.619625/r_proof + 94.504804/r_header = 0.822014460 microseconds

has many solutions, even before accounting for nested checks. The scenarios below deliberately assign the same effective rate to I proof commands and U executed header commands. That is a transparent approximation to a complete counted workload, not a fitted claim that the two dispatches cost the same.

| Route and cost scenario | Effective I/U rate, million/CPU-second | Nanoseconds per counted I or U | Native proof-emission planning rate, MB/s |
|---|---:|---:|---:|
| Stock-format ordinary PA, cost-low | 200 | 5 | 375 |
| Stock-format ordinary PA, central | 100 | 10 | 150 |
| Stock-format ordinary PA, cost-high | 25 | 40 | 50 |
| Engineered same-rules, cost-low | 400 | 2.5 | 750 |
| Engineered same-rules, central | 160 | 6.25 | 375 |
| Engineered same-rules, cost-high | 50 | 20 | 100 |

These choices have the following basis and limits:

* The stock cost-low checking rate is close to the best saved mixed interpreter rate. It presupposes short well-shared PA headers, fitting chunks and little additional locality loss. It is optimistic, not demonstrated under stock limits.
* The stock central rate is about 54–62% of the measured range. This deliberately allows for different PA header/argument mixes, term construction, tighter chunking and less favorable locality. The high-cost rate allows another factor four. Neither discount was measured on this signed-round circuit.
* The engineered central rate retains the slower end of the saved range. Capacity tuning, deliberate sharing, native templates and exact same-rule streaming are candidate engineering changes. The optimistic 400 million rate is roughly twice the saved best rate; it is an unmeasured optimization scenario. The 50 million stress rate allows substantial remaining allocation/transport loss. “Same rules” forbids substituting a native arithmetic acceptance oracle or silently trusting an external checked shard.
* Emission rates bracket the measured 328–375 MB/s native template emitter. A general PA emitter must construct witnesses, exact terms and references; the measured OR emitter does not price wide integer witness generation. The central stock discount and optimistic engineered uplift are explicit assumptions. Add witness/discovery work separately unless actually included in a measured producer.

For an actually counted circuit use

    T_check = (I+U)/r + T_exceptional_mix + T_library/import/join,
    T_emit = serialized_body_bytes / r_emit + T_witness + T_library_emit.

The effective rates already include an assumed ordinary mix of argument checks and allocation per dispatch. Do not charge that same assumed mix again. `T_exceptional_mix` is the additional measured or modeled cost beyond that mixture, such as unusually large argument/dependency checks, cache misses or semantic conversions absent from the template. Alternatively use an opcode/argument/allocation-resolved model and discard the effective-rate approximation entirely.

CPU generation and checking costs add for the saved serialized pipeline. Pipelining changes elapsed time, not their sum. A fused emitter/checker may avoid materializing bytes, but then its template processing and checking need a replacement cost; it cannot claim both zero emission and the same measured serialized pipeline without evidence. Device I/O and network/storage floors are additional deployment constraints, with overlap stated rather than counted twice.

One core-year means 31,557,600 CPU seconds. Thus a counted 10^18 dispatches alone costs approximately 158/317/1268 core-years in the stock low/central/high cases, or 79/198/634 in the engineered cases. These conversions are not counts of the campaign's work. No universal Lean/MM0 speed ratio follows: Lean kernel big-natural reduction performs a different proof workload, and its own pilots must be priced separately.

## 3. Reconciliation with the full signed-round schedule

The new note `moebius/SIGNED_DYADIC_PRODUCT_ROUND_ACCEPTANCE_SCHEDULE_2026-11-11.md` fixes one materialized branch with 1<=s<=a+b. It validates arbitrary candidate capacities first, proves one unsigned product, binds a power-of-two shift, checks two sign-dependent natural additions against the same retained result word, and exports the exact tie-toward-positive-infinity result. Source/destination bindings, negative zero, actual ranges and final canonicalization remain explicit.

For its positive-product branch let m,n be operand byte lengths and ell the raw addition byte length. The displayed known counts are

    I = 25mn+42n+3m+32ell+41
        +D0+C_terms+sum_extra(a_j+1+h_j)+I_outside,
    U = 182mn+238n+20m+232ell+134
        +sum_new_closed u_f+sum_extra u_j+U_outside.

Here D0 counts newly instantiated **closed** facts, C_terms counts actual constructor-child requests, and the extra applications include source decoders, sign/exponent/shift/range/destination adapters. Header execution is separate from stored header bytes. The known I+U subtotal is therefore

    207mn+280n+23m+264ell+175,

not the byte arithmetic event count. Zero-product proofs have their own branch schedule. The new paper still needs independent review and actual PA implementation; its exact coefficients are an author derivation, not fresh runtime evidence.

The same source gives useful anchors for provisional aggregate P/A estimates when individual gates are not yet expanded:

* The original rectangular product template is P(m,n)=5mn+2n+1. Full-cell/PB/caller known I+U, before table instances, constructor work and other adapters, is `207mn+280n+23m+117`. Its leading ratio to P is 41.4. For m>=n>=1 this known subtotal is at most79P: the difference is `188mn-122n-23m-38>=0`. This is an upper bound for the *known subtotal only*, not the complete multiplier.
* The range-checking adder plus base and initial-zero removal has known `I+U=132ell+31` against A(ell)=2ell+1, approaching66 dispatches per A event. Its table/range producers, term construction and operand bindings still add work. The formula is below66A, not a complete upper bound.

These derivations explain why converting one byte event to one dispatch is untenable. They also show why the aggregate P/A coefficients cannot be measured from the old OR fixture. A retained byte-word interface avoids unnecessary public-numeral round trips, but does not eliminate the first source binding or final destination proof.

For root's **provisional estimate only**, use the following explicit local-expansion allowances when exact I/U are unavailable:

| Cost scenario | Combined dispatch allowance kP per P | Combined dispatch allowance kA per A |
|---|---:|---:|
| Low | 100 | 80 |
| Central | 180 | 160 |
| High | 400 | 320 |

They are engineering allowances, not universal proven bounds. The low case assumes aggressive matching-term reuse and mostly cached closed table/range facts, leaving comparatively little above the displayed subtotal. Central/high allocate more for fresh conclusions, first table/range applications, ordinary local adapters and lost reuse. The paper's full formula names the costs these allowances approximate; their actual values remain unknown until a complete ordinary-PA fixture fixes statement representations, request frequencies and IDs. Public source/export conversions, witness generation, analytic proof translation, library proofs, global joins, discovery and repairs stay separate. They must not be buried in these local allowances or declared paid without evidence.

The resulting local checking sensitivities are:

| Route | Low microseconds/P, A | Central microseconds/P, A | High microseconds/P, A |
|---|---:|---:|---:|
| Stock-format ordinary PA | 0.5, 0.4 | 1.8, 1.6 | 16, 12.8 |
| Engineered same-rules | 0.25, 0.2 | 1.125, 1 | 8, 6.4 |

Apply these to the separately retained P and A totals, **or** price the full signed-gate I/U expansion, not both. If a workload's A total already includes its round-witness additions, do not add them again from the signed schedule. If an addition has a different mathematical/interface role, first map it to the appropriate actual template. Very small operations, zero branches, special constants and wider digits may need different schedules; no new optimization or uniform replacement is inferred here.

This deliberately broad range is usable for a provisional estimate while exposing its weakness. It is not a confidence interval, proof-size bound or procurement forecast. Unfinished implementations or very large uncached source terms can move the result outside it.

## 4. Coordination with the spectral and finite estimates

The spectral report retains the accepted combined main-plus-guard three-product counts P=3076486625497782230 and A=519549455680901010, and separately retains the regrid A-core and residue/head/source work. This audit does not fold those inventories. The author has the expansion/rate tables above and must keep the additional source/converter/library categories visible. Mean186/runtime692 changes have no accepted exact price inventory here and receive no automatic reduction.

The finite report can retain the direct selected-mask timing for exactly its measured schematic pattern. Do not apply the new natural multiplication P/A coefficients to that OR trace. Completion of ordinary PA tables, checked source lookup, prime provenance, full-word closure, generic coverage and final interval composition remains extra. The measured native emitter is not a prime-certificate generator.

For direct-order prime certificates, expand modular-product, division/remainder and sign/range/binding schedules before applying dispatch throughput. A report such as “roughly 2–10 million dispatches per rung” is an additional provisional circuit allowance, not established by counting 68860 byte events. Its justification must retain the precise number and widths of products, quotient witnesses and representation adapters. This audit supplies no empirical MM0 primality timing and does not reuse the saved Lean 55.08 ms Lucas–Pratt measurement as an MM0 number.

Local closed-fact reuse has a genuine ordinary-rule mechanism: v requests with a saved exact conclusion change from 2v proof commands and v header executions to v+1 commands and one header execution using ThmSave/Ref. That reduction applies only to actual matching objects in a fitting theorem-local context. It costs a heap entry and can widen IDs. Stock resets destroy local proof identities. No global table cache, unpriced header elimination or arbitrary shard import is assumed. If the chosen I/U expansion already uses this reuse, do not subtract it again.

## 5. Missing implementation and full-proof obligations

The provisional arithmetic estimate is conditional on completing the following, which the saved microbenchmarks do not supply:

1. Ordinary-PA proofs of the chosen byte/carry/range facts and generic cell, row, adder, numeral, signed and round interfaces, with exact source/destination terms and negative controls. Neither schematic axioms nor the peano_hex coercion/evaluator axioms are accepted as PA-only completion.
2. A complete representative proof under the actual stock or explicitly engineered resource/file format. Stock heap65536/store2^26 and first-4GiB statement/individual-proof limits require real chunking and composition; the saved enlarged run is not that demonstration.
3. Witness and proof generation, local table/term construction, declaration-level reuse, parsing/bootstrap, representation exports, proof bytes and transport at actual lifetimes. Source headers execute on every application, even if stored once.
4. The complete analytic foundation and translation/join to these PA finite proofs. The reviewed foundation plan proposes proof-producing translation into a compatible standard-axiom theory; it has no implemented full Lean4 analytic closure. PA arithmetic alone does not supply real/complex analysis, integrals, zeros or the final Goldbach proof. Existing Lean proofs/exports are reusable inputs only after actual target translation and axiom/statement checking.
5. Actual principal/nonprincipal certificate production, strict signs/completeness, finite binary coverage/prime witnesses, exceptional cases and final theorem assembly. An optimistic arithmetic rate does not prove these inputs exist or have bounded generation cost.

Root may assign explicit provisional engineering allowances to these categories in the full estimate, but those are not timing measurements from this audit. A total which sets them to zero is incomplete. There is also no meaningful finite completion-time guarantee while the analytic translator or required mathematics remains missing. Development effort is a separate axis from CPU cost; this note supplies no invented person-month estimate.

The next decisive calibration would be a tiny complete ordinary-PA product-round fixture with the exact accepted signatures, stock parser enabled, real source/output bindings, and separate emission/checking/header/allocation counters. It should precede large-scale proof generation. This audit did not create that fixture or launch a new optimization branch.

## 6. Evidence and reproducibility boundary

All files below were read or hashed from saved local artifacts. No historical writer or benchmark was rerun. The saved rate table comes directly from summary/raw measurement files; the expansion allowances and transfer scenarios are new, explicitly provisional judgments.

| Workspace-relative artifact | SHA256 |
|---|---|
| work/formal-goldbach-bench/mm0/REPORT.md | E78BFC3A070EE69BEE9DAA7E93376759E8938E379C067A24AFF910B4E609C02B |
| work/formal-goldbach-bench/mm0/summary.json | 209361FFDDE02CEBEE787511DF38CB6A27B9B647A80DE37F0C0BFA4CF472B687 |
| work/formal-goldbach-bench/mm0/actual-reset-or.native-result.json | 91837F11CF87F54153C1FDD8C09AC7506CE7BA98DB9BB4BE8A8E53FC1A5A170C |
| work/formal-goldbach-bench/mm0/build.py | DBD6E8C620863E21732E31673669D983FAE02E5A2CDA11D7F9E09CB1747493D5 |
| work/formal-goldbach-bench/mm0/build-manifest.json | D23E55E934CF4414309339B8D6FB49D69612C8CDE5B188B9EB683677FFF5FE33 |
| work/formal-goldbach-bench/mm0/src/verifier.c | 71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5 |
| work/formal-goldbach-bench/mm0/src/verifier_types.c | 87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E |
| work/formal-goldbach-bench/FORECAST.md | 5B2F23382BA1A950D6BD79707E2CE45DB912B196D0117CC1C0E3E923D272B262 |
| work/qrh-campaign/agents/moebius/SIGNED_DYADIC_PRODUCT_ROUND_ACCEPTANCE_SCHEDULE_2026-11-11.md | D6FFF3F04959C72E64481F52651B9C6598E076C604350D140880234BD0816AE5 |
| work/qrh-campaign/agents/moebius/MM0_ANALYTIC_FOUNDATION_IMPLEMENTATION_PLAN_2026-11-11.md | 5B84A49945FCF62C52F1B52574E9F1D783CBF7A9DE7D259435AC7252F006415C |
| work/qrh-campaign/agents/audit/ORDINARY_BACKEND_ACCOUNTING_AND_LOCAL_REUSE_2026-11-11.md | 0E7920DAAD05D434AF6FBD6CBDE79963BE1210417066F734285D23BC18718A50 |

The old FORECAST headline totals are historical and are not carried into the new estimate. Only its measured component evidence and explicit trust/timing boundaries are reused. The current handoff is a usable, qualified calibration model, not a standard-axioms-only completion claim.
