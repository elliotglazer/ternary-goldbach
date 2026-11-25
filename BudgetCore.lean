module

public import Moment
public import Totient
public import Arith
public import Mathlib.Topology.Algebra.InfiniteSum.Real

@[expose] public section

open Real Finset ArithmeticFunction
open scoped ArithmeticFunction
namespace GoldbachEnergy

theorem energy_infinite (N : ℝ) (hN : 10^20 ≤ N) :
    (∑' i : ℕ, Λ (i+1)^2 * exp (-2*((i+1:ℕ):ℝ)/N)) ≤ 0.84*N*Real.log N := by
  exact Real.tsum_le_of_sum_range_le (fun i => mul_nonneg (sq_nonneg _) (exp_pos _).le)
    (energy_range N hN)

/-- Control of the principal term for every large denominator, with no exception list. -/
theorem principal_ratio_of (hratio : ∀ n : ℕ, 2331 ≤ n → 120*n < n.totient^2) (N : ℝ) (q : ℕ) (hN : 10^20 ≤ N)
    (hq : 1.1*(Real.log N)^2 < q) : Real.log N/(q.totient:ℝ) < 0.088 := by
  have hn : 0 < N := lt_of_lt_of_le (by norm_num) hN
  have hlog : 46.05 ≤ Real.log N := by
    have hh := Real.log_le_log (show (0:ℝ)<10^20 by norm_num) hN
    rw [Real.log_pow, Real.log_ten_eq] at hh
    push_cast at hh
    linarith [Real.log_two_gt_d9,Real.log_five_gt_d9]
  have hq1 : 2331 ≤ q := by
    by_contra! hc
    have hc' : (q:ℝ) ≤ 2330 := by exact_mod_cast (show q ≤ 2330 by omega)
    nlinarith [sq_nonneg (Real.log N-46.05)]
  have hφ : (120:ℝ)*q < (q.totient:ℝ)^2 := by exact_mod_cast hratio q hq1
  have hf : (0:ℝ)<q.totient := by exact_mod_cast (Nat.totient_pos.mpr (by omega : 0<q))
  rw [div_lt_iff₀ hf]
  by_contra! hu
  have hs := sq_le_sq' (by linarith : -(Real.log N) ≤ 0.088*(q.totient:ℝ)) hu
  nlinarith

theorem sup_budget_of (hratio : ∀ n : ℕ, 2331 ≤ n → 120*n < n.totient^2) {N p err s : ℝ} (hN : 10^20 ≤ N) {q : ℕ}
    (hq : 1.1*(Real.log N)^2 < q) (hp : p ≤ N / q.totient)
    (he : err ≤ 0.122 * N / Real.log N) (hs : s ≤ p+err) :
    s ≤ 0.21*N/Real.log N := by
  have hn : 0<N := lt_of_lt_of_le (by norm_num) hN
  have hl : 0<Real.log N := Real.log_pos (by linarith)
  have hφ : (0:ℝ)<q.totient := by
    have hq0 : (0:ℝ)<q := lt_trans (by positivity) hq
    exact_mod_cast (Nat.totient_pos.mpr (show 0<q by exact_mod_cast hq0))
  have hu := principal_ratio_of hratio N q hN hq
  rw [div_lt_iff₀ hφ] at hu
  have hp' := (le_div_iff₀ hφ).mp hp
  have hp'' : N/q.totient ≤ 0.088*N/Real.log N := by
    rw [le_div_iff₀ hl, div_mul_eq_mul_div, div_le_iff₀ hφ]
    nlinarith only [mul_le_mul_of_nonneg_left hu.le hn.le]
  linarith [show 0.088*N/Real.log N+0.122*N/Real.log N = 0.21*N/Real.log N by ring]

/-- The actual closing arithmetic, given the major arc and Parseval inequalities. -/
theorem positive {N J₁ J₂ θ M T : ℝ} (hN : 10^20 ≤ N)
    (h1 : 0.18*N^2 < J₁) (hθ : |θ| ≤ 1) (hM : M ≤ 0.21*N/Real.log N)
    (hT0 : 0 ≤ T) (hT : T ≤ 0.84*N*Real.log N) (hJ : |J₂| ≤ M*T) :
    0 < exp 1*(J₁+J₂) + θ*(N*Real.sqrt N)*Real.log N^3 := by
  have hn : 0 < N := lt_of_lt_of_le (by norm_num) hN
  have hl : 0 < Real.log N := Real.log_pos (by linarith)
  apply LeanLab.Zinoviev1997.theorem34_final N J₁ J₂ θ hN h1 _ hθ
  calc |J₂| ≤ (0.21*N/Real.log N)*(0.84*N*Real.log N) :=
              hJ.trans (mul_le_mul hM hT hT0 (by positivity))
       _ = 0.1764*N^2 := by field_simp; ring
       _ < 0.179*N^2 := by nlinarith [sq_pos_of_pos hn]

#print axioms energy_infinite
#print axioms principal_ratio_of
#print axioms sup_budget_of
#print axioms positive
end GoldbachEnergy
