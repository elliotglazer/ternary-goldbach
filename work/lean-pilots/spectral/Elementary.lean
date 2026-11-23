import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Analysis.Complex.Exponential
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.GCongr

noncomputable section
open Complex Finset
namespace SpectralPilot

def logSeries (x : ℝ) : ℝ := 2 * ∑ i ∈ Finset.range 8, x ^ (2 * i + 1) / (2 * i + 1)

lemma logSeries_error {x : ℝ} (hx0 : 0 ≤ x) (hx : x ≤ 1 / 3) :
    |Real.log ((1 + x) / (1 - x)) - logSeries x| ≤ 1 / 50000000 := by
  have ha : |x| < 1 := by rw [abs_of_nonneg hx0]; linarith
  have h := Real.sum_range_sub_log_div_le ha 8
  rw [abs_of_nonneg hx0] at h
  have hd : (8 / 9 : ℝ) ≤ 1 - x ^ 2 := by nlinarith only [hx0, hx]
  have hp : x ^ 17 ≤ (1 / 3 : ℝ) ^ 17 := pow_le_pow_left₀ hx0 hx 17
  have hb : x ^ 17 / (1 - x ^ 2) ≤ (1 / 3 : ℝ) ^ 17 / (8 / 9) := by
    exact div_le_div₀ (by positivity) hp (by norm_num) hd
  have he : Real.log ((1 + x) / (1 - x)) - logSeries x =
      2 * (1 / 2 * Real.log ((1 + x) / (1 - x)) -
        ∑ i ∈ Finset.range 8, x ^ (2 * i + 1) / (2 * i + 1)) := by
    unfold logSeries
    ring
  rw [he, abs_mul]
  norm_num at h ⊢
  have hc : 2 * ((1 / 3 : ℝ) ^ 17 / (8 / 9)) ≤ 1 / 50000000 := by norm_num
  linarith

def expSeries (z : ℂ) : ℂ := ∑ m ∈ Finset.range 16, z ^ m / m.factorial

lemma expSeries_error {z : ℂ} (hz : ‖z‖ ≤ 2) :
    ‖Complex.exp z - expSeries z‖ ≤ 1 / 10000000 := by
  have h := Complex.exp_bound' (n := 16) (x := z) (by norm_num; linarith)
  have hp : ‖z‖ ^ 16 ≤ (2 : ℝ) ^ 16 := pow_le_pow_left₀ (norm_nonneg _) hz 16
  have hc : (2 : ℝ) ^ 16 / (Nat.factorial 16) * 2 ≤ 1 / 10000000 := by
    norm_num [Nat.factorial]
  exact h.trans ((mul_le_mul_of_nonneg_right
    (div_le_div_of_nonneg_right hp (by positivity)) (by norm_num)).trans hc)

lemma exp_transport {x y : ℂ} (hx : x.re ≤ 0) (hxy : ‖y - x‖ ≤ 1) :
    ‖Complex.exp y - Complex.exp x‖ ≤ 2 * ‖y - x‖ := by
  have he : Complex.exp y - Complex.exp x =
      Complex.exp x * (Complex.exp (y - x) - 1) := by
    rw [mul_sub, ← Complex.exp_add]
    simp only [add_sub_cancel, mul_one]
  rw [he, norm_mul]
  have hn : ‖Complex.exp x‖ ≤ 1 := by
    rw [Complex.norm_exp]
    exact Real.exp_le_one_iff.mpr hx
  exact (mul_le_mul hn (Complex.norm_exp_sub_one_le hxy) (norm_nonneg _)
    (by norm_num)).trans (by simp)

end SpectralPilot
