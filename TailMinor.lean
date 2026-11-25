module

public import TailBudget

@[expose] public section


open Real
noncomputable section
namespace GoldbachEnergy

theorem minor_budget_tail {N : ℝ} (hn : 1 ≤ N) (hL : 56 ≤ Real.log N) : MinorBudgetAt N := by
  let L := Real.log N
  let R := Real.sqrt N
  have hl : 56 ≤ L := hL
  have h0 : 0<L := by linarith
  have hN : 0<N := lt_of_lt_of_le zero_lt_one hn
  have hR : 0<R := Real.sqrt_pos.mpr hN
  have hsq : R^2=N := Real.sq_sqrt hN.le
  have hsc : L^4 ≤ 0.00000681*R := tail_scale hN hL
  have hL4 : L ≤ L^4 := le_self_pow₀ (by linarith) (by decide)
  have h2 : (56:ℝ)^2 ≤ L^2 := pow_le_pow_left₀ (by norm_num) hl 2
  have hτ : minorOrder N = 4900*L^4 := order_in_tail hN hL
  have hτ64 : 64 ≤ minorOrder N := by rw [hτ]; nlinarith only [hL4,hl]
  intro q hq0 hq δ hd
  let t := Real.sqrt q
  let s := Real.sqrt |δ|
  have ht0 : 0 ≤ t := Real.sqrt_nonneg _
  have hs0 : 0 ≤ s := Real.sqrt_nonneg _
  have ht2 : t^2=(q:ℝ) := Real.sq_sqrt (Nat.cast_nonneg _)
  have hs2 : s^2=|δ| := Real.sq_sqrt (abs_nonneg _)
  have hqR : (0:ℝ)<q := by exact_mod_cast hq0
  have ht1 : 1 ≤ t := by simpa [t] using Real.sqrt_le_sqrt (show (1:ℝ) ≤ q by exact_mod_cast hq0)
  have ht : t ≤ 70*L^2 := by apply (sq_le_sq₀ ht0 (by positivity)).mp; rw [ht2]; rw [hτ] at hq; linarith only [hq]
  have hp : 4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N := by
    apply minor_product_bound hq0 hN _ hτ64 hd
    apply le_trans (mul_le_mul_of_nonneg_left hq (by norm_num))
    rw [hτ]; exact all_levels_small hn (by linarith)
  refine ⟨tailTiling (twistRate δ),tailTiling 1,?_⟩
  have hh := twist_in_tail hn hL q hq0 hp
  have hd' := (le_div_iff₀ (mul_pos (by linarith : 0 < minorOrder N) hqR)).mp hd
  rw [hτ] at hd'
  have hrad : t*s*(70*L^2) ≤ R := by
    apply (sq_le_sq₀ (by positivity) hR.le).mp
    rw [mul_pow,mul_pow,ht2,hs2,hsq]; linarith only [hd']
  have A : t*R*(103*L)*L ≤ 0.05*N := by
    have ha := mul_le_mul_of_nonneg_right ht (mul_nonneg hR.le (sq_nonneg L))
    have hb := mul_le_mul_of_nonneg_right hsc hR.le
    nlinarith only [ha,hb,hsq,hN]
  have B : t*R*(10.8*L*s)*L ≤ 0.155*N := by
    have hb := mul_le_mul_of_nonneg_right hrad hR.le
    nlinarith only [hb,hsq,hN]
  have C : t*(51*L^2)*L ≤ 0.001*N := by
    have hsmall : L ≤ 0.01*R := by linarith only [hL4,hsc,hR]
    have hc := mul_le_mul hsc hsmall h0.le (by positivity)
    have hu := mul_le_mul_of_nonneg_right ht (pow_nonneg h0.le 3)
    nlinarith only [hc,hu,hsq,hN]
  have E : t*(3150*L*|δ|)*L ≤ 0.001*N := by
    have hle : t ≤ (q:ℝ) := by nlinarith only [ht2,mul_le_mul_of_nonneg_right ht1 ht0]
    have hcoeff : 3150000*L^2 ≤ 4900*L^4 := by
      nlinarith only [mul_le_mul_of_nonneg_right h2 (sq_nonneg L),sq_nonneg L]
    have hj := mul_le_mul hcoeff (mul_le_mul_of_nonneg_right hle (abs_nonneg δ))
      (mul_nonneg ht0 (abs_nonneg δ)) (by positivity)
    nlinarith only [hj,hd']
  have hnum : tailCeiling N q δ ≤ 0.21*N/L := by
    rw [le_div_iff₀ h0]; change t*(R*(103*L+10.8*L*s)+51*L^2+3150*L*|δ|)*L ≤ _
    linarith only [A,B,C,E,hN]
  have hconstant : minorConstant N ≤ 0.096 := by unfold minorConstant; split <;> norm_num
  have hp' : minorPrincipalBudget N q δ ≤ 0.096*N/L :=
    (min_le_left _ _).trans (div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_right hconstant hN.le) h0.le)
  apply (add_le_add (hh.trans hnum) hp').trans
  change 0.21*N/L+0.096*N/L ≤ 0.315*N/L
  rw [← add_div]; apply div_le_div_of_nonneg_right _ h0.le; linarith

#print axioms minor_budget_tail
end GoldbachEnergy
