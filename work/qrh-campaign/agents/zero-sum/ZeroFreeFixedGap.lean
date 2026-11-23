import TernaryGoldbach.Explicit.ZeroFreeRegion
import ZetaLowUnconditional

open Complex Set Metric Filter MeasureTheory
open scoped Real Interval Topology ComplexConjugate ArithmeticFunction.vonMangoldt

namespace TernaryGoldbach.Explicit

theorem half_re_digamma_half_le_low {σ t : ℝ} (h1 : 1 < σ) (h2 : σ ≤ 2) (ht : 2.39 ≤ |t|) :
    1 / 2 * (Complex.digamma (((σ : ℂ) + t * I) / 2)).re ≤ 1 / 2 * Real.log |t| + 0.4 := by
  have e : ((σ : ℂ) + t * I) / 2 = ((σ / 2 : ℝ) : ℂ) + ((t / 2 : ℝ) : ℂ) * I := by push_cast; ring
  rw [e]
  have h := re_digamma_le' (x := σ / 2) (y := t / 2) (by linarith)
  have hl1 : Real.log (σ / 2 + 1) ≤ Real.log 2 := Real.log_le_log (by linarith) (by linarith)
  have hl2 := Real.log_two_lt_d9
  have hq : 1 + (t / 2) ^ 2 / (σ / 2) ^ 2 ≤ t ^ 2 * 1.18 := by
    rw [div_pow, div_pow, div_div_div_cancel_right₀ (by norm_num : (2:ℝ) ^ 2 ≠ 0)]
    have hσ2 : 1 ≤ σ ^ 2 := by nlinarith
    have ht2 : 2.39 ^ 2 ≤ t ^ 2 := by rw [← sq_abs]; nlinarith
    have : t ^ 2 / σ ^ 2 ≤ t ^ 2 := div_le_self (sq_nonneg t) hσ2
    nlinarith
  have hq0 : 0 < 1 + (t / 2) ^ 2 / (σ / 2) ^ 2 := by positivity
  have hl3 : Real.log (1 + (t / 2) ^ 2 / (σ / 2) ^ 2) ≤ 2 * Real.log |t| + Real.log 1.18 := by
    have ht0 : 0 < |t| := by linarith
    refine (Real.log_le_log hq0 hq).trans (le_of_eq ?_)
    have htne : t ≠ 0 := by intro h; rw [h, abs_zero] at ht; norm_num at ht
    rw [Real.log_mul (pow_ne_zero 2 htne) (by norm_num), ← sq_abs, Real.log_pow]; push_cast; ring
  have hl4 : Real.log 1.18 ≤ 0.18 := by
    have := Real.log_le_sub_one_of_pos (show (0:ℝ) < 1.18 by norm_num); linarith
  nlinarith

theorem vM_term_le_low {σ τ : ℝ} (hσ1 : 1 < σ) (hσ2 : σ ≤ 1.02) (hτ : 2.39 ≤ τ) {Z : ℝ}
    (hZ : Z ≤ (logDeriv xiF ((σ : ℂ) + τ * I)).re -
      (σ - 1 / 2) / (1.6181 - 1 / 2) * (logDeriv xiF ((1.6181 : ℝ) + τ * I)).re) :
    (LSeries (fun n => (Λ n : ℂ)) ((σ : ℂ) + τ * I)).re ≤
      2 / τ ^ 2 + (1 - (σ - 1 / 2) / (1.6181 - 1 / 2)) * (1 / 2 * Real.log τ + 0.4 - 1 / 2 * Real.log π) +
        1 / 2 * ((σ - 1 / 2) / (1.6181 - 1 / 2)) * (0.20604 + 11 / τ ^ 2) +
        (σ - 1 / 2) / (1.6181 - 1 / 2) *
          (1 / 1.6181 + 1 / (1.6181 - 1) - 1 / 2 * Real.log π +
            1 / 2 * (Real.log (1.6181 / 2 + 2) - 2 / 1.6181 - 1 / (1.6181 / 2 + 1))) - Z := by
  set κ := (σ - 1 / 2) / (1.6181 - 1 / 2) with hκ
  have hκ0 : 0 ≤ κ := div_nonneg (by linarith) (by norm_num)
  have hκ1 : κ ≤ 1 := by rw [hκ, div_le_one (by norm_num)]; linarith
  have hs : 1 < ((σ : ℂ) + τ * I).re := by simpa using hσ1
  have hs1 : 1 < (((1.6181 : ℝ) : ℂ) + τ * I).re := by simp; norm_num
  have hL := re_vM_eq hs
  have hL1 := re_vM_eq hs1
  -- `ℜ(−ζ'/ζ)(s₁) ≤ E₁`
  have hE1 := (re_vM_le (σ := 1.6181) (by norm_num) τ).trans (vM_real_le (by norm_num))
  -- small terms
  have hτ0 : 0 < τ := by linarith
  have r1 : (1 / ((σ : ℂ) + τ * I)).re ≤ 1.02 / τ ^ 2 := by
    rw [one_div, Complex.inv_re, Complex.normSq_apply]
    simp only [add_re, ofReal_re, mul_re, I_re, mul_zero, ofReal_im, I_im, mul_one, sub_self, add_zero,
      add_im, mul_im, zero_add]
    rw [div_le_div_iff₀ (by positivity) (by positivity)]
    nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ 1.02 - σ) (sq_nonneg τ), sq_nonneg σ]
  have r2 : (1 / ((σ : ℂ) + τ * I - 1)).re ≤ 0.02 / τ ^ 2 := by
    rw [one_div, Complex.inv_re, Complex.normSq_apply]
    simp only [sub_re, add_re, ofReal_re, mul_re, I_re, mul_zero, ofReal_im, I_im, mul_one, sub_self,
      add_zero, one_re, sub_im, add_im, mul_im, zero_add, one_im, sub_zero]
    rw [div_le_div_iff₀ (by positivity) (by positivity)]
    nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ 0.02 - (σ - 1)) (sq_nonneg τ), sq_nonneg (σ - 1)]
  have r3 : 0 ≤ (1 / (((1.6181 : ℝ) : ℂ) + τ * I)).re := by
    rw [one_div, Complex.inv_re]; apply div_nonneg _ (Complex.normSq_nonneg _); simp; norm_num
  have r4 : 0 ≤ (1 / (((1.6181 : ℝ) : ℂ) + τ * I - 1)).re := by
    rw [one_div, Complex.inv_re]; apply div_nonneg _ (Complex.normSq_nonneg _); simp; norm_num
  -- digamma
  have ed : ((σ : ℂ) + τ * I) / 2 = ((σ / 2 : ℝ) : ℂ) + ((τ / 2 : ℝ) : ℂ) * I := by push_cast; ring
  have ed1 : (((1.6181 : ℝ) : ℂ) + τ * I) / 2 = ((1.6181 / 2 : ℝ) : ℂ) + ((τ / 2 : ℝ) : ℂ) * I := by
    push_cast; ring
  have hψ1 := half_re_digamma_half_le_low hσ1 (by linarith) (by rw [abs_of_pos hτ0]; exact hτ)
  rw [abs_of_pos hτ0] at hψ1
  have hD := re_digamma_sub_le (a := σ / 2) (b := 1.6181 / 2) (y := τ / 2) (by linarith) (by linarith)
  rw [← ed, ← ed1] at hD
  have hD1 : (1.6181 / 2 - σ / 2) / (σ / 2 + 1) ≤ 0.20604 := by
    rw [div_le_iff₀ (by linarith)]; nlinarith
  have hD2 : 1.6181 / 2 / ((1.6181 / 2) ^ 2 + (τ / 2) ^ 2) + (1.6181 / 2 + 1) / ((1.6181 / 2 + 1) ^ 2 + (τ / 2) ^ 2)
      ≤ 11 / τ ^ 2 := by
    have a1 : 1.6181 / 2 / ((1.6181 / 2) ^ 2 + (τ / 2) ^ 2) ≤ 1.6181 / 2 / ((τ / 2) ^ 2) :=
      div_le_div_of_nonneg_left (by norm_num) (by positivity) (by nlinarith)
    have a2 : (1.6181 / 2 + 1) / ((1.6181 / 2 + 1) ^ 2 + (τ / 2) ^ 2) ≤ (1.6181 / 2 + 1) / ((τ / 2) ^ 2) :=
      div_le_div_of_nonneg_left (by norm_num) (by positivity) (by nlinarith)
    have e : 1.6181 / 2 / ((τ / 2) ^ 2) + (1.6181 / 2 + 1) / ((τ / 2) ^ 2) = 10.4724 / τ ^ 2 := by
      field_simp; ring
    have : 10.4724 / τ ^ 2 ≤ 11 / τ ^ 2 := div_le_div_of_nonneg_right (by norm_num) (by positivity)
    linarith
  -- combine
  set X := (logDeriv xiF ((σ : ℂ) + τ * I)).re
  set X1 := (logDeriv xiF (((1.6181 : ℝ) : ℂ) + τ * I)).re
  set P := (Complex.digamma (((σ : ℂ) + τ * I) / 2)).re
  set P1 := (Complex.digamma ((((1.6181 : ℝ) : ℂ) + τ * I) / 2)).re
  set E1 := 1 / 1.6181 + 1 / (1.6181 - 1) - 1 / 2 * Real.log π +
      1 / 2 * (Real.log (1.6181 / 2 + 2) - 2 / 1.6181 - 1 / (1.6181 / 2 + 1))
  set L1 := (LSeries (fun n => (Λ n : ℂ)) (((1.6181 : ℝ) : ℂ) + τ * I)).re
  have hZ' : Z ≤ X - κ * X1 := hZ
  have hPP : P - P1 ≤ 0.20604 + 11 / τ ^ 2 := by linarith
  have k1 : κ * L1 ≤ κ * E1 := mul_le_mul_of_nonneg_left hE1 hκ0
  have k2 : κ * (P - P1) ≤ κ * (0.20604 + 11 / τ ^ 2) := mul_le_mul_of_nonneg_left hPP hκ0
  have k3 : (1 - κ) * (1 / 2 * P) ≤ (1 - κ) * (1 / 2 * Real.log τ + 0.4) :=
    mul_le_mul_of_nonneg_left hψ1 (by linarith)
  have k4 : 0 ≤ κ * ((1 / (((1.6181 : ℝ) : ℂ) + τ * I)).re + (1 / (((1.6181 : ℝ) : ℂ) + τ * I - 1)).re) :=
    mul_nonneg hκ0 (by linarith)
  have hsplit : (1.02 / τ ^ 2) + 0.02 / τ ^ 2 ≤ 2 / τ ^ 2 := by
    rw [← add_div]; exact div_le_div_of_nonneg_right (by norm_num) (by positivity)
  rw [hL]
  rw [hL1] at k1
  linear_combination hZ' + k1 + (1 / 2 : ℝ) * k2 + k3 + k4 + r1 + r2 + hsplit




theorem vM_term_le_fixed {τ Z : ℝ} (hτ : 2.39 ≤ τ) (hτmax : τ ≤ 4e8)
    (hZ : Z ≤ (logDeriv xiF (((1.014 : ℝ) : ℂ) + τ * I)).re -
      (1.014 - 1 / 2) / (1.6181 - 1 / 2) *
        (logDeriv xiF (((1.6181 : ℝ) : ℂ) + τ * I)).re) :
    (LSeries (fun n => (Λ n : ℂ)) (((1.014 : ℝ) : ℂ) + τ * I)).re ≤ 6.85 - Z := by
  set κ : ℝ := (1.014 - 1 / 2) / (1.6181 - 1 / 2) with hκ
  set E1 : ℝ := 1 / 1.6181 + 1 / (1.6181 - 1) - 1 / 2 * Real.log π +
    1 / 2 * (Real.log (1.6181 / 2 + 2) - 2 / 1.6181 - 1 / (1.6181 / 2 + 1)) with hE1
  have hκ0 : 0 ≤ κ := by norm_num [κ]
  have hκ1 : 0 ≤ 1 - κ := by norm_num [κ]
  have hτ0 : 0 < τ := by linarith
  have hτsq : 2.39 ^ 2 ≤ τ ^ 2 := by nlinarith
  have h2 : 2 / τ ^ 2 ≤ 0.351 := by
    rw [div_le_iff₀ (by positivity : (0 : ℝ) < τ ^ 2)]
    nlinarith only [hτsq]
  have h11 : 11 / τ ^ 2 ≤ 1.926 := by
    rw [div_le_iff₀ (by positivity : (0 : ℝ) < τ ^ 2)]
    nlinarith only [hτsq]
  have hexp : (4e8 : ℝ) ≤ Real.exp 20 := by
    have h := exp_nat_ge' 20
    norm_num at h ⊢
    linarith
  have hlog : Real.log τ ≤ 20 := log_le_of_le_exp' hτ0 (hτmax.trans hexp)
  have hA : (1 - κ) * (1 / 2 * Real.log τ + 0.4 - 1 / 2 * Real.log π) ≤
      0.55 * 9.83 := by
    have ha : 1 / 2 * Real.log τ + 0.4 - 1 / 2 * Real.log π ≤ 9.83 := by
      linarith [log_pi_ge]
    calc
      _ ≤ (1 - κ) * 9.83 := mul_le_mul_of_nonneg_left ha hκ1
      _ ≤ 0.55 * 9.83 := by norm_num [κ]
  have hD : 1 / 2 * κ * (0.20604 + 11 / τ ^ 2) ≤ 0.491 := by
    have h := mul_le_mul_of_nonneg_left (add_le_add_left h11 0.20604)
      (show 0 ≤ 1 / 2 * κ by positivity)
    norm_num [κ] at h
    linarith
  have hE1u : E1 ≤ 1.2857 := by
    have hl := log280905_le
    have hp := log_pi_ge
    rw [hE1, show (1.6181 : ℝ) / 2 + 2 = 2.80905 by norm_num]
    norm_num
    linarith
  have hE : κ * E1 ≤ 0.592 := by
    have h := mul_le_mul_of_nonneg_left hE1u hκ0
    norm_num [κ] at h
    linarith
  have hb := vM_term_le_low (σ := 1.014) (by norm_num) (by norm_num) hτ hZ
  change (LSeries (fun n => (Λ n : ℂ)) (((1.014 : ℝ) : ℂ) + τ * I)).re ≤
    2 / τ ^ 2 + (1 - κ) * (1 / 2 * Real.log τ + 0.4 - 1 / 2 * Real.log π) +
      1 / 2 * κ * (0.20604 + 11 / τ ^ 2) + κ * E1 - Z at hb
  linarith only [hb, h2, hA, hD, hE]

theorem zero_free_fixed_pos {ρ : ℂ} (hρ : xiF ρ = 0)
    (ht : 2.39 ≤ ρ.im) (htmax : ρ.im ≤ 1e8) : ρ.re ≤ 249 / 250 := by
  by_contra hβ
  push_neg at hβ
  have hz := xiF_zero_re hρ
  have hβh : ρ.re ≠ 1 / 2 := by linarith
  have hσ : (1 : ℝ) < 1.014 := by norm_num
  have hσ2 : (1.014 : ℝ) ≤ 1.02 := by norm_num
  set κ : ℝ := (1.014 - 1 / 2) / (1.6181 - 1 / 2) with hκ
  have hκ0 : 0 ≤ κ := by norm_num [κ]
  have h1den : 0 < 1.014 - ρ.re := by linarith
  have h2den : 0 < 1.014 + ρ.re - 1 := by linarith
  have h3den : 0 < 1.6181 - ρ.re := by linarith
  have h4den : 0 < 1.6181 + ρ.re - 1 := by linarith
  have hr1 : 500 / 9 ≤ 1 / (1.014 - ρ.re) := by
    rw [le_div_iff₀ h1den]
    linarith
  have hr2 : 0.98 ≤ 1 / (1.014 + ρ.re - 1) := by
    rw [le_div_iff₀ h2den]
    linarith
  have hr3 : 1 / (1.6181 - ρ.re) ≤ 1.618 := by
    rw [div_le_iff₀ h3den]
    linarith
  have hr4 : 1 / (1.6181 + ρ.re - 1) ≤ 0.62 := by
    rw [div_le_iff₀ h4den]
    linarith
  have hr34 : κ * (1 / (1.6181 - ρ.re) + 1 / (1.6181 + ρ.re - 1)) ≤ 1.03 := by
    have h := mul_le_mul_of_nonneg_left (add_le_add hr3 hr4) hκ0
    norm_num [κ] at h
    linarith
  have hZlow : 55.5 ≤ (1 / (1.014 - ρ.re) + 1 / (1.014 + ρ.re - 1)) -
      κ * (1 / (1.6181 - ρ.re) + 1 / (1.6181 + ρ.re - 1)) := by
    linarith only [hr1, hr2, hr34]
  have hZ := stech_wrap_rho hσ hσ2 hρ hβh
  have hterm1 := vM_term_le_fixed ht (by linarith : ρ.im ≤ 4e8) (hZlow.trans hZ)
  have hterm2 := vM_term_le_fixed (τ := 2 * ρ.im) (by linarith) (by linarith)
    (stech_wrap (τ := 2 * ρ.im) hσ hσ2)
  have hterm3 := vM_term_le_fixed (τ := 3 * ρ.im) (by linarith) (by linarith)
    (stech_wrap (τ := 3 * ρ.im) hσ hσ2)
  have hterm4 := vM_term_le_fixed (τ := 4 * ρ.im) (by linarith) (by linarith)
    (stech_wrap (τ := 4 * ρ.im) hσ hσ2)
  have hreal : (LSeries (fun n => (Λ n : ℂ)) (((1.014 : ℝ) : ℂ) + ((0 : ℝ) : ℂ) * I)).re ≤ 500 / 7 := by
    refine (vM_real_le hσ).trans ?_
    have hlog : Real.log ((1.014 : ℝ) / 2 + 2) ≤ 0.9197 :=
      (Real.log_le_log (by norm_num) (by norm_num : (1.014 : ℝ) / 2 + 2 ≤ 2.5085)).trans log2585_le
    have hp := log_pi_ge
    norm_num at hlog ⊢
    linarith
  have hP := vM_positivity hσ ρ.im
  rw [show (0 : ℝ) * ρ.im = 0 by ring, show (1 : ℝ) * ρ.im = ρ.im by ring] at hP
  linarith only [hP, hreal, hterm1, hterm2, hterm3, hterm4]

theorem zero_free_fixed {ρ : ℂ} (hρ : xiF ρ = 0)
    (ht : 2.39 ≤ |ρ.im|) (htmax : |ρ.im| ≤ 1e8) : ρ.re ≤ 249 / 250 := by
  rcases le_or_gt 0 ρ.im with h | h
  · rw [abs_of_nonneg h] at ht htmax
    exact zero_free_fixed_pos hρ ht htmax
  · have hc : xiF (conj ρ) = 0 := by rw [xiF_conj, hρ, map_zero]
    have hb := zero_free_fixed_pos hc
      (by simpa only [Complex.conj_im, abs_of_neg h] using ht)
      (by simpa only [Complex.conj_im, abs_of_neg h] using htmax)
    simpa only [Complex.conj_re] using hb

theorem zeta_zero_re_le_fixed {ρ : ℂ} (hρ : riemannZeta ρ = 0)
    (h0 : 0 < ρ.re) (h1 : ρ.re < 1) (htmax : |ρ.im| ≤ 1e8) :
    ρ.re ≤ 249 / 250 := by
  exact zero_free_fixed ((xiF_eq_zero_iff h0 h1).mpr hρ)
    (abs_im_ge_of_nontrivial_zero hρ h0 h1) htmax

end TernaryGoldbach.Explicit

