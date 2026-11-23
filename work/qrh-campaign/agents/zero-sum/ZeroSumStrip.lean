import TernaryGoldbach.Explicit.ZeroSumGen
import TernaryGoldbach.Explicit.XiPartial

open Complex MeasureTheory Set Filter Metric
open scoped Real

namespace TernaryGoldbach.Explicit

noncomputable def ZStrip (B : ℝ → ℝ) (T0 : ℝ) : ℝ :=
  Real.log (B (T0 + 3.48) / 0.355) / Real.log (10 / 2.7)

theorem count_strip_windowG {f : ℂ → ℂ} {B : ℝ → ℝ} {κ : ℝ}
    (hp : PolyDatum f B κ) {T T0 : ℝ} (hT0 : 0 ≤ T0) (S : Finset ℂ)
    (hS : S ⊆ zerosRectD f T) (hre : ∀ u ∈ S, 0 ≤ u.re ∧ u.re ≤ 1)
    (him : ∀ u ∈ S, |u.im| ≤ T0) (k : ℕ) :
    ∑ u ∈ S.filter (fun u => (⌊u.im / 3.48⌋ + Jl T0).toNat = k),
      (multRectD f T u : ℝ) ≤ ZStrip B T0 := by
  set F := S.filter (fun u => (⌊u.im / 3.48⌋ + Jl T0).toNat = k) with hF
  rcases F.eq_empty_or_nonempty with hE | ⟨u0, hu0⟩
  · rw [hE, Finset.sum_empty]
    exact div_nonneg (hp.log_pos _).le (log_ratio_pos (by norm_num) (by norm_num)).le
  set c := ((k : ℝ) - Jl T0 + 1 / 2) * 3.48 with hc
  have hJ := lt_Jl hT0
  have hwin : ∀ u ∈ F, |u.im - c| ≤ 1.74 := by
    intro u hu
    obtain ⟨huS, hk⟩ := Finset.mem_filter.1 hu
    have hw := mem_line_window (h := 3.48) (by norm_num) hJ (him u huS)
    rw [hk] at hw
    rw [abs_le]
    constructor <;> linarith [hw.1, hw.2]
  have hball : ∀ u ∈ F, ‖u - (2 + c * I)‖ ≤ 2.7 := by
    intro u hu
    obtain ⟨hr0, hr1⟩ := hre u (Finset.mem_filter.1 hu).1
    refine norm_le_of_re_im (a := 2) (b := 1.74) (by norm_num) ?_ ?_ (by norm_num)
    · simp only [Complex.sub_re, Complex.add_re, Complex.re_ofNat, Complex.mul_re,
        Complex.ofReal_re, Complex.I_re, mul_zero, Complex.ofReal_im,
        Complex.I_im, mul_one, sub_zero]
      rw [abs_le]
      constructor <;> linarith
    · simp only [Complex.sub_im, Complex.add_im, Complex.im_ofNat, Complex.mul_im,
        Complex.ofReal_re, Complex.I_re, mul_zero, Complex.ofReal_im,
        Complex.I_im, mul_one, zero_add]
      exact hwin u hu
  have hcount := sum_multRectD_le hp F ((Finset.filter_subset _ _).trans hS) c
    (r := 2.7) (by norm_num) (by norm_num) hball
  have hcT : |c| ≤ |T0 + 3.48| := by
    have h0 := hwin u0 hu0
    have h0' := him u0 (Finset.mem_filter.1 hu0).1
    rw [abs_of_pos (by linarith : (0 : ℝ) < T0 + 3.48)]
    have hdist := abs_sub_abs_le_abs_sub c u0.im
    rw [abs_sub_comm] at hdist
    linarith
  refine hcount.trans ?_
  unfold ZStrip
  exact div_le_div_of_nonneg_right (hp.log_mono hcT)
    (log_ratio_pos (by norm_num) (by norm_num)).le

theorem sum_mult_strip_le {f : ℂ → ℂ} {B : ℝ → ℝ} {κ : ℝ}
    (hp : PolyDatum f B κ) {T T0 : ℝ} (hT0 : 0 ≤ T0) (S : Finset ℂ)
    (hS : S ⊆ zerosRectD f T) (hre : ∀ u ∈ S, 0 ≤ u.re ∧ u.re ≤ 1)
    (him : ∀ u ∈ S, |u.im| ≤ T0) :
    ∑ u ∈ S, (multRectD f T u : ℝ) ≤ 2 * Jl T0 * ZStrip B T0 := by
  have hZ : 0 ≤ ZStrip B T0 :=
    div_nonneg (hp.log_pos _).le (log_ratio_pos (by norm_num) (by norm_num)).le
  have hsum := sum_window_le (fun u => (multRectD f T u : ℝ))
    (fun u _ => Nat.cast_nonneg _) (h := 3.48) (by norm_num) (Jl T0)
    (lt_Jl hT0) him hZ (count_strip_windowG hp hT0 S hS hre him)
    (f := fun _ => (1 : ℂ)) (f' := fun _ => (0 : ℂ))
    (fun t => hasDerivAt_const t (1 : ℂ)) continuous_const
  simp only [norm_one, norm_zero, mul_one, intervalIntegral.integral_const,
    smul_eq_mul, mul_zero, add_zero, sub_neg_eq_add] at hsum
  convert hsum using 1 <;> ring

theorem norm_zero_sum_le_rpow_mul {S : Finset ℂ} (m : ℂ → ℕ) (M : ℂ → ℂ)
    {x θ : ℝ} (hx : 1 ≤ x) (hre : ∀ u ∈ S, u.re ≤ θ) :
    ‖∑ u ∈ S, (m u : ℂ) * (M u * (x : ℂ) ^ u)‖ ≤
      x ^ θ * ∑ u ∈ S, (m u : ℝ) * ‖M u‖ := by
  have hx0 : 0 < x := lt_of_lt_of_le zero_lt_one hx
  calc
    ‖∑ u ∈ S, (m u : ℂ) * (M u * (x : ℂ) ^ u)‖
        ≤ ∑ u ∈ S, ‖(m u : ℂ) * (M u * (x : ℂ) ^ u)‖ := norm_sum_le _ _
    _ ≤ ∑ u ∈ S, x ^ θ * ((m u : ℝ) * ‖M u‖) := by
      apply Finset.sum_le_sum
      intro u hu
      rw [norm_mul, norm_mul, Complex.norm_natCast, norm_cpow_x hx0]
      calc
        (m u : ℝ) * (‖M u‖ * x ^ u.re)
            ≤ (m u : ℝ) * (‖M u‖ * x ^ θ) :=
          mul_le_mul_of_nonneg_left
            (mul_le_mul_of_nonneg_left
              (Real.rpow_le_rpow_of_exponent_le hx (hre u hu)) (norm_nonneg _))
            (Nat.cast_nonneg _)
        _ = _ := by ring
    _ = _ := (Finset.mul_sum S (fun u => (m u : ℝ) * ‖M u‖) (x ^ θ)).symm



theorem sum_mult_zeta_low_le {T : ℝ} (S : Finset ℂ)
    (hS : S ⊆ zerosRectD zetaF T)
    (hre : ∀ u ∈ S, 0 ≤ u.re ∧ u.re ≤ 1)
    (him : ∀ u ∈ S, |u.im| ≤ 1e8) :
    ∑ u ∈ S, (multRectD zetaF T u : ℝ) ≤ 1e18 := by
  have hlog : (1 / 2 : ℝ) ≤ Real.log (10 / 2.7) := by
    rw [show (10 / 2.7 : ℝ) = (0.27 : ℝ)⁻¹ by norm_num, Real.log_inv]
    have h := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 0.27)
    linarith
  have hZ : ZStrip BPz2 1e8 ≤ 1e9 := by
    unfold ZStrip
    apply (div_le_iff₀ (by linarith : (0 : ℝ) < Real.log (10 / 2.7))).2
    have hnum := log_BPz2_lin (1e8 + 3.48)
    norm_num at hnum
    nlinarith only [hnum, hlog]
  have hZ0 : 0 ≤ ZStrip BPz2 1e8 :=
    div_nonneg (polyDatum_zeta2.log_pos _).le (by linarith)
  have hJ : (Jl (1e8 : ℝ) : ℝ) ≤ 1e8 := by norm_num [Jl]
  have hcount := sum_mult_strip_le polyDatum_zeta2 (by norm_num : (0 : ℝ) ≤ 1e8)
    S hS hre him
  have hprod := mul_le_mul hJ hZ hZ0 (by norm_num : (0 : ℝ) ≤ 1e8)
  nlinarith only [hcount, hprod]

/-- A logarithmic Jensen estimate for all low zeros, retaining their multiplicities. -/
theorem sum_mult_zeta_low_sharp_le {T : ℝ} (S : Finset ℂ)
    (hS : S ⊆ zerosRectD zetaF T)
    (hre : ∀ u ∈ S, 0 ≤ u.re ∧ u.re ≤ 1)
    (him : ∀ u ∈ S, |u.im| ≤ 1e8) :
    ∑ u ∈ S, (multRectD zetaF T u : ℝ) ≤ 3e10 := by
  have hlog : (1 / 2 : ℝ) ≤ Real.log (10 / 2.7) := by
    rw [show (10 / 2.7 : ℝ) = (0.27 : ℝ)⁻¹ by norm_num, Real.log_inv]
    have h := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 0.27)
    linarith
  have hexp : (1.3e8 : ℝ) ≤ Real.exp 19 := by
    have h := exp_nat_ge' 19
    norm_num at h ⊢
    linarith
  have hlog1 : Real.log (|(1e8 + 3.48 : ℝ)| + 22) ≤ 19 := by
    refine (Real.log_le_iff_le_exp (by norm_num)).2 ?_
    exact le_trans (by norm_num) hexp
  have hlog2 : Real.log (1.25 * (|(1e8 + 3.48 : ℝ)| + 11)) ≤ 19 := by
    refine (Real.log_le_iff_le_exp (by norm_num)).2 ?_
    exact le_trans (by norm_num) hexp
  have hZ : ZStrip BPz2 1e8 ≤ 401 := by
    unfold ZStrip
    apply (div_le_iff₀ (by linarith : (0 : ℝ) < Real.log (10 / 2.7))).2
    have hnum := log_BPz2_le' (1e8 + 3.48)
    nlinarith only [hnum, hlog1, hlog2, hlog]
  have hZ0 : 0 ≤ ZStrip BPz2 1e8 :=
    div_nonneg (polyDatum_zeta2.log_pos _).le (by linarith)
  have hJ : (Jl (1e8 : ℝ) : ℝ) ≤ 3e7 := by norm_num [Jl]
  have hcount := sum_mult_strip_le polyDatum_zeta2 (by norm_num : (0 : ℝ) ≤ 1e8)
    S hS hre him
  have hprod := mul_le_mul hJ hZ hZ0 (by norm_num : (0 : ℝ) ≤ 3e7)
  nlinarith only [hcount, hprod]

theorem sum_weight_zeta_low_le {T C : ℝ} (S : Finset ℂ)
    (hS : S ⊆ zerosRectD zetaF T)
    (hre : ∀ u ∈ S, 0 ≤ u.re ∧ u.re ≤ 1)
    (him : ∀ u ∈ S, |u.im| ≤ 1e8)
    (g : ℂ → ℝ) (hg0 : ∀ u ∈ S, 0 ≤ g u) (hC : 0 ≤ C)
    (hg : ∀ u ∈ S, g u * max (1 / 8) |u.im| ≤ C) :
    ∑ u ∈ S, (multRectD zetaF T u : ℝ) * g u ≤ 1e20 * C := by
  have hpoint : ∀ u ∈ S, g u ≤ 8 * C := by
    intro u hu
    have h := mul_le_mul_of_nonneg_left (le_max_left (1 / 8 : ℝ) |u.im|) (hg0 u hu)
    have h' := hg u hu
    linarith
  calc
    ∑ u ∈ S, (multRectD zetaF T u : ℝ) * g u
        ≤ ∑ u ∈ S, (multRectD zetaF T u : ℝ) * (8 * C) :=
      Finset.sum_le_sum fun u hu =>
        mul_le_mul_of_nonneg_left (hpoint u hu) (Nat.cast_nonneg _)
    _ = (∑ u ∈ S, (multRectD zetaF T u : ℝ)) * (8 * C) :=
      (Finset.sum_mul S (fun u => (multRectD zetaF T u : ℝ)) (8 * C)).symm
    _ ≤ 1e18 * (8 * C) :=
      mul_le_mul_of_nonneg_right (sum_mult_zeta_low_le S hS hre him) (by positivity)
    _ ≤ 1e20 * C := by nlinarith



theorem sum_weight_zeta_low_twenty_four_le {T C : ℝ} (S : Finset ℂ)
    (hS : S ⊆ zerosRectD zetaF T)
    (hre : ∀ u ∈ S, 0 ≤ u.re ∧ u.re ≤ 1)
    (him : ∀ u ∈ S, |u.im| ≤ 1e8)
    (g : ℂ → ℝ) (hg0 : ∀ u ∈ S, 0 ≤ g u) (hC : 0 ≤ C)
    (hg : ∀ u ∈ S, g u * max (1 / 24) |u.im| ≤ C) :
    ∑ u ∈ S, (multRectD zetaF T u : ℝ) * g u ≤ 1e20 * C := by
  have hpoint : ∀ u ∈ S, g u ≤ 24 * C := by
    intro u hu
    have h := mul_le_mul_of_nonneg_left (le_max_left (1 / 24 : ℝ) |u.im|) (hg0 u hu)
    have h' := hg u hu
    linarith
  calc
    ∑ u ∈ S, (multRectD zetaF T u : ℝ) * g u
        ≤ ∑ u ∈ S, (multRectD zetaF T u : ℝ) * (24 * C) :=
      Finset.sum_le_sum fun u hu =>
        mul_le_mul_of_nonneg_left (hpoint u hu) (Nat.cast_nonneg _)
    _ = (∑ u ∈ S, (multRectD zetaF T u : ℝ)) * (24 * C) :=
      (Finset.sum_mul S (fun u => (multRectD zetaF T u : ℝ)) (24 * C)).symm
    _ ≤ 1e18 * (24 * C) :=
      mul_le_mul_of_nonneg_right (sum_mult_zeta_low_le S hS hre him) (by positivity)
    _ ≤ 1e20 * C := by nlinarith

end TernaryGoldbach.Explicit
