import Tail
import RoundedInputs

noncomputable section
open Complex
namespace SpectralPilot

def indexedSample : ℂ := ∑ j : Fin 8,
  (-1 : ℂ) ^ j.val * ((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS)

def finiteRounded : ℂ := ∑ j : Fin 8, (-1 : ℂ) ^ j.val * roundedInput j

lemma finiteSample_eq_indexed : finiteSample = indexedSample := by
  norm_num [finiteSample, indexedSample, Fin.sum_univ_succ,
    Finset.sum_Icc_succ_top, Finset.Icc_self, chi4_nat]
  ring

lemma finiteRounded_eval : finiteRounded =
    (572952 : ℂ) / 1048576 + Complex.I * (51250 / 1048576) := by
  norm_num [finiteRounded, roundedInput, Fin.sum_univ_succ, rounded1, rounded3,
    rounded5, rounded7, rounded9, rounded11, rounded13, rounded15]
  ring

lemma finiteSample_rounding_error : ‖finiteSample - finiteRounded‖ ≤ (1 / 62500 : ℝ) := by
  rw [finiteSample_eq_indexed]
  unfold indexedSample finiteRounded
  rw [← Finset.sum_sub_distrib]
  have hp (j : Fin 8) :
      ‖(-1 : ℂ) ^ j.val * ((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS) -
        (-1 : ℂ) ^ j.val * roundedInput j‖ ≤ (1 / 500000 : ℝ) := by
    rw [← mul_sub, norm_mul]
    simpa using roundedInput_error j
  calc
    _ ≤ ∑ j : Fin 8, ‖(-1 : ℂ) ^ j.val * ((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS) -
        (-1 : ℂ) ^ j.val * roundedInput j‖ := norm_sum_le _ _
    _ ≤ ∑ _j : Fin 8, (1 / 500000 : ℝ) := Finset.sum_le_sum (fun j _ => hp j)
    _ = _ := by norm_num

lemma actual_sample_disk : ‖chi4.LFunction sampleS - finiteRounded‖ ≤
    (33 / 128 + 1 / 62500 : ℝ) := by
  rw [actual_sample_split]
  have he : finiteSample + sampleTail - finiteRounded =
      (finiteSample - finiteRounded) + sampleTail := by ring
  rw [he]
  exact (norm_add_le _ _).trans (by linarith [finiteSample_rounding_error, sampleTail_bound])

/-- Actual positive-height L enclosure, obtained from certified finite inputs and the source tail. -/
theorem actual_sample_box : (1 / 4 : ℝ) < (chi4.LFunction sampleS).re ∧
    |(chi4.LFunction sampleS).im| < (1 / 2 : ℝ) := by
  have hr := (Complex.abs_re_le_norm (chi4.LFunction sampleS - finiteRounded)).trans actual_sample_disk
  have hi := (Complex.abs_im_le_norm (chi4.LFunction sampleS - finiteRounded)).trans actual_sample_disk
  rw [finiteRounded_eval] at hr hi
  norm_num at hr hi
  have hr' := abs_le.mp hr
  have hi' := abs_le.mp hi
  constructor
  · linarith
  · rw [abs_lt]
    constructor <;> linarith

end SpectralPilot
