# Rational j7 supervisor result-schema review

2026-11-11. Verdict: PASS for the bounded static result-schema review at the source pin below. The requested schema corrections are present; no further correction is required in this scope. This is not a verdict on the complete process supervisor or on any executed numerical result.

This is a bounded static review of the worker-result schema in `integration/rational_j7_supervision_20261111_common.py`. It does not review the complete Windows process-supervision implementation. It does not execute a fixture, import a worker or supervisor module, recompute a function value, or establish the truth of a worker's arithmetic claims.

## Frozen reference contracts

Paths are relative to `work/qrh-campaign/agents/`.

| Reference | SHA256 |
| --- | --- |
| `integration/rational_j7_supervision_20261111_common.py` | `FA073C190EEEDCF03288A926F8AA6139C76D72C87379DF35AE533429A9A722CC` |
| `integration/rational_direct_g_j7_producer_20261111.py` | `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7` |
| `moebius/rational_direct_g_j7_independent_20261111.py` | `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC` |
| `integration/RATIONAL_J7_NUMERICAL_SUPERVISOR_DESIGN_2026-11-11.md` | `E3FF0DD6DB600A42496767254CFE44322F1E92F5CE564EB97DC95150B6E60150` |
| `integration/small_em_batch_candidate_20261111_01.json` | `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E` |

The relevant common-module functions are `parameters`, `recipe`, `output_summary`, `structured_output`, `worker_telemetry`, `wire_bounds`, and their Q/D/trace shape helpers. Source and receipt hashes used by those functions are also in scope. Original-handle ownership, process creation, lifetime accounting, cleanup, and host completion are separate reviews and prerequisites.

I reread the result-schema section after the final source freeze and verified the full-file hash. No supervisor or worker module was imported or executed, and no synthetic or actual receipt was evaluated in this review. The conclusions below follow from source inspection against the frozen worker constructors and accepted design.

## Corrections found during the draft review

Two original checks would have rejected a genuine successful worker result.

First, the independent worker emits ten negative-control **strings**, whereas the producer emits ten dictionaries with name, rejected, and reason. A shared dictionary-only predicate was wrong for the independent phase. The author split validation by phase and now checks the exact ordered name list in each format.

Second, the producer's copied target budget contains only EM and Taylor. The original old receipt also contains `outer_finite_g_bound`, `full_quotient_error_budget`, `exact_image_rounding`, and `coefficient_padding_added_twice`. Comparing the two entire dictionaries was wrong. The repaired check compares exactly the old budget's EM/Taylor projection.

The initial draft also checked indexed rows only for their labels. It would have accepted a row such as `{'h':0}` without any coefficient center, radius, or gate record. The author added exact row and top-level schemas, fixed radii, gate counts, and mathematical number-format checks. Other requested repairs added scalar/counter/telemetry schemas, expanded dyadic bounds, nonfinite-float rejection, and typed completion-byte counts. These changes enforce the promised structural contract; they do not attempt a second analytic computation.

## Producer result contract

The parameters and recipe agree with the frozen worker: N=1024, B=1025, M=16, K=16, j=7, center 629/1250+i*31985/16, outer radius 1, and panel radius 1/16. The recipe retains the raw log-two cache, 512 logarithm terms, 256 arctangent terms, 513 exponential terms, four real squarings, grids 1041/1025/513, ties toward positive infinity, ascending head order, and factorial-normalized complex-s coefficients.

There must be exactly 1025 ordered log records and 1025 ordered phase records, labeled 1 through 1025, plus sixteen records in each of head, correction, and g, labeled 0 through 15. The exact record keys require every consumed center, radius, reduction field, and gate trace. The common-module radius checks match the worker's actual output formats:

* log radius 2^-1024 and phase radius 2^-499, except exact zero radii at n=1;
* head radius 2^-442, correction radius 2^-434, and g radius 2^-420;
* 1028 shared coordinate gates, 514 log gates and 1542 phase gates for every n>1, zero leaf gates for n=1, and two coordinate gates per final complex coefficient.

The total gate count is exactly `1028+1024*(514+1542)+96`. The 33 Bernoulli entries are present and use canonical rational encodings. The supervisor does not claim to prove their recurrence merely by checking those encodings. All thirteen named scalar-check flags must be literal true; their associated rational fields have the prescribed format and their dyadic allocation constants are exact. This validates a complete claimed scalar receipt, not the scalar inequalities themselves.

The copied target must have exactly its hash, g_jets, panel, endpoints, and analytical_budget fields. It matches the old j7 objects and EM/Taylor projection. The producer's three image objects match the unchanged old panel and endpoints. Only these extracted target objects enter the new result; unrelated diagnostic floats elsewhere in the old receipt are not subjected to this result's mathematical wire checks. The old coefficient dyadics are checked in the same canonical sense as the frozen producer's decoder.

The completion file has its own exact key set, an integer byte count equal to the measured candidate file size, the candidate hash, typed producer telemetry, and both external-seal and independent-acceptance flags set to literal true. Agreement with the bounded stdout completion line and the original worker process is a separate supervision obligation.

## Independent result contract

The independent result binds the exact producer source, producer receipt, independent source, mathematical specification, and old target. Its counts claim 1025 producer logs/phases, 1025 independent logs/phases, sixteen independent coefficients, and three image checks.

It actually emits 1025 independent leaf records and sixteen independent g records; their exact keys and ordered labels are checked. The independent pi and log radii are 2^-1056, phase radii are 2^-531, and final coefficient radii are 2^-450. The exact n=1 leaf radii remain zero. Recorded center distances have canonical rational encodings and nonnegative numerators.

The independent worker does **not** emit a second array of the three image rectangles. It emits the count after comparing them with the fixed target. The supervisor correctly binds that count and target/source identity instead of inventing an absent image-array requirement. Whether those three comparisons and the independent coefficient containments truly pass is the responsibility of the executed pinned worker and its arithmetic review, not the schema checker.

The exact independent control names are changed_center, changed_index, wrong_endpoint_owner, omitted_n1024, signed_bernoulli, omitted_B_pole_term, shifted_elementary_center, invalid_rounding_witness, omitted_Taylor_tail, and changed_immutable_endpoint. The producer's corresponding names and dictionary format are checked separately.

## Numeric encodings and claim boundary

Canonical rational encodings require exactly numerator and denominator strings, a positive denominator, and gcd one. Canonical dyadics require exactly mantissa and exponent, an integer exponent, an odd nonzero mantissa or the unique zero representation, and both integer/exponent size bounds and the expanded positive-shift numerator bound. No large shift is needed to verify that bound. Extra or incomplete mathematical number fields are rejected rather than interpreted as generic dictionaries.

Labels, counts, exponents, and byte lengths use integer-type checks that exclude booleans and floats. Mathematical arrays have exact lengths and record key sets. Finite floats are confined to the named telemetry schema. Nonfinite values, including overflowed numeric literals that a JSON parser can convert to infinity, and unsupported values such as null are rejected. Duplicate JSON keys, excessive depth, oversized arrays, and malformed decimal strings are rejected too.

The intended conclusion is deliberately limited: a result from the exact supervised worker has the complete claimed format, unchanged target, and required provenance. A well-shaped forged result would not become a proof because of these tests. Arithmetic acceptance still requires the actual independent worker's successful pinned execution; final phase acceptance also requires the separate original-handle and post-exit supervision chain. No runtime authorization, spectral conclusion, or Lean theorem follows from this source review alone.
