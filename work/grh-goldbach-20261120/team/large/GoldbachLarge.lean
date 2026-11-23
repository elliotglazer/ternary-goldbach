/-
Copyright 2026 Charlie Reams. Apache-2.0.
Extracted from calr3/ternary-goldbach at 23b2d68ca344203d4384e0aff7affa4ec034bef9.
Only the large-range declarations are included. See prepare.py.
-/
import TernaryGoldbach.Helfgott.Inputs
import TernaryGoldbach.Helfgott.Numerics

variable [Fact TernaryGoldbach.PlattGRH]

open Complex MeasureTheory ArithmeticFunction

namespace TernaryGoldbach.Helfgott

/-- Steps 1–2: the full weighted count is at least `(1.049 - 1.0376) x²/κ`. -/
theorem repSum_lower_bound (N : ℕ) (hN : Odd N) (hN27 : 10 ^ 27 ≤ N) :
    (1.049 - 1.0376) * xOf N ^ 2 / κ ≤ repSum (fun _ => True) N := by
  set M := majorArcs 8 r₀ (xOf N)
  obtain ⟨hint, hid⟩ := circle_identity_input N (by omega)
  have hsplit := integral_inter_add_sdiff (measurableSet_majorArcs 8 r₀ (xOf N)) hint
  have hmaj := major_arcs_input N hN hN27
  have hmin := minor_arcs_input N hN27
  -- The minor arc contribution is bounded by the integral of the norm.
  have hnorm : ‖∫ α in Set.Ioc (0:ℝ) 1 \ M, integrand N α‖ ≤ 1.0376 * xOf N ^ 2 / κ := by
    refine (norm_integral_le_integral_norm _).trans (le_of_eq_of_le ?_ hmin)
    refine setIntegral_congr_fun (measurableSet_Ioc.diff (measurableSet_majorArcs _ _ _)) ?_
    intro α _
    simp only [integrand, norm_mul, norm_pow, norm_e, mul_one]
    ring
  have hre : repSum (fun _ => True) N =
      (∫ α in Set.Ioc (0:ℝ) 1 ∩ M, integrand N α).re +
        (∫ α in Set.Ioc (0:ℝ) 1 \ M, integrand N α).re := by
    rw [← Complex.add_re, hsplit, hid, ofReal_re]
  have := neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans hnorm)
  rw [hre]
  simp only [κ, M] at hmaj this ⊢
  linarith

open Classical in
omit [Fact TernaryGoldbach.PlattGRH] in
/-- Step 4: a nonzero count over a set of primes gives a representation. -/
theorem isSumOfThreePrimes_of_repSum_ne_zero {P : ℕ → Prop} (hP : ∀ n, P n → n.Prime)
    (N : ℕ) (h : repSum P N ≠ 0) : IsSumOfThreePrimes N := by
  unfold repSum at h
  obtain ⟨n₁, -, h⟩ := Finset.exists_ne_zero_of_sum_ne_zero h
  obtain ⟨n₂, -, h⟩ := Finset.exists_ne_zero_of_sum_ne_zero h
  obtain ⟨n₃, -, h⟩ := Finset.exists_ne_zero_of_sum_ne_zero h
  split_ifs at h with hc
  · exact ⟨n₁, n₂, n₃, hP _ hc.2.1, hP _ hc.2.2.1, hP _ hc.2.2.2, hc.1⟩
  · exact absurd rfl h

/-- **Helfgott's theorem for large `N`**: every odd `N ≥ 10²⁷` is a sum of three primes
(in fact of three odd primes). -/
theorem ternaryGoldbachFrom : TernaryGoldbachFrom (10 ^ 27) := by
  intro N hN hN27
  have h1 := repSum_lower_bound N hN hN27
  have h2 := nonprime_input N hN27
  have h3 := final_inequality_crude N hN27
  apply isSumOfThreePrimes_of_repSum_ne_zero (P := fun n => n.Prime ∧ Odd n) (fun n h => h.1)
  intro h0
  linarith

end TernaryGoldbach.Helfgott

namespace TernaryGoldbach

/-- **Helfgott's theorem for large `n`**: every odd `n ≥ 10²⁷` is a sum of three primes, given
Platt's GRH verification. -/
theorem ternary_goldbach_large_of_hypotheses (hGRH : PlattGRH) :
    TernaryGoldbachFrom (10 ^ 27) :=
  haveI := Fact.mk hGRH
  Helfgott.ternaryGoldbachFrom

end TernaryGoldbach
