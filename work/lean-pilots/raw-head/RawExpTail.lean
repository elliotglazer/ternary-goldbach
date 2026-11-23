import Mathlib.Analysis.Complex.Exponential
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

/-! Internal raw-head pilot: the actual exponential Taylor tail and phase transport.
These are analytic polynomial bounds, before rounded Horner evaluation. -/

noncomputable section

namespace RawHead

def expPartial (N : ℕ) (z : ℂ) : ℂ :=
  ∑ m ∈ Finset.range N, z ^ m / m.factorial

lemma expPartial73_error {z : ℂ} (hz : ‖z‖ ≤ 4) :
    ‖Complex.exp z - expPartial 73 z‖ ≤ 1 / (2 ^ 124 : ℝ) := by
  have h := Complex.exp_bound' (n := 73) (x := z) (by norm_num; linarith only [hz])
  have hp : ‖z‖ ^ 73 ≤ (4 : ℝ) ^ 73 :=
    pow_le_pow_left₀ (norm_nonneg _) hz 73
  have hc : (4 : ℝ) ^ 73 / (Nat.factorial 73) * 2 ≤ 1 / (2 ^ 124 : ℝ) := by
    norm_num [Nat.factorial]
  exact h.trans ((mul_le_mul_of_nonneg_right
    (div_le_div_of_nonneg_right hp (by positivity)) (by norm_num)).trans hc)

lemma expPartial73_imag_error {theta : ℝ} (htheta : |theta| ≤ 4) :
    ‖Complex.exp (Complex.I * theta) - expPartial 73 (Complex.I * theta)‖ ≤
      1 / (2 ^ 124 : ℝ) := by
  apply expPartial73_error
  simpa only [norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs]
    using htheta

/-- Unit-circle exponential transport has constant one, with no small-phase premise. -/
lemma exp_imag_lipschitz (x y : ℝ) :
    ‖Complex.exp (Complex.I * x) - Complex.exp (Complex.I * y)‖ ≤ |x - y| := by
  have hex : Complex.I * (y : ℂ) + Complex.I * ((x - y : ℝ) : ℂ) =
      Complex.I * (x : ℂ) := by
    push_cast
    ring
  have he : Complex.exp (Complex.I * x) - Complex.exp (Complex.I * y) =
      Complex.exp (Complex.I * y) * (Complex.exp (Complex.I * (x - y : ℝ)) - 1) := by
    rw [mul_sub, ← Complex.exp_add, hex, mul_one]
  rw [he, norm_mul, Complex.norm_exp_I_mul_ofReal, one_mul]
  simpa only [Real.norm_eq_abs] using
    (Real.norm_exp_I_mul_ofReal_sub_one_le (x := x - y))

end RawHead
