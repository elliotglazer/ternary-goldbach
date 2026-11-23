# Independent forecast scope and mathematics audit

2026-11-10 Pacific. Research/source review only; no compiler or benchmark run by this reviewer. Audited `FORECAST.md` SHA256 `D59A5528EFBBBA83DCCC5AD711029E83C353A79974D9C034C6E1D050587E572C`. The final numerical model audit is **pending the coordinator's final inputs**. This note does not approve the provisional 2,000/20,000 totals numerically.

## Disposition

The draft clearly distinguishes a forecast from an actual Goldbach proof, current explicit MMB checking from an unbuilt arithmetic accelerator, sampled covers from a uniform theorem, and native computation from certified arithmetic. The packed mathematical test is sound. The corrections below should be incorporated before final scope approval.

## Required clarifications

### R1. Broad optimization must include the faster native algorithm

The draft anchors accelerated-MM0 discussion to the 3.015 ms native packed multiplication. `prime-cover/PACKED_REPORT.md` also records a **0.608 ms native shift/OR test on the same 262,144-target, 188-anchor fixture**. Its coverage-only extrapolation is approximately 147 core-years, versus 729 for native packing. An arithmetic accelerator is not obliged to choose the algorithm that happens to benchmark best in the present Lean kernel.

Include this alternative and identify accelerated full-project costs as unmeasured. The conclusion should not be that 147 years is an end-to-end budget: certified source data, construction, lookup, arithmetic implementation correctness and proof composition are excluded. Conversely, 729 years is not a lower bound or the uniquely supported accelerated arithmetic target.

If new proved-sound accelerators are allowed for MM0, the same optimization permission must be allowed for Lean. Both could use an equivalently specialized certified checker; a universal ranking by system name then has no measured basis. The coordinator has acknowledged this correction.

### R2. State exactly what the schematic MM0 theorem omits

`mm0/REPORT.md` says the final theorem is `ok`, the table/lift/reset/final rules are schematic axioms, and reset does **not** require an all-ones accumulator. Python checks the actual fixture's all-ones property. The draft discloses the schematic library and missing provenance, but should also explicitly disclose that final coverage closure is not certified by the MM0 theorem.

The actual trace contains 256 distinct words and 2,892 updates, repeated 160 times. This demonstrates verifier instruction throughput for that pattern; it does not exercise billions of distinct windows, large source-table access, or corresponding cache behavior. Include this limitation alongside the timing.

These limitations do not invalidate the timing measurement. They do prevent describing it as a PA arithmetic proof or complete certified coverage benchmark. The draft's phrase “valid proof stream accepted by the checker” is correct only relative to its explicitly schematic specification.

## Modeling caveats for the pending numerical audit

`prime-cover/packed_large.py` chooses the shortest successful prefix of the 512-anchor pool for each local fixture. At width 262,144 this is 188 anchors, radix exponent 9 and offset span 3,789. It is not a timed polynomial using all 512 reserved anchors.

A production implementation can cache several prefix polynomials per anchor block, or use a fixed larger pool. Those are sound designs, but their construction and arithmetic costs differ. Do not combine a single fixed 512-anchor polynomial with the 188-anchor fixture rate without an explicit allowance. Variation in m, radix exponent, span, local coverage difficulty, and exceptional witnesses belongs in the sensitivity model.

The proposed hierarchy and shared source facts are designs, not measured whole-proof machinery. Importing aligned source facts must preserve their checked prime interpretation and indices. Precomputing their values alone does not discharge that proof work. Likewise, all generated auxiliary primality declarations must be charged and replayed, rather than only their short named wrapper theorems.

The cited `prime-cert/REPORT.md` was not yet present when this audit was performed. The draft's claim about complete primality auxiliary-declaration replay therefore remains pending source confirmation here; it is not independently approved by this audit. This may simply reflect an in-progress report.

## Packed formula: PASS

Assume finite 0/1 source digits P_j, nonnegative offsets s_i<=S, radix B=2^k with k>=1, and m<=h=B/2. Repeated offsets are permitted mathematically when counted with multiplicity; the exporter instead requires distinct offsets and constructs a 0/1 anchor bitmap.

For P'=sum P_j B^j and A=sum B^(S−s_i), every product coefficient is at most m<=h<B. Thus the product has no base-B carries, and its coefficient at S+t is sum_i P_(s_i+t). Source indices outside the finite domain are interpreted as zero; the needed source window includes every s_i+t.

Adding K_s changes each target coefficient c to c+h−1<=2h−1=B−1 and leaves all other coefficients unchanged. There is still no interdigit carry. The target high bit is one exactly when c>=1. Hence `(P'*A+K_s) & H_s = H_s` is equivalent to positive coverage at every target position. The relaxed m<=h bound is correct for this **additive** test. It must not be transferred to the older OR-then-subtract formula, which requires c<h.

The generic theorem translating these counts and certified prime interpretations to Goldbach has not been formalized by these arithmetic experiments. The forecast says so correctly. Local successful arithmetic equalities alone do not prove the full number-theoretic claim.

## Other reviewed scope claims: PASS with stated boundaries

* No full Goldbach proof is claimed; required generic, source-primality and assembly proofs are listed.
* No uniform coverage guarantee is inferred from sampled pools; fallbacks are required.
* Present Lean kernel arithmetic primitives are distinguished from external/native-decide trust.
* A PA-preserving accelerated checker may use a different format without adding mathematical axioms. The draft does not claim that a verified compiler plus an observed native run produces an ordinary MMB proof.
* Expanded proof serialization is treated as an implementation choice, with fused streaming unmeasured.
* Trillion-scale proof assembly is explicitly not demonstrated in a stock monolithic invocation; hashes/manifests are not mistaken for proofs.
* Host/backend differences and excluded development time are disclosed.

Final numerical validation and recheck of the revised forecast remain pending.

## Final audit: PASS within the conditional-forecast scope

The final review supersedes the pending status above. R1 and R2 are resolved in the revised forecast. The faster native shift/OR reference, equal permission for accelerators in either system, schematic `ok` conclusion, missing MM0 all-ones closure, repeated 256-word fixture, and 188-versus-512-anchor distinction are now explicit. The prime-certificate report is present and was reviewed.

This is a pass for reproducibility, arithmetic, and stated scope of the **conditional engineering forecast**. It does not certify the eventual Goldbach proof, completeness of the proposed implementation, global coverage, the optimality of either design, or the adequacy of unmeasured allowances.

### Frozen artifacts reviewed

| Artifact | SHA256 |
|---|---|
| `FORECAST.md` | `5b2f23382ba1a950d6bd79707e2ce45db912b196d0117cc1c0e3e923d272b262` |
| `forecast_inputs.json` | `9b974ad8f24d28e9b3017657519145752ee5de008aed7e6f6e03d7129d9a9662` |
| `forecast_model.py` | `20d1359e2f81da2417bb53528339fe8a608b85bf921e2846839ff60e8dd91bd4` |
| `freeze_forecast_inputs.py` | `12d22cbff5652d738057555f490eb8e040ab0d64961cb6b6f8c0f354e05dd4b3` |
| `forecast.json` | `71a28b74d31b9fe2f962f43b4b9469b2c909a8b9d618bf9d1c639a29076e2a3c` |

All seven raw-input hashes listed in `forecast_inputs.json` match. The first attempt caught a changed `mm0/summary.json`; the coordinator refroze the inputs after that report was finalized. The final MM0 summary hash is `209361ffdde02cebee787511df38cb6a27b9b647a80de37f0c0bfa4cf472b687`. The numerical calibration values did not change during that repair.

All hashes in the prime-certificate result's artifact map and the MM0 summary's artifact map were checked successfully. The two Lean arithmetic source hashes and all nine pinned MM0 source-manifest file hashes also matched the files examined. This validates local provenance consistency; it is not a new execution of their benchmarks.

Both Python scripts were executed in memory with `Path.write_text` replaced by a capture function and bytecode writing disabled. The regenerated input JSON matched the frozen input exactly as parsed, and the regenerated model JSON matched `forecast.json` exactly as parsed. No model, source, benchmark, or compiled artifact was written by this audit.

### Counts, units, and numerical reproduction

The inclusive interval from 4 to 4e18 contains 1,999,999,999,999,999,999 even targets. Independent integer arithmetic gives:

* 465,661,288 anchor blocks of at most 2^32 targets;
* 238,418,579,456 reserved anchors at 512 per block;
* 31,250,000,000,000,000 64-target words;
* 7,629,394,531,250 chunks of at most 262,144 targets.

The model consistently uses 31,557,600 seconds per core-year. Seconds, milliseconds, and microseconds are converted correctly. Its dedicated-core interpretation of the Lean inner wall timer, unlike the prime/MM0 process-CPU timers, is explicitly an assumption.

| Lean component | Reproduced core-years |
|---|---:|
| Packed kernel coverage extrapolation | 821.903250 |
| Build/layout allowance | 256.844766 |
| Full prime-certificate closure extrapolation | 416.116825 |
| Native construction allowance | 100 |
| Shared-data/assembly allowance | 200 |
| Total | **1,794.864841** |

The build/layout calculation multiplies measured coverage by 1.05 times 1.25; its added component is therefore 31.25% of measured coverage. This is correctly labeled as an allowance, not a measured 262,144-target construction cost.

The chosen MM0 strategy is pool 512 in each of the three modeled routes. It minimizes the stated sum among the measured pool/sequential strategies; no broader algorithmic optimum is claimed. Its mean selected-mask count is 11.174560546875. The sequential strategy appears through both native measurement sources but is not selected, so that duplication does not affect the minimum.

| Prealigned serial MM0 component | Reproduced core-years |
|---|---:|
| Native cover search | 1,289.772287 |
| Schematic coverage-step checking | 9,096.115472 |
| Serialized proof emission | 4,421.828678 |
| Index/provenance/full-mask allowance | 2,766.409812 |
| Other preparation/prime/assembly allowance | 1,000 |
| Total | **18,574.126248** |

The repeated-slice serial alternative totals **25,863.321922** core-years. The idealized prealigned fusion scenario totals **14,152.297570** by removing separately charged emission; the model correctly labels it unmeasured rather than asserting that template processing is free. Native packed and native shift/OR arithmetic extrapolate to **728.944724** and **146.910961** core-years. The wall-time conversion at 70% efficiency is internally consistent; the prose uses rounded 2,000/20,000 planning numbers rather than the unrounded model totals.

### Prime measurement includes the full auxiliary closure

The model selects the `full_shared_closure` row for 32 roots and ten repetitions. Its 1,355 declarations comprise 250 named prime nodes and 1,105 auxiliaries. All 13,550 checks were accepted and the negative control was rejected. The recorded 17.625 CPU seconds divided by 320 anchor-equivalents gives exactly 55.078125 ms per anchor, producing the 416.116825-core-year component. The model does not use the incomplete named-root-only timing.

The supplied report and result manifest record standard Lean axioms only for all 32 root proofs. Supporting imported Mathlib/fixed theorems remain previously checked prerequisites, rather than being rechecked inside this timer. The input roots are a small structured sample, and the forecast does not claim a universal bound for all 62-bit prime certificates. Proof construction and more extensive sharing are separate uncertain terms.

### Residual conditions remain material

The accepted arithmetic does not validate the 100/200/1,000-core-year allowances, the per-mask 0.25-microsecond allowance, or the proposed sensitivity envelopes as bounds. Formal source expansion, efficient certified lookup, PA derivations replacing schematic rules, complete final coverage closure, prefix-polynomial reuse, and scalable proof-DAG assembly remain unimplemented or unintegrated. Extreme cover/certificate cases can move actual costs outside the planning ranges. The revised forecast states these conditions rather than presenting its rounded numbers as demonstrated full-proof runtimes.

No additional required correction remains for the reviewed conditional forecast.
