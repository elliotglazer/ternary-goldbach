import RawExpTail
import Mathlib.Data.Nat.Factorial.Basic
import Mathlib.Tactic.FieldSimp
import Lean.Elab.Tactic.Omega

/-! Internal raw-head pilot: normalized exponential Horner and its rounding stability.
The approximation premises below are internal affine-rounding contracts, not analytic
source assumptions. A concrete integer producer must discharge them before export. -/

noncomputable section
namespace RawHead

def expHorner (z : ℂ) : ℕ → ℕ → ℂ
  | 0, _ => 1
  | N + 1, k => 1 + z / ((k + 1 : ℕ) : ℂ) * expHorner z N (k + 1)

lemma expHorner_eq_sum (z : ℂ) (N k : ℕ) :
    expHorner z N k =
      ∑ m ∈ Finset.range (N + 1), z ^ m / ((k + 1).ascFactorial m : ℂ) := by
  induction N generalizing k with
  | zero => simp [expHorner]
  | succ N ih =>
    rw [expHorner, ih]
    conv_rhs => rw [Finset.sum_range_succ']
    simp only [pow_zero, Nat.ascFactorial_zero, Nat.cast_one, div_one]
    rw [Finset.mul_sum]
    have hs :
        (∑ m ∈ Finset.range (N + 1), z / ((k + 1 : ℕ) : ℂ) *
          (z ^ m / ((k + 1 + 1).ascFactorial m : ℂ))) =
        ∑ m ∈ Finset.range (N + 1),
          z ^ (m + 1) / ((k + 1).ascFactorial (m + 1) : ℂ) := by
      apply Finset.sum_congr rfl
      intro m hm
      have ha : (k + 1).ascFactorial (m + 1) =
          (k + 1) * (k + 1 + 1).ascFactorial m := by
        rw [Nat.ascFactorial_succ, ← Nat.succ_ascFactorial]
      rw [ha, Nat.cast_mul, pow_succ]
      simp only [div_eq_mul_inv, mul_inv_rev]
      ring
    rw [hs]
    ring

lemma expHorner_eq_expPartial (N : ℕ) (z : ℂ) :
    expHorner z N 0 = expPartial (N + 1) z := by
  rw [expHorner_eq_sum, expPartial]
  simp only [zero_add, Nat.one_ascFactorial]

lemma expHorner72_eq (z : ℂ) : expHorner z 72 0 = expPartial 73 z :=
  expHorner_eq_expPartial 72 z

lemma expHorner_factor_le {z : ℂ} (hz : ‖z‖ ≤ 4) (k : ℕ) :
    ‖z / ((k + 1 : ℕ) : ℂ)‖ ≤ 4 / ((k + 1 : ℕ) : ℝ) := by
  rw [norm_div, Complex.norm_natCast]
  exact div_le_div_of_nonneg_right hz (by positivity)

lemma expHorner_error_step {z : ℂ} {a : ℕ → ℕ → ℂ} {δ : ℝ}
    (hstep : ∀ N k, ‖a (N + 1) k -
      (1 + z / ((k + 1 : ℕ) : ℂ) * a N (k + 1))‖ ≤ δ) (N k : ℕ) :
    ‖a (N + 1) k - expHorner z (N + 1) k‖ ≤
      δ + ‖z / ((k + 1 : ℕ) : ℂ)‖ * ‖a N (k + 1) - expHorner z N (k + 1)‖ := by
  have he : a (N + 1) k - expHorner z (N + 1) k =
      (a (N + 1) k - (1 + z / ((k + 1 : ℕ) : ℂ) * a N (k + 1))) +
      z / ((k + 1 : ℕ) : ℂ) * (a N (k + 1) - expHorner z N (k + 1)) := by
    rw [expHorner]
    ring
  rw [he]
  calc
    _ ≤ ‖a (N + 1) k - (1 + z / ((k + 1 : ℕ) : ℂ) * a N (k + 1))‖ +
        ‖z / ((k + 1 : ℕ) : ℂ) * (a N (k + 1) - expHorner z N (k + 1))‖ :=
      norm_add_le _ _
    _ = ‖a (N + 1) k - (1 + z / ((k + 1 : ℕ) : ℂ) * a N (k + 1))‖ +
        ‖z / ((k + 1 : ℕ) : ℂ)‖ * ‖a N (k + 1) - expHorner z N (k + 1)‖ := by
      rw [norm_mul]
    _ ≤ _ := add_le_add (hstep N k) le_rfl

lemma expHorner_error_high {z : ℂ} {a : ℕ → ℕ → ℂ} {δ : ℝ}
    (hz : ‖z‖ ≤ 4) (hδ : 0 ≤ δ) (hzero : ∀ k, a 0 k = 1)
    (hstep : ∀ N k, ‖a (N + 1) k -
      (1 + z / ((k + 1 : ℕ) : ℂ) * a N (k + 1))‖ ≤ δ)
    (N k : ℕ) (hk : 4 ≤ k) :
    ‖a N k - expHorner z N k‖ ≤ 5 * δ := by
  induction N generalizing k with
  | zero => simp [hzero, expHorner, hδ]
  | succ N ih =>
    have hc : ‖z / ((k + 1 : ℕ) : ℂ)‖ ≤ 4 / 5 := by
      rw [norm_div, Complex.norm_natCast]
      apply div_le_div₀ (by norm_num : (0 : ℝ) ≤ 4) hz (by norm_num)
      exact_mod_cast (show 5 ≤ k + 1 by omega)
    have hi := ih (k + 1) (by omega)
    calc
      _ ≤ δ + ‖z / ((k + 1 : ℕ) : ℂ)‖ *
          ‖a N (k + 1) - expHorner z N (k + 1)‖ := expHorner_error_step hstep N k
      _ ≤ δ + (4 / 5) * (5 * δ) := by
        exact add_le_add le_rfl (mul_le_mul hc hi (norm_nonneg _) (by norm_num))
      _ = 5 * δ := by ring

/-- One top-level error propagation step, with the child's uniform bound supplied explicitly. -/
lemma expHorner_error_at {z : ℂ} {a : ℕ → ℕ → ℂ} {δ B C : ℝ}
    (hδ : 0 ≤ δ) (hB : 0 ≤ B) (hC : 0 ≤ C)
    (hzero : ∀ k, a 0 k = 1)
    (hstep : ∀ N k, ‖a (N + 1) k -
      (1 + z / ((k + 1 : ℕ) : ℂ) * a N (k + 1))‖ ≤ δ)
    (k : ℕ) (hc : ‖z / ((k + 1 : ℕ) : ℂ)‖ ≤ C)
    (hchild : ∀ N, ‖a N (k + 1) - expHorner z N (k + 1)‖ ≤ B * δ)
    (N : ℕ) : ‖a N k - expHorner z N k‖ ≤ (1 + C * B) * δ := by
  cases N with
  | zero =>
    rw [hzero, expHorner, sub_self, norm_zero]
    positivity
  | succ N =>
    calc
      _ ≤ δ + ‖z / ((k + 1 : ℕ) : ℂ)‖ *
          ‖a N (k + 1) - expHorner z N (k + 1)‖ := expHorner_error_step hstep N k
      _ ≤ δ + C * (B * δ) :=
        add_le_add le_rfl (mul_le_mul hc (hchild N) (norm_nonneg _) hC)
      _ = (1 + C * B) * δ := by ring

lemma expHorner_error {z : ℂ} {a : ℕ → ℕ → ℂ} {δ : ℝ}
    (hz : ‖z‖ ≤ 4) (hδ : 0 ≤ δ) (hzero : ∀ k, a 0 k = 1)
    (hstep : ∀ N k, ‖a (N + 1) k -
      (1 + z / ((k + 1 : ℕ) : ℂ) * a N (k + 1))‖ ≤ δ)
    (N : ℕ) : ‖a N 0 - expHorner z N 0‖ ≤ 77 * δ := by
  have h4 : ∀ n, ‖a n 4 - expHorner z n 4‖ ≤ 5 * δ :=
    fun n => expHorner_error_high hz hδ hzero hstep n 4 (by omega)
  have hc3 : ‖z / ((3 + 1 : ℕ) : ℂ)‖ ≤ 1 := by
    simpa using expHorner_factor_le hz 3
  have h3 := expHorner_error_at hδ (by norm_num : (0 : ℝ) ≤ 5)
    (by norm_num : (0 : ℝ) ≤ 1) hzero hstep 3 hc3 h4
  norm_num at h3
  have hc2 : ‖z / ((2 + 1 : ℕ) : ℂ)‖ ≤ 4 / 3 := expHorner_factor_le hz 2
  have h2 := expHorner_error_at hδ (by norm_num : (0 : ℝ) ≤ 6)
    (by norm_num : (0 : ℝ) ≤ 4 / 3) hzero hstep 2 hc2 h3
  norm_num at h2
  have hc1 : ‖z / ((1 + 1 : ℕ) : ℂ)‖ ≤ 2 := by
    have h := expHorner_factor_le hz 1
    norm_num at h ⊢
    exact h
  have h1 := expHorner_error_at hδ (by norm_num : (0 : ℝ) ≤ 9)
    (by norm_num : (0 : ℝ) ≤ 2) hzero hstep 1 hc1 h2
  norm_num at h1
  have hc0 : ‖z / ((0 + 1 : ℕ) : ℂ)‖ ≤ 4 := by
    simpa using expHorner_factor_le hz 0
  have h0 := expHorner_error_at hδ (by norm_num : (0 : ℝ) ≤ 19)
    (by norm_num : (0 : ℝ) ≤ 4) hzero hstep 0 hc0 h1 N
  norm_num at h0
  exact h0

lemma expHorner72_error {z : ℂ} {a : ℕ → ℕ → ℂ} {δ : ℝ}
    (hz : ‖z‖ ≤ 4) (hδ : 0 ≤ δ) (hzero : ∀ k, a 0 k = 1)
    (hstep : ∀ N k, ‖a (N + 1) k -
      (1 + z / ((k + 1 : ℕ) : ℂ) * a N (k + 1))‖ ≤ δ) :
    ‖a 72 0 - expPartial 73 z‖ ≤ 81 * δ := by
  rw [← expHorner72_eq]
  have h := expHorner_error hz hδ hzero hstep 72
  linarith only [h, hδ]

end RawHead
