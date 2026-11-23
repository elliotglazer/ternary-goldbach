import PinnedCount
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-! Counts and von Mangoldt weights of proper powers in the finite Gaussian window. -/

namespace GrhGoldbach.LocalPowers

open Finset Real
open scoped ArithmeticFunction.vonMangoldt

/-- Count integer bases whose `k`-th power lies in `(a,b]`. -/
theorem count_le_64 {a b v : ℝ} (ha : 1 ≤ a) (hab : a ≤ b) (hv : 0 < v)
    (hroot : 0.99 * v ≤ √a) (hwidth : b - a ≤ 126.2 * v)
    {k : ℕ} (hk : 2 ≤ k) :
    ((Iic ⌊b⌋₊).filter (fun m => ⌊a⌋₊ < m ^ k ∧ m ^ k ≤ ⌊b⌋₊)).card ≤ 64 := by
  have ha0 : 0 ≤ a := by linarith only [ha]
  have hb0 : 0 ≤ b := ha0.trans hab
  have hk' : (2 : ℝ) ≤ k := by exact_mod_cast hk
  have hc := LeanLab.PrimePowerWindow.count_le ha0 hab (show 1 ≤ k by omega)
  have hm := LeanLab.PrimePowerWindow.rpow_sub_mono ha hab
    (show 0 ≤ 1 / (k : ℝ) by positivity) (one_div_le_one_div_of_le (by norm_num : (0 : ℝ) < 2) hk')
  rw [← Real.sqrt_eq_rpow, ← Real.sqrt_eq_rpow] at hm
  have hsum : 1.98 * v ≤ √b + √a := by linarith only [hroot, Real.sqrt_le_sqrt hab]
  have hd : √b - √a < 64 := by
    by_contra! h
    have hp := mul_le_mul h hsum (show 0 ≤ 1.98 * v by positivity) (by linarith only [h])
    nlinarith only [hp, hwidth, Real.sq_sqrt ha0, Real.sq_sqrt hb0, hv]
  apply Nat.lt_succ_iff.mp
  exact_mod_cast (show ((((Iic ⌊b⌋₊).filter
    (fun m => ⌊a⌋₊ < m ^ k ∧ m ^ k ≤ ⌊b⌋₊)).card : ℕ) : ℝ) < 65 by
    linarith only [hc, hm, hd])

/-- The actual exponential window at every finite-branch point satisfies the
integer-base count. The left endpoint is excluded and the right is included. -/
theorem gaussian_count_le_64 {x : ℝ} (hlo : 10^15 ≤ x) {k : ℕ} (hk : 2 ≤ k) :
    ((Iic ⌊x⌋₊).filter (fun m =>
      ⌊x * exp (-(126.2 / √x))⌋₊ < m ^ k ∧ m ^ k ≤ ⌊x⌋₊)).card ≤ 64 := by
  have hx : 0 < x := by linarith only [hlo]
  have hv : 0 < √x := Real.sqrt_pos.2 hx
  have hv' : (10000 : ℝ) ≤ √x := (Real.le_sqrt (by norm_num) hx.le).2 (by linarith only [hlo])
  have hlin := Real.add_one_le_exp (-(126.2 / √x))
  have hl := mul_le_mul_of_nonneg_left hlin hx.le
  have he : x * (-(126.2 / √x) + 1) = x - 126.2 * √x := by
    field_simp [hv.ne']
    nlinarith only [Real.sq_sqrt hx.le]
  rw [he] at hl
  have hlow : (0.99 * √x)^2 ≤ x * exp (-(126.2 / √x)) := by
    have hmul := mul_le_mul_of_nonneg_right hv' hv.le
    nlinarith only [hl, hmul, Real.sq_sqrt hx.le, hv]
  have ha : 1 ≤ x * exp (-(126.2 / √x)) := by
    have hbig : 1 ≤ 0.99 * √x := by linarith only [hv']
    nlinarith only [hlow, hbig, sq_nonneg (0.99 * √x - 1)]
  have hab : x * exp (-(126.2 / √x)) ≤ x := by
    exact mul_le_of_le_one_right hx.le (Real.exp_le_one_iff.mpr (neg_nonpos.mpr (by positivity)))
  exact count_le_64 ha hab hv
    ((Real.le_sqrt (by positivity) (by positivity)).2 hlow) (by linarith only [hl]) hk

/-- Uniform mass budget for the proper powers in the buffered Gaussian
window. Any upper-bounded-by-one weight is supported, including the Gaussian. -/
theorem gaussian_nonprime_mass_le {x : ℝ} (hlo : 10^15 ≤ x) (hhi : x ≤ 10^27)
    (weight : ℕ → ℝ) (hw : ∀ n, weight n ≤ 1) :
    ∑ n ∈ (Ioc ⌊x * exp (-(126.2 / √x))⌋₊ ⌊x⌋₊).filter (fun n => ¬ n.Prime),
      Λ n * weight n ≤ 362880 := by
  let A := ⌊x * exp (-(126.2 / √x))⌋₊
  let B := ⌊x⌋₊
  have hB0 : B ≠ 0 := by
    have : 1 ≤ B := Nat.le_floor (by norm_num only [Nat.cast_one]; linarith only [hlo])
    omega
  have hB : (B : ℝ) ≤ 10^27 := (Nat.floor_le (by linarith only [hlo])).trans hhi
  have hlog : Nat.log 2 B < 90 := by
    apply (Nat.log_lt_iff_lt_pow (by decide : 1 < 2) hB0).2
    have : B ≤ 10^27 := by exact_mod_cast hB
    omega
  have hlogB : Real.log B ≤ 63 := by
    have hp : (0 : ℝ) < B := by exact_mod_cast Nat.pos_of_ne_zero hB0
    have h := Real.log_le_log hp hB
    rw [Real.log_pow, Real.log_ten_eq] at h
    norm_num only [Nat.cast_ofNat] at h
    linarith only [h, Real.log_two_lt_d9, Real.log_five_lt_d9]
  change ∑ n ∈ (Ioc A B).filter (fun n => ¬ n.Prime), Λ n * weight n ≤ _
  calc
    _ ≤ ∑ n ∈ (Ioc A B).filter (fun n => ¬ n.Prime), Λ n :=
      sum_le_sum (fun n _ => mul_le_of_le_one_right ArithmeticFunction.vonMangoldt_nonneg (hw n))
    _ ≤ _ := LeanLab.PrimePowerWindow.sum_nonprime_le A B
    _ ≤ ∑ _k ∈ Icc 2 (Nat.log 2 B), (63 * 64 : ℝ) := by
      refine sum_le_sum (fun k hk => ?_)
      have hk2 := (mem_Icc.mp hk).1
      have hk' : (1 : ℝ) ≤ k := by exact_mod_cast (show 1 ≤ k by omega)
      have hdiv : Real.log B / (k : ℝ) ≤ 63 := by
        apply (div_le_iff₀ (by linarith only [hk'])).2
        linarith only [hlogB, hk']
      have hc : ((((Iic B).filter (fun m => A < m ^ k ∧ m ^ k ≤ B)).card : ℕ) : ℝ) ≤ 64 := by
        exact_mod_cast gaussian_count_le_64 hlo hk2
      exact mul_le_mul hdiv hc (Nat.cast_nonneg _) (by norm_num)
    _ ≤ 362880 := by
      rw [sum_const, nsmul_eq_mul, Nat.card_Icc]
      have hcard : Nat.log 2 B + 1 - 2 ≤ 90 := by omega
      have hcard' : ((Nat.log 2 B + 1 - 2 : ℕ) : ℝ) ≤ 90 := by exact_mod_cast hcard
      linarith only [hcard']

end GrhGoldbach.LocalPowers
