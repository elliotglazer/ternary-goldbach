module

public import RationalArcs
public import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

@[expose] public section


open Real MeasureTheory Set Filter Finset ArithmeticFunction TernaryGoldbach
open scoped ArithmeticFunction.Moebius
noncomputable section
namespace GoldbachEnergy

theorem principal_off_axis {N β : ℝ} {q : ℕ} (hq : 0<q) (hβ : 0 < |β|) :
    ‖principalWave N q β‖ ≤ 1/((q.totient:ℝ)*(2*π)*|β|) := by
  have hφ : (0:ℝ)<q.totient := by exact_mod_cast Nat.totient_pos.mpr hq
  have hm : |(μ q : ℝ)| ≤ 1 := by exact_mod_cast (abs_moebius_le_one (n := q))
  have hd := Complex.abs_im_le_norm (((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I)
  have hd' : 2*π*|β| ≤ ‖((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I‖ := by
    simpa [abs_mul,abs_of_pos Real.pi_pos] using hd
  unfold principalWave
  rw [norm_div,Complex.norm_real,Real.norm_eq_abs,abs_div,abs_of_pos hφ]
  calc _ ≤ (1/(q.totient:ℝ))/(2*π*|β|) := div_le_div₀ (by positivity)
          (div_le_div_of_nonneg_right hm hφ.le) (by positivity) hd'
       _ = _ := by ring

/-- One of the two omitted tails of a continuous principal cube, including its totient factor. -/
theorem principal_half_tail (N : ℝ) {q : ℕ} (hq : 0<q) {R s : ℝ} (hR : 0<R)
    (hs : |s| = 1) :
    (∫ t in Ioi R, ‖principalWave N q (s*t)‖^3) ≤
      1 / (2*((q.totient:ℝ)*(2*π))^3*R^2) := by
  let A := (q.totient:ℝ)*(2*π)
  have hφ : (0:ℝ)<q.totient := by exact_mod_cast Nat.totient_pos.mpr hq
  have hA : 0<A := by dsimp [A]; positivity
  have hg := (integrableOn_Ioi_rpow_of_lt (by norm_num : (-3:ℝ)< -1) hR).const_mul (1/A^3)
  calc _ ≤ ∫ t in Ioi R, (1/A^3)*t^(-3:ℝ) := by
         apply integral_mono_of_nonneg (Eventually.of_forall (fun t => by positivity)) hg
         filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
         have ht' := hR.trans ht
         have ha : |s*t| = t := by rw [abs_mul, hs,one_mul,abs_of_pos ht']
         have hp := principal_off_axis (N := N) (β := s*t) hq (by rwa [ha])
         rw [ha] at hp
         apply (pow_le_pow_left₀ (norm_nonneg _) hp 3).trans_eq
         rw [Real.rpow_neg ht'.le]
         norm_num [A] <;> ring
       _ = _ := by
         rw [integral_const_mul, integral_Ioi_rpow_of_lt (by norm_num) hR]
         norm_num [Real.rpow_neg hR.le,A] <;> ring

theorem principal_two_tails {N : ℝ} (hN : 1<N) {q : ℕ} (hq : 0<q) :
    (∫ t in Ioi (radius N q), ‖principalWave N q t‖^3) +
      (∫ t in Ioi (radius N q), ‖principalWave N q (-t)‖^3) ≤
      N^2/(32*π^3*(Real.log N)^2*q.totient) := by
  have hl := Real.log_pos hN
  have hn : 0<N := by linarith
  have hφ : (0:ℝ)<q.totient := by exact_mod_cast Nat.totient_pos.mpr hq
  have hr : 0<radius N q := by unfold radius; positivity
  have h₁ := principal_half_tail N hq hr (by norm_num : |(1:ℝ)|=1)
  have h₂ := principal_half_tail N hq hr (by norm_num : |(-1:ℝ)|=1)
  simp only [one_mul, neg_one_mul] at h₁ h₂
  apply (add_le_add h₁ h₂).trans_eq
  unfold radius
  field_simp
  <;> ring

/-- Summing over the φ(q) reduced centres at each denominator costs at most
0.00112 N² for replacing all the central principal integrals by full-line integrals. -/
theorem sum_principal_tails_from_two_e19 {N : ℝ} (hN : (2*10^19)≤N) :
    (∑ q ∈ Icc 1 ⌊modulusCutoff N⌋₊, (q.totient:ℝ) *
      ((∫ t in Ioi (radius N q), ‖principalWave N q t‖^3) +
       (∫ t in Ioi (radius N q), ‖principalWave N q (-t)‖^3))) ≤ 0.00112*N^2 := by
  have hn : 1<N := lt_of_lt_of_le (by norm_num) hN
  have hl := Real.log_pos hn
  have hQ : (⌊modulusCutoff N⌋₊:ℝ) ≤ 1.1*(Real.log N)^2 :=
    Nat.floor_le (by unfold modulusCutoff; positivity)
  calc _ ≤ ∑ _q ∈ Icc 1 ⌊modulusCutoff N⌋₊, N^2/(32*π^3*(Real.log N)^2) := by
         apply sum_le_sum
         intro q hq
         have hp : 0<q := (Finset.mem_Icc.mp hq).1
         have hφ : (0:ℝ)<q.totient := by exact_mod_cast Nat.totient_pos.mpr hp
         apply (mul_le_mul_of_nonneg_left (principal_two_tails hn hp) hφ.le).trans_eq
         field_simp
       _ ≤ _ := by
         simp only [sum_const, Nat.card_Icc, Nat.add_sub_cancel, nsmul_eq_mul]
         rw [mul_div_assoc', div_le_iff₀ (by positivity)]
         have hp := pow_le_pow_left₀ (by norm_num : (0:ℝ)≤3.14) (by linarith [Real.pi_gt_d6] : 3.14 ≤ π) 3
         have hc : 1.1 ≤ 0.00112*32*π^3 := by linarith
         calc _ ≤ (1.1*(Real.log N)^2)*N^2 := mul_le_mul_of_nonneg_right hQ (sq_nonneg _)
              _ ≤ _ := by nlinarith only [mul_le_mul_of_nonneg_right hc (mul_nonneg (sq_nonneg (Real.log N)) (sq_nonneg N))]

theorem sum_principal_tails {N : ℝ} (hN : 10^20≤N) :
    (∑ q ∈ Icc 1 ⌊modulusCutoff N⌋₊, (q.totient:ℝ) *
      ((∫ t in Ioi (radius N q), ‖principalWave N q t‖^3) +
       (∫ t in Ioi (radius N q), ‖principalWave N q (-t)‖^3))) ≤ 0.00112*N^2 :=
  sum_principal_tails_from_two_e19 ((by norm_num : (2:ℝ)*10^19 ≤ 10^20).trans hN)

#print axioms sum_principal_tails
end GoldbachEnergy
