module

public import TailHeight

@[expose] public section


open Real TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

/-- The height and conductor enter the Jensen majorant mainly through their product. -/
theorem conductor_height_product {q d : ℕ} [NeZero d] (hd : d≤q) {Y : ℝ} :
    BP d Y/0.355 ≤ (4*(q:ℝ)*(|Y|+22))^11 := by
  have h1 : (0:ℝ)<d := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne d)
  have hq : (d:ℝ)≤q := by exact_mod_cast hd
  have hd1 : (1:ℝ)≤d := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne d)
  have hq1 := hd1.trans hq
  have ha := abs_nonneg Y
  unfold BP
  rw [show (10:ℝ)=(10:ℕ) by norm_num,Real.rpow_natCast,div_le_iff₀ (by norm_num)]
  calc 1400*(d:ℝ)^9*(d+1)*(|Y|+22)*(1.25*(|Y|+11))^10
      ≤ 1400*(q:ℝ)^9*(2*q)*(|Y|+22)*(1.25*(|Y|+22))^10 := by gcongr <;> linarith
    _ = (1400*2*(1.25:ℝ)^10)*(q:ℝ)^10*(|Y|+22)^11 := by ring
    _ ≤ ((4:ℝ)^11*0.355)*(q:ℝ)^11*(|Y|+22)^11 := by
      apply mul_le_mul_of_nonneg_right _ (by positivity)
      apply mul_le_mul (by norm_num) (pow_le_pow_right₀ hq1 (by decide : 10 ≤ 11)) (by positivity) (by norm_num)
    _ = _ := by ring

theorem product_log_BP {q d : ℕ} [NeZero d] (hd : d≤q) {N Y : ℝ}
    (hn : 0<N) (hw : 4*(q:ℝ)*(|Y|+22)≤N) :
    Real.log (BP d Y/0.355) ≤ 11*Real.log N := by
  have hd0 : (0:ℝ)<d := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne d)
  have h := (conductor_height_product (Y:=Y) hd).trans
    (pow_le_pow_left₀ (by positivity) hw 11)
  simpa only [Real.log_pow,Nat.cast_ofNat] using Real.log_le_log (by unfold BP; positivity) h

theorem minor_product_bound {N τ δ : ℝ} {q : ℕ} (hq0 : 0<q) (hn : 0<N)
    (hq : 248*(q:ℝ)≤N) (ht : 64≤τ) (hd : |δ| ≤ N/(τ*q)) :
    4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N := by
  have hq' : (0:ℝ)<q := by exact_mod_cast hq0
  have hτ : 0<τ := by linarith
  have hδ := (le_div_iff₀ (mul_pos hτ hq')).mp hd
  have ha : ‖twistRate δ‖ ≤ 1+8*|δ| := by
    unfold twistRate
    calc _ ≤ ‖(1:ℂ)‖+‖((2*π*δ:ℝ):ℂ)*Complex.I‖ := norm_sub_le _ _
      _ ≤ _ := by
        rw [norm_one,norm_mul,Complex.norm_I,mul_one,Complex.norm_real,Real.norm_eq_abs,abs_mul,
          abs_of_pos (show 0<2*π by positivity)]
        linarith only [mul_le_mul_of_nonneg_right (show 2*π ≤ 8 by linarith [Real.pi_lt_four]) (abs_nonneg δ)]
  rw [abs_of_nonneg (by positivity)]
  have hh := mul_le_mul_of_nonneg_left ha hq'.le
  have hlow := mul_le_mul_of_nonneg_right ht (mul_nonneg (abs_nonneg δ) hq'.le)
  nlinarith only [hδ,hh,hlow,hq]

theorem all_levels_small {N : ℝ} (hn : 1≤N) (hl : 44≤Real.log N) :
    248*(4900*(Real.log N)^4) ≤ N := by
  have hL0 : 0<Real.log N := by linarith
  have h := Real.pow_div_factorial_le_exp (Real.log N) hL0.le 16
  rw [Real.exp_log (lt_of_lt_of_le zero_lt_one hn)] at h
  have hf : ((16:ℕ).factorial:ℝ) = 20922789888000 := by norm_num [Nat.factorial]
  rw [hf] at h
  have h12 := pow_le_pow_left₀ (by norm_num : (0:ℝ)≤44) hl 12
  have h' := mul_le_mul_of_nonneg_right h12 (pow_nonneg hL0.le 4)
  nlinarith only [h,h',pow_nonneg hL0.le 4]

#print axioms product_log_BP
#print axioms minor_product_bound
#print axioms all_levels_small
end GoldbachEnergy
