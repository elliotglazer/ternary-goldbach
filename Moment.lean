module

public import Energy

@[expose] public section


open Real Finset ArithmeticFunction
open scoped ArithmeticFunction
namespace GoldbachEnergy

private theorem decay (t : ℝ) (n : ℕ) :
    exp (-t)^n = exp (-(n:ℝ)*t) := by
  rw [← exp_nat_mul]; congr 1; ring

private theorem point (N : ℝ) (hN : 0 < N) (n : ℕ) (hn : 0 < n) :
    Λ n ^ 2 * exp (-2*n/N) ≤
    Real.log N * (Λ n * exp (-(2/N)) ^ n) + Λ n * exp (-(1/N)) ^ n := by
  rw [decay, decay]
  let t := (n:ℝ)/N
  have ht : 0 < t := by dsimp [t]; positivity
  have hlog := Real.log_le_sub_one_of_pos ht
  dsimp only [t] at hlog
  rw [Real.log_div (by positivity) hN.ne'] at hlog
  have u : (Λ n : ℝ) ≤ Real.log N + t := by
    dsimp [t]; linarith [vonMangoldt_le_log (n := n)]
  have he : t ≤ exp t := by linarith [Real.add_one_le_exp t]
  have hp := mul_le_mul_of_nonneg_right he (Real.exp_pos (-2*t)).le
  rw [← Real.exp_add, show t+-2*t = -t by ring] at hp
  have hm := mul_le_mul_of_nonneg_right u (Real.exp_pos (-2*t)).le
  have h1 : (Λ n : ℝ) * exp (-2*t) ≤ Real.log N * exp (-2*t) + exp (-t) := by linarith
  have h2 := mul_le_mul_of_nonneg_left h1 (vonMangoldt_nonneg (n := n))
  rw [show -2*(n:ℝ)/N = -2*t by dsimp [t]; ring,
    show -(n:ℝ)*(2/N) = -2*t by dsimp [t]; ring,
    show -(n:ℝ)*(1/N) = -t by dsimp [t]; ring]
  linarith

/-- A uniform bound on the finite sums entering Parseval, including prime powers. -/
theorem energy_range (N : ℝ) (hN : 10^20 ≤ N) (M : ℕ) :
    ∑ i ∈ range M, Λ (i+1)^2 * exp (-2*((i+1:ℕ):ℝ)/N) ≤ 0.84 * N * Real.log N := by
  have hN0 : 0 < N := lt_of_lt_of_le (by norm_num) hN
  have hL : 45 ≤ Real.log N := by
    apply Real.le_log_iff_exp_le hN0 |>.mpr
    calc exp 45 = exp 1 ^ 45 := by rw [← exp_nat_mul]; norm_num
         _ ≤ (2.7182818286 : ℝ)^45 := pow_le_pow_left₀ (exp_pos 1).le exp_one_lt_d9.le 45
         _ ≤ 10^20 := by norm_num
         _ ≤ N := hN
  have hmaj := Finset.sum_le_sum (s := range M)
    (fun (i : ℕ) _ => point N hN0 (i+1) (by omega))
  simp only [← Finset.mul_sum, Finset.sum_add_distrib] at hmaj
  have h1 := mangoldt_weight (2/N) (by positivity) M
  have h2 := mangoldt_weight (1/N) (by positivity) M
  unfold weighted at h1 h2
  rw [show (1.6:ℝ)/(2/N) = 0.8*N by field_simp; ring] at h1
  rw [show (1.6:ℝ)/(1/N) = 1.6*N by field_simp] at h2
  have h3 := mul_le_mul_of_nonneg_left h1 (show 0 ≤ Real.log N by linarith)
  have h4 : 1024 * Real.log N ≤ 0.001*N*Real.log N := by
    apply mul_le_mul_of_nonneg_right <;> linarith
  have h5 : 0.039*N*45 ≤ 0.039*N*Real.log N :=
    mul_le_mul_of_nonneg_left hL (by positivity)
  linarith

theorem energy (N : ℕ) (hN : (10:ℝ)^20 ≤ N) (M : ℕ) :
    ∑ n ∈ Icc 1 M, Λ n^2 * exp (-2*n/N) ≤ 0.84*N*Real.log N := by
  have he := energy_range N hN M
  rw [← Finset.Ico_add_one_right_eq_Icc 1 M, Finset.sum_Ico_eq_sum_range]
  simpa only [Nat.add_sub_cancel_right, Nat.add_comm 1] using he

#print axioms energy
end GoldbachEnergy
