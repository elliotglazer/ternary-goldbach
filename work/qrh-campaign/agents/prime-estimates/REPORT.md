# Prime-estimate QRH investigation

Pinned source is calr3/ternary-goldbach at 23b2d68ca344203d4384e0aff7affa4ec034bef9. All references below are relative to TernaryGoldbach/. Scratch files do not alter the pinned source.

## Actual proof work

The final draft declaration is `Explicit.psi_asymp_qrh` in `QrhPsi.lean`.

```lean
theorem psi_asymp_qrh {x : ℝ} (hx : Real.exp 35000 ≤ x) :
    |psiR x - x| ≤ 0.2 * x / Real.log x ^ 3
```

This has the same mathematical statement as `Explicit/PsiAsymp.lean:632`'s `psi_asymp8`, with the Platt instance removed. Compilation and axiom checks for the full theorem remain pending. Both numerical lemmas in QrhPsiNumeric.lean compiled successfully with Lean v4.35.0 and matched Mathlib artifacts. Their printed types are exact and their only axioms are propext, Classical.choice and Quot.sound. The checked source SHA256 is 600B3F9F7E1CD2FF568EF4FCE268D02B44357F4D8C1FC00BA2BDC5F4A003CE7B. The file contains proof terms without `sorry` or axioms. The actual QRH theorem is imported by `QrhZetaBridge.lean`, whose upper-strip input is `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re`. Xi reflection proves the lower bound 1/8 on the real part of each nontrivial zero.

The components are as follows.

- `QrhPsiAux.lean` bounds the Gaussian Mellin transform by `norm(Mg) * max(1/8, abs(im)) <= 2 exp(delta^2/2 + abs(a))` throughout the closed strip [1/8, 7/8].
- The zero-sum worker's `ZeroSumStrip.lean` bounds the weighted sum below height 1e8 by 1e20 times this pointwise weight. This constant is deliberately coarse and applies only to the far-asymptotic proof.
- `QrhPsi.lean` adapts the existing `SsumG_gsm_err_zf3H` proof. Its low-zero contribution is at most `1e24 * x^(7/8)`. The three existing middle ranges and the Gaussian tail retain their original estimates.
- `QrhPsiNumeric.lean` proves `1e24 exp(7L/8) <= 5e-5 exp(L)/L^3` for L >= 35000, and its x-form corollary. Its proof uses the degree-16 term of the exponential series. The required constant inequality is `2e28 * 16! * 8^16 <= 35000^13`.
- `QrhPsiMid.lean` strengthens `MidB0_8_asymp_le` to `5e-5/log^3 x` by retaining its proof and tightening only the final, highly slack numerical comparison.
- The existing `psi_asymp_of` helper then receives its unchanged 1e-4/log^3 budget, split equally between low zeros and the first middle range.

No finite-height critical-line assertion follows from this proof. The argument uses the QRH strip throughout the low-zero contribution.

## Existing range obligations

| Estimate | Range | Current source and constants |
|---|---|---|
| Small psi table | 12 <= n < 1e6 | `Prelim/PsiTwoSided.lean:97`, direct `SmallTab.small_table` branch, abs(psi-n) <= sqrt(n) |
| Unconditional theta sieve | 1e6 <= t < 1e9 | `Prelim/PsiSieveMain.lean:28160`, theta <= t + .1 sqrt(t), t - theta <= 2 sqrt(t) |
| Existing psi envelope | 1e6 <= x <= 1e17 | `Explicit/PsiRanges1e8.lean`, RHBelow 1e8 through `rh_upto_1e8` |
| Theta middle range | 1e12 <= n <= 1e17 | `Prelim/ThetaExplicit.lean:387`, abs(theta-n) < n/log^3(n) |
| Psi plateau | x >= 1e17 | `Explicit/PsiPlateau1e8.lean:120`, abs(psi-x) <= 4.91e-7 x + 1145 sqrt(x) + 4.2e10 |
| Psi large fixed error | x >= exp(20000) | `Explicit/PsiRange1.lean`, abs(psi-x) <= 2.1e-14 x |
| Psi far asymptotic | x >= exp(35000) | `Explicit/PsiAsymp.lean:632`, abs(psi-x) <= .2 x/log^3(x) |
| Theta global consumer | n >= 1e12 | `Prelim/ThetaExplicit.lean:512`, abs(theta-n) < n/log^3(n) + epl(n)n |
| Theta plateau definition | 120 < log(x) < 20000 | `Prelim/ThetaExplicit.lean:27`, epl(x)=4.92e-7, otherwise zero |
| Elementary psi upper bound | x >= 0 | `Explicit/PsiSandwich.lean:90`, psi(x) <= 4x, unconditional |
| Elementary prime powers | n >= 2 | `Prelim/ThetaExplicit.lean:45`, psi(n)-theta(n) <= 2.001 log(n) sqrt(n), unconditional |

The dependency at q=1 enters directly at `Explicit/ZetaZeroSums.lean:29`, where `rh_upto_1e8` converts PlattGRH to RHBelow 1e8. The unconditional zero-free region above height 1e8 remains available and is sufficient for the high-zero part of the draft.

The middle psi constants consumed by `Prelim/PsiTwoSided.lean` include 33 through 1e8, 72 through 1e15, and 200 through 1e17. Finer consumers use 31.5 on (1e7, 1e8], 35.5 through 3.2e10, 42.82 on (3.2e11, 3.2e12], and 45.08 on (3.2e11, 1e13].

The generated half-decade cW8 constants, in ascending intervals from [1e6,3.2e6] to [3.2e16,1e17], are 32.84, 31.88, 31.48, 31.35, 31.66, 32.16, 33.06, 34.1, 35.44, 36.94, 38.72, 40.61, 42.82, 45.08, 47.58, 50.27, 54.89, 61.38, 73.3, 94.25, 132.5, 199.0.

## Mertens consumers

`Prelim/MertensProduct.lean:2258` needs the exact final inequality

q/phi(q) < exp(gamma) log(log r) + 2.50637/log(log r),

for q >= 1, r >= 3, q <= r. Its prime-product proof has a kernel branch for prime x <= 1e5, seven numerical bins for 1e5 <= x < 1e12, and the large argument for x >= 1e12.

The seven bins use `E2_le_bin`, endpoint theta estimates and the psi envelope `cE`, which equals 1 below 1e6, 5 below 5e7, 31.5 through 1e8, 35.5 through 3.2e10 and 72 through 1e15. Above 1e15 the error tail is bounded by .0002926. The E2 endpoint bound at 1e18 is .0000683. Thus improving only the theorem's large-x endpoint does not remove the old psi dependency from these bins.

For x >= 1e12, the proof uses the E1 variation bound

D(x) = 1443/sqrt(x) + 13/x + 16/log^3(x) + 8.5e-6

when log(x)<20000, replacing the last term by 2/log^2(x) above that threshold. `E1_win_num` derives this by integrating the Gaussian window [1,e^2] with delta=8e-8, low zeros through 1e8 and local endpoint theta estimates. It requires a separate QRH rewrite. The current psi far-asymptotic draft by itself does not discharge that Mertens window obligation.

## Quantitative limitation of a generic QRH bound

If a later proof yields abs(psi(x)-x) <= C x^(7/8) log^2(x), then the existing Moebius input `.00985 x/log(x)` requires

C exp(-L/8) L^3 <= .00985.

The theta target x/log^3(x) requires, before adding prime powers,

C exp(-L/8) L^5 <= 1.

The following floating-point crossings are diagnostics, not certified inequalities and not established values of C.

| Hypothetical C | Moebius crossing log(x) | Moebius crossing log10(x) | Theta crossing log(x) | Theta crossing log10(x) |
|---|---:|---:|---:|---:|
| 1 | 158.548 | 68.857 | 214.786 | 93.280 |
| 10 | 180.016 | 78.180 | 237.173 | 103.003 |
| 100 | 201.094 | 87.334 | 259.135 | 112.541 |
| 1000 | 221.875 | 96.360 | 280.762 | 121.934 |

Even the optimistic C=1 experiment leaves a large interval after the existing tables. This is a limitation of that proposed estimate and the current proof architecture. It is not a proof that all QRH-based approaches need a finite verification of that size. More cancellation, sharper unsmoothing, direct bounds on the arithmetic consumer, or additional finite certificates could change it.


