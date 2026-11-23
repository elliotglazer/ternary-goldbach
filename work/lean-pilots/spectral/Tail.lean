import CentralChi4
import FiniteInputs
import FiniteAbel

noncomputable section
open Complex MeasureTheory Set TernaryGoldbach.Explicit
namespace SpectralPilot

lemma sampleS_norm_sharp : ‖sampleS‖ ≤ 33 / 64 := by
  have h := Complex.sq_norm sampleS
  norm_num [sampleS, Complex.normSq, Complex.mul_re, Complex.mul_im] at h
  change ‖sampleS‖ ^ 2 = 1049 / 4096 at h
  nlinarith only [h, norm_nonneg sampleS]

lemma norm_psum_chi4 (n : ℕ) : ‖psum chi4 n‖ ≤ 1 := by
  rw [psum_chi4]
  split_ifs <;> norm_num

def finiteSample : ℂ :=
  ∑ n ∈ Finset.Icc (1 : ℕ) 16, chi4 (n : ZMod 4) * (n : ℂ) ^ (-sampleS)

def sampleTail : ℂ := sampleS * ∫ t in Ioi (16 : ℝ),
  psum chi4 ⌊t⌋₊ * (t : ℂ) ^ (-(sampleS + 1))

lemma actual_sample_split : chi4.LFunction sampleS = finiteSample + sampleTail := by
  rw [SpectralAbelPilot.LFunction_finite_abel chi4_ne_one
    (by norm_num [sampleS] : 0 < sampleS.re) (by norm_num : 1 ≤ (16 : ℕ))]
  norm_num [psum_chi4, finiteSample, sampleTail]

lemma sampleTail_bound : ‖sampleTail‖ ≤ 33 / 128 := by
  have hi : IntegrableOn (fun t : ℝ => t ^ (-(3 / 2 : ℝ))) (Ioi 16) :=
    integrableOn_Ioi_rpow_of_lt (by norm_num) (by norm_num)
  have hb : ‖∫ t in Ioi (16 : ℝ), psum chi4 ⌊t⌋₊ *
      (t : ℂ) ^ (-(sampleS + 1))‖ ≤ (1 / 2 : ℝ) := by
    have hpoint : ∀ᵐ (t : ℝ) ∂volume.restrict (Ioi (16 : ℝ)),
        ‖psum chi4 ⌊t⌋₊ * (t : ℂ) ^ (-(sampleS + 1))‖ ≤ t ^ (-(3 / 2 : ℝ)) := by
      filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
      have ht0 : 0 < t := lt_trans (by norm_num : (0 : ℝ) < 16) ht
      rw [norm_mul, norm_cpow_neg ht0]
      norm_num [sampleS]
      exact mul_le_of_le_one_left (Real.rpow_nonneg ht0.le _)
        (norm_psum_chi4 _)
    apply (norm_integral_le_of_norm_le hi hpoint).trans
    rw [integral_Ioi_rpow_of_lt (by norm_num) (by norm_num)]
    norm_num [show (-(3 / 2 : ℝ) + 1) = -(1 / 2 : ℝ) by norm_num,
      Real.rpow_neg, ← Real.sqrt_eq_rpow]
  unfold sampleTail
  rw [norm_mul]
  have := mul_le_mul sampleS_norm_sharp hb (norm_nonneg _) (by norm_num : (0 : ℝ) ≤ 33 / 64)
  norm_num at this ⊢
  exact this

end SpectralPilot
