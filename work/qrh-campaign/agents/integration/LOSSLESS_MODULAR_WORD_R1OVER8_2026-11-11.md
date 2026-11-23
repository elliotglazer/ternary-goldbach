# Lossless replay of the nontrivial r=1/8 modular word

2026-11-11. The original `T=1000000, r=1/8` point has the 11-step word

`T(-1), S, T(4), S, T(2), S, T(-12), S, T(-2), S, T(6)`.

A new lossless receipt for this word passes all **87 operation/constant checks and 43 domain checks**, conditional on one explicitly unproved seed. Both root-v divisions that failed full-input containment in the old exported-endpoint receipt now pass on the exact internal-ball sets. No output interval was widened, no failed check was suppressed, and no previous artifact was changed.

This is a bounded external arithmetic result. It is not a proof of the seed, a theta-series evaluation, a derivative unwind, or a spectral statement. No Lean build or formal backend was used.

## 1. Files and fixed provenance

Paths are relative to `work/qrh-campaign/agents/`.

| Item | Path | SHA256 |
|---|---|---|
| New script | `integration/lossless_modular_word_20261111.py` | `9B6B49FF7EBC546BD4D340F89A954519B420047F0858D8DFF1001E4F708E4720` |
| New receipt | `integration/lossless_modular_word_20261111.json` | `E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910` |
| Original producer | `prime-estimates/principal_theta_modular_pilot_20261111.py` | `EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14` |
| Original four-point data, read only | `prime-estimates/principal_theta_modular_pilot_20261111.json` | `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF` |
| Reused exact helper code | `integration/lossless_modular_two_step_20261111.py` | `9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6` |
| Helper's mathematical report | `integration/LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md` | `2AC88432744B5D99FC821A16E2A0AD2B3AC9AB5483956F1A0B8DB2FAD8CD4230` |
| Independent helper review | `mellin/REVIEW_LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md` | `46BDD3D1CA0AD8C730A693AC4CFA7F5D55C3043EDBF4180B82C939C5BC18B697` |

The generator verifies the code/data pins, imports only the original producer's definitions, and explicitly executes the six translations and five inversions for this one point. It does not call its reduction loop, theta sums, derivative unwind, direct Gaussian summation, or four-point runner. Sixty available original snapshots match when re-exported through the old 256-bit endpoint function. The receipt adds the previously absent intermediate arithmetic nodes in lossless form.

Commands from the repository root:

```
work/qrh-campaign/interval-env/Scripts/python.exe -X utf8 work/qrh-campaign/agents/integration/lossless_modular_word_20261111.py
python work/qrh-campaign/agents/integration/lossless_modular_word_20261111.py --check work/qrh-campaign/agents/integration/lossless_modular_word_20261111.json
```

Generation uses the installed Arb at the original 256-bit precision. The second command is read-only and uses ordinary Python plus the pinned standard-library exact helpers. It does not import Arb or execute numerical transcendental code. Both commands succeeded.

## 2. The seed remains a separate obligation

The single seed is the closed complex box for

`tau = exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))`.

This is the original `r=1/8` expression, since `2r=1/4`. The fixed metadata and recipe reject the `r=0` case. The reviewed rational trigonometric seed theorem at r=0 is **not** reused as a theorem for this product. A separate exact certificate for exp(1/4), with proper propagation through both products into this seed box, remains needed.

Every assertion of composition in this receipt is conditional on the actual prescribed tau lying in its seed box. The seed node is labeled `unproved_seed`, and the verification result returns `unproved_seed_ids=['tau']`. The old r=0 one-node P bound does not discharge this obligation.

## 3. Exact sets, operand identities, and graph

Each scalar node contains exact dyadic midpoint/radius and endpoints. The checker verifies nonnegative radius and `lo=mid-radius`, `hi=mid+radius`. This represents the actual internal ball, without the extra outward rounding of the original `.lower()`/`.upper()` export. Complex values are Cartesian products of two such sets.

The fixed recipe binds the full ordered list of 88 nodes, their IDs, kinds, operations, operand IDs, and constants. In particular, stage i+1 consumes **the previous stage's actual `next` node**, not a new unproved point with a similar numerical value. Altering the word, seed parameters, or a dependency is rejected. Every node also records whether all of its dependencies compose from the seed; a local failure would remain visible and would prevent descendants from being counted as a completed chain.

For each of five S stages, with translated point t, the graph contains

```
next = -1/t
z = -i*t
x = Re(z), y = Im(z)
xx = x^2, yy = y^2
norm2 = xx+yy, norm = sqrt(norm2)
usum = norm+x, uhalf = usum/2, u = sqrt(uhalf)
den = 2u, v = y/den
root = u+i*v, A = 1/root.
```

Each of six T stages contains its translated point and its eighth-root phase constant `exp(pi*i*n/4)`. These constants are certified algebraically: even exponents give axis values ±1 or ±i; odd exponents use the specified signs and positive coordinate magnitude whose square is 1/2. This certifies a unique exact constant, not an arbitrary root of the same polynomial. The standard identity with the exponential is a paper/source lemma of the reviewed modular plan. Some phases are not used by a particular theta type, but retaining all six makes that choice explicit for a future jet consumer.

The counts are:

| Operation | Count |
|---|---:|
| Unproved seed | 1 |
| Translation | 6 |
| Eighth-root constant | 6 |
| Complex reciprocal, including S and A | 10 |
| Rotation by −i | 5 |
| Coordinate projection | 10 |
| Unary square | 10 |
| Addition | 10 |
| Nonnegative square root | 10 |
| Scaling by 2 or 1/2 | 10 |
| Division | 5 |
| Complex assembly | 5 |

There are 81 ordinary arithmetic/structural gates and six algebraic-constant gates after the seed. All pass.

## 4. Nonlinear containment and the old failures

Scalar addition, multiplication/scaling, and division use the complete Cartesian product of input intervals. Square root uses nonnegative input/output and endpoint-square inequalities. Squares are explicitly unary operations, with their exact range including zero when required. All ten square nodes also pass the more conservative independent-product test here, so this word needs no special correlation tightening for those products.

Both kinds of complex reciprocal use the reviewed exact rectangle-image method. The input rectangle excludes zero. The real component `x/(x²+y²)` and imaginary component `−y/(x²+y²)` have no interior critical point off zero; corners and the finitely many edge stationary points give exact component extrema. These candidates have rational coordinates. All ten reciprocal boxes contain these exact ranges. This avoids the insufficient earlier rule that separated the numerator from a coarse norm denominator.

For root-v, all four corner quotients `y/(2u)` are checked after proving `u>0`. All five divisions pass, including:

| New gate | Original failed edge | Result on lossless sets |
|---|---|---|
| `s0.v` | `points[1].steps[1]` | full-input quotient contained |
| `s2.v` | `points[1].steps[5]` | full-input quotient contained |

The original six nonzero translations at this point also all pass in the new lossless representation. The old failures remain correct under their wider exported-input semantics. This result does not assign an exact internal rounding cause to every previous quotient failure; it demonstrates that the corresponding newly recorded internal sets and correctly bound operations compose.

The principal-root interpretation uses the same symbolic argument as the reviewed two-step packet. For x>0, `n=sqrt(x²+y²)`, `u=sqrt((n+x)/2)>0`, and `v=y/(2u)` imply `(u+iv)²=x+iy` and positive real part. The gate graph preserves the repeated x/y identities required by this argument. It does not assert that every independent pair selected from the output root box obeys that equation with every z in the input box.

## 5. Domains, resources, and rejection controls

Each translation satisfies the strict real-domain guard `|Re(t)|<3/5` and positive imaginary part. For each of five S stages, `Im(t)<1/2`, the recorded next imaginary lower endpoint exceeds `100/61` times the input imaginary upper endpoint, and the root argument, u, divisor, and reciprocal-root domains are positive. At the final translated point `Im(t)>2/5`. All 43 exact checks pass.

The checker reads 494 dyadic fields. Maximum input mantissa width is 283 bits and maximum absolute exponent is 316. Eighty reciprocal extremum candidates are evaluated; their numerators and denominators require at most 601 and 599 bits. These small local inputs fit the reused helper's guarded 4,096-bit/exponent Fraction path. This remains a bounded prototype, not the general huge-exponent compact backend or a performance forecast.

Six corruptions are rejected: wrong real node, changed word, wrong translation predecessor, wrong root-v numerator, wrong eighth-root exponent, and a false zero quotient output. The result contains no failed gate IDs. If a future packet contains any failure, its explicit flags must be preserved rather than replaced by an overlap test or an intended-point interpretation.

## 6. Remaining soundness and production obligations

No specialized correlation-aware interval operation is needed for the arithmetic gates in this tested word. Unary square/root semantics and exact operand identities remain essential, and the symbolic principal-root and eighth-root identities must be formalized once. Arbitrary future words may still need stronger interval contracts or more precise exports; this result does not claim otherwise.

The open tasks are the actual exp(1/4)-times-trigonometric seed certificate, formal soundness and kernel replay of the typed graph/arithmetic, theta-type and derivative transport, reduced theta evaluation with analytic tails, final P assembly, and any subsequent Fourier or contour use. The completed word supplies only the intermediate points, domains, phases, and local root multipliers for those later steps. It creates no new theorem premise and claims no completed P value or spectral proof for r=1/8.
