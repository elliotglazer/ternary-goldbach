# Rational direct-g j7: independent structural review

2026-11-11. **PASS for the source-level structural scope below.** No remaining blocking coverage, parsing, independence, or control-flow defect was found in these frozen revisions. This is not an executed acceptance result or runtime authorization. Neither evaluator was imported, compiled, or executed in this review. No elementary values, coefficients, images, negative-control outcomes, or Lean proofs were generated.

## Exact versions

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| `integration/rational_direct_g_j7_producer_20261111.py` | `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7` |
| `integration/RATIONAL_DIRECT_G_J7_PREPARATION_2026-11-11.md` | `8DBFB1D85065A8341D3EB34C65D1103CA83C10F9FD38C3333D4033AFE17537DF` |
| `moebius/rational_direct_g_j7_independent_20261111.py` | `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC` |
| `moebius/RATIONAL_DIRECT_G_J7_INDEPENDENT_PREPARATION_2026-11-11.md` | `9DFC579D2985F2E7B156CF2E94E4D7888905B32BDEC37893969087E9294D5871` |
| `major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md` | `8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2` |
| `zero-sum/REVIEW_RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md` | `0ED13860F941BE3786D9EE780F71590581D2C658BF30B84A8CE79AF383ABE4ED` |
| `major-constants/REVIEW_RATIONAL_DIRECT_G_J7_ARITHMETIC_CODE_2026-11-11.md` | `CA2693F85775FEB9244F74AEE698000FFA57EF844EB613C982DCC8D436859AAD` |

The immutable old target remains `integration/small_em_batch_candidate_20261111_01.json`, SHA256 `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E`. The final source and preparation hashes were checked locally. Earlier moving revisions are not covered by this verdict.

## Required evidence is retained

Both programs fix N=1024, B=1025, M=16, K=16, j=7, and center `629/1250+i*31985/16`. They retain all 1025 labeled logarithms and phases, including the exact n=1 branches and the distinct B phase. The head uses n=1 through 1024; the correction includes all sixteen signed Bernoulli terms and the exact +B term in the pole-removal polynomial. There is no dropped last summand or replacement of the direct formula by the earlier batching approximation.

All sixteen normalized complex-s coefficients are retained. The independent checker verifies complete ordered leaf labels, every head/correction/g row, fixed radii, and literal target metadata. It reconstructs every prescribed producer rounding event and digest, including the common log-two/pi calculation. Its expected coordinate-gate count is the source expression `1028+1024*(514+1542)+96=2106468`. The observed-bit counter is explicitly only a rounding-operand observation, not a measured bound on all arithmetic allocations.

The final coefficient tests require full containment in the immutable old squares. Independent fresh balls must also fit the producer balls; overlap is not substituted for containment. All three actual-zeta images are reconstructed: the whole panel `[1999,15993/8]` and endpoints 7 and 8, both owned by model 7. Rectangular Horner uses the old coefficient squares, adds the prescribed EM and Taylor pads once, and retains the prescribed reciprocal-first operation order for the entire s-1 rectangle. The code requires exact equality with the three old image records. Fresh narrower coefficient centers cannot silently replace those image inputs.

## Independent computation versus deterministic replay

The independent module never imports or calls the producer. It has two separate purposes, clearly distinguished in its preparation note and code:

1. Reconstruct the fixed producer Horner/squaring schedule, verify each signed rounding witness, and compare exact centers, counts, and digests. Digest equality is additional evidence after recomputation, not a substitute for arithmetic.
2. Recompute fresh elementary leaves with forward term-and-sum recurrences and finer grids, use separate truncated polynomial multiplication for the correction, and reverse the head summation order. These fresh values undergo the full required containment checks.

The independent module intentionally shares its own rational helpers and finite-g builder between its replay and fresh passes. This is not two independent implementations of every helper. It nevertheless supplies the distinct elementary algorithm required by the specification, independently written from the producer and without importing it. Neither program imports a numerical transcendental library or uses a built-in zeta, L-function, Gamma, real logarithm, exponential, or trigonometric evaluation. Standard-library math usage is integer combinatorics/gcd and metadata finiteness checks; numerical elementary evaluation is the explicit rational series.

## Parsing, integer limits, and mutations

The frozen versions reject duplicate JSON keys, nonfinite JSON numbers, malformed canonical rational/dyadic data, nonpositive denominators, incorrect labels, and altered target metadata. Recursive equality distinguishes booleans and floats from integer metadata. New dyadic values use odd nonzero mantissas and canonical zero; compatibility decoding of the old target is protected by its immutable byte hash. Input reads and hashes are bounded, and dyadic shifts check the prospective numerator size before allocation.

The producer now checks raw rational cross-products and sums before Fraction normalization. Its product helper first applies an operand-bit lower bound and then checks the exact product. The independent arithmetic also checks raw numerator/denominator products and sums. These are fail-closed work limits, not a claim that all later arithmetic fits. Ordinary Python internal arithmetic, comparisons, allocation, and serialization are not a formally verified bounded-machine implementation; complete-process memory limits still require the external supervisor. The fixed mathematical constants and source-generated loop bounds are not attacker-selected unbounded evaluation parameters.

The ten producer controls and ten independent controls reach the relevant rejection paths: changed model/center/owner; missing n=1024; wrong Bernoulli sign; omitted +B; shifted elementary center; invalid signed rounding; omitted Taylor pad; and changed immutable endpoint data. In particular, the repaired producer `verify_full_q` is invoked on the positive full-Q construction and on the omitted-B mutation. The independent omitted-B control reconstructs the full correction without B and compares it to the required coefficient. The image controls reach actual reconstruction or immutable-target comparison. These are not flags that merely report the intended rejection.

The independent reader validates ten distinct, typed producer control records but does not regenerate their reason strings or require the literal producer control names. Its own ten semantic controls are run separately by the prescribed execution path. Thus the producer control records alone are not treated as independent evidence. Static review establishes these call paths only; it does not establish that any future attempt reaches or passes them.

Preliminary review identified the raw-intermediate checks, omitted-B validator, bounded reads/shifts, type-sensitive equality, and incomplete producer-control record validation as issues. The final revisions repair these issues; their former versions must not be substituted for the hashes above.

## Resource and acceptance boundary

There is no evaluator subprocess, retry, precision adjustment, or automatic resumed attempt in either source. Both require a hash-bound authorization manifest, fixed target and caps, owned output names, and an exclusive attempt marker. The prescribed limits remain one 600-second producer and one 900-second independent attempt, each with a 512 MiB complete-process limit and 16 MiB aggregate output/log/partial limit.

Worker checks are not a complete resource seal. Their clocks begin after process launch; independent JSON serialization occurs after its prepublication check; in-process telemetry cannot attest post-exit peak or physical enforcement. Windows job membership does not prove the job's configured limits. A separately reviewed supervisor must enforce the launch-to-exit deadline, child prohibition, aggregate bytes including logs/partials, and valid final OS lifetime telemetry. Missing or invalid final evidence cannot be repaired by `CANDIDATE` or `ARITHMETIC_CANDIDATE` status. No runtime estimate or assurance of finishing within the caps follows from this review.

The separately pinned arithmetic review checks the series, error allocation, normalization, and interval formulas. This structural verdict does not replace that mathematical review, the future complete independent run, the external resource seal, or a later Lean implementation and kernel check. It covers only j7, not the other seven centers, original FFT/batching intermediates, a nonvanishing claim, or removal of PlattGRH from the final theorem.
