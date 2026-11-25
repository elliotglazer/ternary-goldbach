module

public import PrincipalMajor
public import RouteOnArcs

@[expose] public section


open MeasureTheory Real Finset TernaryGoldbach GoldbachEnergy
noncomputable section
namespace GoldbachRoute

theorem restricted_model_lower {N : ℕ} (ho : Odd N) (hn : 10^20 ≤ N) :
    0.2287*(N:ℝ)^2 < (restrictedModel N).re := by
  have hn' : (10:ℝ)^20 ≤ N := by exact_mod_cast hn
  have hp : 0<(N:ℝ) := lt_of_lt_of_le (by norm_num) hn'
  have hL := LeanLab.Zinoviev1997.log_1e20_ge.trans (Real.log_le_log (by norm_num) hn')
  have hQ : 400 ≤ ⌊modulusCutoff N⌋₊ := by
    apply Nat.le_floor
    unfold modulusCutoff
    nlinarith only [sq_nonneg (Real.log N-46),hL]
  let S := ∑ q ∈ Icc 1 ⌊modulusCutoff N⌋₊, GoldbachSingular.fourierCoefficient N q
  have hS : 1.25 ≤ S.re := GoldbachSingular.truncated_ramanujan_lower ho hQ
  have he : 0.22983 < S.re/(2*exp 1) := by
    rw [lt_div_iff₀ (by positivity)]
    linarith [exp_one_lt_d9]
  have herr := neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans (restrictedModel_error hn))
  change -(0.00112*(N:ℝ)^2) ≤ (restrictedModel N-S*(((N:ℝ)^2/(2*exp 1):ℝ):ℂ)).re at herr
  rw [Complex.sub_re,Complex.mul_re] at herr
  simp only [Complex.ofReal_re,Complex.ofReal_im,mul_zero,sub_zero] at herr
  rw [show S.re*((N:ℝ)^2/(2*exp 1)) = (S.re/(2*exp 1))*(N:ℝ)^2 by ring] at herr
  linarith only [herr,mul_lt_mul_of_pos_right he (sq_pos_of_pos hp),sq_pos_of_pos hp]

/-- Both analytic errors now refer to the actual wave, with the principal model
evaluated independently. The major error only needs a lower bound on its real part. -/
theorem primes_of_model_comparison {N : ℕ} (ho : Odd N) (hn : 10^20 ≤ N) {c d : ℝ}
    (hc : 0 ≤ c) (hbudget : 0.705*c+d+0.001 ≤ 0.2287)
    (hmin : ∀ u ∈ minorArcs N, ‖wave N u‖ ≤ c*N/Real.log N)
    (hmaj : (restrictedModel N).re - d*(N:ℝ)^2 ≤
      (∫ u in Set.Ioc (0:ℝ) 1 \ minorArcs N, integrand N u).re) : IsSumOfThreePrimes N := by
  apply three_primes_from_arc_bounds (m := 0.2287-d) hc (by linarith) N hn
    (measurable_minorArcs N) Set.sdiff_subset hmin
  linarith only [restricted_model_lower ho hn,hmaj]

#print axioms primes_of_model_comparison
end GoldbachRoute
