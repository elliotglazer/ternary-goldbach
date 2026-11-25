module

public import Ramanujan
public import Coefficient
public import Budget

@[expose] public section


open Real Finset MeasureTheory TernaryGoldbach
namespace GoldbachEnergy

/-- Numerical consequence of the major-arc expansion with its 0.04 remainder. -/
theorem major_from_expansion {n σ θ₁ θ₂ j : ℝ} (hn : 10^20 ≤ n) (hs : 1.25 ≤ σ)
    (h1 : |θ₁| ≤ 1) (h2 : |θ₂| ≤ 1)
    (hj : j = σ/exp 1 * (n^2/2+8*θ₁*n) + 0.04*θ₂*n^2) :
    0.1898*n^2 < j := by
  have hn0 : 0<n := lt_of_lt_of_le (by norm_num) hn
  have hr : 0.4598 < σ/exp 1 := by
    rw [lt_div_iff₀ (exp_pos _)]; linarith [exp_one_lt_d9]
  have ha : n^2/2-8*n ≤ n^2/2+8*θ₁*n := by
    nlinarith only [mul_le_mul_of_nonneg_right (abs_le.mp h1).1 hn0.le]
  have hn2 := mul_nonneg hn0.le (show 0 ≤ n-100000 by linarith)
  have hmain := mul_le_mul hr.le ha (by nlinarith only [hn2,hn0.le]) (by linarith : 0 ≤ σ/exp 1)
  have herr := mul_le_mul_of_nonneg_right (abs_le.mp h2).1 (sq_nonneg n)
  rw [hj]; nlinarith only [hmain,herr,hn2,hn0]

/-- A standard truncated major-arc expansion and the relaxed minor-arc estimate
suffice. The singular coefficient here is the actual Ramanujan sum. -/
theorem three_primes_from_expansion {N Q : ℕ} (ho : Odd N) (hn : 10^20 ≤ N)
    (hQ : 400 ≤ Q) {E : Set ℝ} (hE : MeasurableSet E) (hs : E ⊆ Set.Ioc 0 1)
    (hminor : ∀ α ∈ E, ‖wave N α‖ ≤ 0.2675*N/Real.log N)
    (hmaj : ∃ θ₁ θ₂ : ℝ, |θ₁| ≤ 1 ∧ |θ₂| ≤ 1 ∧
      (∫ x in Set.Ioc (0:ℝ) 1 \ E, integrand N x).re =
      (∑ q ∈ Icc 1 Q, GoldbachSingular.fourierCoefficient N q).re / exp 1 *
      ((N:ℝ)^2/2+8*θ₁*N)+0.04*θ₂*(N:ℝ)^2) : IsSumOfThreePrimes N := by
  obtain ⟨θ₁,θ₂,h1,h2,hj⟩ := hmaj
  exact three_primes_from_arc_bounds (c := 0.2675) (m := 0.1898) (by norm_num)
    (by norm_num) N hn hE hs hminor (major_from_expansion (by exact_mod_cast hn)
      (GoldbachSingular.truncated_ramanujan_lower ho hQ) h1 h2 hj)

/-- Convert the bound for the principal term into headroom for all other terms. -/
theorem sup_from_remainder {N p err s c : ℝ} (hn : 10^20 ≤ N) {q : ℕ}
    (hq : 1.1*(Real.log N)^2 < q) (hp : p ≤ N/q.totient)
    (he : err ≤ (c-0.088)*N/Real.log N) (hs : s ≤ p+err) : s ≤ c*N/Real.log N := by
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hL : 0<Real.log N := Real.log_pos (by linarith)
  have hq0 : (0:ℝ)<q := lt_trans (by positivity) hq
  have hφ : (0:ℝ)<q.totient := by
    exact_mod_cast (Nat.totient_pos.mpr (show 0<q by exact_mod_cast hq0))
  have hratio := principal_ratio N q hn hq
  rw [div_lt_iff₀ hφ] at hratio
  have hpr : N/q.totient ≤ 0.088*N/Real.log N := by
    rw [le_div_iff₀ hL, div_mul_eq_mul_div, div_le_iff₀ hφ]
    nlinarith only [mul_le_mul_of_nonneg_left hratio.le hn0.le]
  calc s ≤ 0.088*N/Real.log N + (c-0.088)*N/Real.log N := hs.trans (add_le_add (hp.trans hpr) he)
       _ = _ := by ring

#print axioms three_primes_from_expansion
#print axioms sup_from_remainder
end GoldbachEnergy
