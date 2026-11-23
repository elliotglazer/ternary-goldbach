import TernaryGoldbach.Explicit.GaussSmooth

/-!
Scratch lemmas for replacing the low-zero contribution in `psi_asymp8`.
No declaration here claims that the QRH explicit-formula assembly is complete.
-/

open Complex Set Filter MeasureTheory Finset
open scoped Real Interval Topology

namespace TernaryGoldbach.Explicit

/-- A Gaussian Mellin-transform bound on the closed QRH strip. -/
theorem norm_Mg_qrh24_strip_le {a b δ : ℝ} (hb : b ≤ 0) {s : ℂ}
    (h0 : 1 / 24 ≤ s.re) (h1 : s.re ≤ 23 / 24) :
    ‖Mg a b δ s‖ * max (1 / 24) |s.im| ≤
      2 * Real.exp (δ ^ 2 / 2 + |a|) := by
  have hs0 : s ≠ 0 := by
    intro hs
    rw [hs] at h0
    norm_num at h0
  have hg : ‖cexp ((δ : ℂ) ^ 2 * s ^ 2 / 2)‖ ≤ Real.exp (δ ^ 2 / 2) := by
    rw [norm_cexp_gauss]
    apply Real.exp_le_exp.2
    have hre : s.re ^ 2 ≤ 1 := by nlinarith
    nlinarith [sq_nonneg δ, sq_nonneg s.im, sq_nonneg (δ * s.im)]
  have hI := norm_intExp_le' (a := a) (b := b) hs0
  have hsn : max (1 / 24) |s.im| ≤ ‖s‖ := by
    apply max_le
    · have hr := Complex.abs_re_le_norm s
      rw [abs_of_nonneg (by linarith : 0 ≤ s.re)] at hr
      linarith
    · exact Complex.abs_im_le_norm s
  have hnum : Real.exp (a * s.re) + Real.exp (b * s.re) ≤
      2 * Real.exp |a| := by
    have ha : Real.exp (a * s.re) ≤ Real.exp |a| := by
      apply Real.exp_le_exp.2
      cases abs_cases a <;> nlinarith
    have hb' : Real.exp (b * s.re) ≤ Real.exp |a| := by
      apply Real.exp_le_exp.2
      nlinarith [abs_nonneg a]
    linarith
  have hInt : ‖∫ w in b..a, cexp (s * w)‖ * max (1 / 24) |s.im| ≤
      2 * Real.exp |a| := by
    calc
      ‖∫ w in b..a, cexp (s * w)‖ * max (1 / 24) |s.im| ≤
          ((Real.exp (a * s.re) + Real.exp (b * s.re)) / ‖s‖) * ‖s‖ :=
        mul_le_mul hI hsn (by positivity) (by positivity)
      _ = Real.exp (a * s.re) + Real.exp (b * s.re) := by
        field_simp [(norm_pos_iff.2 hs0).ne']
      _ ≤ 2 * Real.exp |a| := hnum
  rw [Mg, norm_mul, Real.exp_add]
  calc
    ‖cexp ((δ : ℂ) ^ 2 * s ^ 2 / 2)‖ *
        ‖∫ w in b..a, cexp (s * w)‖ * max (1 / 24) |s.im| =
        ‖cexp ((δ : ℂ) ^ 2 * s ^ 2 / 2)‖ *
          (‖∫ w in b..a, cexp (s * w)‖ * max (1 / 24) |s.im|) := by ring
    _ ≤ Real.exp (δ ^ 2 / 2) * (2 * Real.exp |a|) :=
      mul_le_mul hg hInt (by positivity) (by positivity)
    _ = 2 * (Real.exp (δ ^ 2 / 2) * Real.exp |a|) := by ring

end TernaryGoldbach.Explicit




