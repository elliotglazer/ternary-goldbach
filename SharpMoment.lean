module

public import Moment

@[expose] public section

open Real Finset ArithmeticFunction
open scoped ArithmeticFunction
namespace GoldbachEnergy

theorem psi_affine_sharp {x : ℝ} (hx : 0 ≤ x) :
    Chebyshev.psi x ≤ 1.4*x + 20000 := by
  by_cases h : x<1
  · rw [Chebyshev.psi_eq_zero_of_lt_two (by linarith)]; linarith
  have hs := Real.sqrt_pos.mpr (show 0<x by linarith)
  have hl := Real.log_le_sub_one_of_pos (show 0 < √x/1024 by positivity)
  rw [Real.log_div hs.ne' (by norm_num), Real.log_sqrt hx] at hl
  have hc : Real.log 1024 < 7 := by
    rw [show (1024:ℝ)=2^10 by norm_num,Real.log_pow]; norm_num1; linarith [Real.log_two_lt_d9]
  have h4 : Real.log 4 ≤ 1.387 := by
    rw [show (4:ℝ)=2^2 by norm_num,Real.log_pow]; norm_num1; linarith [Real.log_two_lt_d9]
  have hlog : Real.log x ≤ √x/512+12 := by linarith
  have hp := Chebyshev.psi_le (le_of_not_gt h)
  nlinarith only [hp, mul_le_mul_of_nonneg_right h4 hx, mul_le_mul_of_nonneg_left hlog hs.le,
    Real.sq_sqrt hx, sq_nonneg (√x-1400), hx]

private theorem mass_sharp (t : ℝ) (ht : 0<t) (M : ℕ) :
    weighted (fun n => Λ n) M (exp (-t)) ≤ 1.4/t + 20000 := by
  refine weighted_exp ht (by norm_num) (fun j => ?_) M
  apply le_trans (le_of_eq ?_) (psi_affine_sharp (x := j) (by positivity))
  rw [Chebyshev.psi_eq_sum_Icc, Nat.floor_natCast, ← Nat.range_succ_eq_Icc_zero, sum_range_succ']
  simp [pre]

private theorem weight_point (N : ℝ) (hN : 0<N) (n : ℕ) (hn : 0<n) :
    Λ n^2*exp (-2*n/N) ≤ Real.log N*(Λ n*exp (-(2/N))^n) +
      0.14*(Λ n*exp (-(1/N))^n) := by
  let t := (n:ℝ)/N
  have ht : 0<t := by dsimp [t]; positivity
  have hlog := Real.log_le_sub_one_of_pos ht
  dsimp only [t] at hlog
  rw [Real.log_div (by positivity) hN.ne'] at hlog
  have hΛ : (Λ n:ℝ) ≤ Real.log N + (t-1) := by dsimp [t]; linarith [vonMangoldt_le_log (n := n)]
  have he2 : exp (-2) ≤ (0.14:ℝ) := by
    rw [Real.exp_neg,show (2:ℝ) = (2:ℕ)*1 by norm_num,Real.exp_nat_mul,inv_le_comm₀ (by positivity) (by norm_num)]
    nlinarith [pow_le_pow_left₀ (by norm_num : (0:ℝ)≤2.7) (show (2.7:ℝ) ≤ exp 1 by linarith [Real.exp_one_gt_d9]) 2]
  have hlin : t-1 ≤ exp (t-2) := by linarith [Real.add_one_le_exp (t-2)]
  have he : (t-1)*exp (-2*t) ≤ 0.14*exp (-t) := by
    calc _ ≤ exp (t-2)*exp (-2*t) := mul_le_mul_of_nonneg_right hlin (exp_pos _).le
         _ = exp (-2)*exp (-t) := by rw [← exp_add,← exp_add]; congr 1; ring
         _ ≤ _ := mul_le_mul_of_nonneg_right he2 (exp_pos _).le
  have h1 : Λ n*exp (-2*t) ≤ Real.log N*exp (-2*t)+0.14*exp (-t) := by
    linarith [mul_le_mul_of_nonneg_right hΛ (exp_pos (-2*t)).le]
  have hmul := mul_le_mul_of_nonneg_left h1 (vonMangoldt_nonneg (n := n))
  rw [← exp_nat_mul,← exp_nat_mul]
  rw [show (n:ℝ)*(-(2/N)) = -2*t by dsimp [t]; ring,
    show (n:ℝ)*(-(1/N)) = -t by dsimp [t]; ring,
    show -2*(n:ℝ)/N = -2*t by dsimp [t]; ring]
  linarith

theorem energy_range_sharp_from_two_e19 (N : ℝ) (hN : (2*10^19) ≤ N) (M : ℕ) :
    ∑ i ∈ range M, Λ (i+1)^2 * exp (-2*((i+1:ℕ):ℝ)/N) ≤ 0.705*N*Real.log N := by
  have hN0 : 0<N := lt_of_lt_of_le (by norm_num) hN
  have hL : 44 ≤ Real.log N := by
    apply Real.le_log_iff_exp_le hN0 |>.mpr
    calc exp 44 = exp 1^44 := by rw [← exp_nat_mul]; norm_num
         _ ≤ (2.7182818286:ℝ)^44 := pow_le_pow_left₀ (exp_pos 1).le exp_one_lt_d9.le 44
         _ ≤ (2*10^19) := by norm_num
         _ ≤ N := hN
  have hm := Finset.sum_le_sum (s := range M) (fun i _ => weight_point N hN0 (i+1) (by omega))
  simp only [Finset.sum_add_distrib,← Finset.mul_sum] at hm
  have h1 := mass_sharp (2/N) (by positivity) M
  have h2 := mass_sharp (1/N) (by positivity) M
  unfold weighted at h1 h2
  rw [show (1.4:ℝ)/(2/N)=0.7*N by field_simp; ring] at h1
  rw [show (1.4:ℝ)/(1/N)=1.4*N by field_simp] at h2
  have h3 := mul_le_mul_of_nonneg_left h1 (show 0 ≤ Real.log N by linarith)
  have h4 : 20000*Real.log N ≤ 0.0001*N*Real.log N := by
    apply mul_le_mul_of_nonneg_right <;> linarith
  have h5 : 0.0049*N*44 ≤ 0.0049*N*Real.log N := mul_le_mul_of_nonneg_left hL (by positivity)
  linarith

theorem energy_range_sharp (N : ℝ) (hN : 10^20 ≤ N) (M : ℕ) :
    ∑ i ∈ range M, Λ (i+1)^2 * exp (-2*((i+1:ℕ):ℝ)/N) ≤ 0.705*N*Real.log N :=
  energy_range_sharp_from_two_e19 N ((by norm_num : (2:ℝ)*10^19 ≤ 10^20).trans hN) M

#print axioms energy_range_sharp
end GoldbachEnergy
