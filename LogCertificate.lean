module

public import Mathlib.Analysis.Complex.ExponentialBounds
public import Mathlib.Analysis.SpecialFunctions.Log.Basic
public import Mathlib.Analysis.Real.Sqrt
public import Mathlib.Tactic

@[expose] public section


open Real Finset
namespace GoldbachEnergy

/-- Bounds at rational endpoints use a fixed polynomial on [0,1] and integral scaling. -/
def expPoly (s : ℚ) : ℚ := 1+s+s^2/2+s^3/6+s^4/24+s^5/120

private theorem exp_poly {s : ℚ} (h0 : 0 ≤ s) (h1 : s ≤ 1) :
    (expPoly s : ℝ) ≤ Real.exp s ∧ Real.exp s ≤ ((expPoly s + s^6*7/4320 : ℚ):ℝ) := by
  have hs0 : 0 ≤ (s:ℝ) := by exact_mod_cast h0
  have hs1 : (s:ℝ) ≤ 1 := by exact_mod_cast h1
  have low := Real.sum_le_exp_of_nonneg hs0 6
  have high := Real.exp_bound' hs0 hs1 (by decide : 0<6)
  norm_num [Finset.sum_range_succ,Nat.factorial] at low high
  unfold expPoly; push_cast
  constructor <;> linarith

theorem lower_log_certificate (k : ℕ) (s x : ℚ) (hs0 : 0≤s) (hs1 : s≤1)
    (h : (27182818286/10000000000:ℚ)^k*(expPoly s+s^6*7/4320) ≤ x) :
    (k:ℝ)+(s:ℝ) ≤ Real.log x := by
  have ht := (exp_poly hs0 hs1).2
  have hpos : (0:ℝ) ≤ ((expPoly s+s^6*7/4320:ℚ):ℝ) := (Real.exp_pos _).le.trans ht
  have ha : Real.exp 1 ≤ ((27182818286/10000000000:ℚ):ℝ) := by
    rw [show (((27182818286/10000000000:ℚ):ℝ)) = 2.7182818286 by norm_num]
    exact Real.exp_one_lt_d9.le
  have hh := mul_le_mul (pow_le_pow_left₀ (Real.exp_pos _).le ha k) ht (Real.exp_pos _).le (by positivity)
  have v : Real.exp ((k:ℝ)+s) ≤ (x:ℝ) := by
    rw [Real.exp_add,show (k:ℝ)=(k:ℝ)*1 by ring,Real.exp_nat_mul]
    exact hh.trans (by exact_mod_cast h)
  exact (Real.le_log_iff_exp_le ((Real.exp_pos _).trans_le v)).mpr v

theorem upper_log_certificate (k : ℕ) (s x : ℚ) (hx : 0<x) (hs0 : 0≤s) (hs1 : s≤1)
    (h : x ≤ (27182818283/10000000000:ℚ)^k*expPoly s) :
    Real.log x ≤ (k:ℝ)+(s:ℝ) := by
  have ht := (exp_poly hs0 hs1).1
  have ha : ((27182818283/10000000000:ℚ):ℝ) ≤ Real.exp 1 := by
    rw [show (((27182818283/10000000000:ℚ):ℝ)) = 2.7182818283 by norm_num]
    exact Real.exp_one_gt_d9.le
  have he : (0:ℝ) ≤ (expPoly s:ℝ) := by
    have : (0:ℝ)≤s := by exact_mod_cast hs0
    unfold expPoly; push_cast; positivity
  apply (Real.log_le_iff_le_exp (by exact_mod_cast hx)).mpr
  rw [Real.exp_add,show (k:ℝ)=(k:ℝ)*1 by ring,Real.exp_nat_mul]
  exact (show (x:ℝ) ≤ _ by exact_mod_cast h).trans
    (mul_le_mul (pow_le_pow_left₀ (by norm_num) ha k) ht he (by positivity))

theorem jensen_denominator {W : ℝ} (hW : W ∈ Set.Icc (7:ℝ) 7.01) :
    0.96 ≤ Real.log (10/Real.sqrt (9/4+(W/2)^2)) := by
  have hc : (0.96:ℝ) ≤ Real.log 2.62 := by
    have h := lower_log_certificate 0 (96/100) (262/100) (by norm_num) (by norm_num)
      (by norm_num [expPoly])
    norm_num at h ⊢; exact h
  have hp : 0 < 9/4+(W/2)^2 := by positivity
  have hs : Real.sqrt (9/4+(W/2)^2) ≤ 3.816 := by
    apply (Real.sqrt_le_left (by norm_num)).mpr
    nlinarith [sq_le_sq' (by linarith [hW.1] : -(7.01:ℝ) ≤ W) hW.2]
  apply hc.trans (Real.log_le_log (by norm_num) _)
  rw [le_div_iff₀ (Real.sqrt_pos.mpr hp)]; linarith

#print axioms lower_log_certificate
#print axioms upper_log_certificate
#print axioms jensen_denominator
end GoldbachEnergy
