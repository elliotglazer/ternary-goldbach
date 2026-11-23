import Mathlib.NumberTheory.Chebyshev
import Mathlib.NumberTheory.Bertrand
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Push
import Mathlib.Tactic.Ring

/-!
Elementary and numerical parts of the GRH-based finite reduction.

The numerical cutoff is the one in Deshouillers, Effinger, te Riele and
Zinoviev (1997), section 3. Schoenfeld's RH estimate is NOT proved here.
The lemmas below concern theta, real inequalities, and Bertrand's theorem.
-/

namespace GrhGoldbach

/-- Strict increase of theta supplies a prime, with the indicated endpoints. -/
theorem exists_prime_of_theta_lt {a b : ℕ}
    (h : Chebyshev.theta a < Chebyshev.theta b) :
    ∃ p : ℕ, p.Prime ∧ a < p ∧ p ≤ b := by
  classical
  by_contra hn
  push Not at hn
  have hs : Nat.primesLE b ⊆ Nat.primesLE a := by
    intro p hp
    have hp' := Nat.mem_primesLE.mp hp
    exact Nat.mem_primesLE.mpr ⟨by
      by_contra hpa
      have hpb := hn p hp'.2 (by omega)
      omega, hp'.2⟩
  have hle : Chebyshev.theta b ≤ Chebyshev.theta a := by
    rw [Chebyshev.theta_eq_sum_primesLE_log, Chebyshev.theta_eq_sum_primesLE_log]
    exact Finset.sum_le_sum_of_subset_of_nonneg hs
      (fun p _ _ => Real.log_natCast_nonneg p)
  exact (not_lt_of_ge hle) h

/-- Two pointwise error estimates suffice; there is no zero-location premise here. -/
theorem exists_prime_of_theta_error {a b : ℕ} {E : ℝ}
    (ha : |Chebyshev.theta a - a| < E)
    (hb : |Chebyshev.theta b - b| < E)
    (hab : 2 * E ≤ (b : ℝ) - a) :
    ∃ p : ℕ, p.Prime ∧ a < p ∧ p ≤ b := by
  apply exists_prime_of_theta_lt
  have ha' := (abs_lt.mp ha).2
  have hb' := (abs_lt.mp hb).1
  linarith only [ha', hb', hab]

/-- A coarse logarithm bound is sufficient for the published gap constant. -/
theorem log_ten_lt_2303 : Real.log 10 < 2303 / 1000 := by
  rw [Real.log_ten_eq]
  linarith only [Real.log_two_lt_d9, Real.log_five_lt_d9]

theorem log_le_2303_div_50 {x : ℝ} (hx : 1 ≤ x) (hX : x ≤ 10 ^ 20) :
    Real.log x ≤ 2303 / 50 := by
  have h := Real.log_le_log (by linarith only [hx]) hX
  rw [Real.log_pow] at h
  norm_num only [Nat.cast_ofNat] at h
  linarith only [h, log_ten_lt_2303]

/-- Uniform numerical majorant for the right side of Schoenfeld (6.1).
The spare margin is retained explicitly for the four-unit endpoint shift. -/
theorem schoenfeld_expression_lt {x : ℝ} (hx : 2300000000 ≤ x)
    (hX : x ≤ 10 ^ 20) :
    (1 / (8 * Real.pi)) * Real.sqrt x * (Real.log x - 2) * Real.log x <
      (1615000000000 - 4 : ℝ) / 2 := by
  have hx1 : 1 ≤ x := by linarith only [hx]
  have hl0 : 0 ≤ Real.log x := Real.log_nonneg hx1
  have hl := log_le_2303_div_50 hx1 hX
  have hs : Real.sqrt x ≤ 10 ^ 10 := by
    apply (Real.sqrt_le_iff).2
    constructor
    · positivity
    · norm_num at hX ⊢
      exact hX
  have hs0 := Real.sqrt_nonneg x
  have hpi : 0 < 8 * Real.pi := by positivity
  have hprod : (Real.log x - 2) * Real.log x ≤
      (2303 / 50 - 2 : ℝ) * (2303 / 50) := by
    by_cases hsmall : Real.log x ≤ 2
    · have hnonpos : (Real.log x - 2) * Real.log x ≤ 0 :=
        mul_nonpos_of_nonpos_of_nonneg (by linarith only [hsmall]) hl0
      linarith only [hnonpos]
    · apply mul_le_mul (by linarith only [hl]) hl hl0
      norm_num
  have hnum : Real.sqrt x * ((Real.log x - 2) * Real.log x) ≤
      (10 ^ 10 : ℝ) * ((2303 / 50 - 2) * (2303 / 50)) := by
    calc
      _ ≤ Real.sqrt x * ((2303 / 50 - 2) * (2303 / 50)) :=
        mul_le_mul_of_nonneg_left hprod hs0
      _ ≤ _ := mul_le_mul_of_nonneg_right hs (by norm_num)
  have hnum' : Real.sqrt x * ((Real.log x - 2) * Real.log x) <
      ((1615000000000 - 4 : ℝ) / 2) * (8 * Real.pi) := by
    nlinarith only [hnum, Real.pi_gt_d4]
  have hdiv := (div_lt_iff₀ hpi).2 hnum'
  convert hdiv using 1
  ring

/-- Bertrand covers the transition where the lower theta endpoint would be too small. -/
theorem exists_prime_small_remainder {n : ℕ}
    (hlo : 1615000000000 + 3 < n) (hhi : n ≤ 2000000000000) :
    ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ 4 ≤ n - p ∧ n - p ≤ 1615000000000 := by
  obtain ⟨p, hp, hp₁, hp₂⟩ := Nat.bertrand ((n - 4) / 2) (by omega)
  exact ⟨p, hp, by omega, by omega, by omega⟩

end GrhGoldbach
