# Compact dyadic receipt pilot — 2026-11-11

The compact arithmetic prototype handles every exported endpoint without constructing a huge power of two. The existing modular receipt **does not pass full interval-operation replay**: 14 translation edges and 3 root-component quotient edges fail their exact full-input enclosure tests. These failures are retained. They do not establish that the original mathematical point enclosures are false; they establish that the exported boxes cannot be used unchanged as this operation certificate.

This is external Python arithmetic evidence and a diagnostic for future certificate production. It is not a Lean backend, a proof of transcendental enclosures, or certification of theta/xi values. No producer, canonical source, or frozen package was changed. Independent review is requested separately.

## 1. Exact packet

All paths below are relative to `work/qrh-campaign/agents/`.

| Item | Path | SHA256 |
|---|---|---|
| Arithmetic plan | `integration/COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md` | `85651AA198E92AEBDB541C48A2C42AC666B0F5A72A7DDB728545A83F01AD19A8` |
| Plan review | `major-constants/REVIEW_COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md` | `2BD81A05B6C84A27149C1BEE5827B4918DD4F7F454AB799B1DEA8E954398F9DC` |
| Frozen input | `prime-estimates/principal_theta_modular_pilot_20261111.json` | `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF` |
| Input producer | `prime-estimates/principal_theta_modular_pilot_20261111.py` | `EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14` |
| Prototype | `integration/compact_dyadic_receipt_pilot_20261111.py` | `6FC3E2976B53B49D1A4FDFBDEA6A2D1E327CAA8BFCA24CCE0B1A77CE90B39840` |
| Result | `integration/compact_dyadic_receipt_pilot_20261111.json` | `7DF5B2AF02EB4D5E624286F62CDA4AF4D43D0F232A32F1663D246878C698773E` |

The script asserts the input hash before replay. Its result has explicit status `PARTIAL: listed sufficient checks failed`. Process exit 0 means the diagnostic completed and its regression assertions passed, **not** that the input operation trace passed.

Run used Python 3.14.7, Windows AMD64, standard library only. From the repository root, the original invocation was `python work/qrh-campaign/agents/integration/compact_dyadic_receipt_pilot_20261111.py`. It writes its own result and includes measured CPU time, so a new run changes the result bytes. To review without changing the frozen receipt, load the module with `importlib.util.spec_from_file_location`, call `run()`, and compare all fields except `cpu_seconds_including_regression`; the saved `script_sha256` is appended by the main entry point.

## 2. Implemented arithmetic and limits

A value is `D(m,e)=m*2^e`, with integer mantissa and signed integer exponent. Nonzero mantissas are normalized to odd form, and zero to `(0,0)`. Comparisons first inspect signs and `e+bit_length(abs(m))`. Equal top exponents need only a mantissa-width alignment.

For the sign of at most three terms, zeros are removed and terms are sorted again after every merge. A leading top-exponent gap of at least two proves domination. Otherwise the two leading terms are exactly merged with bounded shifts. The plan's `W+4` intermediate-width assertion is checked. Thus cancellation does not cause a shift by the absolute exponent gap.

Directed rounding to grid `2^g` returns the input exactly when it is already on the grid. When the discarded bit count is at least the mantissa width, it returns the sign-appropriate zero/one-grid-unit enclosure without performing that shift. Otherwise bounded division by a power of two gives the quotient and sticky bit. The rule is checked for negative inputs as well as positive inputs.

Exact products add exponents and multiply mantissas. Addition/subtraction enclosures reduce to three-term signs. Quotient witnesses normalize the denominator sign and cross-multiply; a zero denominator is rejected. Square-root witnesses require a nonnegative lower endpoint and compare endpoint squares. Full complex reciprocals use a deliberately coarse rectangle rule, described below.

All left-shift helpers assert a supplied bound at most 8,192 bits. Actual resource maxima are reported below. This is a bounded prototype, not a general parser hardened against arbitrarily large hostile mantissa strings. It makes no prediction of Lean runtime. Reading a huge mantissa still costs its size; demanding a very narrow relative enclosure after cancellation can require more precision. The signed exponent representation only avoids allocating zeros solely because the exponent magnitude is large.

## 3. What the actual receipt passes

The input has four points: `T=10^6` or `60,343,058`, each at real node `0` or `1/8`. Recursive inventory counts occurrences, not unique shared objects:

| Inventory | Value |
|---|---:|
| Raw endpoint occurrences | 4,058 |
| Real endpoint-pair occurrences | 2,029 |
| Complex-box occurrences | 984 |
| Largest raw mantissa | 256 bits |
| Signed exponent range | −54,699,295,540 through 0 |
| Largest exponent bit length | 36 |

All 2,029 pairs are ordered, contained in their displayed dyadic intervals, and have displayed endpoints equal to the exact outward rounding of the raw endpoints to `2^-128`. This is stronger than display overlap. Very small nonzero raw intervals remain represented compactly even when their display is `[0,2^-128]` or its negative counterpart.

Other passing tests are:

- Four real-node inclusions, four `Im(w)=pi/4−1/(T+1)` interval consequences of the **supplied** pi box, and four initial imaginary lower bounds.
- All 28 adjacent step-input equalities and four final-box equalities; all 28 pairs of input/output upper-half-plane tests.
- All 16 translated real-domain checks, and all 32 phase-coordinate algebraic checks. Odd eighth-root coordinates use their correct signs and squared containment of `1/2`; these do not independently derive a transcendental phase identity.
- All 12 inversion-domain tests, inversion-growth inequalities, and enclosures of `z=−i*tau`. The latter are enclosure tests, not unnecessary equality of separately exported endpoints.
- All 12 root-domain tests (`Re(z)>0`, nonnegative norm, positive `u`), norm-square enclosures, `2u^2=norm+Re(z)` enclosures, and root-component assembly equalities.
- Four terminal-domain tests and four recorded inversion-count checks.

These are conditional algebraic facts about the supplied intervals. In particular, the tests of the pi-dependent node do not certify the supplied pi enclosure itself.

## 4. Failed and unavailable operation checks

For a real translation by integer `n`, full-input replay requires

`output.lo <= input.lo − n` and `input.hi − n <= output.hi`.

Both nonzero-translation endpoint deficits are positive in all 14 nonzero-`n` steps. The two `n=0` steps pass. At `points[0].steps[0]`, with `T=10^6`, real node zero, and `n=−1`, **each** inward deficit is exactly

`133693435 * 2^-283`.

The result records all 16 pairs of exact deficits as compact dyadics. The diagnostic aligns these modest-size expressions only after an explicit 2,048-bit gap guard. No deficit is repaired or rounded away.

For `v=Im(z)/(2u)`, the denominator is positive, so testing all four endpoint combinations exactly characterizes the range over the exported independent rectangle. Nine of 12 edges pass. These three fail:

| Edge, zero-based | Excluded corner | Failed side |
|---|---|---|
| `point1/step1/S` | `Im(z).upper`, `u.lower` | upper output bound |
| `point1/step5/S` | `Im(z).lower`, `u.lower` | lower output bound |
| `point3/step5/S` | `Im(z).lower`, `u.lower` | lower output bound |

The result records cross-multiplied residual signs; no division approximation is used. Dependence between the true point values may make those independent corners irrelevant to the true value, but that dependence is not a full-input rectangle certificate.

The 24 attempted complex reciprocal checks (12 `A=1/root`, 12 modular inversions) are all **not certified by the coarse rule**. That rule bounds the numerator and `x^2+y^2` independently, which can overestimate the actual image. Its failure is not evidence that a true input point, or even the exact rectangle image, lies outside the output. A sharper reciprocal rule or richer dependency certificate remains needed.

The producer's `binary` routine serializes `x.lower()`/`x.upper()`, while later arithmetic runs on the original Arb ball, not on a reconstruction from those exported endpoints. This architecture is compatible with the observed trace mismatch, but this pilot does not establish the exact internal rounding cause. A separate bounded internal-midpoint/radius diagnosis is being conducted. Neither that diagnosis nor a local widened edge would repair the entire dependent trace unless widened values were propagated or an exact alternative dependency witness were supplied.

The receipt does not supply a complete elementary-operation DAG for the reduced exponential series, derivative unwind, or final `P`. This pilot therefore does not claim to replay those operations. It does not verify exp, sin, cos, pi, omitted Gaussian tails, or analytic theta identities. No external floating-point result becomes an acceptance axiom here.

## 5. Regression, corruption controls, and measured resources

Small independent `Fraction` oracles check 1,225 comparison/product pairs, 4,900 three-term signs, 13,005 directed roundings, and 1,050 quotient enclosures. Integer square root supplies 20 small square-root enclosures. Fractions are restricted to these small cases and the tiny node metadata; no actual huge-exponent endpoint is converted to `Fraction`.

Additional exact controls use exponent magnitude `10^100`: comparison, cancellation exposing a tiny term, positive/negative sticky rounding, addition, quotient, and square root. Their largest working exponent is 334 bits and largest shifted mantissa 129 bits.

Eight synthetic corruptions are rejected: false addition/product/quotient, zero denominator, negative square-root branch, false square root, and malformed exponent/mantissa. Three controls on actual receipt fields reject a reversed pi interval, a false zero display interval, and the opposite root branch. These are targeted controls, not a claim of complete fuzz testing.

Actual replay operation counts include diagnostics and unsuccessful sufficient tests:

| Operation | Count |
|---|---:|
| Comparison | 12,971 |
| At-most-three-term sign | 266 |
| Exact product | 706 |
| Directed rounding | 4,058 |
| No-shift small-term rounding | 2,060 |
| Guarded left/right shifts | 21,620 / 1,946 |
| Quotient witnesses | 48 |
| Square-root witnesses | 10 |

Largest actual working mantissa, including shifted temporaries before cancellation: **768 bits**. Largest actual exponent: **36 bits**. Largest guarded left/right shift: **531 / 254 bits**. The complete diagnostic plus regression used 0.375 process CPU seconds in the recorded run. This is a single external Python measurement, not a performance forecast for the future Lean checker or complete modular evaluator.

## 6. Consequence for the implementation plan

The compact arithmetic representation works on the actual extreme exponents and detects small strict failures without denominator expansion. Certificate production must now provide operation witnesses that compose: either serialize exact internal input balls and prove their interpretation, or compute/export output enclosures from the already-serialized input enclosures, or provide checked dependency identities that justify tighter outputs. Any regenerated trace must retain the full graph, including nonlinear steps and transcendental enclosures. The current receipt is useful external point evidence, but it is not already such a compositional arithmetic trace.
