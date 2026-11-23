# Rational-only certificate for the local modular seed

2026-11-11. Six- and seven-term alternating Taylor sums give a strict enclosure of

`tau = -cos(2/1000001) + i*sin(2/1000001)`

inside the **existing frozen internal seed box** of the lossless two-step packet. All finite inequalities were checked using exact Python integers and fractions, without Arb, floating-point arithmetic, pi, exponential evaluation, or numerical sine/cosine. The analytic justification below uses the actual sine/cosine series and the alternating-series inequalities.

This discharges the local seed at paper-plus-exact-external-certificate scope. It is not a Lean proof. The earlier packet remains unchanged and still calls its seed unproved; this new version-bound supplement supplies the missing mathematical argument. It does not evaluate a full modular kernel or change any spectral status.

## 1. Fixed packet and pins

Paths are relative to `work/qrh-campaign/agents/`.

| Item | Path | SHA256 |
|---|---|---|
| Lossless two-step report | `integration/LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md` | `2AC88432744B5D99FC821A16E2A0AD2B3AC9AB5483956F1A0B8DB2FAD8CD4230` |
| Frozen target receipt | `integration/lossless_modular_two_step_20261111.json` | `31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE` |
| Independent two-step review | `mellin/REVIEW_LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md` | `46BDD3D1CA0AD8C730A693AC4CFA7F5D55C3043EDBF4180B82C939C5BC18B697` |
| New checker/generator | `integration/lossless_seed_taylor_20261111.py` | `3000DB601B1206E1A128438774D0C33DF7FB3EA27AEAECD65CECD81E63CD2137` |
| New certificate | `integration/lossless_seed_taylor_20261111.json` | `6C3EE4AE09014B64541899F276405C607624A5DABF70DFBA3AEE5EF654E82C3F` |
| Elementary source plan | `prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md` | `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC` |
| Plan review | `independent-feasibility/REVIEW_INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md` | `4C773E1497C2C6F2D99D0A1F5A060A8029E9CC5EBCD85D5F3265914A13547181` |

The checker requires the exact target receipt hash, node ID `tau`, seed expression, height `T=1000000`, real node `r=0`, and argument `2/1000001`. It verifies the seed's center/radius and endpoint identities. It does not accept a nearby argument or a different output box merely because the resulting inequalities happen to pass.

Read-only replay from the repository root:

```
python work/qrh-campaign/agents/integration/lossless_seed_taylor_20261111.py --check work/qrh-campaign/agents/integration/lossless_seed_taylor_20261111.json
```

Generation and read-only replay both passed. The script imports only the standard library and does not import the external modular producer or its numerical libraries.

## 2. Analytic proof of the rational bounds

Put `x=2/1000001`, so `0<x<1`. For `a=0` (cosine) or `a=1` (sine), define

`f_a(k)=x^(2k+a)/(2k+a)!`,

`P_a(N)=sum_{0<=k<N} (-1)^k*f_a(k)`.

Every term is positive. For every natural k,

`f_a(k+1)/f_a(k)=x^2/((2k+a+1)(2k+a+2))`

`<=q_a=x^2/((a+1)(a+2))<1`.

The denominator inequality follows because both positive factors increase with k. Thus `f_a` is antitone. It is also dominated by `f_a(0)*q_a^k`, so it tends to zero and is summable. These statements concern **all k**, not only the finitely checked terms in the receipt.

The source series identities give

`cos x = sum' (-1)^k*f_0(k)`,

`sin x = sum' (-1)^k*f_1(k)`.

For an antitone sequence with these convergent alternating partial sums, an even number of terms is a lower bound and an odd number is an upper bound. Therefore

`P_a(6) <= F_a(x) <= P_a(7)`,

where `F_0=cos` and `F_1=sin`. The exact width is the next term

`P_a(7)-P_a(6)=f_a(6)>0`.

This uses cosine polynomials of degrees 10 and 12, and sine polynomials of degrees 11 and 13. No unbounded numerical sum is computed. The usual first-omitted-term remainder bound is also available from the same hypotheses; the two-sided even/odd enclosure already suffices here.

The complex seed interval is consequently

`Re(tau) in [-P_0(7),-P_0(6)]`,

`Im(tau) in [P_1(6),P_1(7)]`.

The reversal of cosine endpoints is essential.

## 3. Actual source APIs

These are source-proved APIs in Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, not new declarations or executed Lean checks:

- `Mathlib/Analysis/SpecialFunctions/Trigonometric/Series.lean:100`, `Real.hasSum_cos`, gives exactly the series with coefficient `(-1)^n*r^(2*n)/(2*n)!`.
- The same file at line 105, `Real.hasSum_sin`, gives `(-1)^n*r^(2*n+1)/(2*n+1)!`.
- `Mathlib/Analysis/SpecificLimits/Normed.lean:1007`, `Antitone.alternating_series_le_tendsto`, takes convergence of finite partial sums and antitonicity and bounds the even partial sum below the limit.
- The same file at line 1021, `Antitone.tendsto_le_alternating_series`, gives the odd partial sum above the limit. The optional `alternating_series_error_bound` at line 1041 additionally takes summability of the unsigned sequence.

Exact source hashes: `Trigonometric/Series.lean` is `1C8457816ED5E9D72967890E7C25EECE5A5FF2D9B90248B768E060993ADFC9FF`; `SpecificLimits/Normed.lean` is `29AA06CCC31F1BFD454DBF888C108F4C3FBE8AA5A9AEDE4F95D3D7473C03EE70`.

The elementary source plan already permits exact rational finite sums and analytic remainder arguments. Its general sine/cosine route uses complex exponential bounds; the tiny fixed argument here permits the shorter direct alternating-series specialization. No new numerical premise is introduced.

## 4. Exact finite result

The generator obtains the seven positive terms in each channel by a rational recurrence. The checker independently recomputes each term using integer powers and factorials, checks both partial sums, the exact first-omitted-term width, and the finite recurrence/monotonicity inequalities. It also checks the closed-form global ratio parameters `q_0=x^2/2` and `q_1=x^2/6` used in the proof above.

The certificate records full rational bounds and strict containment margins. Each margin is positive and has the following exact dyadic lower bound:

| Margin inside frozen seed | Strict lower bound |
|---|---:|
| Real lower endpoint clearance | `2^-258` |
| Real upper endpoint clearance | `2^-257` |
| Imaginary lower endpoint clearance | `2^-273` |
| Imaginary upper endpoint clearance | `2^-276` |

The largest integer appearing in the recorded fractions/terms/margins is 582 bits. Fourteen positive Taylor terms are checked. The computation is small because the argument is rational and tiny; this is not a performance claim about general high-height transcendental evaluations.

Eight corruption controls are rejected: changed argument denominator, changed height, changed real node, wrong target hash, wrong seed ID, odd lower truncation length, a false cosine term, and a false sine lower bound.

## 5. What now composes, and what remains

The paper alternating-series proof plus this exact rational certificate puts the actual prescribed tau inside the frozen lossless seed box. The independently reviewed two-step graph then propagates this enclosure through its 16 arithmetic gates and six domain checks. Its symbolic root identity identifies the final root with the principal square root of `−i*(tau+1)`. Thus the local translation, S output, root formula and A multiplier have a complete paper/exact-external-evidence route without an unproved numerical seed assumption.

Neither checker is a kernel proof. Lean work still includes the rational checker soundness/finite evaluation, source-series adapters, typed operation-graph soundness, reciprocal extrema, and the root-identity adapter. The remaining modular trajectory, theta sums, error bounds, derivative unwind, Fourier evaluation, contours, and spectral statements are outside this packet. No old file or status field has been edited to imply otherwise.
