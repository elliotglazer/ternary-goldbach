import GammaEnclosure
import Mathlib.Analysis.SpecialFunctions.Gamma.Deligne

namespace SpectralCompletion

noncomputable def samplePoint : ℂ := (1/2:ℂ)+Complex.I*(5/64)

noncomputable def completionScale : ℝ :=
  Real.exp (Real.log 4 / 4 - 3 * Real.log Real.pi / 4)

theorem completionScale_pos : 0 < completionScale := Real.exp_pos _

theorem completion_factor_eq :
    (4:ℂ)^(samplePoint/2) * Complex.Gammaℝ (samplePoint+1) =
      (completionScale:ℂ)*gammaPhase := by
  have hp : (Real.pi:ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr Real.pi_ne_zero
  have harg : (samplePoint+1)/2 = (3/4:ℂ)+Complex.I*(5/128) := by
    dsimp [samplePoint]; ring
  rw [Complex.Gammaℝ_def, harg]
  dsimp [completionScale, gammaPhase]
  rw [Complex.cpow_def_of_ne_zero (by norm_num : (4:ℂ) ≠ 0),
    Complex.cpow_def_of_ne_zero hp]
  rw [Complex.ofReal_exp]
  rw [← mul_assoc, ← Complex.exp_add]
  rw [← mul_assoc, ← Complex.exp_add]
  congr 2
  rw [← Complex.ofReal_log Real.pi_pos.le,
    show Complex.log (4:ℂ) = (Real.log 4:ℂ) by
      simpa only [Complex.ofReal_ofNat] using
        (Complex.ofReal_log (by norm_num : (0:ℝ)≤4)).symm]
  rw [Real.log_div (by norm_num : (4:ℝ)≠0) Real.pi_ne_zero]
  dsimp [samplePoint]
  push_cast
  ring

theorem completed_product_positive {L : ℂ}
    (hLre : (1/4:ℝ) < L.re) (hLim : |L.im| < 1/2) :
    0 < ((4:ℂ)^(samplePoint/2) * (Complex.Gammaℝ (samplePoint+1)*L)).re := by
  rw [← mul_assoc, completion_factor_eq, mul_assoc, Complex.re_ofReal_mul]
  apply mul_pos completionScale_pos
  rw [Complex.mul_re]
  have hg := gammaPhase_enclosure
  have hLpos : 0 < L.re := by linarith
  have hre : (3/4:ℝ)*L.re ≤ gammaPhase.re*L.re :=
    mul_le_mul_of_nonneg_right hg.1 hLpos.le
  have him : gammaPhase.im*L.im ≤ |gammaPhase.im| *|L.im| :=
    (le_abs_self _).trans_eq (abs_mul _ _)
  have hib : |gammaPhase.im| *|L.im| ≤ (1/4:ℝ)*(1/2) :=
    mul_le_mul hg.2 hLim.le (abs_nonneg _) (by norm_num)
  linarith

end SpectralCompletion

