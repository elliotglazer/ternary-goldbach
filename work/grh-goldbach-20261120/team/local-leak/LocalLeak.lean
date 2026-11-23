import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.NumberTheory.ArithmeticFunction.VonMangoldt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-! Elementary bounds for the Gaussian smoothing of a buffered log interval.
The strict lower and closed upper endpoints match the interval integral in
`TernaryGoldbach.Explicit.gsm`. -/

open Set
open scoped ArithmeticFunction.vonMangoldt

namespace GrhGoldbach.LocalLeak

theorem mem_log_window_iff {x p δ a b z : ℝ} (hx : 0 < x) (hp : 0 < p) (hd : 0 < δ) :
    z ∈ Ioc ((b - Real.log (p / x)) / δ) ((a - Real.log (p / x)) / δ) ↔
      p ∈ Ioc (x * Real.exp (b - δ * z)) (x * Real.exp (a - δ * z)) := by
  rw [mem_Ioc, mem_Ioc, div_lt_iff₀ hd, le_div_iff₀ hd]
  have hpx : 0 < p / x := div_pos hp hx
  have hlo : b - δ * z < Real.log (p / x) ↔ x * Real.exp (b - δ * z) < p := by
    rw [Real.lt_log_iff_exp_lt hpx, lt_div_iff₀ hx, mul_comm]
  have hhi : Real.log (p / x) ≤ a - δ * z ↔ p ≤ x * Real.exp (a - δ * z) := by
    rw [Real.log_le_iff_le_exp hpx, div_le_iff₀ hx, mul_comm]
  rw [← hlo, ← hhi, mul_comm δ z]
  constructor <;> rintro ⟨h₁, h₂⟩ <;> constructor <;> linarith

/-- Every shift of size at most K fits in the hard prime interval. -/
theorem buffered_window_subset {x δ K b z : ℝ} (hx : 0 ≤ x) (hd : 0 ≤ δ)
    (hz : |z| ≤ K) :
    Ioc (x * Real.exp (b - δ * z)) (x * Real.exp (-(K * δ) - δ * z)) ⊆
      Ioc (x * Real.exp (b - K * δ)) x := by
  rcases abs_le.mp hz with ⟨hz₁, hz₂⟩
  have h₁ := mul_le_mul_of_nonneg_left hz₂ hd
  have h₂ := mul_le_mul_of_nonneg_left hz₁ hd
  intro p hp
  refine ⟨lt_of_le_of_lt (mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr ?_) hx) hp.1,
    hp.2.trans (mul_le_of_le_one_right hx (Real.exp_le_one_iff.mpr ?_))⟩
  · linarith only [h₁]
  · linarith only [h₂]

/-- A real bound on the length of any shifted log interval. -/
theorem shifted_width_le {x a w δ z : ℝ} (hx : 0 ≤ x) (ha : a ≤ 0)
    (hw : 0 ≤ w) (hd : 0 ≤ δ) :
    x * Real.exp (a - δ * z) - x * Real.exp (a - w - δ * z) ≤
      x * w * Real.exp (δ * |z|) := by
  have he : Real.exp (a - δ * z) ≤ Real.exp (δ * |z|) := by
    apply Real.exp_le_exp.mpr
    have h := mul_le_mul_of_nonneg_left (neg_le_abs z) hd
    linarith only [ha, h]
  have hdiff : 1 - Real.exp (-w) ≤ w := by linarith only [Real.add_one_le_exp (-w)]
  calc
    _ = x * Real.exp (a - δ * z) * (1 - Real.exp (-w)) := by
      rw [show a - w - δ * z = (a - δ * z) + (-w) by ring, Real.exp_add]; ring
    _ ≤ x * Real.exp (a - δ * z) * w := mul_le_mul_of_nonneg_left hdiff (by positivity)
    _ ≤ x * Real.exp (δ * |z|) * w :=
      mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left he hx) hw
    _ = _ := by ring

/-- The atom at a positive natural index in the shifted interval. -/
theorem mangoldt_le_for_shift {n : ℕ} {x a δ z : ℝ} (hn : 0 < n) (hx : 0 < x)
    (ha : a ≤ 0) (hd : 0 ≤ δ) (hlog : Real.log x ≤ 63)
    (hupper : (n : ℝ) ≤ x * Real.exp (a - δ * z)) :
    Λ n ≤ 63 * Real.exp (δ * |z|) := by
  have hn' : 0 < (n : ℝ) := by exact_mod_cast hn
  have h := Real.log_le_log hn' hupper
  rw [Real.log_mul hx.ne' (Real.exp_pos _).ne', Real.log_exp] at h
  have hshift := mul_le_mul_of_nonneg_left (neg_le_abs z) hd
  have habs : 0 ≤ δ * |z| := mul_nonneg hd (abs_nonneg _)
  have hmangoldt : Λ n ≤ Real.log (n : ℝ) := ArithmeticFunction.vonMangoldt_le_log
  linarith only [hmangoldt, h, hlog, ha, hshift, habs, Real.add_one_le_exp (δ * |z|)]

/-- Pointwise exponential majorant on the two tails. When integrated against
gpdf, each exponential moment is exp(K²/2). -/
theorem outside_chernoff {δ K z : ℝ} (hK : 2 * δ ≤ K) (hz : K ≤ |z|) :
    Real.exp (2 * δ * |z|) ≤ Real.exp (-(K - 2 * δ) * K) *
      (Real.exp (K * z) + Real.exp (-K * z)) := by
  have h := mul_nonneg (sub_nonneg.mpr hK) (sub_nonneg.mpr hz)
  calc
    _ ≤ Real.exp (-(K - 2 * δ) * K + K * |z|) := Real.exp_le_exp.mpr (by nlinarith only [h])
    _ = Real.exp (-(K - 2 * δ) * K) * Real.exp (K * |z|) := Real.exp_add _ _
    _ ≤ _ := by
      apply mul_le_mul_of_nonneg_left _ (Real.exp_pos _).le
      rcases le_or_gt 0 z with hz₀ | hz₀
      · rw [abs_of_nonneg hz₀]; linarith only [Real.exp_pos (-K * z)]
      · rw [abs_of_neg hz₀, mul_neg, neg_mul]; linarith only [Real.exp_pos (K * z)]

theorem chernoff_moment_factor (δ K : ℝ) :
    Real.exp (-(K - 2 * δ) * K) * Real.exp (K ^ 2 / 2) =
      Real.exp (2 * δ ^ 2 - (K - 2 * δ) ^ 2 / 2) := by
  rw [← Real.exp_add]; congr 1; ring

end GrhGoldbach.LocalLeak

#print axioms GrhGoldbach.LocalLeak.mem_log_window_iff
#print axioms GrhGoldbach.LocalLeak.buffered_window_subset
#print axioms GrhGoldbach.LocalLeak.shifted_width_le
#print axioms GrhGoldbach.LocalLeak.mangoldt_le_for_shift
#print axioms GrhGoldbach.LocalLeak.outside_chernoff
#print axioms GrhGoldbach.LocalLeak.chernoff_moment_factor
