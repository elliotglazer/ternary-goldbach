# Review of the compact dyadic receipt pilot

2026-11-11. **The partial diagnostic is independently confirmed. The existing receipt does not pass complete interval-operation replay.** No correction is required to the author's final report. Its 14 failed translation enclosures and three failed root-component quotient enclosures must remain explicit. The passing serialization and arithmetic checks do not prove analytic enclosures or a zero-free region.

No Lean build, spectral scan, production FFT, or new analytic-function evaluation was performed. Frozen inputs were not changed.

## Frozen packet

All relative paths below start at `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| `integration/COMPACT_DYADIC_RECEIPT_PILOT_2026-11-11.md` | `0FFCADCFF083F743EA7BE224D2A09431CF1B304EFBB428DAC4980AD73CB94C19` |
| `integration/compact_dyadic_receipt_pilot_20261111.py` | `6FC3E2976B53B49D1A4FDFBDEA6A2D1E327CAA8BFCA24CCE0B1A77CE90B39840` |
| `integration/compact_dyadic_receipt_pilot_20261111.json` | `7DF5B2AF02EB4D5E624286F62CDA4AF4D43D0F232A32F1663D246878C698773E` |
| Actual four-point input, `prime-estimates/principal_theta_modular_pilot_20261111.json` | `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF` |
| Independent script, `major-constants/review_compact_receipt_20261111.py` | `06A3AE13768F29045BEF39DD7A96B51B69AC136F0422C0C395FE7FD15B6DD726` |
| Independent receipt, `major-constants/review_compact_receipt_20261111.json` | `CD891A210D53123F110179A6A0E76D7470F941A7C4A022A65E492A7D5A8B3629` |

The mathematical arithmetic plan was previously reviewed in `major-constants/REVIEW_COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md`, SHA `2BD81A05B6C84A27149C1BEE5827B4918DD4F7F454AB799B1DEA8E954398F9DC`. That source/API review is not a Lean implementation certificate.

## Independent method

I inspected the final Python source, the frozen input, the resulting diagnostic, and the author note. I also reran the author module through `run()` without invoking its receipt-writing main block. Every saved field except the explicitly variable process time and the main-block-added script hash matched. The frozen receipt hash was unchanged before and after this replay. Exit zero means the diagnostic completed; its returned status remains `PARTIAL: listed sufficient checks failed`.

The separate implementation uses a different exact arithmetic strategy. For each signed dyadic term `m*2^e`, it enumerates the bits of the finite mantissa and records their positions `e+j`. Positive and negative contributions are accumulated in separate sets, carrying a collision from position `k` to `k+1`. Comparison uses the largest position in the symmetric difference of the two sets. This is exact because the highest differing binary digit dominates the finite sum of all lower digits. Each carry removes an occupied bit, so the work depends on the bits supplied, not on traversing empty exponent gaps. It does not use the author's top-exponent merging algorithm.

Display rounding is independently reconstructed by partitioning these bit positions at grid exponent `-128`. Only the bounded retained positions are shifted into an integer coefficient; any discarded nonzero bit sets the appropriate signed sticky correction. Actual product terms are formed by integer mantissa products and exponent sums. No huge endpoint is converted to Fraction or to an expanded denominator.

The separate receipt includes the complete list of failed translation locations, the three failed quotient corners, and the exact first-edge input/output dyadics. Its `diagnostic_completed` field does not claim successful operation replay.

## Verified serialization and domain facts

The four points have heights `1000000` and `60343058`, each at real node `0` and `1/8`. Counts are occurrences, not distinct stored values. There are 4,058 raw endpoints, 2,029 real intervals and 984 complex boxes. Raw mantissas have at most 256 bits. Exponents range from `-54699295540` to zero, with at most 36 bits in their signed magnitude representation.

All 2,029 intervals pass each of the following independent checks:

- The raw lower endpoint is no larger than the raw upper endpoint.
- The displayed interval contains the raw interval.
- The displayed endpoints are exactly the outward rounding of the raw endpoints to the `2^-128` grid.

This is containment, not merely overlap. Tiny nonzero values are not silently replaced by exact zero.

The independent sparse-bit checks also confirm all 32 shared-box equalities, counting 28 adjacent step links and four final links; all 56 individual input/output upper-half-plane checks; the 16 translation range and stopping-domain checks; the 12 inversion growth inequalities; and all 12 root-argument rotation enclosures, positive-domain checks and root component assembly equalities. The author's four node-real checks, four supplied-pi consequences, four initial imaginary lower bounds, 32 algebraic phase-coordinate checks and inversion-count checks also reproduced in the read-only replay and have the claimed formulas on inspection.

The node relation is conditional on the supplied pi interval. For `d=T+1`, its imaginary part is `pi/4 - 1/d`; multiplying the lower/upper interval consequences by positive `d` gives precisely the two checked three-term inequalities. Nothing in these tests proves the supplied pi interval. Likewise the eighth-root coordinate square/sign tests are arithmetic consequences of the intended phase formula, not an independent proof of that formula.

## Exact translation failures

For a step subtracting integer `n`, a compositional interval proof needs

```
output.lower <= input.lower - n,
input.upper - n <= output.upper.
```

The two steps with `n=0` pass. All 14 steps with nonzero `n` fail on both sides. This is an exact failure of the displayed input-to-output interval implication, not numerical uncertainty in the checker.

For the first step, at height `1000000`, real node zero, `n=-1`, the frozen dyadics are:

| Endpoint | Mantissa | Exponent |
| --- | --- | ---: |
| Input lower | `-57896044618542305854132046004956919652080144651701577215397953469767229054481` | -255 |
| Input upper | `-57896044618542305854132046004956919652080144651701577215397953469767229054479` | -255 |
| Output lower | `31082640110290001034562265977759734291642114279939416787485936545745600507` | -283 |
| Output upper | `31082640110290001034562265977759734291642114279939416787485936546015084549` | -283 |

Exact subtraction gives

```
output.lower - input.lower + n =  133693435 * 2^-283,
output.upper - input.upper + n = -133693435 * 2^-283.
```

Thus each boundary is inward by `133693435*2^-283`. This identity was checked with the sparse-bit method and, separately, with Fraction using only these modest exponents. It agrees with the parent's independent check.

The original producer's `binary` function exports `x.lower()` and `x.upper()`, while the subsequent operation uses the original Arb ball. This difference in representations is compatible with the observed mismatch. This review does not establish the internal midpoint/radius cause; that is a separate bounded investigation. It also does not infer that the original true point value lies outside the output. The conclusion is specifically that these exported intervals do not compose through the asserted translation operation.

## Root and reciprocal checks

All 12 norm-square witnesses and all 12 `2u^2 = norm + Re(z)` interval witnesses pass in the independent arithmetic implementation. Here each left/right test uses exact products and finite sums. All required positive-domain checks pass.

The raw root argument represents `z=-i*tau`. Exact equality of separately exported endpoints is unnecessarily strong and fails in two cases. Correct containment of the rotated input in the exported argument passes in all 12. The final author script uses this enclosure condition, without widening the frozen data.

The formula `v=Im(z)/(2u)` has positive denominator. Its extrema over the independent input rectangle occur among the four endpoint pairs. Nine of 12 full-rectangle enclosures pass. The exact failed corners are:

| Zero-based location | Numerator endpoint | `u` endpoint | Violation |
| --- | --- | --- | --- |
| `point1/step1/S` | upper | lower | `2*u*v.upper - Im(z) < 0` |
| `point1/step5/S` | lower | lower | `Im(z) - 2*u*v.lower < 0` |
| `point3/step5/S` | lower | lower | `Im(z) - 2*u*v.lower < 0` |

The other side of each of these corner tests is positive. The independent receipt records the exact dyadic numerator, denominator factor and output endpoints, together with the residual signs. Dependence between the true values of `u` and `Im(z)` is not captured by this rectangle. Such dependence could support a different proof, but is not supplied by the failed independent-input witness.

All 24 coarse complex reciprocal checks fail to certify, matching the author. This has a weaker interpretation. That sufficient test allows the numerator and `x^2+y^2` to vary independently across their enclosing intervals. It can exceed the actual complex reciprocal image. Its failure does not establish that the exact rectangle image, much less the actual point, misses the output. A sharper image argument or a checked dependency relation is required.

## Implementation, shifts and rejection checks

The code implements the reviewed sign/magnitude comparison and bounded three-term merging correctly. Its large-exponent branch returns a sign by dominance without aligning the huge gap. Directed rounding handles negative values by floor/ceiling, not truncation toward zero. Division first checks and normalizes the divisor sign. Square-root acceptance checks both nonnegative branch and endpoint squares. The actual result preserves failed checks rather than forcing acceptance.

Left shifts go through a helper that asserts a nonnegative distance within a stated bound no larger than 8,192. The auxiliary exact translation-deficit diagnostic has its separate 2,048-bit gap guard. Right shifts for rounding occur only below the mantissa bit length; normalization shifts by the mantissa's own trailing-zero count. The small Fraction oracle explicitly bounds its exponents. The remaining Fraction uses parse the fixed small real-node metadata, not the enormous endpoint exponents.

Final instrumentation includes shifted operands before cancellation. It reports a maximum actual working mantissa of **768 bits**, signed exponent size 36 bits, and largest left/right shifts of 531/254. The earlier 767-bit observation did not include every shifted temporary and is superseded. Independent inspection of shifted temporaries confirmed 768. These are external prototype allocation observations, not a forecast of Lean checking speed or complete evaluator cost.

The author regression reproduced all comparison/product, sign, signed rounding, quotient and square-root checks, including exponent magnitude `10^100`. Its eight synthetic rejection controls and three actual-field controls passed. The independent script separately rejects reversed actual pi endpoints, a false zero display, malformed endpoint fields/types and false addition, product, quotient and square claims. In particular `1+2^(-10^100) <= 1` is rejected without expanding the gap. These are targeted tests, not comprehensive hostile-input testing. The prototype is not represented as a hardened parser or trusted proof checker.

## Acceptance boundary and next requirement

The review accepts the author's partial results and failure report without correction. It does **not** accept the old receipt as a complete arithmetic certificate. An exit-zero diagnostic, successful hash comparison, or provenance from Arb is not a Lean proof. Neither script establishes the pi, exponential, trigonometric or Gaussian-tail enclosures, the entire derivative-unwind trace, or the actual theta/xi values.

A repair needs a new derived receipt whose operation outputs enclose the inputs actually used by the checker, with every dependency propagated. Alternatives include exact internal ball data with a proved interpretation or a proved dependency-aware operation witness. Widening one failed output without rechecking subsequent steps is not a completed repair. The original receipt and this failure report should remain frozen.

For eventual formal acceptance, every necessary arithmetic result must be consumed through kernel-checked integer reductions and proved semantic lemmas. The analytic primitives and their domains still require proofs. The compact representation removes unnecessary exponent-gap allocation; it does not remove any of those obligations or supply a new final-root premise.
