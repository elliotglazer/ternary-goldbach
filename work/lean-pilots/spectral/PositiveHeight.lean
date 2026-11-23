import SampleBox
import Chi4Reality
import CompletionFactor

noncomputable section
open Complex
namespace SpectralPilot

/-- Strict sign and exact reality of the actual conductor-normalized completion at the first
positive coarse sample. All finite input, tail, rounding and completion bounds are proved. -/
theorem positive_height_chi4_certificate :
    0 < (((4 : ℂ) ^ (((1 / 2 : ℂ) + I * (5 / 64)) / 2)) *
      chi4.completedLFunction ((1 / 2 : ℂ) + I * (5 / 64))).re ∧
    (((4 : ℂ) ^ (((1 / 2 : ℂ) + I * (5 / 64)) / 2)) *
      chi4.completedLFunction ((1 / 2 : ℂ) + I * (5 / 64))).im = 0 := by
  constructor
  · change 0 < ((4 : ℂ) ^ (sampleS / 2) * chi4.completedLFunction sampleS).re
    rw [SpectralRealityPilot.chi4_completed_eq (by norm_num [sampleS])]
    rw [mul_comm (chi4.LFunction sampleS) (Complex.Gammaℝ (sampleS + 1))]
    exact SpectralCompletion.completed_product_positive actual_sample_box.1 actual_sample_box.2
  · simpa using SpectralRealityPilot.normalized_completed_chi4_real (5 / 64 : ℝ)

end SpectralPilot
