import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-! Internal raw-head helpers for the literal positive-real-base power.
The definition has a total real carrier. Its connection to principal complex
power, and the raw-head quotient identity, require positive bases. -/

noncomputable section

open Complex
open scoped ComplexConjugate

namespace RawHead

def integerPower (x t : ℝ) : ℂ :=
  Complex.exp (((-1 / 2 : ℂ) - Complex.I * (t : ℂ)) * (Real.log x : ℂ))

lemma integerPower_eq_cpow {x : ℝ} (hx : 0 < x) (t : ℝ) :
    integerPower x t = (x : ℂ) ^ ((-1 / 2 : ℂ) - Complex.I * (t : ℂ)) := by
  rw [Complex.cpow_def_of_ne_zero (Complex.ofReal_ne_zero.mpr (ne_of_gt hx)),
    ← Complex.ofReal_log (le_of_lt hx)]
  unfold integerPower
  congr 1
  ring

lemma conj_integerPower (x t : ℝ) :
    conj (integerPower x t) =
      Complex.exp (((-1 / 2 : ℂ) + Complex.I * (t : ℂ)) * (Real.log x : ℂ)) := by
  unfold integerPower
  rw [← Complex.exp_conj]
  congr 1
  have hhalf : conj (-1 / 2 : ℂ) = (-1 / 2 : ℂ) := by
    apply Complex.ext <;> norm_num
  simp only [map_mul, map_sub, hhalf,
    Complex.conj_ofReal, Complex.conj_I, neg_mul, sub_neg_eq_add]

lemma integerPower_raw_head {a c : ℝ} (ha : 0 < a) (hc : 0 < c) (t : ℝ) :
    (c : ℂ) * conj (integerPower c t) * integerPower a t =
      ((a / c : ℝ) : ℂ) ^ ((-1 / 2 : ℂ) - Complex.I * (t : ℂ)) := by
  have hexp : (c : ℂ) = Complex.exp (Real.log c : ℂ) := by
    rw [← Complex.ofReal_exp, Real.exp_log hc]
  rw [← integerPower_eq_cpow (div_pos ha hc) t, conj_integerPower]
  unfold integerPower
  conv_lhs => lhs; lhs; rw [hexp]
  rw [← Complex.exp_add, ← Complex.exp_add,
    Real.log_div (ne_of_gt ha) (ne_of_gt hc), Complex.ofReal_sub]
  congr 1
  ring

lemma integerPower_norm (x t : ℝ) :
    ‖integerPower x t‖ = Real.exp (-Real.log x / 2) := by
  rw [integerPower, Complex.norm_exp]
  congr 1
  simp [Complex.mul_re, Complex.sub_re]
  ring

lemma integerPower_norm_le_one {x : ℝ} (hx : 1 ≤ x) (t : ℝ) :
    ‖integerPower x t‖ ≤ 1 := by
  rw [integerPower_norm, Real.exp_le_one_iff]
  have hlog := Real.log_nonneg hx
  linarith

lemma integerPower_zero (x : ℝ) :
    integerPower x 0 = (Real.exp (-Real.log x / 2) : ℂ) := by
  rw [integerPower, Complex.ofReal_exp]
  congr 1
  push_cast
  ring

lemma exp_neg_log_half_eq_inv_sqrt {x : ℝ} (hx : 0 < x) :
    Real.exp (-Real.log x / 2) = (Real.sqrt x)⁻¹ := by
  rw [Real.sqrt_eq_rpow, ← Real.rpow_neg (le_of_lt hx), Real.rpow_def_of_pos hx]
  congr 1
  ring

lemma integerPower_zero_eq_inv_sqrt {x : ℝ} (hx : 0 < x) :
    integerPower x 0 = ((Real.sqrt x)⁻¹ : ℝ) := by
  rw [integerPower_zero, exp_neg_log_half_eq_inv_sqrt hx]

lemma integerPower_add_time (x t h : ℝ) :
    integerPower x (t + h) = integerPower x t *
      Complex.exp (-Complex.I * (h : ℂ) * (Real.log x : ℂ)) := by
  unfold integerPower
  rw [← Complex.exp_add, Complex.ofReal_add]
  congr 1
  ring

lemma integerPower_time_step (x t : ℝ) :
    integerPower x (t + 5 / 64) = integerPower x t *
      Complex.exp (-Complex.I * (5 / 64 : ℂ) * (Real.log x : ℂ)) := by
  simpa using integerPower_add_time x t (5 / 64)

end RawHead
