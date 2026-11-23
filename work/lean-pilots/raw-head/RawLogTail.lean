import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

/-! Internal raw-head pilot: an actual logarithm tail and exact range reduction.
These lemmas concern the literal real polynomial, before any numerical rounding. -/

noncomputable section
open Finset

namespace RawHead

def logPartial (N : ℕ) (v : ℝ) : ℝ :=
  2 * ∑ i ∈ Finset.range N, v ^ (2 * i + 1) / (2 * i + 1)

lemma logPartial_error (N : ℕ) {v : ℝ} (hv0 : 0 ≤ v) (hv : v ≤ 1 / 3) :
    |Real.log ((1 + v) / (1 - v)) - logPartial N v| ≤
      (9 / 4 : ℝ) * (1 / 3) ^ (2 * N + 1) := by
  have ha : |v| < 1 := by
    rw [abs_of_nonneg hv0]
    linarith only [hv]
  have h := Real.sum_range_sub_log_div_le ha N
  rw [abs_of_nonneg hv0] at h
  have hd : (8 / 9 : ℝ) ≤ 1 - v ^ 2 := by
    nlinarith only [hv0, hv]
  have hp : v ^ (2 * N + 1) ≤ (1 / 3 : ℝ) ^ (2 * N + 1) :=
    pow_le_pow_left₀ hv0 hv _
  have hb : v ^ (2 * N + 1) / (1 - v ^ 2) ≤
      (1 / 3 : ℝ) ^ (2 * N + 1) / (8 / 9) := by
    exact div_le_div₀ (by positivity) hp (by norm_num) hd
  have he : Real.log ((1 + v) / (1 - v)) - logPartial N v =
      2 * (1 / 2 * Real.log ((1 + v) / (1 - v)) -
        ∑ i ∈ Finset.range N, v ^ (2 * i + 1) / (2 * i + 1)) := by
    unfold logPartial
    ring
  rw [he, abs_mul, abs_of_nonneg (by norm_num : (0 : ℝ) ≤ 2)]
  calc
    _ ≤ 2 * ((1 / 3 : ℝ) ^ (2 * N + 1) / (8 / 9)) :=
      mul_le_mul_of_nonneg_left (h.trans hb) (by norm_num)
    _ = (9 / 4 : ℝ) * (1 / 3) ^ (2 * N + 1) := by ring

lemma logPartial45_error {v : ℝ} (hv0 : 0 ≤ v) (hv : v ≤ 1 / 3) :
    |Real.log ((1 + v) / (1 - v)) - logPartial 45 v| ≤
      1 / (2 ^ 135 : ℝ) := by
  apply (logPartial_error 45 hv0 hv).trans
  norm_num

lemma logPartial45_log_two_error :
    |Real.log 2 - logPartial 45 (1 / 3)| ≤ 1 / (2 ^ 135 : ℝ) := by
  have h := logPartial45_error (v := 1 / 3) (by norm_num) le_rfl
  rw [show (1 + (1 / 3 : ℝ)) / (1 - 1 / 3) = 2 by norm_num] at h
  exact h

/-- Exact range-reduced polynomial error for the integer-pool source domain.
The logarithm-two cache is still the exact polynomial here; arithmetic errors
and the final source-grid rounding must be added by a separate producer lemma. -/
lemma logPartial45_range_error {x : ℝ} {k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : (2 : ℝ) ^ k ≤ x) (hhi : x ≤ 2 * (2 : ℝ) ^ k) :
    |Real.log x - ((k : ℝ) * logPartial 45 (1 / 3) +
      logPartial 45 ((x - 2 ^ k) / (x + 2 ^ k)))| ≤
      19 / (2 ^ 135 : ℝ) := by
  let a : ℝ := 2 ^ k
  have ha : 0 < a := by dsimp [a]; positivity
  have hd : 0 < x + a := add_pos hx ha
  let v : ℝ := (x - a) / (x + a)
  have hv0 : 0 ≤ v := div_nonneg (sub_nonneg.mpr hlo) hd.le
  have hv : v ≤ 1 / 3 := (div_le_iff₀ hd).2 (by dsimp [a] at *; linarith only [hhi])
  have hratio : (1 + v) / (1 - v) = x / a := by
    dsimp [v]
    field_simp [ha.ne', hd.ne']
    ring
  have hy := logPartial45_error hv0 hv
  rw [hratio, Real.log_div hx.ne' ha.ne', Real.log_pow] at hy
  have he : Real.log x - ((k : ℝ) * logPartial 45 (1 / 3) +
      logPartial 45 ((x - 2 ^ k) / (x + 2 ^ k))) =
      (Real.log x - (k : ℝ) * Real.log 2 - logPartial 45 v) +
        (k : ℝ) * (Real.log 2 - logPartial 45 (1 / 3)) := by
    dsimp [v, a]
    ring
  rw [he]
  calc
    _ ≤ |Real.log x - (k : ℝ) * Real.log 2 - logPartial 45 v| +
        |(k : ℝ) * (Real.log 2 - logPartial 45 (1 / 3))| := abs_add_le _ _
    _ ≤ 1 / (2 ^ 135 : ℝ) + (k : ℝ) * (1 / (2 ^ 135 : ℝ)) := by
      rw [abs_mul, show |(k : ℝ)| = (k : ℝ) from abs_of_nonneg (Nat.cast_nonneg k)]
      exact add_le_add hy
        (mul_le_mul_of_nonneg_left logPartial45_log_two_error (Nat.cast_nonneg k))
    _ ≤ 1 / (2 ^ 135 : ℝ) + 18 * (1 / (2 ^ 135 : ℝ)) := by
      have hkr : (k : ℝ) ≤ 18 := by exact_mod_cast hk
      exact add_le_add (le_refl (1 / (2 ^ 135 : ℝ)))
        (mul_le_mul_of_nonneg_right hkr (by positivity : (0 : ℝ) ≤ 1 / (2 ^ 135 : ℝ)))
    _ = 19 / (2 ^ 135 : ℝ) := by ring

end RawHead
