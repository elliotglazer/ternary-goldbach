module

public import ModelRoute

@[expose] public section


open MeasureTheory Real Finset TernaryGoldbach GoldbachEnergy
noncomputable section
namespace GoldbachRoute

theorem restricted_model_lower_from_two_e19 {N : ℕ} (ho : Odd N) (hn : 2*10^19 ≤ N) :
    0.2287*(N:ℝ)^2 < (restrictedModel N).re := by
  have hn' : 2*(10:ℝ)^19 ≤ N := by exact_mod_cast hn
  have hp : 0<(N:ℝ) := lt_of_lt_of_le (by norm_num) hn'
  have hL : 44 ≤ Real.log N := by
    apply (Real.le_log_iff_exp_le hp).mpr
    calc Real.exp 44 = Real.exp 1^44 := by rw [← Real.exp_nat_mul]; norm_num
         _ ≤ (2.7182818286:ℝ)^44 := pow_le_pow_left₀ (Real.exp_pos 1).le Real.exp_one_lt_d9.le _
         _ ≤ 2*10^19 := by norm_num
         _ ≤ _ := hn' 
  have hQ : 400 ≤ ⌊modulusCutoff N⌋₊ := by
    apply Nat.le_floor
    unfold modulusCutoff
    nlinarith only [sq_nonneg (Real.log N-44),hL]
  let S := ∑ q ∈ Icc 1 ⌊modulusCutoff N⌋₊, GoldbachSingular.fourierCoefficient N q
  have hS : 1.25 ≤ S.re := GoldbachSingular.truncated_ramanujan_lower ho hQ
  have he : 0.22983 < S.re/(2*exp 1) := by
    rw [lt_div_iff₀ (by positivity)]
    linarith [exp_one_lt_d9]
  have herr := neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans (restrictedModel_error_from_two_e19 hn))
  change -(0.00112*(N:ℝ)^2) ≤ (restrictedModel N-S*(((N:ℝ)^2/(2*exp 1):ℝ):ℂ)).re at herr
  rw [Complex.sub_re,Complex.mul_re] at herr
  simp only [Complex.ofReal_re,Complex.ofReal_im,mul_zero,sub_zero] at herr
  rw [show S.re*((N:ℝ)^2/(2*exp 1)) = (S.re/(2*exp 1))*(N:ℝ)^2 by ring] at herr
  linarith only [herr,mul_lt_mul_of_pos_right he (sq_pos_of_pos hp),sq_pos_of_pos hp]

theorem primes_from_two_e19_comparison {N : ℕ} (ho : Odd N) (hn : 2*10^19 ≤ N)
    (hmin : ∀ u ∈ minorArcs N, ‖wave N u‖ ≤ 0.315*N/Real.log N)
    (hmaj : (restrictedModel N).re - 0.005*(N:ℝ)^2 ≤
      (∫ u in Set.Ioc (0:ℝ) 1 \ minorArcs N, integrand N u).re) : IsSumOfThreePrimes N := by
  by_cases hbig : 10^20 ≤ N
  · exact primes_of_model_comparison ho hbig (by norm_num) (by norm_num) hmin hmaj
  apply three_primes_from_bounded_arcs (c:=0.315) (m:=0.2287-0.005) (by norm_num)
    (by norm_num) N hn (by omega) (measurable_minorArcs N) Set.sdiff_subset hmin
  linarith only [restricted_model_lower_from_two_e19 ho hn,hmaj]
#print axioms primes_from_two_e19_comparison
end GoldbachRoute
