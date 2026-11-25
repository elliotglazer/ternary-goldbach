module

public import TailBudget
public import MajorNumerics

@[expose] public section

open Real
noncomputable section
namespace GoldbachEnergy

theorem major_budget_tail {N : ℝ} (hn : 1 ≤ N) (hL : 56 ≤ Real.log N) : MajorBudgetAt N := by
  let L := Real.log N
  let R := Real.sqrt N
  have hl : 56 ≤ L := hL
  have hp0 : 0<L := by linarith
  have hN : 0<N := lt_of_lt_of_le zero_lt_one hn
  have hR : 0<R := Real.sqrt_pos.mpr hN
  have hsq : R^2=N := Real.sq_sqrt hN.le
  have hsc : L^4 ≤ 0.00000681*R := tail_scale hN hL
  have hL4 : (56:ℝ)^4 ≤ L^4 := pow_le_pow_left₀ (by norm_num) hl 4
  have hbigR : 12702 ≤ R := by linarith only [hsc,hL4]
  have harr : 248*(4900*L^4) ≤ N := all_levels_small hn (by linarith)
  intro q hq hlim δ hd
  have hqmax : (q:ℝ) ≤ 1.1*L^2 := hlim
  have hφ : (1:ℝ) ≤ q.totient := by exact_mod_cast Nat.totient_pos.mpr hq
  have hδ : |δ| ≤ 2*L := by
    apply hd.trans; rw [div_le_iff₀ (by linarith)]
    nlinarith only [mul_le_mul_of_nonneg_left hφ hp0.le]
  have hz : ‖twistRate δ‖ ≤ 1+12.58*L := by linarith only [(twist_norm_bounds δ).2,hδ]
  have hprod : 4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N := by
    rw [abs_of_nonneg (by positivity)]
    have hh := mul_le_mul hqmax (show 8+‖twistRate δ‖+22 ≤ 14*L by linarith)
      (by positivity) (by positivity)
    have h34 := mul_le_mul_of_nonneg_right hl (pow_nonneg hp0.le 3)
    nlinarith only [hh,h34,harr,pow_nonneg hp0.le 3]
  refine ⟨tailTiling (twistRate δ),tailTiling 1,(twist_in_tail hn hL q hq hprod).trans ?_⟩
  have ht : Real.sqrt q ≤ 2*L := by
    apply (Real.sqrt_le_left (by positivity)).mpr; nlinarith only [hqmax,sq_nonneg L]
  have hs : Real.sqrt |δ| ≤ L := (Real.sqrt_le_left hp0.le).mpr (by nlinarith only [hδ,mul_le_mul_of_nonneg_right hl hp0.le,hp0])
  have hx : 103*L+10.8*L*Real.sqrt |δ| ≤ 12.8*L^2 := by
    nlinarith only [mul_le_mul_of_nonneg_left hs hp0.le,mul_le_mul_of_nonneg_right hl hp0.le,hp0]
  have hc : 51*L^2+3150*L*|δ| ≤ 6351*L^2 := by
    nlinarith only [mul_le_mul_of_nonneg_left hδ hp0.le]
  have hb := add_le_add (mul_le_mul_of_nonneg_left hx hR.le) hc
  have hu := mul_le_mul ht hb (by positivity) (by positivity)
  have hv := mul_le_mul_of_nonneg_right hu hp0.le
  have hsmall := mul_le_mul_of_nonneg_left hsc hR.le
  have hrem := mul_le_mul_of_nonneg_right hbigR (pow_nonneg hp0.le 4)
  rw [le_div_iff₀ hp0]
  unfold tailCeiling
  change Real.sqrt q*(R*(103*L+10.8*L*Real.sqrt |δ|)+51*L^2+3150*L*|δ|)*L ≤ 0.001*N
  nlinarith only [hv,hsmall,hrem,hsq,hN]

#print axioms major_budget_tail
end GoldbachEnergy
