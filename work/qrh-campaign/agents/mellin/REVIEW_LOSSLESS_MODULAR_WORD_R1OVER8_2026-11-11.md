# Independent review of the r=1/8 lossless modular word

2026-11-11. **PASS conditional on the explicitly unproved seed enclosure. No correction requested.** All 81 arithmetic/structural gates, six algebraic constants and 43 domain checks pass an independent exact replay. This is one word at T=1000000, r=1/8. It does not establish the seed, a theta jet, a P value, or a spectral result.

## Frozen artifacts and replay

Paths are relative to `work/qrh-campaign/agents`.

| Item | SHA256 |
|---|---|
| `integration/LOSSLESS_MODULAR_WORD_R1OVER8_2026-11-11.md` | `449D40E3447F91532A8DFB7240833FF16511DAECA96C21C1DAFDE01F9C51D790` |
| `integration/lossless_modular_word_20261111.py` | `9B6B49FF7EBC546BD4D340F89A954519B420047F0858D8DFF1001E4F708E4720` |
| `integration/lossless_modular_word_20261111.json` | `E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910` |
| Independent `mellin/review_lossless_modular_word_20261111.py` | `5328E4E0DFD8E31F69137B5E0582AADEF60672A7AFD0764E41A7434B257D95AE` |
| Independent `mellin/review_lossless_modular_word_20261111.json` | `8D20434CB6CB0DDF6805FB49F59C2AD6705821D6EFE95030661A175FB16DCD41` |

The independent script imports only the standard library, not the producer, its exact helper, or Arb. It verifies the four pinned input artifacts, reconstructs all exact midpoint/radius intervals, fixes the entire 88-node dependency graph, and checks every operation and domain. It separately checks all ten unary squares against the larger independent-product range. Both this script and the author's read-only `--check` command exited zero. The latter also reproduced the stated resource counters and six rejection controls. No generation or transcendental evaluation was rerun.

## Exact dependency and set semantics

The word is

`T(-1), S, T(4), S, T(2), S, T(-12), S, T(-2), S, T(6)`.

At a T(n) step the reduced point is `t=current-n`; at S the next point is `-1/t`. Each subsequent translation consumes that previous S-output node. The independent expected graph binds these operands, each local root expression, all constants and all signs. No intermediate point is admitted as a fresh seed.

A scalar interval is exactly `[mid-rad,mid+rad]`, with nonnegative radius and independently checked stored endpoints. Complex inputs are Cartesian products. Addition, scaling and division use the full input Cartesian products. Square is a unary operation with the zero-crossing case included; all ten inputs in this packet additionally pass the independent-product check. A square-root output is nonnegative and its squared endpoints bracket the input interval, proving containment by monotonicity. Projections and assembly preserve their exact operand intervals.

Each of the ten complex reciprocal gates is checked using a separately coded exact extremum calculation. For `1/(x+iy)`, each component has no interior critical point away from zero. The checker includes all corners and, on each edge, the candidates with coordinate zero or equal to plus/minus the absolute value of the fixed other coordinate. This overinclusive union contains every required stationary point for both components. All candidates are rational and the input rectangle excludes zero. Negation of the S output reverses both coordinate endpoints. These checks concern the entire input rectangle, not just an intended central value.

## Root-v gates and principal branches

All five gates `s0.v`, `s1.v`, `s2.v`, `s3.v`, `s4.v` contain the full independent quotient range of their recorded `y` and `2u` inputs. The independent implementation obtains that range by multiplying the numerator interval by the ordered reciprocal denominator interval. Every denominator has a strictly positive lower endpoint.

This includes `s0.v` and `s2.v`, corresponding to the original failed exported-endpoint edges `points[1].steps[1]` and `points[1].steps[5]`. The result does not erase those failures. The older receipt used different, outward-rounded input sets; its rejected containment claims remain rejected. The new packet proves containment for the newly recorded exact internal balls. This review does not assign an unmeasured rounding cause to every older failure.

For each S stage, the exact expressions are `z=-i*t`, `x=Re(z)>0`, `y=Im(z)`, `n=sqrt(x^2+y^2)`, `u=sqrt((n+x)/2)>0`, and `v=y/(2u)`. Algebra gives `v^2=(n-x)/2`, so `(u+iv)^2=z` and its real part is positive. This identifies the principal square root on the right half-plane. The graph preserves the repeated operand identities used in this proof while its interval operations safely forget correlations. It does not assert that arbitrary choices from the final root rectangle square to the same z. The final A gate encloses the reciprocal of the whole root rectangle and hence the actual required root reciprocal.

## Constants and reduction guards

The six phase constants are `exp(pi*i*n/4)` for the recorded shifts. Reduction of n modulo eight fixes their signs. Even exponents give the appropriate axis value. For odd exponents, a nonnegative magnitude interval whose squared endpoints enclose 1/2 encloses the unique positive square root of 1/2; the specified signs identify the intended eighth root. No arbitrary polynomial root or unsupported exponential evaluation is accepted. Their identity with the modular phases uses the already reviewed elementary theta transformation formulas; this packet does not yet apply them to a theta jet.

All translated points have strict real bound 3/5 and positive imaginary part. All five inversion inputs have imaginary part below 1/2, and each output's imaginary lower bound exceeds 100/61 times the corresponding input upper bound. The root positivity guards also hold. The final translated point has imaginary part strictly above 2/5. The independent checker counts exactly 43 such assertions.

For completeness, it also constructs a rational nearest-integer witness at each translation. It takes the input real midpoint and clamps it to `[n-1/2,n+1/2]`. Each resulting rational lies within distance less than 1/10 of the entire input real interval, and n is a nearest integer to it. Thus the fixed shifts satisfy the actual overlapping reduction rule, including allowed ties, rather than only the looser post-translation domain.

## Provenance, seed and scope

The original four-point data remain pinned at SHA `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF`. The independent checker verifies that all sixty old snapshot hulls contain their corresponding new exact intervals. This is deliberately a containment check, not an independent rerun of the author's claim that its generator reproduced all old 256-bit exports exactly. The generator code does check that exact reproduction, but generation was not required for this independent arithmetic verdict.

The seed remains the separate assertion that

`exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))`

belongs to the displayed seed rectangle. Its factor exp(1/4) comes from 2r=1/4. The reviewed r=0 trigonometric seed and one-node P bound do not establish this product enclosure. The word's conditional interpretation is therefore essential and correctly retained in the author packet.

Remaining work includes that seed certificate, formal soundness and kernel replay of the graph, theta-type and derivative transport, reduced theta-series bounds, and final P assembly. None of those conclusions, any full grid, or any spectral coverage is inferred here. All frozen source, prior receipts and prior statuses were preserved.
