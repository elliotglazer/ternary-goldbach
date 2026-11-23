# Rational direct-g j7: independent checker preparation

2026-11-11. Preparation only. The code has been parsed and compiled **as text**, but has not been imported or executed. No logarithm, exponential, coefficient, image, gate sequence or numerical negative control has been evaluated. Static review and separate supervised-run authorization remain mandatory.

## Frozen inputs and prepared code

Paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| `moebius/rational_direct_g_j7_independent_20261111.py` | `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC` |
| `major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md` | `8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2` |
| `zero-sum/REVIEW_RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md` | `0ED13860F941BE3786D9EE780F71590581D2C658BF30B84A8CE79AF383ABE4ED` |
| `integration/rational_direct_g_j7_producer_20261111.py` | `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7` |
| `integration/RATIONAL_DIRECT_G_J7_PREPARATION_2026-11-11.md` | `8DBFB1D85065A8341D3EB34C65D1103CA83C10F9FD38C3333D4033AFE17537DF` |
| `moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md` | `EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B` |
| `prime-estimates/REVIEW_SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md` | `F0D115608E1742220E4CAB26EA8DA930D24F2D1D410ED34609EA7B7DC4DABDA5` |
| Immutable old target `integration/small_em_batch_candidate_20261111_01.json` | `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E` |

The code also pins all twelve source/design inputs in the producer's `PINS` map, including the accepted elementary, inner-rounding and EM allocations. The producer source hash is supplied by the future reviewed run manifest, so the two source files do not have circular embedded hashes. A source hash never substitutes for checking its arithmetic.

## What is independently reconstructed

The input is precisely the old j7 model at `629/1250+i*31985/16`, its sixteen normalized complex-s coefficients, the whole vertical panel `[1999,15993/8]`, and its two endpoints. No other center, transform, spectral margin or zero-free conclusion is claimed.

There are two computations in the prepared independent job:

1. **Producer template replay.** Separate local implementations rebuild the raw log2 cache, the Machin calculation, all 1025 log and phase records, and the head, full correction and final sixteen coefficients. Every real-coordinate rounding checks the two exact signed comparisons and the Euclidean remainder. It then reconstructs the prescribed five-integer newline digest, not merely the final center. All intermediate Horner/squaring/outer gates are covered. The expected total is `1028+1024*(514+1542)+96=2106468` coordinate gates, with exact n1 branches taking none. The counter and observed rounding-integer bit maximum are compared with the producer receipt.
2. **Fresh forward computation.** It uses `deltaI=2^-1080`, inner grid `2^-1081`, `etaI=2^-1056`, canonical grid `2^-1057`, and outer grid `2^-545`. Log/atan powers, terms and sums have the separately budgeted gates. Exponential terms and accumulators advance forward; real exponentials then undergo four rounded squarings. Log2 is retained on the inner grid until final log assembly. All 1025 leaves are recomputed from exact inputs. This is additional to, not a replacement for, template replay.

No producer module is imported or called. Only Python standard-library integer/rational arithmetic, parsing, hashing and OS telemetry are used. The source was read for wire compatibility and exact gate ordering. The elementary implementations were written separately. Within the independent module, the exact rational helpers and the finite-g builder are deliberately shared between its replay and fresh-input passes; this does not create two independent implementations of those helpers. They are independent of the producer's helpers. This sharing is explicit for review.

## Finite-g and image source map

The mathematical source is the frozen specification and its reviewed elementary/EM/Cauchy inputs. The following maps those claims to the prepared functions; it does not assert a Lean proof of the Python code.

| Prepared function | Mathematical responsibility |
| --- | --- |
| `signed_witness`, `nearest`, `Gates.real` | Check `(2m-1)q <= 2p*2^g < (2m+1)q`, including negative ties; check remainder; hash the exact reduced input and integer result. |
| `replay_log_inner`, `replay_pi`, `replay_exp_poly`, `phase` | Reconstruct the fixed producer Horner schedules and phase input/reduction. Real exp gates are real-coordinate gates, while cis gates include both coordinates even if one is zero. |
| `forward_log_inner`, `forward_pi`, `forward_exp_poly`, forward branch of `phase` | The specification's independent term-and-sum algorithms. Initial log/atan power is rounded; no unused final power update is performed. |
| `validate_scalar_budgets` | Check both schedules' exact rational analytic-tail and propagated-gate budgets, plus phase-input, direct-head, correction and final-g bounds. Reconstruct the producer's scalar receipt rather than trusting its flags. |
| `bernoulli` | Generate B0 through B32 by the rational triangular recurrence, including B1=-1/2; compare every signed producer entry. |
| `poly_product`, `full_correction` | Form each rising polynomial by a generic truncated polynomial product, rather than the producer's direct old-array affine loop. Retain the half term, all sixteen Bernoulli corrections, the factor B^(1-2m), and the separate exact +B pole-removal term. |
| `direct_g` | Sum the head in descending n for the independent pass; retain all h=0,...,15 normalized log powers. Build and convolve the B exponential coefficients, round completed head/correction once each, assemble `(c-1)D_h+D_(h-1)+correction_h`, then round once. D_-1 is zero. |
| `independent_values`, `check_disk`, `check_inside` | Full independent log/phase/G-ball containment and a separate full containment in each immutable old coordinate square. Store own leaf centers/radii and exact containment distances. |
| `image` | Exact rational rectangular Horner on the **old** coefficient squares. Add E_EM and E_Taylor once, form the whole reciprocal rectangle using unary squares and a positive norm-square lower endpoint, then multiply. Reassociating interval division is not permitted: the reciprocal-first order matches the old target. |
| `read_target`, `check_header`, `execute` | Bind the literal grid, indices, ownership, exact target bytes, wire recipe, all three image equalities, and every required array. |

The independent coefficient norm radius is `2^-450`; the producer fresh coefficient radius is `2^-420`. The own phase radius is `2^-531`, against the producer's `2^-499`; these include log-input perturbation. The final actual-zeta image pads remain exactly

```
E_EM = (4*2003*33)/(63/2) * (2034/(6*1025))^32,
E_Taylor = 2^-33/15.
```

There is no added batching tail, extra coefficient padding, replacement narrow model, or additional `2^-64` image pad. Exact reconstruction must equal all three literal target rectangles.

## Receipt and negative controls

The input wire is `rational-direct-g-j7-v1`. Integer strings, rationals and dyadics are validated canonically; denominators are positive, dyadic nonzero mantissas odd, and zero is `(0,0)`. JSON duplicate keys and nonfinite numbers are rejected. Nested exact-metadata equality is type-sensitive, so booleans cannot stand for integer indices. Files are size-checked before bounded reads, and shifts are checked before allocating an oversized dyadic numerator.

The future output is `rational-direct-g-j7-independent-v1`. Success at the arithmetic-worker level is only `ARITHMETIC_CANDIDATE`. It records the code/target/producer pins, all independent leaf centers/radii and distances, the sixteen independent G balls, complete-count summaries and ten own negative controls. It is not a self-issued lifetime resource seal.

The own negative controls alter a center, model index, endpoint owner, required n=1024 row, Bernoulli sign, the +B correction term, an elementary center, a rounding witness, the Taylor image pad, and an immutable endpoint. They invoke the same geometry, signed arithmetic, leaf-label, Bernoulli, full-correction and image comparison predicates as the positive path. The omitted-B control recomputes the complete correction without B and compares its first rounded coefficient with the required producer coefficient. The omitted-tail control recomputes the image without the Taylor pad and requires rejection. No negative control has yet been run, so the preparation makes no claim that its expected rejection actually occurred.

## Attempt and resource boundary

There is no generated run manifest. A future manifest must bind this exact checker, the separately frozen producer source and receipt, the twelve source pins, this preparation note, a completed static review, the fixed target/caps, and the external supervisor protocol. The output filename is restricted to this agent's directory. An exclusive `.attempt.json` marker prevents reuse of the same attempt path. The checker never imports the producer and never starts a subprocess.

The fixed limits are 900 seconds from process launch, a 512 MiB complete-process-tree peak, and 16 MiB aggregate retained outputs/logs/partials. The worker checks its OS peak and cooperative elapsed time, requires Windows job membership, reserves output space and returns incomplete on a handled failure. Partial own leaf evidence and progress counts can be retained. It cannot attest post-exit peak, physical prevention of transient overshoot, supervisor configuration, or time before its own initialization. A separately reviewed external supervisor must enforce the launch-to-exit deadline, prohibit child workers, retain the process handle, check final lifetime peak and aggregate output size, and issue the final seal. No seal or invalid telemetry means no accepted run. Job membership alone is not proof of the configured policy.

The 65536-bit bound is checked on exact rational arithmetic and raw cross-products in this implementation. It is a fail-closed work bound, not an expectation that all expressions fit. The accepted sub-2100-bit elementary denominator result is not misreported as a limit on rounding operands or later coefficients. There is no automatic retry, precision change, resumed second attempt or fallback to floating arithmetic.

## Validation performed and remaining gate

The final source was passed to `ast.parse` and built-in `compile(text, filename, 'exec')`, without executing the resulting code object. This succeeded. An initial attempt to invoke the system `python` launcher could not start; syntax-only checking then used the existing interval environment's Python executable, importing only `ast` and `pathlib` for that check. The evaluator was never imported. No runtime manifest, function values, coefficient arrays or numerical receipts were produced.

Full static source review, the external supervisor/run-manifest preparation, and separate execution authorization remain. Even a later successful external arithmetic attempt would establish only the direct-g j7 slice, conditional on the reviewed analytic source arguments and sound implementation. The Lean checker, source bridges, kernel acceptance, other seven centers and the original PlattGRH replacement objective remain outside this preparation result.
