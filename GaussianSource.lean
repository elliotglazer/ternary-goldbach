module

/- Gaussian declarations reproduced under Apache-2.0 from calr3/ternary-goldbach,
   commit 23b2d68ca344203d4384e0aff7affa4ec034bef9, Explicit/GaussSmooth.lean.
   The statements, definition bodies and proofs are unchanged. -/
public import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.Ring
public import Mathlib.Tactic.Positivity
public import Mathlib.Tactic.FunProp

@[expose] public section


open Complex Set Filter MeasureTheory
open scoped Real Interval Topology

namespace GrhGoldbach.GaussianSource

/-- The standard normal density. -/
noncomputable def gpdf (z : ℝ) : ℝ := Real.exp (-(z ^ 2 / 2)) / √(2 * π)

theorem gpdf_pos (z : ℝ) : 0 < gpdf z := by unfold gpdf; positivity

theorem gpdf_nonneg (z : ℝ) : 0 ≤ gpdf z := (gpdf_pos z).le

theorem continuous_gpdf : Continuous gpdf := by unfold gpdf; fun_prop

theorem sqrt_two_pi_pos : 0 < √(2 * π) := Real.sqrt_pos.2 (by positivity)

theorem integral_gpdf : ∫ z, gpdf z = 1 := by
  unfold gpdf
  rw [integral_div]
  have h := integral_gaussian (1 / 2)
  have e : (fun x : ℝ => Real.exp (-(1 / 2) * x ^ 2)) = fun x => Real.exp (-(x ^ 2 / 2)) := by
    funext x; ring_nf
  rw [e, show π / (1 / 2) = 2 * π by ring] at h
  rw [h, div_self sqrt_two_pi_pos.ne']

theorem integrable_gpdf : Integrable gpdf := by
  unfold gpdf
  have h := integrable_exp_neg_mul_sq (b := 1 / 2) (by norm_num)
  have e : (fun x : ℝ => Real.exp (-(1 / 2) * x ^ 2)) = fun x => Real.exp (-(x ^ 2 / 2)) := by
    funext x; ring_nf
  rw [e] at h
  exact h.div_const _

/-- `E[e^{cZ}] = e^{c²/2}` for complex `c`. -/
theorem integral_gpdf_mul_cexp (c : ℂ) : ∫ z : ℝ, (gpdf z : ℂ) * cexp (c * z) = cexp (c ^ 2 / 2) := by
  have h := integral_cexp_quadratic (b := (-(1 / 2) : ℂ)) (by simp) c 0
  have e1 : ∀ z : ℝ, (gpdf z : ℂ) * cexp (c * z) =
      cexp (-(1 / 2) * (z : ℂ) ^ 2 + c * z + 0) / ((√(2 * π) : ℝ) : ℂ) := by
    intro z
    unfold gpdf
    rw [Complex.ofReal_div, Complex.ofReal_exp, div_mul_eq_mul_div, ← Complex.exp_add]
    congr 2; push_cast; ring
  simp_rw [e1]
  rw [integral_div, h]
  have e2 : ((π : ℂ) / -(-(1 / 2) : ℂ)) ^ (1 / 2 : ℂ) = ((√(2 * π) : ℝ) : ℂ) := by
    rw [show (π : ℂ) / -(-(1 / 2) : ℂ) = ((2 * π : ℝ) : ℂ) by push_cast; ring, Real.sqrt_eq_rpow,
      Complex.ofReal_cpow (by positivity)]
    push_cast; ring_nf
  rw [e2, mul_div_assoc, mul_div_cancel₀ _ (by exact_mod_cast sqrt_two_pi_pos.ne')]
  congr 1; ring

theorem integrable_gpdf_mul_cexp (c : ℂ) : Integrable fun z : ℝ => (gpdf z : ℂ) * cexp (c * z) := by
  have h := integrable_cexp_quadratic' (b := (-(1 / 2) : ℂ)) (by simp) c 0
  have e1 : (fun z : ℝ => (gpdf z : ℂ) * cexp (c * z)) =
      fun z : ℝ => cexp (-(1 / 2) * (z : ℂ) ^ 2 + c * z + 0) / ((√(2 * π) : ℝ) : ℂ) := by
    funext z
    unfold gpdf
    rw [Complex.ofReal_div, Complex.ofReal_exp, div_mul_eq_mul_div, ← Complex.exp_add]
    congr 2; push_cast; ring
  rw [e1]; exact h.div_const _

/-- Real version: `E[e^{tZ}] = e^{t²/2}`. -/
theorem integral_gpdf_mul_exp (t : ℝ) : ∫ z : ℝ, gpdf z * Real.exp (t * z) = Real.exp (t ^ 2 / 2) := by
  have h := integral_gpdf_mul_cexp (t : ℂ)
  have e : (fun z : ℝ => (gpdf z : ℂ) * cexp ((t : ℂ) * z)) = fun z => ((gpdf z * Real.exp (t * z) : ℝ) : ℂ) := by
    funext z; push_cast; ring_nf
  rw [e, integral_complex_ofReal, show (t : ℂ) ^ 2 / 2 = ((t ^ 2 / 2 : ℝ) : ℂ) by push_cast; ring,
    ← Complex.ofReal_exp] at h
  exact_mod_cast h

theorem integrable_gpdf_mul_exp (t : ℝ) : Integrable fun z : ℝ => gpdf z * Real.exp (t * z) := by
  have h := (integrable_gpdf_mul_cexp (t : ℂ)).re
  refine h.congr (Eventually.of_forall fun z => ?_)
  simp only
  rw [show (t : ℂ) * (z : ℂ) = ((t * z : ℝ) : ℂ) by push_cast; ring, ← Complex.ofReal_exp,
    ← Complex.ofReal_mul]
  rfl

/-! ## The smoothing and its Mellin transform -/

/-- `φ(u) = ∫_{(b − log u)/δ}^{(a − log u)/δ} g`. -/
noncomputable def gsm (a b δ : ℝ) (u : ℝ) : ℝ := ∫ z in (b - Real.log u) / δ..(a - Real.log u) / δ, gpdf z

end GrhGoldbach.GaussianSource
