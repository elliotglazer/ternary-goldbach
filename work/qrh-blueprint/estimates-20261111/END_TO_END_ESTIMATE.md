# Provisional end-to-end estimate for the selected proof route

2026-11-11. These estimates cover the selected analytic proof, numerical certificates and finite prime coverage. They describe explicit proposed certificate implementations. They are not estimates of the best achievable Lean or MM0 implementation, confidence intervals, or upper bounds on completion. The complete spectral certificate implementation and its global success evidence do not yet exist.

The present model is extremely expensive. It does not support committing compute to a full production run. Its useful conclusion is that the spectral certificate representation needs measured improvement before this route has a credible practical budget. The mathematical strategy remains selected; the production proof encoding is not settled.

## First complete acceptance

One core-year is 8766 core-hours. The following totals include generation and the first acceptance of the complete proof. A Lean spectral build already checks its proofs; an independent second replay is excluded. MM0 external generation and its first checker run are both included.

| Proposed implementation | Low scenario, core-hours | Central scenario, core-hours | High scenario, core-hours |
|---|---:|---:|---:|
| Lean, initial complete build | 1.40 billion | 67.7 billion | 10.4 trillion |
| Ordinary PA MM0, conditional on a legal proof layout | 2.49 billion | 32.7 billion | 8.97 trillion |

In core-years these are approximately 160000 / 7.73 million / 1.19 billion for Lean, and 284000 / 3.73 million / 1.02 billion for the specified MM0 design. The apparent ordering changes across scenarios. It is not evidence that either system is fundamentally faster: their proposed arithmetic encodings and workload-transfer assumptions differ.

The central decomposition is:

| Component | Lean, core-hours | Ordinary PA MM0, core-hours |
|---|---:|---:|
| Spectral construction including initial Lean checking | 67.7 billion | Not a separate MM0 stage |
| Spectral external MM0 generation | Not separately measured for Lean | 19.7 billion |
| Spectral first MM0 checking | Included in Lean build | 13.0 billion |
| Finite binary and ladder generation | About 92500 | About 3.01 million |
| Finite binary and ladder checking | About 69100 | About 3.30 million |

The finite-only central scenarios are about 18.4 core-years in Lean at B = 10^16 and 720 core-years for ordinary PA MM0 at B = 2 * 10^16. Those small finite totals must never be presented as end-to-end proof estimates. Different cutoffs trade binary work against the prime ladder. Neither a complete chain nor a successful production coverage run has been supplied for these candidates.

Generic arithmetic and analytic library CPU reserves are included once in the spectral component. Finite-specific decoder and interval-assembly reserves are included in the finite component. Human formalization time is excluded. The primary model does not include an additional independent full replay; the central optional Lean spectral replay alone is another 59.6 billion core-hours, plus the finite checking bill.

## What supports the numbers

The combined large-transform arithmetic counts are independently reconstructed. The model also pays for shifted-Hurwitz source generation, separate raw heads and exact assembly, the wider small-conductor transforms, principal RH through height 10^8, completion/sign evaluation, repairs, count completeness, representation transport and libraries. Review found omitted small point-product and scaling categories; the selected v6 model includes them. The newer mean186 assignment receives no uncomputed runtime discount.

The new binary pilot proves all 64 even targets in [3999999997356523524, 3999999997356523650] from actual primality certificates and exact mask semantics. Its complete standalone build took 87.80 seconds wall and 126.03 seconds CPU, including imports and construction. It is a complete correctness example, not a scalable throughput calibration. Its source and prime proofs are cold within the small fixture; their production amortization is still assumed. The older 3.40-millisecond packed-equality benchmark measured only arithmetic and remains labeled accordingly.

The new arithmetic pilot checks complete signed product-and-round bundles with ranges and negative ties. Kernel replay took about 8 to 20 milliseconds for its 21-declaration representation. That observation does not establish a conversion from the separately counted byte-arithmetic workload to Lean time. The scenario conversion explicitly assumes a reference quantity R = P/5000 + A/500, with initial Lean construction/admission costs of 1 / 20 / 200 milliseconds per R. R is a normalization chosen for this Fermi model, not a measured gate count. Those assumptions account for much of the enormous uncertainty.

MM0 uses explicit provisional expansion factors of 100 / 180 / 400 executed proof-and-header instructions per product-template unit, and 80 / 160 / 320 per addition-template unit. Assumed checker rates are 200 / 100 / 25 million such instructions per CPU second. Existing measured MM0 traces use schematic axioms and enlarged resource limits; they do not establish a completed PA arithmetic or analytic implementation. Full ordinary-rule proof layout and resource admission remain unresolved.

Neither model establishes a lower bound on efficient certificate checking. Batching arithmetic, sharing range arguments, changing numeral proofs or choosing a different verified representation can invalidate these estimates. No measured speedup for those changes is credited here. The low scenario already assumes improvement over the current Lean bundle; it is not a demonstrated optimized design.

## Storage and elapsed time

The spectral model assumes the following serialized proof volumes. These are sensitivity calculations, not measured production files or required peak RAM.

| Representation | Low | Central | High |
|---|---:|---:|---:|
| Lean, retained packets | 5.05 exabytes | 107 exabytes | 12.5 zettabytes |
| MM0, assumed stream before extra retry/retention conventions | 1.17 zettabytes | 8.51 zettabytes | 461 zettabytes |

Decimal units are used. Lean assumes 1000 / 10000 / 100000 bytes per reference R; MM0 assumes 1 / 2 / 8 serialized bytes per executed proof-and-header instruction. Neither ratio is calibrated for the proposed complete proof. They expose the consequence of emitting local certificates at the modeled granularity. Streaming reduces retained storage, but does not by itself reduce total checking or transport. Actual library serialization and some finite proof-layout costs remain unestimated; these figures are not complete storage bounds.

The finite MM0 central model separately projects about 262 petabytes for its schematic binary stream before PA completion. Its estimated ladder header-access traffic is not serialized proof size and is not added as if it were a file. Raw source bitmaps, cached numerical centers, serialized proof streams and peak live checker memory are distinct. No production memory cap or distributed schedule has been proved.

CPU work cannot be converted into elapsed time solely by dividing by the purchased core count. Dependency depth, memory, proof-context limits and disk/network bandwidth may dominate. The tables therefore make no elapsed-time promise.

## Proof feasibility remains separate

The spectral pilot is still being completed at positive height. Its finite Abel identity, concrete power enclosures, Gamma/completion enclosure and exact realness must be joined without analytic premises left over. An arithmetic microbenchmark and the proved central-point result do not discharge that requirement.

At full scale, actual signs, refinement success, closed endpoints, multiplicities and Turing-count surplus remain to be demonstrated. Assumed repair fractions are 0.1%, 3% and 100%; the high case is not a termination guarantee. The existing Lean theorem's `Fact PlattGRH` and `Fact BinaryGoldbachInput` hypotheses still need actual proved providers. MM0 additionally lacks a completed analytic formalization of this route. If these mathematical or implementation obligations fail, the model does not supply a finite completion date.

Recommendations (1) and (2) are recorded in `../LEAN_IMPLEMENTATION_DECISION_2026-11-11.md`. This report supplies recommendation (3)'s provisional numerical scenarios with their assumptions. Recommendation (4)'s binary pilot is complete; its positive-height spectral pilot remains open. The active goal remains incomplete.

## Reproducibility and review

- `FINITE_COST_ESTIMATE.md`: F03C9E49433988ECCEF97D6A10CCA073F7BD024F1B92511285CCD7D65CA1BFCE.
- `SPECTRAL_COST_ESTIMATE.md`: 48F721494509A7EDF164210C91DA0FDAD8140E05F85E7EA3C01A6E16EA567D43. The equivalent delivery copy is `SPECTRAL_COST_ESTIMATE_UTF8.md`, 7AA4266067C5C3384498560E81AB83200A0077F9120D7A4BAF9D5C9620380626.
- `MM0_CALIBRATION_AUDIT.md`: 4BFCDFC88F2ABA0D87D1AA705778D32D2482916E429932F96EF3D6D27A0D8792.
- `combine_end_to_end.py` checks those selected model inputs and all 21 spectral source-ledger pins before producing `END_TO_END_ESTIMATE.json`. It sums disjoint finite and spectral phases without any new prime or spectral computation.
- `root_finite_scalar_audit.json` records 162 independent count/partition checks over 18 finite scenarios. The independent finite-accounting review is `../../qrh-campaign/agents/audit/REVIEW_FINITE_COST_AND_BINARY_PILOT_ACCOUNTING_2026-11-11.md`, SHA256 658199430387F768E48ECF5E7B0DDCF90A746208359FB50F337C45D1B447A4CE.
- `REVIEW_SPECTRAL_COST_ESTIMATE.md`, SHA256 C19DED53A60BFAFFEB02439B93943E890513EEB40F04B9D9C5F43B5CE5255693, independently reconciles all selected spectral rows, phase formulas and storage assumptions.

Component review validates the conditional accounting and source correspondence. It does not validate guessed completion factors, prove a scalable certificate implementation, or identify the optimal backend.

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none introduced by these estimates; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: none introduced by these estimates; repository-wide state not audited.
SEALED_THIS_TURN: 0.
