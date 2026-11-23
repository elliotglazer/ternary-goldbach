# Independent review of the fixed modular seed

2026-11-11. **PASS within paper proof plus exact external arithmetic scope.** No correction requested. This review supplies the numerical seed premise left open in the previously reviewed local two-step packet. It does not certify a complete modular trajectory, a spectral assertion, or a Lean theorem.

## Frozen inputs and independent output

Paths below are relative to `work/qrh-campaign/agents`.

| Item | SHA256 |
|---|---|
| `integration/LOSSLESS_SEED_TAYLOR_2026-11-11.md` | `E5AB4A2B4B7A81DC6731F337D032A39F6DF2509F580D4E00B109DC2DF9A7D00B` |
| `integration/lossless_seed_taylor_20261111.py` | `3000DB601B1206E1A128438774D0C33DF7FB3EA27AEAECD65CECD81E63CD2137` |
| `integration/lossless_seed_taylor_20261111.json` | `6C3EE4AE09014B64541899F276405C607624A5DABF70DFBA3AEE5EF654E82C3F` |
| Frozen target `integration/lossless_modular_two_step_20261111.json` | `31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE` |
| Prior `mellin/REVIEW_LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md` | `46BDD3D1CA0AD8C730A693AC4CFA7F5D55C3043EDBF4180B82C939C5BC18B697` |
| Independent `mellin/review_lossless_seed_taylor_20261111.py` | `EFA97B95FAD365A0C913606F1DE9BDA9ADC04DE0086CAC2DAD096354C76187C2` |
| Independent `mellin/review_lossless_seed_taylor_20261111.json` | `01048A1E135FD596CB84277C18FFF2C9D322E2BC082EFD90A1CE10356BCE9A11` |

The independent script imports only Python standard-library modules, not the producer or a numerical library. Its complete run exits zero. It verifies all five input artifact hashes, two source hashes, all fourteen positive terms, both partial sums in each channel, exact widths, exact containment margins and the frozen seed's center/radius/endpoint identities. No frozen file was modified.

## Analytic derivation and normalization

The prescribed seed is exactly

`tau = -cos(x) + i*sin(x)`, `x=2/1000001`.

For parity `a=0,1`, set `f_a(k)=x^(2k+a)/(2k+a)!`. All terms are positive. For every natural k,

`f_a(k+1)/f_a(k) = x^2/((2k+a+1)(2k+a+2)) <= x^2/((a+1)(a+2)) = q_a < 1`.

This is an all-k argument: both denominator factors increase and are positive. It implies antitonicity and the bound `f_a(k)<=f_a(0)*q_a^k`, hence convergence to zero and absolute summability. The finite term checks are not used as a substitute for this argument.

The actual cosine and sine series identify the alternating sums. Writing `P_a(N)=sum_{k<N}(-1)^k*f_a(k)`, even six terms give a lower bound and odd seven terms give an upper bound:

`P_0(6)<=cos(x)<=P_0(7)`, `P_1(6)<=sin(x)<=P_1(7)`.

The exact width in each case is `f_a(6)>0`. Thus the two-sided enclosure itself controls the entire omitted tail; no numerical tail truncation is assumed. The cosine degrees are 10/12 and the sine degrees are 11/13. Negating cosine reverses its endpoints, giving real interval `[-P_0(7),-P_0(6)]`, while the imaginary interval is `[P_1(6),P_1(7)]`. The producer and independent checker both use this reversal.

The Mathlib source was checked at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`:

- `Mathlib/Analysis/SpecialFunctions/Trigonometric/Series.lean:100,105`: `Real.hasSum_cos` and `Real.hasSum_sin`, with precisely the powers and factorials above. File SHA256 `1C8457816ED5E9D72967890E7C25EECE5A5FF2D9B90248B768E060993ADFC9FF`.
- `Mathlib/Analysis/SpecificLimits/Normed.lean:1007,1021`: `Antitone.alternating_series_le_tendsto` and `Antitone.tendsto_le_alternating_series`, providing the even lower and odd upper partial sums. File SHA256 `29AA06CCC31F1BFD454DBF888C108F4C3FBE8AA5A9AEDE4F95D3D7473C03EE70`.

The HasSum-to-finite-range convergence adapter and finite rational evaluation still require Lean implementation. No Lean elaboration or kernel check was run here.

## Independent arithmetic and strict containment

To avoid duplicating the producer recurrence as the sole computation, the independent checker constructs each channel over common denominator `(12+a)! * 1000001^(12+a)`. Each numerator is formed by exact integer division for the corresponding factorial and power, then cross-checked against the direct rational term. It reconstructs the sums and checks them against the receipt. The argument, T=1000000, r=0, node ID `tau`, exact expression string and target hash are all fixed and checked.

The resulting enclosure lies strictly inside the existing lossless seed box. Exact lower bounds for the four clearances are:

| Clearance | Strict lower bound |
|---|---:|
| Real lower | `2^-258` |
| Real upper | `2^-257` |
| Imaginary lower | `2^-273` |
| Imaginary upper | `2^-276` |

All inequalities use integer/rational arithmetic. They involve no numerical sine, cosine, pi, exponential, Gamma, zeta or Arb oracle. The author's eight corruption controls are appropriate bounded controls; they are not a general security or resource-bound guarantee for an arbitrary certificate verifier.

## Composition and remaining scope

Together with the prior independent two-step review, this establishes a paper/exact-external route from the actual prescribed tau to its translated value, reciprocal S output, principal square-root formula and A multiplier through the sixteen checked arithmetic gates and six domain checks. The original packet's label saying the seed was unproved remains unchanged; this pinned supplement is the new justification.

The result applies only to the fixed seed and local graph. It does not repair or erase the older compact endpoint-replay failures, establish later reduction steps, or certify theta sums, derivative unwinding, Fourier evaluation, contour coverage or any zero count. Kernel-level rational replay, source-series adapters, graph soundness, reciprocal extrema and square-root identification remain implementation obligations. There is no additional mathematical seed assumption left in this bounded paper argument.
