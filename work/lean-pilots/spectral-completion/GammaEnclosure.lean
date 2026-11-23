import Mathlib.Analysis.SpecialFunctions.Gamma.BohrMollerup
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Tactic

open MeasureTheory Set
open scoped Real

namespace SpectralCompletion

lemma gamma_between_one_two {x : ℝ} (h1 : 1 ≤ x) (h2 : x ≤ 2) :
    Real.Gamma x ≤ 1 := by
  have h := Real.convexOn_Gamma.2 (by norm_num : (1 : ℝ) ∈ Ioi 0)
    (by norm_num : (2 : ℝ) ∈ Ioi 0) (by linarith : 0 ≤ 2-x)
    (by linarith : 0 ≤ x-1) (by ring : (2-x)+(x-1)=1)
  have hG : Real.Gamma 2 = 1 := by
    simpa using (Real.Gamma_add_one (by norm_num : (1 : ℝ) ≠ 0))
  simp only [smul_eq_mul, Real.Gamma_one, hG] at h
  convert h using 1 <;> congr 1 <;> ring

lemma gamma_real_bounds :
    (16/15 : ℝ) ≤ Real.Gamma (3/4) ∧ Real.Gamma (3/4) ≤ 4/3 ∧
      Real.Gamma (1/4) ≤ 4 ∧ Real.Gamma (5/4) ≤ 1 := by
  have h7 := gamma_between_one_two (x := 7/4) (by norm_num) (by norm_num)
  have h5 := gamma_between_one_two (x := 5/4) (by norm_num) (by norm_num)
  have hrec7 := Real.Gamma_add_one (by norm_num : (3/4 : ℝ) ≠ 0)
  have hrec5 := Real.Gamma_add_one (by norm_num : (1/4 : ℝ) ≠ 0)
  norm_num only [show (3/4:ℝ)+1=7/4 by norm_num,
    show (1/4:ℝ)+1=5/4 by norm_num] at hrec7 hrec5
  have hc := Real.convexOn_Gamma.2 (by norm_num : (3/4 : ℝ) ∈ Ioi 0)
    (by norm_num : (7/4 : ℝ) ∈ Ioi 0)
    (by norm_num : (0:ℝ) ≤ 3/4) (by norm_num : (0:ℝ) ≤ 1/4)
    (by norm_num : (3/4:ℝ)+1/4=1)
  norm_num [smul_eq_mul, Real.Gamma_one] at hc
  constructor
  · linarith
  constructor
  · linarith
  constructor
  · linarith
  · exact h5

lemma abs_log_le_half_powers {x : ℝ} (hx : 0 < x) :
    |Real.log x| ≤ x^(1/2:ℝ)+x^(-1/2:ℝ) := by
  have hp := Real.two_mul_le_exp (x := Real.log x / 2)
  have hn := Real.two_mul_le_exp (x := -Real.log x / 2)
  rw [Real.rpow_def_of_pos hx, Real.rpow_def_of_pos hx]
  have e1 : Real.log x * (1/2:ℝ) = Real.log x / 2 := by ring
  have e2 : Real.log x * (-1/2:ℝ) = -Real.log x / 2 := by ring
  rw [e1, e2]
  apply abs_le.mpr
  constructor <;> nlinarith only [hp, hn, Real.exp_pos (Real.log x/2),
    Real.exp_pos (-Real.log x/2)]

lemma cpow_vertical_factor {x : ℝ} (hx : 0 < x) (a b : ℝ) :
    (x:ℂ)^((a:ℂ)+Complex.I*b-1) =
      (x^(a-1):ℝ) * Complex.exp (Complex.I * (b*Real.log x : ℝ)) := by
  have hxC : (x:ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  rw [show (a:ℂ)+Complex.I*b-1 = ((a-1:ℝ):ℂ)+Complex.I*b by push_cast; ring,
    Complex.cpow_add _ _ hxC, ← Complex.ofReal_cpow hx.le,
    Complex.cpow_def_of_ne_zero hxC, ← Complex.ofReal_log hx.le]
  congr 2
  push_cast
  ring

lemma gamma_integrand_difference_bound {x : ℝ} (hx : 0 < x) (a b : ℝ) :
    ‖(Real.exp (-x):ℂ)*(x:ℂ)^((a:ℂ)+Complex.I*b-1) -
       (Real.exp (-x):ℂ)*(x:ℂ)^((a:ℂ)-1)‖ ≤
    |b| *(Real.exp (-x)*x^(a-1+1/2) + Real.exp (-x)*x^(a-1-1/2)) := by
  rw [cpow_vertical_factor hx,
    show (a:ℂ)-1 = ((a-1:ℝ):ℂ) by push_cast; rfl,
    ← Complex.ofReal_cpow hx.le]
  rw [show (Real.exp (-x):ℂ)*((x^(a-1):ℝ)*Complex.exp (Complex.I*(b*Real.log x:ℝ))) -
      (Real.exp (-x):ℂ)*(x^(a-1):ℝ) =
      ((Real.exp (-x)*x^(a-1):ℝ):ℂ)*(Complex.exp (Complex.I*(b*Real.log x:ℝ))-1) by
        push_cast; ring,
    norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (mul_nonneg (Real.exp_pos _).le (Real.rpow_nonneg hx.le _))]
  calc
    _ ≤ (Real.exp (-x)*x^(a-1))*|b *Real.log x| :=
      mul_le_mul_of_nonneg_left (by simpa only [Real.norm_eq_abs] using
        (Real.norm_exp_I_mul_ofReal_sub_one_le (x := b*Real.log x)))
        (mul_nonneg (Real.exp_pos _).le (Real.rpow_nonneg hx.le _))
    _ ≤ (Real.exp (-x)*x^(a-1))*(|b| *(x^(1/2:ℝ)+x^(-1/2:ℝ))) := by
      rw [abs_mul]
      gcongr
      exact abs_log_le_half_powers hx
    _ = _ := by
      rw [Real.rpow_add hx, sub_eq_add_neg (a-1) (1/2), Real.rpow_add hx]
      ring

lemma gamma_vertical_difference :
    ‖Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128)) - (Real.Gamma (3/4):ℂ)‖ ≤ 25/128 := by
  have hi1 := Complex.GammaIntegral_convergent
    (s := (3/4:ℂ)+Complex.I*(5/128)) (by norm_num)
  have hi0 := Complex.GammaIntegral_convergent (s := (3/4:ℂ)) (by norm_num)
  have hp := Real.GammaIntegral_convergent (s := 5/4) (by norm_num)
  have hm := Real.GammaIntegral_convergent (s := 1/4) (by norm_num)
  rw [← Complex.Gamma_ofReal, Complex.Gamma_eq_integral (by norm_num :
    0 < ((3/4:ℂ)+Complex.I*(5/128)).re),
    Complex.Gamma_eq_integral (by norm_num : 0 < ((3/4:ℝ):ℂ).re)]
  unfold Complex.GammaIntegral
  simp only [Complex.ofReal_div, Complex.ofReal_ofNat]
  rw [← integral_sub hi1 hi0]
  calc
      _ ≤ ∫ x in Ioi (0:ℝ), (5/128:ℝ)*
          (Real.exp (-x)*x^(5/4-1:ℝ)+Real.exp (-x)*x^(1/4-1:ℝ)) := by
        apply norm_integral_le_of_norm_le ((hp.add hm).const_mul (5/128:ℝ))
        filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
        convert gamma_integrand_difference_bound hx (3/4) (5/128) using 1 <;> norm_num
      _ = (5/128:ℝ)*(Real.Gamma (5/4)+Real.Gamma (1/4)) := by
        rw [integral_const_mul, integral_add hp hm,
          ← Real.Gamma_eq_integral (by norm_num : (0:ℝ)<5/4),
          ← Real.Gamma_eq_integral (by norm_num : (0:ℝ)<1/4)]
      _ ≤ 25/128 := by
        have h := gamma_real_bounds
        linarith only [h.2.2.1, h.2.2.2]

noncomputable def gammaPhase : ℂ :=
  Complex.exp (Complex.I * (((5/128)*Real.log (4/Real.pi):ℝ):ℂ)) *
    Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))

lemma phase_abs_le : |(5/128:ℝ)*Real.log (4/Real.pi)| ≤ 5/384 := by
  have hpi := Real.pi_gt_three
  have hpi4 := Real.pi_lt_four
  have hp : 0 < 4/Real.pi := div_pos (by norm_num) Real.pi_pos
  have h1 : 1 ≤ 4/Real.pi := (le_div_iff₀ Real.pi_pos).mpr (by linarith)
  have h4 : 4/Real.pi < 4/3 := (div_lt_iff₀ Real.pi_pos).mpr (by linarith)
  rw [abs_of_nonneg (mul_nonneg (by norm_num) (Real.log_nonneg h1))]
  have hlog := Real.log_le_sub_one_of_pos hp
  linarith

lemma gammaPhase_distance :
    ‖gammaPhase - (Real.Gamma (3/4):ℂ)‖ ≤ 245/1152 := by
  let e := Complex.exp (Complex.I * (((5/128)*Real.log (4/Real.pi):ℝ):ℂ))
  let g := (Real.Gamma (3/4):ℂ)
  have he : ‖e‖ = 1 := Complex.norm_exp_I_mul_ofReal _
  have he1 : ‖e-1‖ ≤ 5/384 :=
    (Real.norm_exp_I_mul_ofReal_sub_one_le).trans (by
      simpa only [Real.norm_eq_abs] using phase_abs_le)
  have hg : ‖g‖ ≤ 4/3 := by
    dsimp [g]
    rw [Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (Real.Gamma_pos_of_pos (by norm_num : (0:ℝ)<3/4))]
    exact gamma_real_bounds.2.1
  have hid : gammaPhase-g =
      e*(Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))-g)+(e-1)*g := by
    dsimp [gammaPhase, e]; ring
  rw [hid]
  calc
    _ ≤ ‖e*(Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))-g)‖+‖(e-1)*g‖ := norm_add_le _ _
    _ = ‖Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))-g‖+‖e-1‖*‖g‖ := by
      rw [norm_mul, norm_mul, he, one_mul]
    _ ≤ (25/128:ℝ)+(5/384)*(4/3) := add_le_add gamma_vertical_difference
      (mul_le_mul he1 hg (norm_nonneg _) (by norm_num))
    _ = _ := by norm_num

theorem gammaPhase_enclosure :
    (3/4:ℝ) ≤ gammaPhase.re ∧ |gammaPhase.im| ≤ 1/4 := by
  have hd := gammaPhase_distance
  have hr := Complex.abs_re_le_norm (gammaPhase - (Real.Gamma (3/4):ℂ))
  have hi := Complex.abs_im_le_norm (gammaPhase - (Real.Gamma (3/4):ℂ))
  simp only [Complex.sub_re, Complex.ofReal_re] at hr
  simp only [Complex.sub_im, Complex.ofReal_im, sub_zero] at hi
  have hlo := gamma_real_bounds.1
  constructor
  · have hh := (abs_le.mp (hr.trans hd)).1
    linarith
  · linarith

end SpectralCompletion


