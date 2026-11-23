/-
Copyright 2026 Charlie Reams. Apache-2.0.
Extracted from calr3/ternary-goldbach at 23b2d68ca344203d4384e0aff7affa4ec034bef9.
Only the large-range declarations are included. See prepare.py.
-/
import TernaryGoldbach.Helfgott.Decay
import TernaryGoldbach.Helfgott.Numerics
import TernaryGoldbach.Helfgott.NonPrime
import TernaryGoldbach.Helfgott.SupNorms
import TernaryGoldbach.Helfgott.Chebyshev

open Complex MeasureTheory ArithmeticFunction

namespace TernaryGoldbach.Helfgott

/-- **Circle method identity** [H, (10.3), (14.50)].  The sums `S_{η₊}`, `S_{η_*}` converge
absolutely because `η₊` and `η_*` decay rapidly (`TernaryGoldbach.Helfgott.Decay`), and the
integral over `[0, 1]` picks out the representations of `N` (`circle_identity_tsum`).

*Proved.* -/
theorem circle_identity_input (N : ℕ) (hN : 0 < N) :
    IntegrableOn (integrand N) (Set.Ioc 0 1) ∧
      ∫ α in Set.Ioc (0:ℝ) 1, integrand N α = (repSum (fun _ => True) N : ℂ) := by
  have hx : 0 < xOf N := div_pos (by exact_mod_cast hN) xOf_denom_bounds.1
  have h := circle_identity_tsum N (summable_etaPlus hx) (summable_etaPlus hx)
    (summable_etaStar hx)
  have hfun : integrand N = fun α =>
      expTsum (fun n => ((Λ n * etaPlus (n / xOf N) : ℝ) : ℂ)) α *
        expTsum (fun n => ((Λ n * etaPlus (n / xOf N) : ℝ) : ℂ)) α *
        expTsum (fun n => ((Λ n * etaStar (n / xOf N) : ℝ) : ℂ)) α * e (-(N * α)) := by
    funext α; simp only [integrand, S, expTsum, sq]
  rw [hfun]
  refine ⟨h.1, h.2.trans ?_⟩
  simp only [repSum, and_true, Complex.ofReal_sum, apply_ite (fun r : ℝ => (r : ℂ)),
    Complex.ofReal_zero, Complex.ofReal_mul]
  refine Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
    Finset.sum_congr rfl fun _ _ => ?_
  split_ifs <;> ring

/-- **Non-prime and even terms**, a weaker form of [H, (14.51)]: the terms where some `nᵢ` is
even or not prime contribute at most `6.7 · 10⁶ · N^{3/2} log N`.

[H] gets the constant `7.3306` from the sharp sup norms `|η₊|_∞ ≤ 1.079955`,
`|η_*|_∞ ≤ 1.414` and the Rosser–Schoenfeld bounds `ψ(x) < 1.03883 x`,
`ψ(x) - θ(x) < 1.4262 √x`.  We use the easy bounds `|η₊| ≤ 400`, `|η_*| ≤ 6.2`
(`Helfgott/SupNorms.lean`) and the elementary `ψ(N) ≤ 1.387 N`, `ψ(N) - θ(N) ≤ 1.6 √N`
(`Helfgott/Chebyshev.lean`) instead; the final inequality still has room
(`final_inequality_crude`).

*Proved.* -/
theorem nonprime_input (N : ℕ) (hN27 : 10 ^ 27 ≤ N) :
    repSum (fun _ => True) N - repSum (fun n => n.Prime ∧ Odd n) N ≤
      6.7e6 * (N * √N) * Real.log N := by
  have hN : 1 ≤ N := le_trans (by norm_num) hN27
  have h := repSum_sub_le_of_bounds hN (fun t ht => abs_etaPlus_le_400 ht)
    (fun t _ => abs_etaStar_le_const t)
  have hpsi := psi_le N hN27
  have hpt := psi_sub_theta_le N hN27
  have hNr : (10 : ℝ) ^ 27 ≤ N := by exact_mod_cast hN27
  have hsq : (10 : ℝ) ^ 13 ≤ √N := Real.le_sqrt_of_sq_le (by nlinarith)
  have hlog2 : Real.log 2 ≤ 0.0001 * √N := by
    have := Real.log_two_lt_d9; nlinarith
  have hlogN : 0 ≤ Real.log N := Real.log_nonneg (by exact_mod_cast hN)
  have hbad0 : 0 ≤ psi N - theta N + Real.log 2 :=
    (Finset.sum_nonneg fun n _ => ΛBad_nonneg n).trans (sum_ΛBad_le N)
  have hpsi0 : 0 ≤ psi N := Finset.sum_nonneg fun n _ => vonMangoldt_nonneg
  have hs0 : 0 ≤ √(N : ℝ) := Real.sqrt_nonneg _
  calc repSum (fun _ => True) N - repSum (fun n => n.Prime ∧ Odd n) N
      ≤ 3 * (400 ^ 2 * 6.2) * Real.log N * (psi N - theta N + Real.log 2) * psi N := h
    _ ≤ 3 * (400 ^ 2 * 6.2) * Real.log N * (1.6001 * √N) * (1.387 * N) := by
        gcongr; linarith
    _ = (3 * (400 ^ 2 * 6.2) * 1.6001 * 1.387) * (N * √N) * Real.log N := by ring
    _ ≤ 6.7e6 * (N * √N) * Real.log N := by gcongr; norm_num

end TernaryGoldbach.Helfgott
