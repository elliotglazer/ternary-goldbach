# Completed small finite-EM batch: independent saved-data audit

**Verdict: PASS at completed external interval experiment and exact saved-data verification scope.** The two frozen programs completed their separately authorized attempts with exit 0. All mandatory saved output containments and image equalities pass my independently written `Fraction` audit. There is no remaining receipt/provenance blocker to recording this bounded experiment. This is not a Lean proof, a full internal diagnostic-trace verification, or new principal/family spectral coverage.

No evaluator module was imported or executed during this review. I made no transcendental calls, FFTs, fresh finite-EM evaluations, tuning, scans, or Lean/Lake runs. My script uses only standard-library JSON, hashing, integer arithmetic and exact rational arithmetic. It independently reconstructs the saved comparisons; genuine interval enclosure of the underlying transcendental expressions is supplied by the already completed, statically reviewed external evaluator, not established anew by reading its boxes.

## Frozen inputs and process provenance

Paths below are relative to `work/qrh-campaign/agents/` in the shared workspace.

| Artifact | SHA256 |
|---|---|
| `integration/small_em_batch_candidate_20261111.py` | `23D358590279AA810EAE764D3FEEA0756C51DF8CF0EA6F05B457A192BB82822C` |
| `independent-feasibility/review_small_em_batch_prepared_20261111.py` | `A6F6A8C78B4DC70F657564D19398ADF2E9F8922B005969B7ABAAA62BFBBC5A9A` |
| `audit/REVIEW_SMALL_EM_BATCH_CODE_PREFLIGHT_2026-11-11.md` | `5715D5D18D82119507B903AF7B2F6355AAAFCADD3DB5B1635A7F9A782511D4D1` |
| `integration/small_em_batch_candidate_20261111_01.json` | `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E` |
| `independent-feasibility/small_em_batch_independent_replay_20261111_01.json` | `2D0CF58A1825978455B029ABE3A73382745955D7EE1A74106A8FF98116A3EE80` |
| `integration/coordinator_small_em_batch_run_20261111_01.json` | `F342EF291A936C73689278F48BC62F785D547090FB413F7448D5C41ECE12BD6B` |
| `integration/small_em_batch_candidate_20261111_01.attempt.json` | `6FA545B8F56ECB04CF2F6DBDD7944CA4783FC434CD349A5318E078893F0B34C0` |
| `integration/coordinator_small_em_batch_completion_20261111_01.json` | `C520A5C48EED177A3FB0683F41719F95DCF71E76D924DD2F330D7C497481D160` |
| `independent-feasibility/coordinator_small_em_batch_review_20261111_01.json` | `897D801DC6D6CC020D7185FC635A8974B56920257F8D090636B8BFA866840446` |
| `independent-feasibility/coordinator_small_em_batch_completion_20261111_01.json` | `1588AA24AC7C6FAC6D2A797E97579D01749AE0057488120F40262670CFA7C6ED` |

I rehashed these artifacts and every source/contract pin in both receipts. The producer has the exact ten source pins, the independent program sixteen; the review receipt embeds the exact independent authorization manifest. The candidate binds its authorization manifest hash and static review. The exclusive producer attempt marker binds the same fixed parameters, code and resource caps. The independent authorization binds both the actual candidate hash and the exact frozen verifier code.

The coordinator's producer record reports tool chunk `2e5655`, exit 0, tool wall time 5.333071 seconds and final PASS. The independent record reports chunk `67d337`, exit 0, tool wall time 3.4862331 seconds and final `PASS_INDEPENDENT_SMALL_EM_BATCH`. Its final console explicitly binds receipt, candidate and independent-code hashes. The producer console itself has no receipt hash; its coordinator record supplies the hash and physical file size, which match the file and independent authorization. Thus the required completion-plus-receipt evidence is present; acceptance is not based on a PASS-looking file alone. These are saved coordinator observations, not a new OS observation made by my checker.

## Exact target and all mandatory outputs

The receipts retain N=1024, B=1025, M=16, K=16, p=24, J=8, L=32; producer precision 192 bits and independent precision 224 bits. The actual complex centers are

`s_j = 629/1250 + i(31999/16 - j/8)`, for `0 <= j < 8`.

All coefficients are normalized complex-s derivatives of finite g, orders 0 through 15. Eight closed downward panels have endpoints `2000-j/8` and `2000-(j+1)/8`; together they cover exactly `[1999,2000]` at real part `.5032`. Their radius is `1/16`. Nine endpoints use owner `min(l,7)`. This is a single bounded left-edge pilot, not the whole high strip or a closed contour.

The independent saved-data script checked the following, without trusting the summaries:

| Obligation | Exact checks |
|---|---:|
| All signed bin labels, rational witnesses, and independently saved x/residual box containments | 1,024 |
| Complete ordered moment disks, including both producer-computed and independent full boxes | 12,288 |
| Complete ordered consumed normalized transforms, with index `(-j) mod 32`, including both full boxes | 3,072 |
| Independent direct-g coefficient boxes inside the producer fixed coordinate squares | 128 complex coefficients / 256 coordinate inclusions |
| Rational reconstruction and exact equality of complete panel images | 8 |
| Rational reconstruction and exact equality of endpoint images | 9 |
| Exact contraction sums, uncertainty allocation and residual-tail ledger | 128 |

For every moment and transform, I recomputed the full rectangle-to-center L1 bound, compared it with the claimed Euclidean radius, and checked equality with the stored independent distance. Every nonzero allocation is exactly `2^-110`; zero-radius records have exact zero centers. These comparisons concern the entire saved box, not overlapping balls or center agreement.

For bins, full signed q is retained in the residual, q lies in `[-5,0]`, k is q modulo 32, the rational x-witness width is at most 1/4, and midpoint rounding gives the recorded q. Every independent residual box lies inside its claimed producer box and strictly within absolute value `55/56`.

For all 128 g coefficients, each producer coordinate halfwidth is exactly `2^-52`, and the independent entire rectangle is contained in it. The frozen independent algorithm builds these coefficients directly, separately from binning and transforms, including a separately formed `exp((1-s)log B)` term. The saved comparisons therefore exercise the complete correction and finite-g assembly, not just the main Dirichlet sum.

For all 17 images, my own rational interval implementation evaluates Horner on the relevant imaginary offset interval, adds the exact EM plus Taylor allowances once in each coordinate, and multiplies by the full rectangular reciprocal of `s-1`. It exactly reproduces both saved image records. The denominator lower bound exceeds `2^20`; no endpoint-only denominator replacement is used. The finite-g outer bound remains `2^27`; Taylor allowance is `2^-33/15`. The saved EM allowance equals

`4*2003*33/(63/2) * (2034/(6*1025))^32 < 2^-38`.

The saved full quotient-error ledger is exactly `1540133/92233720368547758080 < 2^-44`. This is the reviewed approximation-error allowance, not a claim that an entire panel image has width `2^-44`. Coefficient uncertainty is already in the squares and is not charged twice. There is no extra arbitrary image-rounding pad.

## Diagnostics are a narrower claim

The mandatory outputs above are completely covered. The same does not mean every internal elementary, twiddle, R/Q/C, phase-product and assembly diagnostic ball has been independently recomputed. The frozen verifier checks their schema and specified arithmetic budgets; it independently computes the consumed moments, transform outputs and full direct-g coefficients instead of trusting those diagnostic balls as analytic oracles.

I additionally reconstructed all 128 exact rational contractions from stored transform centers, their full contraction-ball containment, the separate source-radius and transform-radius sums, and the residual Taylor term `64*7^h/(h!*24!)`. The stored total equals their sum, and the arithmetic-only component is below `2^-98`. This does not extend the scope to an independent transcendental proof of every diagnostic value. The prior static review's limitation remains in force.

Both numerical programs use python-flint 0.9.0. Their accumulation/transform/finite-g algorithms and precision differ, but they share the FLINT interval library; this is not an independent implementation of all elementary interval primitives.

## Actual caps and completion

| Quantity | Producer | Independent |
|---|---:|---:|
| Final console elapsed seconds | 4.896401400001196 | 3.052405499998713 |
| Final console peak working set bytes | 85,843,968 | 192,008,192 |
| Actual receipt file bytes | 8,058,388 | 6,155,890 |
| Authorized time cap seconds | 180 | 360 |
| Authorized peak working set cap bytes | 536,870,912 | 536,870,912 |
| Authorized receipt size cap bytes | 67,108,864 | 67,108,864 |

The saved telemetry snapshots occur after payload serialization and before publication. The final console measurements are later and no smaller. Physical file sizes match the completion records. The producer records zero children; the statically reviewed programs contain no child-worker path. The caps are cooperative checks with Windows peak-working-set telemetry, not hard OS containment. This run does not test over-limit cleanup or prove behavior under an abrupt kill. All reported measurements stayed inside the limits and both processes completed normally.

These single-run figures include different work: the independent checker also performs candidate parsing and exact checks. They do not establish FFT asymptotic speedup, production throughput, or a full-family cost forecast.

## Reproduction and accepted consequence

My saved-data checker ran once, exit 0, using no author imports. It does not use the root's separate saved-comparison receipt. Its artifacts are:

- `audit/check_small_em_batch_completed_20261111.py`, SHA256 `9E7093F533DA3BD8748E3802AF2AD883627C7B33209132C3F77DC7E25C27959B`.
- `audit/check_small_em_batch_completed_20261111.json`, SHA256 `04E4CEABC5887D4ED6FD6FA71E6ED76D6A629F3B18EC3B0CF1205181190AF025`.

Together with the pinned source/analytic preflight and the successfully completed independent interval evaluator, the receipts support this exact bounded finite-EM batching pilot and its complete consumed output enclosures. This audit itself establishes serialization, provenance, exact saved-box containment and rational image consistency. No new winding computation or nonvanishing acceptance criterion was part of this task, and no broad spectral conclusion follows from these receipts.

Lean implementation and standard-axioms validation remain open. The intended unconditional `TernaryGoldbachFrom (10^27)` and full Statement with only the original `BinaryGoldbachInput` are unchanged; neither the receipts nor any numerical success are new permanent final premises.
