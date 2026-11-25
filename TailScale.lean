module

public import LogCertificate
public import RegularizedMellin

@[expose] public section


open Real
noncomputable section
namespace GoldbachEnergy

/-- Uniform control of the polynomial factor at all heights in the tail. -/
theorem tail_scale {N : ℝ} (hn : 0<N) (hL : 56 ≤ Real.log N) :
    (Real.log N)^4 ≤ 0.00000681*Real.sqrt N := by
  let L := Real.log N
  have hl : 56≤L := hL
  have hp : 0<L := by linarith
  have hx := Real.log_le_sub_one_of_pos (show 0<L/56 by positivity)
  have hlog : Real.log ((L/56)^4) ≤ (L-56)/2 := by rw [Real.log_pow]; norm_num; linarith
  have hpow := Real.exp_le_exp.mpr hlog
  rw [Real.exp_log (pow_pos (by positivity) 4)] at hpow
  have hs : Real.sqrt N = Real.exp (L/2) := by
    rw [Real.sqrt_eq_rpow,Real.rpow_def_of_pos hn]; congr 1; unfold L; ring
  have he : (27182818283/10000000000:ℝ)^28 ≤ Real.exp 28 := by
    rw [show (28:ℝ)=(28:ℕ)*(1:ℝ) by norm_num,Real.exp_nat_mul]
    apply pow_le_pow_left₀ (by norm_num)
    linarith only [Real.exp_one_gt_d9]
  have hnum : (56:ℝ)^4 ≤ 0.00000681*Real.exp 28 := by
    apply le_trans _ (mul_le_mul_of_nonneg_left he (by norm_num)); norm_num
  have h1 := mul_le_mul hpow hnum (by norm_num : (0:ℝ)≤56^4) (Real.exp_pos _).le
  rw [show Real.exp ((L-56)/2)*(0.00000681*Real.exp 28) = 0.00000681*Real.exp (L/2) by
        rw [mul_left_comm,← Real.exp_add]; congr 2; ring] at h1
  rw [hs]; change L^4 ≤ _
  calc L^4 = (L/56)^4*(56:ℝ)^4 := by ring
       _ ≤ _ := h1

theorem twist_norm_bounds (δ : ℝ) :
    1 ≤ ‖twistRate δ‖ ∧ ‖twistRate δ‖ ≤ 1+6.29*|δ| := by
  constructor
  · simpa [twistRate] using Complex.abs_re_le_norm (twistRate δ)
  · unfold twistRate
    calc _ ≤ ‖(1:ℂ)‖+‖((2*π*δ:ℝ):ℂ)*Complex.I‖ := norm_sub_le _ _
      _ ≤ _ := by
        rw [norm_one,norm_mul,Complex.norm_I,mul_one,Complex.norm_real,Real.norm_eq_abs,abs_mul,
          abs_of_pos (show 0<2*π by positivity)]
        linarith only [mul_le_mul_of_nonneg_right (show 2*π ≤ 6.29 by linarith [Real.pi_lt_d6]) (abs_nonneg δ)]

theorem sqrt_twist_bound (δ : ℝ) : Real.sqrt ‖twistRate δ‖ ≤ 1+2.51*Real.sqrt |δ| := by
  apply (Real.sqrt_le_left (by positivity)).mpr
  have h := twist_norm_bounds δ
  nlinarith only [h.2,Real.sq_sqrt (abs_nonneg δ),Real.sqrt_nonneg |δ|,abs_nonneg δ]

#print axioms tail_scale
#print axioms sqrt_twist_bound
end GoldbachEnergy
