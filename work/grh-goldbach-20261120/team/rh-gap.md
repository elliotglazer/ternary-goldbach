# Prime gaps for the existing ternary theorem at 10²⁷

At `calr3/ternary-goldbach` commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, localizing the Gaussian smoothing to the prime interval gives a candidate binary endpoint **B = 4,000,000,000,000,000**. Lean has checked the Mellin norm estimate, the shifted integral, the 5.5 density arithmetic and the 98.977√x finite-sum bound with arbitrary natural zero multiplicities. The actual full-RH Weil import and the complete prime-interval theorem remain open. [Local-window code and receipts](./local-window/README.md)

The earlier route applied the repository's existing numerical coefficients to two separate ψ estimates and gave B = 11,000,000,000,000,000. Both routes use the same full-RH improvement to the Weil window.

## Remove the height cap

In `Explicit/WeilWindow.lean` the full RH proof changes one estimate. The old `weil_windowH` proof bounds the possible negative contribution of zeros above H by calling `off_line_leH` at line 323. Under RH each real part in that sum is nonnegative. The proposed first lemma, using the existing namespace and imports, is

```lean
theorem WH_re_nonneg_of_fullRH (hAll : ∀ H : ℝ, RHBelow H)
    (ℓ : ℝ) (m : ℕ) (T₀ : ℝ) {T : ℝ} {u : ℂ} (hu : u ∈ rectZerosXi T) :
    0 ≤ (WH ℓ m T₀ u).re :=
  WH_re_nonneg_of_line ℓ m T₀
    (re_eq_half_of_mem_rectZerosXiH (hAll |u.im|) hu le_rfl)
```

The binder `hAll` is supplied by the ordinary RH export, after excluding trivial zeros and the pole using the already stated critical-strip inequalities. In a variant of `weil_windowH`, keep its conclusion and the low-height inclusion argument through line 322. Use `hAll H` for the low-height zeros. For each high zero use the displayed lemma, multiply by the nonnegative multiplicity, and apply `Finset.sum_nonneg`. Since `OffC ℓ m ≥ 0`, this proves the same lower bound on the discarded part and the existing numerical constants still apply. The proof of the general Weil formula already takes arbitrary window center.

Pass the new window estimate through `weil_weightedH` in `WeilWeights`, `line_sum_weilH` and `line_sum_weil_allH` in `WeilLineSum`, the corresponding numeric lemmas in `WeilNumB/C`, and the Gaussian prime sum theorem in `PsiWeil`. Preserve the original bounded RH versions for existing callers. In these proofs the high cutoff is forwarded to the window theorem. There is a separate numerical cutoff in `PsiRange.LWH_le`. Recalculate that scalar bound at the new height as described below. The independent Gaussian tail bound `tail_sum_gauss` in `ZetaZeroSums` requires H > 0. [Weil window proof](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/WeilWindow.lean#L259) · [Numerical line estimate](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/WeilNumC.lean#L540) · [Psi bounds](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/PsiWeil.lean#L102).

## Uniform numerical obligations

Use δ = 4·10⁻¹⁴, K = 8.4, H = 5·10¹⁴, Y₁ = 2·10¹⁴ and y₀ = 10¹⁰. For 10¹⁶ ≤ x ≤ 10²⁷ take a = ±Kδ and b = log(y₀/x). Then b ≤ a ≤ Kδ, 3/Y₁ ≤ δ ≤ 1/208, Y₁ + 13 ≤ H/2 and √(y₀/x) ≤ 0.001. The two sandwich conditions on b or y₀ follow from y₀ exp(Kδ) ≤ 10¹⁶. Positive parameters and K ≥ δ satisfy the remaining domain conditions.

| Item to certify | Numerical bound and argument |
|---|---|
| LWH(H) | < 3000. Reuse `PsiPlateau.window_sum_le`'s symbolic harmonic-sum proof with log k ≤ 33 for k = floor(H/6). The upper bound is 2·[2·39.15/1.0906 + (30.17·34 + 5·33² + 10 + 2·25.17)/(6·1.0906)] < 2140. No enumeration up to H/6. |
| JW(δ) | < 150. The formula in `WeilNumC` gives approximately 149.965899. Bound log(1/δ) from both sides, or use monotonicity of its quadratic. |
| LineWH(a,b,δ,Y₁,H) | < 150.2. Multiply JW(δ) + 3000 exp(-32) by exp(δ²/8)(exp(a/2) + √(y₀/x)). |
| TailBH(a,δ,H) | < 10⁻⁷⁰. In the formula `PsiExplicit.TailBH`, EBg < 3 exp(-200)/H, Z3g < 400, c3g < 10⁻¹³ and 1/(1-rhoG) < 6·10¹¹. For the last inequality use 1−exp(−z) ≥ z/(1+z) with z = 3.52·10⁻¹². |
| x⁻¹ᐟ² Vg/(2π) | < 10¹¹. `PsiRange.Vc_le` bounds the coefficient by 253.3. After combining the exponentials with x⁻¹ᐟ², the remaining factor is exp(δ²/8)[exp(−a/2)/√x + 1/√y₀]/δ. |
| Errors for ψ | Each < 5.13·10¹⁵. Use E ≤ 150.2√(10²⁷) + 10¹¹ + 1 in `psi_upper_of_err` and `psi_lower_of_err`. For the upper bound use exp(δ²/2+Kδ)−1 < 3.37·10⁻¹³ and exp(−K²/2) < 4.8·10⁻¹⁶, retaining the denominator 1−2 exp(−K²/2). For the lower bound use 1−exp(−Kδ) ≤ Kδ and include both 2y₀ and 4x exp(−K²/2). |
| Prime powers | ψ(x)−θ(x) < 17√x for x ≥ 10¹⁶. Mathlib's proof of `Chebyshev.psi_sub_theta_le_mul_sqrt` exhibits 3(log 4 + 4) by combining its Costa Pereira inequality with `psi_le_const_mul_self`. Extract those three proof lines into an explicit-constant lemma and identify the repository's `psiR` with Mathlib ψ at natural endpoints. The repository's 1.6√x lemma requires n ≥ 10²⁷, which excludes the required endpoints. |

For an odd n > 2.1·10¹⁶ up to 10²⁷, evaluate ψ at n−B and n−4. Both lie in the checked numerical range. Their difference exceeds B−4−2·5.13·10¹⁵. At the upper endpoint remove at most 17√(10²⁷) of prime powers. At the lower endpoint use θ ≤ ψ. The resulting strict increase of θ gives a prime p in (n−B,n−4], hence an even remainder in [4,B]. For n ≤ B+3 choose p=3. For B+3 < n ≤ 2.1·10¹⁶, Bertrand at floor((n−4)/2) suffices since the remainder is at most (n+5)/2 < B. All thresholds fit with a numerical margin exceeding 2·10¹⁴. Units in this table are natural logarithms and absolute errors. This proposes a verification target, with no new zero count as a separate hypothesis.

## Other source candidates

The pinned PNT+ Büthe theta bound ends in `by sorry` at `TMEEMT.lean:173`. The file also has open proofs for three RH short-interval theorems at lines 1493, 1507 and 1523. The old online Carneiro shortcut used a 2002 inequality that omitted a log factor. The checkout's 2002 statement includes that factor. The actual Carneiro–Milinovich–Soundararajan Theorem 5 uses a closed forward interval, and its proof covers x ≤ 4·10¹⁸ by citing the computed prime-gap record. [Published theorem and finite-range input](https://home.olemiss.edu/~mbmilino/PrimeGaps.pdf) · [Büthe](https://arxiv.org/abs/1410.7015).

Hubbard's standalone Dudek entry already formalizes the prime-gap proof conditional on `HSWN70 gZ` and RH. Here `gZ` indexes each strip zero with its analytic multiplicity. The condition counts every finite subset below |γ| ≤ T and every finite subset in T < |γ| ≤ t, for 70 ≤ T ≤ t. Its envelope is M(T) = T log(T/(2πe))/(2π) + 7/8, R(T) = 0.1038 log T + 0.2573 log log T + 10.2425. The one-sided positive-ordinate HSW result can supply both bounds via conjugation, multiplicity and exclusion of real zeros, subject to a checked counting bridge and a proof of the source theorem. In the pinned PNT+ checkout, `ZetaSummary.lean:29` and `TMEEMT.lean`'s HSW2022 bounds contain `sorry`. The existing cde-moebius Jensen window estimates do not supply the required nearly sharp main term. With the HSW input discharged, Dudek would allow B = 2.51·10¹⁵. [Dudek entry](https://github.com/sthubbar/goldbach-lean/blob/f003a97d7598923787920723668d62c16c82b81e/entries/dudek2014/LeanLab/Dudek2014/SigmaHSW.lean#L40) · [Hasanalizade, Shen and Wong](https://arxiv.org/abs/2107.06506) · [Dudek's paper](https://arxiv.org/abs/1402.6417).

## Localizing to the prime interval

The same full-RH window suggests a lower binary cutoff **B = 4,000,000,000,000,000**. This paper calculation adds two estimates to the Lean work, for Gaussian mass outside the prime interval and for the line sum with a modified weight. The displayed decimals are numerical screens to certify. An improvement from B = 1.1·10¹⁶ to B = 4·10¹⁵ would divide the length of the binary verification by 2.75. The core-hours saved depend on the checker.

For 10¹⁵ ≤ x = n−4 ≤ 10²⁷ write v = √x. Take w = 101/v, δ = 2.8/v, K = 4.5, a = −Kδ and b = a−w. The unsmoothed target is J = (x exp(b−Kδ), x]. Its length is at most (101 + 2·4.5·2.8)v = 126.2v. In particular the lower endpoint exceeds n−B, since 126.2√(10²⁷) + 4 < 3.991·10¹⁵. The explicit-formula main term exceeds 100.9996v by exp(a) − exp(b) ≥ w exp(b) and v ≥ √(10¹⁵).

On the critical line put s = 1/2 + iγ. The exact Mellin formula is a Gaussian factor times the integral of exp(sw) over the log interval. The norm of that integral is at most the interval length because a ≤ 0. Its endpoint formula also bounds it by 2/|γ|. Thus

`‖Mg a b δ s‖ ≤ exp(δ²/8) exp(−δ²γ²/2) · 2/max(|γ|, 2/w).` At γ = 0 the reciprocal factor equals w.

Use the continuous nonnegative weight g(t) = exp(−δ² max(t,0)²/2)·2/max(t,2/w) in the full-RH version of `weil_weightedH`. Its argument in the integral is max(0, |t|−13). Window positivity applies to the repo's real unphased Weil transform. The oscillatory Mellin factor above is bounded in *norm* separately. [Mellin integral](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/GaussSmooth.lean#L216) · [Endpoint norm bound](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/WeilLineSum.lean#L20) · [Generic weight](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/WeilWeights.lean#L45).

Keep Y = 2·10¹⁴ and H = 5·10¹⁴. For |t| ≤ Y+13 the existing `PhiUp_div_le`, `PsiB_le_PsiG` and numeric constants bound the window density by 0.24567 + 0.16385 log(Y+26) − 0.23516 + smallT(13) < 5.5. Use symmetry, shift by 13 and bound the shifted integral on [0, 2/w], [2/w, 1/δ] and [1/δ, ∞]. These parts contribute at most 2, 2 log(w/(2δ)) and 2 exp(−1/2), respectively. For the last inequality change variables to t = δu and use 1/t ≤ t for t ≥ 1. Including the strip |t| ≤ 13, the resulting line coefficient is at most

`exp(δ²/8) · 2 · 5.5 · [13w + 2 + 2 log(101/5.6) + 2 exp(−1/2)] < 98.977.`

The existing middle-height estimate adds at most 2 exp(δ²/8)·3000 exp(−156.8). The high tail is smaller than the bound in the previous section, by δ ≥ 2.8/√(10²⁷) > 4·10⁻¹⁴, δ ≤ 10⁻⁷, |a| ≤ 10⁻⁶ and the formula for `TailBH`. The vertical integral contributes < 255 **absolute**, by `Vc_le` and δv = 2.8. [Window density](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/WeilNumB.lean#L56) · [Numerical constants](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/WeilNumC.lean#L148) · [Middle band](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/WeilLineSum.lean#L110).

For the smoothing error, express the weight as the average over a standard normal Z of the indicator of (x exp(b−δZ), x exp(a−δZ)]. For |Z| ≤ K this interval is contained in J. For the remainder, the shifted interval contains at most (x w exp(δ|Z|) + 1) integers, and each positive integer it contains has von Mangoldt weight at most 63 exp(δ|Z|), since log x < 63. The zero index has zero weight. Completing the square on each tail, or using the normal moment generating function and Chernoff, bounds the contribution outside J by

`126(xw+1) exp(2δ²) exp(−(K−2δ)²/2) < 0.511v.`

The finite-sum-under-the-integral proof in `sandwich_lower` already supplies the required exchange pattern, and `integral_gpdf_mul_exp` supplies the Gaussian moments. The two buffered log endpoints are essential to this estimate. One can equivalently set a = 0 after changing the base point to x exp(−Kδ). A Gaussian attached directly to the hard unshifted endpoints leaks beyond each one. [Gaussian sandwich](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/PsiSandwich.lean#L242).

The prime powers can be bounded inside J using integers alone. For any k ≥ 2 and positive bases u < t with uᵏ, tᵏ in J, one has tᵏ−uᵏ ≥ (t−u)·u^(k−1) ≥ (t−u)√(inf J). Since √(inf J) > 0.99v and |J| ≤ 126.2v, at most 130 integer bases qualify per exponent. Every genuine prime power has k ≤ 90 because x ≤ 10²⁷ < 2⁹⁰. With log x < 63 and `gsm_le_one`, all interior powers of exponent ≥ 2 contribute at most 130·90·63 < 0.024v. This keeps the integer endpoint terms and avoids an identification with Mathlib's Chebyshev functions.

Together the estimates leave more than 1.48v for weighted primes in J. The summand vanishes off prime powers, so a positive remainder produces an actual prime in J. For n below the analytic range one has n ≤ 10¹⁵ + 4 < B and p = 3 suffices for each odd n ≥ 7. In the analytic range any prime in J is odd, and the complement lies in [4, B].
