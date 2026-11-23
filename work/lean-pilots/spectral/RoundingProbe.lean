import FiniteInputs
noncomputable section
open Complex SpectralPilot
example : ‖powerCenter 3 1 - ((603167 : ℂ) / 1048576 + Complex.I * (-51897 / 1048576))‖ ≤
    (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
