import Mathlib.Analysis.MellinTransform
import Mathlib.Analysis.MeanInequalities
import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.MeasureTheory.Integral.Gamma
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open Complex MeasureTheory Set
open scoped Real

namespace TernaryGoldbach.QRH

private theorem gaussian_first_moment :
    (∫ v in Ioi (0 : ℝ), v * Real.exp (-(1 / 2 : ℝ) * v ^ 2)) = 1 := by
  have h := _root_.integral_rpow_mul_exp_neg_mul_rpow (p := 2) (q := 1)
    (b := 1 / 2) (by norm_num) (by norm_num) (by norm_num)
  norm_num [Real.rpow_one, Real.rpow_two, Real.rpow_neg_one, Real.Gamma_one] at h
  simpa only [neg_mul] using h

private theorem gaussian_half_integral_le :
    (∫ v in Ioi (0 : ℝ), Real.exp (-(1 / 2 : ℝ) * v ^ 2)) ≤ 1.2535 := by
  rw [integral_gaussian_Ioi]
  have hp := Real.pi_lt_d6
  have hs := Real.sq_sqrt (show 0 ≤ Real.pi / (1 / 2 : ℝ) by positivity)
  have hn := Real.sqrt_nonneg (Real.pi / (1 / 2 : ℝ))
  nlinarith

/-- A uniform Mellin bound for a function dominated by the etaPlus Gaussian envelope. -/
theorem norm_mellin_lt_of_gaussian_envelope {f : ℝ → ℂ}
    (hf : ∀ v : ℝ, 0 < v → ‖f v‖ ≤ 3.15 * (v * Real.exp (-v ^ 2 / 2)))
    {s : ℂ} (hs0 : 0 ≤ s.re) (hs1 : s.re ≤ 1) :
    ‖mellin f s‖ < 3.95 := by
  let g₀ : ℝ → ℝ := fun v => Real.exp (-(1 / 2 : ℝ) * v ^ 2)
  let g₁ : ℝ → ℝ := fun v => v * Real.exp (-(1 / 2 : ℝ) * v ^ 2)
  have hi₀ : IntegrableOn g₀ (Ioi 0) :=
    (integrable_exp_neg_mul_sq (b := 1 / 2) (by norm_num)).integrableOn
  have hi₁ : IntegrableOn g₁ (Ioi 0) :=
    (integrable_mul_exp_neg_mul_sq (b := 1 / 2) (by norm_num)).integrableOn
  have hi : IntegrableOn
      (fun v => 3.15 * ((1 - s.re) * g₀ v + s.re * g₁ v)) (Ioi 0) :=
    ((hi₀.const_mul (1 - s.re)).add (hi₁.const_mul s.re)).const_mul 3.15
  have hm : ‖mellin f s‖ ≤
      ∫ v in Ioi (0 : ℝ), 3.15 * ((1 - s.re) * g₀ v + s.re * g₁ v) := by
    unfold mellin
    refine norm_integral_le_of_norm_le hi ?_
    refine (ae_restrict_iff' measurableSet_Ioi).2 (Filter.Eventually.of_forall ?_)
    intro v hv
    have hv0 : 0 < v := hv
    have hp : v ^ s.re ≤ (1 - s.re) + s.re * v := by
      have h := Real.geom_mean_le_arith_mean2_weighted
        (w₁ := 1 - s.re) (w₂ := s.re) (p₁ := 1) (p₂ := v)
        (by linarith) hs0 (by norm_num) hv0.le (by ring)
      simpa only [Real.one_rpow, one_mul, mul_one] using h
    have hpow : v ^ (s.re - 1) * v = v ^ s.re := by
      rw [Real.rpow_sub hv0, Real.rpow_one, div_mul_cancel₀ _ hv0.ne']
    have he : -v ^ 2 / 2 = -(1 / 2 : ℝ) * v ^ 2 := by ring
    rw [norm_smul, Complex.norm_cpow_eq_rpow_re_of_pos hv0]
    simp only [Complex.sub_re, Complex.one_re]
    calc
      v ^ (s.re - 1) * ‖f v‖
          ≤ v ^ (s.re - 1) * (3.15 * (v * Real.exp (-v ^ 2 / 2))) :=
        mul_le_mul_of_nonneg_left (hf v hv0) (Real.rpow_nonneg hv0.le _)
      _ = 3.15 * (v ^ s.re * g₀ v) := by
        rw [he]
        dsimp [g₀]
        calc
          _ = 3.15 * ((v ^ (s.re - 1) * v) * Real.exp (-(1 / 2 : ℝ) * v ^ 2)) := by ring
          _ = _ := by rw [hpow]
      _ ≤ 3.15 * (((1 - s.re) + s.re * v) * g₀ v) := by
        apply mul_le_mul_of_nonneg_left _ (by norm_num)
        exact mul_le_mul_of_nonneg_right hp (Real.exp_pos _).le
      _ = 3.15 * ((1 - s.re) * g₀ v + s.re * g₁ v) := by
        dsimp [g₀, g₁]
        ring
  have hI : (∫ v in Ioi (0 : ℝ), 3.15 * ((1 - s.re) * g₀ v + s.re * g₁ v)) =
      3.15 * ((1 - s.re) * (∫ v in Ioi (0 : ℝ), g₀ v) + s.re) := by
    rw [integral_const_mul, integral_add (hi₀.const_mul _) (hi₁.const_mul _),
      integral_const_mul, integral_const_mul]
    change 3.15 * ((1 - s.re) * (∫ v in Ioi (0 : ℝ), g₀ v) +
      s.re * (∫ v in Ioi (0 : ℝ), v * Real.exp (-(1 / 2 : ℝ) * v ^ 2))) = _
    rw [gaussian_first_moment, mul_one]
  rw [hI] at hm
  have hg₀ : (∫ v in Ioi (0 : ℝ), g₀ v) ≤ 1.2535 := gaussian_half_integral_le
  have hb := mul_le_mul_of_nonneg_left hg₀ (show 0 ≤ 1 - s.re by linarith)
  nlinarith

end TernaryGoldbach.QRH





