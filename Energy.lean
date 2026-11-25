module

public import Mathlib.NumberTheory.Chebyshev
public import Mathlib.Analysis.Complex.ExponentialBounds
public import Mathlib.Tactic

@[expose] public section


open Real Finset ArithmeticFunction
open scoped ArithmeticFunction

namespace GoldbachEnergy

theorem psi_affine {x : ℝ} (hx : 0 ≤ x) :
    Chebyshev.psi x ≤ 1.6*x + 1024 := by
  by_cases hx1 : x < 1
  · rw [Chebyshev.psi_eq_zero_of_lt_two (by linarith)]
    linarith
  have hs : 0 < √x := Real.sqrt_pos.mpr (by linarith)
  have hl := Real.log_le_sub_one_of_pos (show 0 < √x / 64 by positivity)
  rw [Real.log_div hs.ne' (by norm_num), Real.log_sqrt hx] at hl
  have h64 : Real.log 64 < 4.2 := by
    rw [show (64:ℝ) = 2^6 by norm_num, Real.log_pow]
    linarith [Real.log_two_lt_d9]
  have h4 : Real.log 4 ≤ 1.4 := by
    rw [show (4:ℝ) = 2^2 by norm_num, Real.log_pow]
    linarith [Real.log_two_lt_d9]
  have hlog : Real.log x ≤ √x / 32 + 6.4 := by linarith
  have hup := Chebyshev.psi_le (le_of_not_gt hx1)
  have h0 := mul_le_mul_of_nonneg_right h4 hx
  have h1 := mul_le_mul_of_nonneg_left hlog hs.le
  nlinarith [Real.sq_sqrt hx, sq_nonneg (√x-64)]

def pre (a : ℕ → ℝ) (k : ℕ) := ∑ i ∈ range k, a (i+1)
def weighted (a : ℕ → ℝ) (k : ℕ) (r : ℝ) := ∑ i ∈ range k, a (i+1)*r^(i+1)

private theorem weighted_slack {a : ℕ → ℝ} {C D r : ℝ} (hr : 0 ≤ r) (hr1 : r ≤ 1)
    (h : ∀ k : ℕ, pre a k ≤ C*k+D) (k : ℕ) :
    weighted a k r + (C*k+D-pre a k)*r^k ≤ C*(∑ i ∈ range k, r^(i+1))+D := by
  induction k with
  | zero => simp [weighted, pre]
  | succ k ih =>
    have hz : 0 ≤ C*k+D-pre a k := by linarith [h k]
    have hp : r^(k+1) ≤ r^k := by
      rw [pow_succ]; exact mul_le_of_le_one_right (pow_nonneg hr _) hr1
    have hmul := mul_le_mul_of_nonneg_left hp hz
    simp only [weighted, pre, sum_range_succ, Nat.cast_succ] at ih ⊢
    unfold pre at hmul
    linarith

theorem weighted_exp {a : ℕ → ℝ} {C D t : ℝ} (ht : 0 < t) (hC : 0 ≤ C)
    (h : ∀ k : ℕ, pre a k ≤ C*k+D) (k : ℕ) :
    weighted a k (exp (-t)) ≤ C/t + D := by
  let r := exp (-t)
  have hr : 0 < r := exp_pos _
  have hr1 : r ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
  have aux := weighted_slack hr.le hr1 h k
  have hrem : 0 ≤ (C*k+D-pre a k)*r^k :=
    mul_nonneg (by linarith [h k]) (pow_nonneg hr.le _)
  have hrt : r*(1+t) ≤ 1 := by
    have hh := mul_le_mul_of_nonneg_left (Real.add_one_le_exp t) hr.le
    have he : r* exp t = 1 := by dsimp [r]; rw [← Real.exp_add]; simp
    linarith
  have hs : ∀ j : ℕ, (∑ i ∈ range j, r^(i+1))*t + r^j ≤ 1 := by
    intro j
    induction j with
    | zero => simp
    | succ j ih =>
      rw [sum_range_succ, pow_succ]
      have hh := mul_le_mul_of_nonneg_left hrt (pow_nonneg hr.le j)
      linarith
  have hsum : (∑ i ∈ range k, r^(i+1)) ≤ 1/t := by
    apply (le_div_iff₀ ht).mpr
    linarith [hs k, pow_nonneg hr.le k]
  have hfinal := mul_le_mul_of_nonneg_left hsum hC
  dsimp only [r] at *
  linarith [show C*(1/t)=C/t by ring]

private theorem pre_psi (k : ℕ) : pre (fun i => Λ i) k = Chebyshev.psi k := by
  rw [Chebyshev.psi_eq_sum_Icc]
  simp only [Nat.floor_natCast, ← Nat.range_succ_eq_Icc_zero]
  rw [sum_range_succ']
  simp [pre]

theorem mangoldt_weight (t : ℝ) (ht : 0 < t) (k : ℕ) :
    weighted (fun i => Λ i) k (exp (-t)) ≤ 1.6/t+1024 :=
  weighted_exp ht (by norm_num) (fun j => (pre_psi j).trans_le (psi_affine (by positivity))) k

end GoldbachEnergy
