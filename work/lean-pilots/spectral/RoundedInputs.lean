import FiniteInputs
import Mathlib.Tactic.FinCases
noncomputable section
open Complex
namespace SpectralPilot

def rounded1 : ℂ := (1048576 : ℂ) / 1048576 + Complex.I * (0 / 1048576)
lemma round1_error : ‖powerCenter 1 0 - rounded1‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded1, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input1_error : ‖(1 : ℂ) ^ (-sampleS) - rounded1‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 1) (k := 0) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((1 : ℂ) ^ (-sampleS))
    (powerCenter 1 0) rounded1
  linarith [round1_error]

def rounded3 : ℂ := (603167 : ℂ) / 1048576 + Complex.I * (-51897 / 1048576)
lemma round3_error : ‖powerCenter 3 1 - rounded3‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded3, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input3_error : ‖(3 : ℂ) ^ (-sampleS) - rounded3‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 3) (k := 1) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((3 : ℂ) ^ (-sampleS))
    (powerCenter 3 1) rounded3
  linarith [round3_error]

def rounded5 : ℂ := (465235 : ℂ) / 1048576 + Complex.I * (-58808 / 1048576)
lemma round5_error : ‖powerCenter 5 2 - rounded5‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded5, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input5_error : ‖(5 : ℂ) ^ (-sampleS) - rounded5‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 5) (k := 2) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((5 : ℂ) ^ (-sampleS))
    (powerCenter 5 2) rounded5
  linarith [round5_error]

def rounded7 : ℂ := (391753 : ℂ) / 1048576 + Complex.I * (-60019 / 1048576)
lemma round7_error : ‖powerCenter 7 2 - rounded7‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded7, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input7_error : ‖(7 : ℂ) ^ (-sampleS) - rounded7‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 7) (k := 2) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((7 : ℂ) ^ (-sampleS))
    (powerCenter 7 2) rounded7
  linarith [round7_error]

def rounded9 : ℂ := (344388 : ℂ) / 1048576 + Complex.I * (-59705 / 1048576)
lemma round9_error : ‖powerCenter 9 3 - rounded9‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded9, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input9_error : ‖(9 : ℂ) ^ (-sampleS) - rounded9‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 9) (k := 3) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((9 : ℂ) ^ (-sampleS))
    (powerCenter 9 3) rounded9
  linarith [round9_error]

def rounded11 : ℂ := (310626 : ℂ) / 1048576 + Complex.I * (-58882 / 1048576)
lemma round11_error : ‖powerCenter 11 3 - rounded11‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded11, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input11_error : ‖(11 : ℂ) ^ (-sampleS) - rounded11‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 11) (k := 3) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((11 : ℂ) ^ (-sampleS))
    (powerCenter 11 3) rounded11
  linarith [round11_error]

def rounded13 : ℂ := (285003 : ℂ) / 1048576 + Complex.I * (-57888 / 1048576)
lemma round13_error : ‖powerCenter 13 3 - rounded13‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded13, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input13_error : ‖(13 : ℂ) ^ (-sampleS) - rounded13‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 13) (k := 3) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((13 : ℂ) ^ (-sampleS))
    (powerCenter 13 3) rounded13
  linarith [round13_error]

def rounded15 : ℂ := (264704 : ℂ) / 1048576 + Complex.I * (-56853 / 1048576)
lemma round15_error : ‖powerCenter 15 3 - rounded15‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded15, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input15_error : ‖(15 : ℂ) ^ (-sampleS) - rounded15‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 15) (k := 3) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((15 : ℂ) ^ (-sampleS))
    (powerCenter 15 3) rounded15
  linarith [round15_error]

def roundedInput (j : Fin 8) : ℂ :=
  ![rounded1, rounded3, rounded5, rounded7, rounded9, rounded11, rounded13, rounded15] j

lemma roundedInput_error (j : Fin 8) :
    ‖((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS) - roundedInput j‖ ≤ (1 / 500000 : ℝ) := by
  fin_cases j
  · simpa [roundedInput] using input1_error
  · simpa [roundedInput] using input3_error
  · simpa [roundedInput] using input5_error
  · simpa [roundedInput] using input7_error
  · simpa [roundedInput] using input9_error
  · simpa [roundedInput] using input11_error
  · simpa [roundedInput] using input13_error
  · simpa [roundedInput] using input15_error

end SpectralPilot
