module

public import FourierEnergy
public import Mathlib.Analysis.MellinTransform

@[expose] public section


open Real ArithmeticFunction MeasureTheory Filter Asymptotics TernaryGoldbach Set
open scoped Topology ArithmeticFunction
noncomputable section
namespace GoldbachEnergy

/-- Subtracting the fixed weight exp(-n) makes the Mellin transform regular at
zero while changing each rational additive sum by a uniformly bounded amount. -/
def cancelledWeight (N δ : ℝ) (t : ℝ) : ℂ :=
  Complex.exp (((-1:ℂ) + ((2*π*δ:ℝ):ℂ)*Complex.I)*t) - Complex.exp ((-(N:ℂ))*t)

private theorem cont_weight (N δ : ℝ) : Continuous (cancelledWeight N δ) := by
  unfold cancelledWeight; fun_prop

private theorem weight_at_zero (N δ : ℝ) : cancelledWeight N δ 0 = 0 := by simp [cancelledWeight]

private theorem weight_bot (N δ : ℝ) :
    cancelledWeight N δ =O[𝓝[>] 0] fun t : ℝ => t ^ (-(-1:ℝ)) := by
  have h : DifferentiableAt ℝ (cancelledWeight N δ) 0 := by unfold cancelledWeight; fun_prop
  have hh := h.hasDerivAt.isBigO_sub.mono (show 𝓝[>] (0:ℝ) ≤ 𝓝 0 from nhdsWithin_le_nhds)
  simpa [weight_at_zero] using hh

private theorem weight_top {N : ℝ} (hN : 1 ≤ N) (δ : ℝ) :
    cancelledWeight N δ =O[atTop] fun t : ℝ => Real.exp (-1*t) := by
  apply Asymptotics.IsBigO.of_bound 2
  filter_upwards [eventually_ge_atTop (0:ℝ)] with t ht
  have he := Real.exp_le_exp.mpr (show -N*t ≤ -1*t by nlinarith only [mul_le_mul_of_nonneg_right hN ht])
  apply (norm_sub_le _ _).trans
  simp [Complex.norm_exp,Complex.mul_re,abs_of_pos (Real.exp_pos _)] at ⊢
  simp only [neg_mul,one_mul] at he
  linarith

theorem cancelled_mellin {N : ℝ} (hn : 1 ≤ N) (δ : ℝ) {s : ℂ} (hs : -1 < s.re) :
    MellinConvergent (cancelledWeight N δ) s ∧ DifferentiableAt ℂ (mellin (cancelledWeight N δ)) s := by
  have hc : LocallyIntegrableOn (cancelledWeight N δ) (Ioi 0) volume := (cont_weight N δ).continuousOn.locallyIntegrableOn (K := Ioi 0) measurableSet_Ioi
  exact ⟨mellinConvergent_of_isBigO_rpow_exp (a := 1) (b := -1) one_pos hc (weight_top hn δ) (weight_bot N δ) hs,
    mellin_differentiableAt_of_isBigO_rpow_exp (a := 1) (b := -1) one_pos hc (weight_top hn δ) (weight_bot N δ) hs⟩

def cancelledSum (N α r : ℝ) : ℂ :=
  ∑' n : ℕ, (Λ n:ℂ) * cancelledWeight N (N*(α-r)) (n/N) * e (n*r)

private theorem wave_summand_summable {N : ℝ} (hN : 0<N) (α : ℝ) :
    Summable (fun n : ℕ => (amp N n:ℂ)*e (n*α)) := by
  apply Summable.of_norm
  have ha (n : ℕ) : |amp N n| = amp N n := abs_of_nonneg (mul_nonneg vonMangoldt_nonneg (Real.exp_pos _).le)
  simpa [norm_mul,norm_e,Real.norm_eq_abs,ha] using amp_summable N hN

private theorem cancelled_summand {N : ℝ} (hn : 0<N) (α r : ℝ) (n : ℕ) :
    (Λ n:ℂ)*cancelledWeight N (N*(α-r)) (n/N)*e (n*r) =
    (amp N n:ℂ)*e (n*α) - (amp 1 n:ℂ)*e (n*r) := by
  have hz : (N:ℂ) ≠ 0 := by exact_mod_cast hn.ne'
  unfold cancelledWeight amp e
  push_cast
  rw [mul_sub,sub_mul]
  simp only [div_one, Complex.ofReal_exp, Complex.ofReal_div, Complex.ofReal_neg]
  simp_rw [mul_assoc]
  congr 1
  · congr 1
    rw [← Complex.exp_add, ← Complex.exp_add]
    congr 1
    field_simp [hz]; ring
  · congr 2
    field_simp [hz]

theorem wave_sub_unit {N : ℝ} (hn : 0<N) (α r : ℝ) :
    cancelledSum N α r = wave N α - wave 1 r := by
  unfold cancelledSum wave
  simp_rw [cancelled_summand hn]
  exact (wave_summand_summable hn α).tsum_sub (wave_summand_summable zero_lt_one r)

theorem norm_wave_one (r : ℝ) : ‖wave 1 r‖ ≤ 6 := by
  let b := Real.exp (-(1/2:ℝ))
  have hb : 0 ≤ b := (exp_pos _).le
  have hb' : b ≤ 2/3 := by
    dsimp [b]; rw [Real.exp_neg,inv_le_comm₀ (exp_pos _) (by norm_num)]
    norm_num
    linarith [Real.add_one_le_exp (1/2)]
  have hlt : b < 1 := by linarith
  have hg := (summable_geometric_of_lt_one hb hlt).mul_left 2
  unfold wave
  apply (norm_tsum_le_tsum_norm (wave_summand_summable zero_lt_one r).norm).trans
  calc _ ≤ ∑' n : ℕ, 2*b^n := by
         apply (wave_summand_summable zero_lt_one r).norm.tsum_le_tsum _ hg
         intro n
         simp only [norm_mul,norm_e,mul_one,Complex.norm_real,Real.norm_eq_abs,
           abs_of_nonneg (show 0≤amp 1 n from mul_nonneg vonMangoldt_nonneg (exp_pos _).le)]
         have hl : Λ n ≤ (n:ℝ) := vonMangoldt_le_log.trans (Real.log_le_self (Nat.cast_nonneg n))
         have he := Real.add_one_le_exp ((n:ℝ)/2)
         have hu : Λ n ≤ 2*Real.exp ((n:ℝ)/2) := by linarith
         unfold amp; rw [div_one]
         apply (mul_le_mul_of_nonneg_right hu (exp_pos _).le).trans_eq
         dsimp [b]; rw [mul_assoc, ← Real.exp_add, ← Real.exp_nat_mul]
         congr 2; ring
       _ ≤ 6 := by
         rw [tsum_mul_left,tsum_geometric_of_lt_one hb hlt]
         rw [mul_inv_le_iff₀ (by linarith)]
         linarith

#print axioms cancelled_mellin
#print axioms wave_sub_unit
#print axioms norm_wave_one
end GoldbachEnergy
