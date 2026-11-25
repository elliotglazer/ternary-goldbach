module

public import Mathlib.Analysis.SpecialFunctions.Pow.Real
public import Mathlib.Tactic.FieldSimp
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.Positivity
public import Mathlib.Tactic.Ring

@[expose] public section


open Real
namespace GoldbachEnergy
noncomputable section

/-- The multiplier of a gamma profile decreases past the logarithmic cutoff. -/
theorem profile_decay {a L : ℝ} (k : ℕ) (ha : 0 < a) (hk : 2*(k:ℝ) ≤ a) (hL : a ≤ L) :
    L^k / Real.exp (L/2) ≤ a^k / Real.exp (a/2) := by
  have hratio : 0 < L/a := div_pos (lt_of_lt_of_le ha hL) ha
  have hlog := Real.log_le_sub_one_of_pos hratio
  have hstep : (k:ℝ)*Real.log (L/a) ≤ (L-a)/2 := by
    have h1 := mul_le_mul_of_nonneg_left hlog (Nat.cast_nonneg k)
    have h2 := mul_le_mul_of_nonneg_right hk (sub_nonneg.mpr hL)
    calc (k:ℝ)*Real.log (L/a) ≤ (k:ℝ)*(L/a-1) := h1
         _ = (k:ℝ)*(L-a)/a := by field_simp <;> ring
         _ ≤ (L-a)/2 := (div_le_iff₀ ha).mpr (by nlinarith only [h2])
  have he := Real.exp_le_exp.mpr hstep
  rw [← Real.log_pow,Real.exp_log (pow_pos hratio k),div_pow] at he
  rw [div_le_iff₀ (pow_pos ha k)] at he
  rw [div_le_div_iff₀ (Real.exp_pos _) (Real.exp_pos _)]
  calc
    L^k * Real.exp (a/2) ≤ (Real.exp ((L-a)/2)*a^k) * Real.exp (a/2) :=
      mul_le_mul_of_nonneg_right he (Real.exp_pos _).le
    _ = a^k * Real.exp (L/2) := by rw [mul_comm _ (a^k),mul_assoc,← Real.exp_add]; congr 2; ring

/-- Retain both constraints in the rational approximation. The second
bound improves with the twist, even when the order bound is large. -/
theorem profile_multiplier {N L c a t s : ℝ} (hN : 0 < N) (hL : Real.log N=L)
    (ha : 6 ≤ a) (haL : a ≤ L) (hc : 0<c) (ht : 0≤t) (hs : 0<s)
    (order : t ≤ c*L^2) (radius : t*s*(c*L^2) ≤ Real.sqrt N) :
    t*L/Real.sqrt N ≤ min (c*a^3/Real.exp (a/2)) (1/(c*a*s)) := by
  have ha0 : 0<a := by linarith
  have hl : 0<L := ha0.trans_le haL
  have hr := Real.sqrt_pos.mpr hN
  have root : Real.sqrt N=Real.exp (L/2) := by
    rw [Real.sqrt_eq_rpow,Real.rpow_def_of_pos hN,hL]; congr 1; ring
  apply le_min
  · have h := profile_decay 3 ha0 (by norm_num <;> linarith) haL
    have w := mul_le_mul_of_nonneg_right order hl.le
    rw [root]
    calc t*L/Real.exp (L/2) ≤ c*(L^3/Real.exp (L/2)) := by
           rw [←mul_div_assoc]; exact div_le_div_of_nonneg_right (by linarith only [w]) (Real.exp_pos _).le
         _ ≤ c*(a^3/Real.exp (a/2)) := mul_le_mul_of_nonneg_left h hc.le
         _ = _ := by ring
  · rw [div_le_div_iff₀ hr (by positivity)]
    have hh := mul_le_mul_of_nonneg_right haL (show 0≤t*s*c*L by positivity)
    nlinarith only [hh,radius]
#print axioms profile_decay
#print axioms profile_multiplier
end
end GoldbachEnergy
