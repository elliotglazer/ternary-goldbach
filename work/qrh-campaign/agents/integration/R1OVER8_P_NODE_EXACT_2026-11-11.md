# One nonzero principal P node with exact elementary replay

2026-11-11. At the fixed point

`w=1/8+i*(pi/4-1/1000001)`

the new rational-only computation encloses the **actual source-normalized P(w)** in a disk of radius `2^-128` around the exact dyadic center recorded in the receipt. Its approximate location is

`1.089752494945126e12 - 2.208954416969382e12*i`.

The decimals are for orientation only. Exact inequalities give `Re(P(w))>10^12` and `Im(P(w))<-2*10^12`, so this node is nonzero. The complete calculation uses rational Machin/Taylor enclosures, the reviewed lossless modular word, all five derivative transforms, and a bound for the entire omitted theta series. No numerical theta, L-function, exp, trigonometric, or pi oracle is called.

This is paper proof plus exact external arithmetic, not Lean or a verified executable. It evaluates this one node only. It does not imply anything about a grid, a contour, or a zeta zero. Earlier frozen files are unchanged.

## 1. Frozen packet and prior accepted inputs

Paths are relative to `work/qrh-campaign/agents/`.

| Item | Path | SHA256 |
|---|---|---|
| New rational computation | `integration/r1over8_p_node_exact_20261111.py` | `4EE532C9698CCD8B462D40A1D102CE6DAD35741173C7D43F911C3AE7B2F15286` |
| New receipt | `integration/r1over8_p_node_exact_20261111.json` | `DDF8B38A52FEBB70F019E805068ED4480CB086C8A27A00A86DAA0D05882AF584` |
| Lossless word data | `integration/lossless_modular_word_20261111.json` | `E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910` |
| Word review | `mellin/REVIEW_LOSSLESS_MODULAR_WORD_R1OVER8_2026-11-11.md` | `5F6D22F549CF251EC44DAC4D436DAD0FF5A077902C22B81978F359AECAAC6C28` |
| Rational seed data | `prime-estimates/r1over8_seed_rational_20261111.json` | `E4EFD292003D1216EDA8E4BD9BFF7921050874F9378222C34A5A71EC39974E89` |
| Seed proof | `prime-estimates/R1OVER8_SEED_RATIONAL_2026-11-11.md` | `5C2B846B4BF1983CE8448FCDBF78FE7860B68C57030598E72D6649831BD37C16` |
| Seed review | `independent-feasibility/REVIEW_R1OVER8_SEED_RATIONAL_2026-11-11.md` | `0D17AC890A1E87D8B226484B78B32B085EC87753E26998AF02D0F5F47C4955E8` |

The new script hash-checks and reruns the word and seed verifiers before using their boxes. Their pinned code hashes are retained in the new receipt. These verification paths import no Arb code. The seed identifies the actual `tau=i*exp(2w)=exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))`, rather than an arbitrary point in a numerically similar box.

Analytic identities and elementary source APIs are those of these accepted plans:

- `integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md`, hash `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D`, reviewed under `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED`.
- `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`, hash `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, reviewed under `ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2`.
- `prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md`, hash `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC`, reviewed under `4C773E1497C2C6F2D99D0A1F5A060A8029E9CC5EBCD85D5F3265914A13547181`.

Read-only reproducible command from the repository root:

```
python work/qrh-campaign/agents/integration/r1over8_p_node_exact_20261111.py --check work/qrh-campaign/agents/integration/r1over8_p_node_exact_20261111.json
```

It recomputes the complete result using standard-library integers/fractions and requires exact equality with the receipt. Generation and read-only replay passed.

## 2. Theta type, phases, and derivative identities

The fixed word is `T(-1),S,T(4),S,T(2),S,T(-12),S,T(-2),S,T(6)`. The selected type evolves as follows:

| Step | Selected type after step | Constant multiplier during reconstruction |
|---|---|---|
| Start | theta3 | 1 |
| T(-1), S | theta4, then theta2 | no T phase; local A from S |
| T(4), S | theta2, then theta4 | −1; local A |
| T(2), S | theta4, then theta2 | 1; local A |
| T(-12), S | theta2, then theta4 | −1; local A |
| T(-2), S | theta4, then theta2 | 1; local A |
| T(6) | theta2 | −i |

The active constant phases multiply to −i. Each local A retains its own argument and principal branch; no unproved product-square-root identity is used. Reconstruction starts by multiplying the final jet by −i, traverses the five S steps backwards, and inserts −1 after stages 3 and 1. All three entries of a jet receive each constant phase.

At an S input t, put `v=-1/t` and `A=1/sqrt(-i*t)`. If g is the next selected theta function, the preceding jet is exactly

```
f   = A*g,
f'  = A*(-g/(2t)+g'/t^2),
f'' = A*(3g/(4t^2)-3g'/t^3+g''/t^4).
```

Primes on g mean derivatives in v. These formulas follow by differentiating the holomorphic S identity, with `A'/A=-1/(2t)`, `A''/A=3/(4t^2)`, `v'=1/t^2`, and `v''=-2/t^3`. T translations have derivative one. The lossless word provides full-input enclosures and domain proofs for every t and A.

## 3. Exact elementary interval primitives used here

Real intervals have rational endpoints. After each arithmetic operation the result is rounded outward to the grid `2^-320`: lower endpoint by integer floor and upper endpoint by integer ceiling. Each rounding call asserts the exact containment inequality. Addition, subtraction, multiplication, and division use their full interval ranges; divisors must exclude zero. Complex multiplication uses four real products. Reciprocals use squared-coordinate ranges and require a strictly positive norm-squared lower bound. Repeated input occurrences may enlarge a box but cannot invalidate it.

**Pi.** Machin's identity is `pi=16*atan(1/5)-4*atan(1/239)`. For each arctangent, an even 128-term alternating sum is the lower endpoint and its next term gives the 129-term upper endpoint. The positive terms decrease geometrically to zero. Integer/fraction arithmetic then forms the correctly reversed interval combination. The source identity is `Real.four_mul_arctan_inv_5_sub_arctan_inv_239`; the source alternating-series APIs and their hypotheses are recorded in the accepted elementary plan. The resulting pi box is checked to lie strictly inside (3,4).

**Real exponential.** For each nonnegative rational endpoint x, choose k with `t=x/2^k<=1/2`. Compute the first 96 Taylor terms with outward interval operations. The lower polynomial bound and the uniform upper remainder

`R = 2^-96 * 97/(96!*96)`

enclose exp(t), by `Real.sum_le_exp_of_nonneg` and `Real.exp_bound'`. Square k times, with outward rounding. Negative arguments use the reciprocal of the positive-argument enclosure. A nondegenerate input interval uses its two endpoint enclosures and monotonicity. No logarithm or floating-point range decision is needed.

**Sine and cosine.** Given the full angle interval X, choose a rationally proposed integer k and form the complete interval `Y=X-2*k*Pi`. Check `Y subset [-4,4]`. Thus each actual angle is reduced by the exact same integer multiple of the actual pi, with its uncertainty included. Evaluate the even and odd parts of the 160-term polynomial for exp(i*y) using outward interval recurrences. The common coordinate remainder is

`2*4^160/160!`.

`Complex.exp_bound'` applies because `4/161<=1/2`; taking real and imaginary parts gives the required sine/cosine enclosures. This remains valid when Y crosses a critical point: the entire interval polynomial is evaluated, not just function values at its endpoints. Periodicity returns the result for X.

These are the precise source remainder formulas in Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, `Analysis/Complex/Exponential.lean:407,516,523`, hash `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0`. The accepted elementary plan pins the periodicity, Machin, and alternating-series sources. All hypotheses above are checked or established by the indicated general proof.

## 4. Terminal theta2: finite terms and whole tail

Let v be the final translated point. Its frozen interval gives `Im(v)>=9`. Classical theta2 and its first two derivatives are

`g_j(v)=2*sum_(n>=0) (pi*i*a_n^2)^j * exp(pi*i*a_n^2*v)`,

where `a_n=n+1/2` and j=0,1,2. Local normal convergence in the upper half-plane justifies these differentiated series. The paired half-integers contribute the factor 2; there is no constant term.

The script evaluates the four paired modes `a=1/2,3/2,5/2,7/2`. For each mode it encloses the complex exponential by `exp(real part)*(cos(imaginary part)+i*sin(imaginary part))`, then multiplies by the exact interval coefficient `pi*i*a^2` for the first and second derivative. All pi and v uncertainties are propagated.

For the omitted modes a>=9/2, the same elementary argument as the accepted r=0 node gives, simultaneously for j<=2,

`2*(pi*a^2)^j*exp(-pi*Y*a^2) <= 64*exp(-2Y*a^2)`.

Indeed `(pi*a^2)^j<=16a^4`, `a^4<=2exp(a^2)`, and `3Y-1>=2Y` for Y>=1. Put u=9/2. Since `(u+k)^2>=u^2+k`, the omitted norm sum is at most

`64*exp(-2Y*u^2)/(1-exp(-2Y)) <= 128*exp(-364) <= 2^-357`.

Here `2*9*(9/2)^2=364.5>=364`, `exp(1)>=2`, and the geometric denominator bound uses `exp(-2Y)<=1/4`. This bounds the entire omitted series, not one term. The code widens each real and imaginary coordinate of every terminal jet entry by `2^-357`, which contains the norm-bounded tail.

## 5. Error transport and final P normalization

Every operation in the five displayed S formulas is evaluated on the full input boxes, including coefficient uncertainty and outward arithmetic. Thus no missing coefficient-error budget is inferred from a point calculation. All g, g', and g'' contributions are retained. A conservative norm amplification is also recorded separately at each stage: if `E>=1/|t|` and `a>=|A|`, the three row bounds are

`a`, `a*(E/2+E^2)`, `a*(3E^2/4+3E^3+E^4)`.

The script obtains E and a from valid interval norm upper bounds, stores all three rational rows and their maximum, and multiplies the five maxima. The final P factor below is included as well. The resulting **tail-only analytic norm error** is checked to be less than `2^-200`. This diagnostic is not added a second time: the terminal coordinate widenings are already propagated through the complete interval calculation. Their rectangular overestimate, which can include a sqrt(2) enlargement compared with the original norm tail, is included in the final interval width.

For this node the prefactor is not of unit modulus. It is explicitly enclosed as

`exp(w/2)=exp(1/16)*(cos(pi/8-1/2000002)+i*sin(pi/8-1/2000002))`.

Finally the computation uses the reviewed source-normalized identity

`P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))`.

It corresponds to the kernel with coefficients `8*pi^2*n^4*exp(9w/2)` and `-12*pi*n^2*exp(5w/2)` in the principal xi evaluator. No extra factor 1/2 or conductor scaling is inserted.

The receipt contains the terminal jet, every reconstructed jet, inverse-t boxes, the prefactor, and the final P box. The final center c is formed on the grid `2^-192`. An exact sum of the two coordinate distances from c to their furthest interval endpoints bounds the Euclidean error. It is strictly less than `2^-128`. The final box also satisfies the stated coarse separation from zero. The old external pilot overlaps this box as a separate sanity observation, but no old P value or overlap condition is an acceptance input.

## 6. Reproducibility and limits

There are 16 recorded elementary calls: one Machin pi construction, ten positive-exponential endpoint computations, and five sine/cosine calls. The node computation performs 4,989 outward roundings, 2,971 real multiplications, 1,963 real additions, and 18 real divisions, excluding the prior seed/word replays. All values are exact integers/fractions. The fixed output comparison detects mutations of the recorded center, omitted-tail field, precision, and nonzero status; these are serialization consistency controls, not independent semantic fuzz tests.

The new code is a small external interval implementation whose soundness is argued above and awaits independent review. Its rational arithmetic, finite graph replay, and analytic adapters still require Lean formalization. This result supplies one actual nonzero P coefficient with an absolute error bound. It supplies no Fourier integral, no contour nonvanishing, no zero count, and no finite-family certificate.
