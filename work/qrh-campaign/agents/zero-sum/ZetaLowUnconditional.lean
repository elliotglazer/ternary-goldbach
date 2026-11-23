import TernaryGoldbach.Explicit.ZetaLowZeroFree
import TernaryGoldbach.Explicit.Xi

open Complex MeasureTheory Set Filter
open scoped Real

namespace TernaryGoldbach.Explicit

/-- The integral remainder excludes low zeros throughout the right half of the strip. -/
theorem zetaF_ne_zero_of_half_le_re_of_abs_im_lt {s : ℂ}
    (hσ0 : 1 / 2 ≤ s.re) (hσ1 : s.re ≤ 1) (ht : |s.im| < 2.39) :
    zetaF s ≠ 0 := by
  have hs : 0 < s.re := by linarith
  have hJ := norm_Jzeta_le hs
  have hplus : 0 < ‖s + 1‖ := by
    calc
      0 < s.re + 1 := by linarith
      _ = (s + 1).re := by simp only [Complex.add_re, Complex.one_re]
      _ ≤ ‖s + 1‖ := Complex.re_le_norm _
  have hden : 0 < 8 * (s.re + 1) := by linarith
  intro hz
  have heq : (s + 1) / 2 = s * (s - 1) * (s + 1) * Jzeta s := by
    have h := zetaF_eq_J hs
    rw [hz] at h
    exact sub_eq_zero.mp h.symm
  have heqNorm := congrArg norm heq
  rw [norm_div, norm_mul, norm_mul, norm_mul, Complex.norm_ofNat] at heqNorm
  have hbound : ‖s + 1‖ / 2 ≤
      (‖s‖ * ‖s - 1‖ * ‖s + 1‖) / (8 * (s.re + 1)) := by
    calc
      ‖s + 1‖ / 2 = ‖s‖ * ‖s - 1‖ * ‖s + 1‖ * ‖Jzeta s‖ := heqNorm
      _ ≤ (‖s‖ * ‖s - 1‖ * ‖s + 1‖) / (8 * (s.re + 1)) := by
        simpa only [mul_one_div] using mul_le_mul_of_nonneg_left hJ
          (mul_nonneg (mul_nonneg (norm_nonneg _) (norm_nonneg _)) (norm_nonneg _))
  have hmul := (le_div_iff₀ hden).mp hbound
  have hmul' : (4 * (s.re + 1)) * ‖s + 1‖ ≤
      (‖s‖ * ‖s - 1‖) * ‖s + 1‖ := by nlinarith only [hmul]
  have hprod : 4 * (s.re + 1) ≤ ‖s‖ * ‖s - 1‖ :=
    (mul_le_mul_iff_left₀ hplus).mp hmul'
  have hn : ‖s‖ ^ 2 = s.re ^ 2 + s.im ^ 2 := by
    rw [Complex.sq_norm, Complex.normSq_apply]
  have hn1 : ‖s - 1‖ ^ 2 = (s.re - 1) ^ 2 + s.im ^ 2 := by
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp only [Complex.sub_re, Complex.one_re, Complex.sub_im, Complex.one_im, sub_zero]
  have hAMGM : ‖s‖ * ‖s - 1‖ ≤ s.re ^ 2 - s.re + 1 / 2 + s.im ^ 2 := by
    nlinarith [sq_nonneg (‖s‖ - ‖s - 1‖)]
  have hσ : (s.re - 1 / 2) * (s.re - 9 / 2) ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos (by linarith) (by linarith)
  have ht2 : s.im ^ 2 < 2.39 ^ 2 := by
    nlinarith [sq_abs s.im, abs_nonneg s.im]
  nlinarith only [hprod, hAMGM, hσ, ht2]

/-- Every nontrivial zero has imaginary part of absolute value at least `2.39`. -/
theorem abs_im_ge_of_nontrivial_zero {s : ℂ} (hz : riemannZeta s = 0)
    (hσ0 : 0 < s.re) (hσ1 : s.re < 1) : 2.39 ≤ |s.im| := by
  by_contra ht
  have ht' : |s.im| < 2.39 := lt_of_not_ge ht
  by_cases hh : 1 / 2 ≤ s.re
  · have hs1 : s ≠ 1 := by
      intro hs
      rw [hs] at hσ1
      norm_num at hσ1
    have hzF : zetaF s = 0 := by rw [zetaF_of_ne hs1, hz, mul_zero]
    exact zetaF_ne_zero_of_half_le_re_of_abs_im_lt hh hσ1.le ht' hzF
  · have href0 : 0 < (1 - s).re := by simp only [Complex.sub_re, Complex.one_re]; linarith
    have href1 : (1 - s).re < 1 := by simp only [Complex.sub_re, Complex.one_re]; linarith
    have hξ : xiF (1 - s) = 0 := by
      rw [xiF_one_sub]
      exact (xiF_eq_zero_iff hσ0 hσ1).mpr hz
    have hrefz := (xiF_eq_zero_iff href0 href1).mp hξ
    have hrefne : 1 - s ≠ 1 := by
      intro heq
      rw [heq] at href1
      norm_num at href1
    have hrefF : zetaF (1 - s) = 0 := by
      rw [zetaF_of_ne hrefne, hrefz, mul_zero]
    have hrefhalf : 1 / 2 ≤ (1 - s).re := by
      simp only [Complex.sub_re, Complex.one_re]
      linarith
    have hreft : |(1 - s).im| < 2.39 := by
      simpa only [Complex.sub_im, Complex.one_im, zero_sub, abs_neg] using ht'
    exact zetaF_ne_zero_of_half_le_re_of_abs_im_lt hrefhalf href1.le hreft hrefF

end TernaryGoldbach.Explicit
